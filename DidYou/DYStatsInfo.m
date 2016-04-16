//
//  DYStatsInfo.m
//  DidYou
//
//  Created by Kayla Galway on 4/11/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "DYStatsInfo.h"

@implementation DYStatsInfo

//first graph
//y axis, number of days, or percentage?
//x axis, list of options, happy etc

//orrrr
//brian hates, but pie graph option
//all percentages, by mood

//need to pull from firebase and do the following:
//count number of days with each main mood

//create methods to calculate percentages

//take information of each mood, check questions
//check how many days of each mood correlate with each boolean

//track by week and by all time

//below are concepts of possible methods



-(instancetype)init {
    self = [super init];
    if (self) {
        _happyArray = [NSMutableArray new];
        _excitedArray = [NSMutableArray new];
        _tenderArray = [NSMutableArray new];
        _scaredArray = [NSMutableArray new];
        _angryArray = [NSMutableArray new];
        _sadArray = [NSMutableArray new];
    }
    return self;
}

-(void)getJournalsDictionary:(void(^)(BOOL))completion{
    
    DataStore *dataStore = [[DataStore alloc]init];
    //can't run this with childByAppendingPath saying datastore.myRootRef for some reason...(possibly no UUID for comp without phone?)
    
    [[[dataStore.myRootRef childByAppendingPath:@"users"] childByAppendingPath:@"D9F755A7-92DB-4DF4-A4E9-143FA2FCFDD9"]
     observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
         
         if (snapshot.value == [NSNull null]) {
             NSLog(@"firebase returned null value for path");
             completion(NO);
             return;
         }
         NSDictionary *resultDictionary = [snapshot value];
         self.journalsDict = resultDictionary[@"journals"];
         completion(YES);
     }];
}

-(NSMutableArray *)arrayOfAllUserMoods:(NSDictionary*)userJournalsDict {
    NSDictionary *journalEmotionsDictionary = userJournalsDict[@"emotions"];
    NSMutableArray *moodsArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *entry in journalEmotionsDictionary) {
        NSLog(@"journalEntriesArray: %@ entry:%@", userJournalsDict, entry);
        NSString *currentMood = entry[@"emotion"];
        //the emotions listed are sub-emotions
        //do we want to make it so that when we upload to firebase, we add a string with the main emotion and sub emotion?
        //or do we just want to sort this array to find the key's associated with each sub emotion value
        [moodsArray addObject:currentMood];
    }
    NSLog(@"moods: %@", moodsArray);
    return moodsArray;
}

-(NSString *)generateMainEmotion:(NSString *)storedEmotion {
    DataStore *dataObject = [[DataStore alloc]init];
    NSString *mainEmotionKey = @"";
    NSArray *emotionKeysArray = [dataObject.emotions allKeys];
    
    for (NSString *emotion in emotionKeysArray) {
        if ([dataObject.emotions[emotion] containsObject:storedEmotion]) {
            mainEmotionKey = emotion;
        } else if ([emotion isEqualToString:storedEmotion]){
            mainEmotionKey = emotion;
        }
    }
    return mainEmotionKey;
}

-(void)addToMoodArrays:(void(^)(BOOL))completion {
    [self getJournalsDictionary:^(BOOL success) {
        if (success) {
            for (NSString *journalEntryString in [self.journalsDict allKeys]) {
                NSDictionary *journalEntryDetails = self.journalsDict[journalEntryString];
                NSString *emotionString = journalEntryDetails[@"emotion"];
                NSString *mainEmotion = [self generateMainEmotion:emotionString];
                if ([mainEmotion isEqualToString:@"Happy"]) {
                    [self.happyArray addObject:mainEmotion];
                } else if ([mainEmotion isEqualToString:@"Excited"]) {
                    [self.excitedArray addObject:mainEmotion];
                } else if ([mainEmotion isEqualToString:@"Tender"]) {
                    [self.tenderArray addObject:mainEmotion];
                } else if ([mainEmotion isEqualToString:@"Scared"]) {
                    [self.scaredArray addObject:mainEmotion];
                } else if ([mainEmotion isEqualToString:@"Angry"]) {
                    [self.angryArray addObject:mainEmotion];
                } else if ([mainEmotion isEqualToString:@"Sad"]) {
                    [self.sadArray addObject:mainEmotion];
                }
            }
            completion(YES);
        }
        else {
            NSLog(@"error comparing user submoods to main mood");
            completion(NO);
        }
    }];
}

-(NSUInteger)numberOfEntriesOverAllTime:(void(^)(BOOL))completion {
    [self getJournalsDictionary:^(BOOL success) {
        if (success) {
            completion(YES);
        } else {
            completion(NO);
        }
    }];
    NSUInteger entriesCount = [[self.journalsDict allKeys] count];
    return entriesCount;
}

//-(NSUInteger)numberOfEntriesOverCurrentMonth:(void(^)(BOOL))completion {
//    
//}

-(NSUInteger)calculateEmotionPercentage:(NSArray *)emotionArray ofEntries:(NSUInteger)entryCount {
    NSUInteger emotionCount = [emotionArray count];
    NSUInteger emotionPercentage = (emotionCount / entryCount) * 100;
    return emotionPercentage;
}



/*
 @"Happy"
 @"Excited"
 @"Tender"
 @"Scared"
 @"Angry"
 @"Sad"
 */

//then another method that counts the number of total emotion values
//then divides the number of total emotion values by the number of the count of each array to create the percentages required





//or maybe scrap and use nspredicate
////-(NSArray *)usersWithSameCountry
//{
//    NSString *usersCountry = self.currentUser.country;
//
//    NSPredicate *sameCountryPredictate = [NSPredicate predicateWithFormat:@"country = %@",usersCountry];
//
//    NSArray *usersWithSameCountry = [self.users filteredArrayUsingPredicate:sameCountryPredictate];
//
//    return usersWithSameCountry;
//
//}

/*
 // retrieve the user information from Firebase
 //Firebase *usersRef = [self.myRootRef childByAppendingPath: @"users"];
 //Firebase *userRef = [usersRef childByAppendingPath: userUUID];
 [[[self.myRootRef childByAppendingPath:@"users"] childByAppendingPath:userUUID]
 // Take the snapshot of the entire tree under users/userUUID
 observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
 if (snapshot.value == [NSNull null]) {
 NSLog(@"firebase returned null value for path");
 return;
 }
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
 {
 [journals addObject:[[DYJournalEntry alloc] initWithDeserialize: journalDict[key]]];
 }
 newUser.journals = journals;
 */





@end
