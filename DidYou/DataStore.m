//
//  DataStore.m
//  DidYou
//
//  Created by Brian Clouser on 3/29/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "DataStore.h"
#import "DYUser.h"
#import "DYJournalEntry.h"
#import "DYUtility.h"
#import <SystemConfiguration/SystemConfiguration.h>


@implementation DataStore

+ (instancetype)sharedDataStore
{
    
    NSLog(@"shared data store called");
    
    static DataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedDataStore = [[DataStore alloc] init];
        
    });
    
    return _sharedDataStore;
}

-(instancetype)init
{
    
    NSLog(@"init for singleton");
    
    self = [super init];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"singletonBeingCreated" object:nil];
    
    if (self)
    {
        _isFirstTime = false;
        _users = [[NSMutableArray alloc] init];
        _emotions = [self emotionsDictionary];
        _userUUID = @"";
        
        _currentUser = [[DYUser alloc] init];
    

        _gotCreated = YES;

        _userImage = [self userImage];


       
        
        
        [self setupFirebase];
        [self userUUIDToUser];
        
    

    }
    
    return self;
}


-(void)setUpLocationManager
{
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    self.geocoder = [[CLGeocoder alloc]init];

    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"didFailWithError, %@", error);
    
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    NSLog(@"LOCATION");
    CLLocation *currentLocation = locations[0];
    
    if (currentLocation != nil) {
        
        //stop location manager
        
        [self.locationManager stopUpdatingLocation];
        
        //translate the locate data into a human-readable address
        
        [self.geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            if (error == nil && [placemarks count] > 0) {
                
                self.placemark = [placemarks lastObject];
                [self addPlacemark: self.placemark];
                
                
            } else {
                
                NSLog(@"@%@", error.debugDescription);
            }
        }];
    }
    
}

-(void)requestLocationPermission
{
    NSLog(@"getting here");
    
    [self setUpLocationManager];
    
}

-(void)setupFirebase
{
    // Create a reference to a Firebase database URL
    self.myRootRef = [[Firebase alloc] initWithUrl:@"https://incandescent-fire-4531.firebaseio.com/"];
}

-(void)userUUIDToUser
{
    // look in NSUserDefaults if UUID exists
    
    NSDictionary *userDefaultsDictionary = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    
    NSArray *userDefaultsKeys = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys];
    
    BOOL uuidExists = [userDefaultsKeys containsObject:@"userUUID"];
    

   if (uuidExists)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"connectedAndUserExists" object:nil];
        
        self.currentUser.userUUID = userDefaultsDictionary[@"userUUID"];
        
        [self pullCurrentUserFromFirebase:self.currentUser.userUUID];
    }
    
    else
    {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"connectedAndUserIsNew" object:nil];
        
        _isFirstTime = true;
        NSString *newUUID = [self createNewUserUUID];
        [self createNewCurrentUserWithUUID:newUUID];
        
    }
    
}

-(void)addUserToFirebase: (DYUser*)user
{
    // Add new user to firebase, serialize user
    Firebase *userRef = [self getUserRef:user];
    DYUtility *util = [DYUtility sharedUtility];
    NSDictionary *myUser = @{
                            @"name": user.name,
                            @"city": user.city,
                            @"country": user.country,
                            @"signUpDate": [util getUTCFormatDate: user.signUpDate],
                            @"journals": @{}
                           
                            };
      [userRef setValue: myUser];
}

-(void)addJournalToFirebase:(DYUser *)user :(DYJournalEntry *)journalEntry
{
    
    NSLog(@"in add journal to firebase");
    // get the user reference and serialize the journal
    // use childByAutoId to assign random key to journal entry, in firebase, have an array, don't want to push array in its entirty every time, JS has a push method, randomly put in there, sort later
    NSLog(@"%@\n\n\n\n\n", self.currentUser.userUUID);
    
    Firebase *journalRef = [[self getUserRef: user] childByAppendingPath:@"journals"];
    [[journalRef childByAutoId] setValue:[journalEntry serialize]];
}



-(void)pushLastJournal

{
    // Journal was updated so push entry to firebase
    
    NSLog(@"in add journal in datastore");

    [self addJournalToFirebase:self.currentUser :[self.currentUser.journals lastObject]];
}

-(void)updateCurrentUserCityAndCountry
{
    
    Firebase *cityRef = [[self getUserRef:self.currentUser] childByAppendingPath:@"city"];
    [[cityRef childByAutoId] setValue: self.currentUser.city];
    
    Firebase *countryRef = [[self getUserRef:self.currentUser] childByAppendingPath:@"country"];
    [[countryRef childByAutoId] setValue: self.currentUser.country];
    
}


-(Firebase *)getUserRef: (DYUser *)user

{   //unique path to the users data
    return [[self.myRootRef childByAppendingPath: @"users"] childByAppendingPath:user.userUUID];
}




-(NSString *)createNewUserUUID
{
    
    NSString *userUUID = [[NSUUID UUID] UUIDString];
    
    [[NSUserDefaults standardUserDefaults] setObject:userUUID  forKey:@"userUUID"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return  userUUID;

    
}

-(void)createNewCurrentUserWithUUID:(NSString *)userUUID
{
    DYUser *newUser = [[DYUser alloc] initWithUserUUID:userUUID signUpDate:[NSDate date]];
    
    self.currentUser = newUser;

    [self.users addObject:self.currentUser];
    
    [self addUserToFirebase: newUser];
}

-(void)pullCurrentUserFromFirebase:(NSString *)userUUID
{

    NSLog(@"in the firebase method trying with UUID: %@", userUUID);
    
    Firebase *userRef = [[self.myRootRef childByAppendingPath:@"users"] childByAppendingPath:userUUID];
    
    
    
    [userRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {

        NSLog(@"in the firebase completion");

        NSLog(@"%@", [snapshot value]);

        DYUtility *util = [DYUtility sharedUtility];
        NSMutableArray *journals = [[NSMutableArray alloc] init];
        NSDictionary *result = [snapshot value];

        self.currentUser.signUpDate = [util fromUTCFormatDate: result[@"signUpDate"]];
        self.currentUser.name = result[@"name"];
        self.currentUser.city = result[@"city"];
        self.currentUser.country = result[@"country"];

         // Deserialize each journal entry
         NSMutableDictionary *journalDict = result[@"journals"];

         for (NSString *key in [journalDict allKeys])

         {   // this is how you deserializing the object in firebase
             [journals addObject:[[DYJournalEntry alloc] initWithDeserialize: journalDict[key]]];
         }

         self.currentUser.journals = [util sortEntriesFromArray:journals];

         //[self.users addObject:self.currentUser];
         
         // Notify the main controller that the firebase data
         // has arrived

         NSLog(@"about to post firebase notification");


         [[NSNotificationCenter defaultCenter]
          postNotificationName:@"FirebaseNotification"
          object:self];

        
        [self setUpLocationManager];

          //this block doesn't get executed until the snapshot is delivered
        
    } ];
    
}



-(NSDictionary *)emotionsDictionary
{
    
    
    NSDictionary *emotions = @{ @"Happy"  :  @[ @"Fulfilled",@"Glad",@"Complete",@"Optimistic",@"Pleased",@"Serene"],
                                @"Excited"  :  @[ @"Ecstatic",@"Engergetic",@"Aroused",@"Bouncy",@"Aroused",@"Joyful"],
                                @"Tender"  :  @[ @"Intimate",@"Loving",@"Sympathetic",@"Touched",@"Soft",@"Trusting"],
                                @"Scared"  :  @[ @"Tense",@"Nervous",@"Anxious",@"Frightened",@"Terrified",@"Apprehensive"],
                                @"Angry"  :  @[ @"Irritated",@"Resentful",@"Upset",@"Furious",@"Raging",@"Annoyed"],
                                @"Sad"  :  @[ @"Blue",@"Mopey",@"Dejected",@"Depressed",@"Heartbroken",@"Remorseful"]};
    
    
    return emotions;
}




+ (BOOL)isNetworkAvailable
{
    SCNetworkReachabilityFlags flags;
    SCNetworkReachabilityRef address;
    address = SCNetworkReachabilityCreateWithName(NULL, "www.apple.com" );
    Boolean success = SCNetworkReachabilityGetFlags(address, &flags);
    CFRelease(address);
    
    BOOL canReach = success
    && !(flags & kSCNetworkReachabilityFlagsConnectionRequired)
    && (flags & kSCNetworkReachabilityFlagsReachable);

    
    return canReach;

}




-(NSArray *)usersWithSameCity
{
    NSString *usersCity = self.currentUser.city;
    
    NSPredicate *sameCityPredictate = [NSPredicate predicateWithFormat:@"city = %@",usersCity];
    
    NSArray *usersWithSameCity = [self.users filteredArrayUsingPredicate:sameCityPredictate];
    
    return usersWithSameCity;
}

-(NSArray *)usersWithSameCountry
{
    NSString *usersCountry = self.currentUser.country;
    
    NSPredicate *sameCountryPredictate = [NSPredicate predicateWithFormat:@"country = %@",usersCountry];
    
    NSArray *usersWithSameCountry = [self.users filteredArrayUsingPredicate:sameCountryPredictate];
    
    return usersWithSameCountry;
    
}


-(void)addPlacemark: (CLPlacemark*)placeMark
{
    
    self.currentUser.city = placeMark.locality;
    self.currentUser.country = placeMark.country;
    
    Firebase *cityRef = [[self getUserRef:self.currentUser] childByAppendingPath:@"city"];
    
    [cityRef setValue:self.currentUser.city];
    
    
    Firebase *countryRef = [[self getUserRef:self.currentUser] childByAppendingPath:@"country"];
    
    [countryRef setValue:self.currentUser.country];
    
    
    //sending city info to firebase
   // Firebase *cityRef = [[[self.myRootRef childByAppendingPath: self.currentUser.userUUID] childByAppendingPath: placeMark.locality] childByAppendingPath:self.currentUser.userUUID];
    //[cityRef setValue: self.currentUser.city];
    
    //Firebase *countryRef = [[[self.myRootRef childByAppendingPath: @"countries"] childByAppendingPath: placeMark.country] childByAppendingPath:self.currentUser.userUUID];
    //[countryRef setValue: self.currentUser.country];

    
}

-(void)deleteAllCurrentUserEntries
{
    
    NSMutableArray *currentUserJournals = self.currentUser.journals;
    
    [currentUserJournals removeAllObjects];
    
    Firebase *journalsRef = [[self getUserRef:self.currentUser] childByAppendingPath:@"journals"];
    
    [journalsRef removeValue];
    
    
}



































@end
