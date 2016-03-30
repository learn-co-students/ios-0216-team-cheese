//
//  DataStore.m
//  DidYou
//
//  Created by Brian Clouser on 3/29/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "DataStore.h"

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
        _users = [[NSMutableArray alloc] init];
        _emotions = [self emotionsDictionary];
        _userUUID = [self userUUID];
        
        [self userUUID];
    }
    
    return self;
}

-(NSDictionary *)emotionsDictionary
{
    
    NSDictionary *emotions = @{ @"Happy"  :  @[ @"Fulfilled",@"Content",@"Glad",@"Complete",@"Satisfied",@"Optimistic",@"Pleased",@"Serene"],
                                @"Excited"  :  @[ @"Ecstatic",@"Engergetic",@"Aroused",@"Bouncy",@"Nervous",@"Perky",@"Antsy",@"Joyful"],
                                @"Tender"  :  @[ @"Intimate",@"Loving",@"Warm-hearted",@"Sympathetic",@"Touched",@"Kind",@"Soft",@"Trusting"],
                                @"Scared"  :  @[ @"Tense",@"Nervous",@"Anxious",@"Jittery",@"Frightened",@"Panic-stricken",@"Terrified",@"Apprehensive"],
                                @"Angry"  :  @[ @"Irritated",@"Resentful",@"Miffed",@"Upset",@"Mad",@"Furious",@"Raging",@"Annoyed"],
                                @"Sad"  :  @[ @"Down",@"Blue",@"Mopey",@"Grieved",@"Dejected",@"Depressed",@"Heartbroken",@"Remorseful"]};
    
    return emotions;
}

-(NSString *)userUUID
{
    // look in NSUserDefaults if UUID exists
    
    NSDictionary *userDefaultsDictionary = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    
    NSArray *userDefaultsKeys = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys];
                                            
    BOOL uuidExists = [userDefaultsKeys containsObject:@"userUUID"];
    
    if (uuidExists)
    {
        return userDefaultsDictionary[@"userUUID"];
    }
    
    else
    {
       
     
        NSString *userUUID = [[NSUUID UUID] UUIDString];
        
        [[NSUserDefaults standardUserDefaults] setObject:userUUID  forKey:@"userUUID"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // create our new user
        
        DYUser *newUser = [[DYUser alloc] initWithUserUUID:userUUID signUpDate:[NSDate date]];
        
        self.currentUser = newUser;
        
        return userUUID;
        
    }
    
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













@end
