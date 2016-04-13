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

+ (instancetype)sharedDataStore;
{
    static DataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[DataStore alloc] init];
    });
    
    return _sharedDataStore;
}

-(instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _isFirstTime = false;
        _users = [[NSMutableArray alloc] init];
        _emotions = [self emotionsDictionary];
        _userUUID = [self userUUID];
        
        [self setupFirebase];
        [self userUUIDToUser];

    }
    
    return self;
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
        [self createNewCurrentUserFromFirebase:userDefaultsDictionary[@"userUUID"]];
    }
    
    else
    {
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

-(void)addJournalToFirebase:(DYUser *)user :(DYJournalEntry *)journalEntry;

{
    // get the user reference and serialize the journal
    // use childByAutoId to assign random key to journal entry, in firebase, have an array, don't want to push array in its entirty every time, JS has a push method, randomly put in there, sort later
    
    Firebase *journalRef = [[self getUserRef: user] childByAppendingPath:@"journals"];
    [[journalRef childByAutoId] setValue:[journalEntry serialize]];
}

-(void)pushLastJournal
{
    // Journal was updated so push entry to firebase
    
    [self addJournalToFirebase:self.currentUser :[self.currentUser.journals lastObject]];
}


-(Firebase *)getUserRef: (DYUser *)user

{   //unique path to the users data
    return [[self.myRootRef childByAppendingPath: @"users"] childByAppendingPath:user.userUUID];
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

-(void)createNewCurrentUserFromFirebase:(NSString *)userUUID
{
    
    Firebase *firebase = [[self.myRootRef childByAppendingPath:@"users"] childByAppendingPath:userUUID];
    
    
    [firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
              if (snapshot.value == [NSNull null]) {
                        NSLog(@"firebase returned null value for path");
                        return;
                    }
            
                     NSLog(@"in the firebase completion");
            
                     DYUtility *util = [DYUtility sharedUtility];
                     NSMutableArray *journals = [[NSMutableArray alloc] init];
                     NSDictionary *result = [snapshot value];
            
                     DYUser *newUser = [[DYUser alloc] initWithUserUUID:userUUID signUpDate: [util fromUTCFormatDate: result[@"signUpDate"]]];
                     newUser.name = result[@"name"];
                     newUser.city = result[@"city"];
                     newUser.country = result[@"country"];
            
                     // Deserialize each journal entry
                     NSMutableDictionary *journalDict = result[@"journals"];
            
                     for (NSString *key in [journalDict allKeys])
            
                     {   // this is how you deserializing the object in firebase
                         [journals addObject:[[DYJournalEntry alloc] initWithDeserialize: journalDict[key]]];
                     }
            
                     newUser.journals = [util sortEntriesFromArray:journals];
            
                     self.currentUser = newUser;
            
                     [self.users addObject:self.currentUser];
                     
                     // Notify the main controller that the firebase data
                     // has arrived
                     [[NSNotificationCenter defaultCenter]
                      postNotificationName:@"FirebaseNotification"
                      object:self];
                      //this block doesn't get executed until the snapshot is delivered
        
     
        
    } ];
    
    
    
    

    
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













#pragma test user data


-(void)testUsers
{
    DYUser *testUser1 = [[DYUser alloc] initWithUserUUID:@"11111" signUpDate:[NSDate date] name:@"Brian" city:@"New York" country:@"United States" journals:[[NSMutableArray alloc] init] ];
    DYUser *testUser2 = [[DYUser alloc] initWithUserUUID:@"22222" signUpDate:[NSDate date] name:@"Kayla" city:@"New York" country:@"United States" journals:[[NSMutableArray alloc] init] ];

    DYUser *testUser3 = [[DYUser alloc] initWithUserUUID:@"33333" signUpDate:[NSDate date] name:@"Andre" city:@"New York" country:@"United States" journals:[[NSMutableArray alloc] init] ];

    DYUser *testUser4 = [[DYUser alloc] initWithUserUUID:@"44444" signUpDate:[NSDate date] name:@"Zirui" city:@"Boston" country:@"United States" journals:[[NSMutableArray alloc] init] ];

    DYUser *testUser5 = [[DYUser alloc] initWithUserUUID:@"55555" signUpDate:[NSDate date] name:@"Tom" city:@"London" country:@"England" journals:[[NSMutableArray alloc] init] ];
    
    
    DYJournalEntry *testEntry1 = [[DYJournalEntry alloc] init];
    DYJournalEntry *testEntry2 = [[DYJournalEntry alloc] init];
    DYJournalEntry *testEntry3 = [[DYJournalEntry alloc] init];
    DYJournalEntry *testEntry4 = [[DYJournalEntry alloc] init];
    DYJournalEntry *testEntry5 = [[DYJournalEntry alloc] init];
    DYJournalEntry *testEntry6 = [[DYJournalEntry alloc] init];
    DYJournalEntry *testEntry7 = [[DYJournalEntry alloc] init];
    DYJournalEntry *testEntry8 = [[DYJournalEntry alloc] init];
    DYJournalEntry *testEntry9 = [[DYJournalEntry alloc] init];
    DYJournalEntry *testEntry10 = [[DYJournalEntry alloc] init];
    DYJournalEntry *testEntry11 = [[DYJournalEntry alloc] init];
    DYJournalEntry *testEntry12 = [[DYJournalEntry alloc] init];
    DYJournalEntry *testEntry13 = [[DYJournalEntry alloc] init];
    DYJournalEntry *testEntry14 = [[DYJournalEntry alloc] init];
    DYJournalEntry *testEntry15 = [[DYJournalEntry alloc] init];
    
    
    
    testEntry1.date = [NSDate date];
    testEntry1.mainEmotion = @"Glad";
    testEntry1.journalEntry = @"Today I feel so glad about my life.\n\nI am the happiest person on the planet.";
    testEntry1.picture1Address = @"testImage1";
    
    testEntry2.date = [[NSDate date] dateByAddingTimeInterval:-60*60*24];
    testEntry2.mainEmotion = @"Nervous";
    testEntry2.journalEntry = @"I am really nervous today.  I was going to ask my girlfriend to marry me but I'm not sure she likes me all that much so this should be interesting.\n\nHere I go.";
    testEntry2.picture1Address = @"testImage2";
    
    testEntry3.date = [[NSDate date] dateByAddingTimeInterval:-60*60*24*2];
    testEntry3.mainEmotion = @"Touched";
    testEntry3.journalEntry = @"My friends all send me birthday wishes.  I felt very touched and happy to have so many people that care about me.";
    testEntry3.picture1Address = @"testImage3";
    
    testEntry4.date = [NSDate date];
    testEntry4.mainEmotion = @"Jittery";
    testEntry4.journalEntry = @"Have a big presentation at work tomorrow.  Feeling very nervous about it and hoping it goes well.";
    testEntry4.picture1Address = @"testImage4";
    
    testEntry5.date = [[NSDate date] dateByAddingTimeInterval:-60*60*24];
    testEntry5.mainEmotion = @"Mad";
    testEntry5.journalEntry = @"I am so fucking pissed my boyfriend has been texting with this other girl and I want to smack him in the face.";
    testEntry5.picture1Address = @"testImage5";
    
    testEntry6.date = [[NSDate date] dateByAddingTimeInterval:-60*60*24*2];
    testEntry6.mainEmotion = @"Dejected";
    testEntry6.journalEntry = @"Ugh, my team lost in the finals last night.  I played like shit and can't believe my career is over.";
    testEntry6.picture1Address = @"testImage6";
    
    testEntry7.date = [NSDate date];
    testEntry7.mainEmotion = @"Soft";
    testEntry7.journalEntry= @"I just feel like such a wimp.  Crazy lady Tanya yelled at me at work and I couldn't stick up for myself.";
    testEntry7.picture1Address = @"testImage7";
    
    testEntry8.date = [[NSDate date] dateByAddingTimeInterval:-60*60*24];
    testEntry8.mainEmotion = @"Terrified";
    testEntry8.journalEntry = @"My neighbor is creeping on me and it's scaring the shit out of me.";
    testEntry8.picture1Address = @"testImage8";
    
    testEntry9.date = [[NSDate date] dateByAddingTimeInterval:-60*60*24*2];
    testEntry9.mainEmotion = @"Miffed";
    testEntry9.journalEntry = @"WTF??? How the hell is Donald Trump going to win the nomination to run for president?\n\nI feel like I'm on crazy pills!!!";
    testEntry9.picture1Address = @"testImage9";
    
    testEntry10.date = [NSDate date];
    testEntry10.mainEmotion = @"Tense";
    testEntry10.journalEntry = @"Big day today.  We present to our biggest client and if it goes well could get a huge contract.";
    testEntry10.picture1Address = @"testImage10";
    
    testEntry11.date = [[NSDate date] dateByAddingTimeInterval:-60*60*24];
    testEntry11.mainEmotion = @"Irritated";
    testEntry11.journalEntry = @"I have the biggest fucking zit on my face and it makes me so fucking annoyed.";
    testEntry11.picture1Address = @"testImage11";
    
    testEntry12.date = [[NSDate date] dateByAddingTimeInterval:-60*60*24*2];
    testEntry12.mainEmotion = @"Down";
    testEntry12.journalEntry = @"My dog died today.  I miss him already.";
    testEntry12.picture1Address = @"testImage12";
    
    testEntry13.date = [NSDate date];
    testEntry13.mainEmotion = @"Mopey";
    testEntry13.journalEntry = @"Ughhhhhh just feeling sorry for myself today.  Need to snap out of it.";
    testEntry13.picture1Address = @"testImage13";
    
    testEntry14.date = [[NSDate date] dateByAddingTimeInterval:-60*60*24];
    testEntry14.mainEmotion = @"Blue";
    testEntry14.journalEntry = @"Today feel's like a day where I want to listen to sad music all day and stay in bed. The weather has got me down.";
    testEntry14.picture1Address = @"testImage14";
    
    testEntry15.date = [[NSDate date] dateByAddingTimeInterval:-60*60*24*2];
    testEntry15.mainEmotion = @"Remorseful";
    testEntry15.journalEntry = @"Feeling pretty bad about how I screamed at my kids yesterday.  Need to make them a nice dinner and tell them that I love them.";
    testEntry15.picture1Address = @"testImage15";
    
    
    [testUser1.journals addObject:testEntry1];
    [testUser1.journals addObject:testEntry2];
    [testUser1.journals addObject:testEntry3];
    [testUser2.journals addObject:testEntry4];
    [testUser2.journals addObject:testEntry5];
    [testUser2.journals addObject:testEntry6];
    [testUser3.journals addObject:testEntry7];
    [testUser3.journals addObject:testEntry8];
    [testUser3.journals addObject:testEntry9];
    [testUser4.journals addObject:testEntry10];
    [testUser4.journals addObject:testEntry11];
    [testUser4.journals addObject:testEntry12];
    [testUser5.journals addObject:testEntry13];
    [testUser5.journals addObject:testEntry14];
    [testUser5.journals addObject:testEntry15];
    
    
    [self.users addObject:testUser1];
    [self.users addObject:testUser2];
    [self.users addObject:testUser3];
    [self.users addObject:testUser4];
    [self.users addObject:testUser5];
    
    
}
















@end
