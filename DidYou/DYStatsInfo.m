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
        _arrayOfCurrentMonthJournalDictionaries = [NSMutableArray new];
        _arrayOfJournalDictionaries = [NSMutableArray new];
    }
    return self;
}

//gets all entries from history
-(void)getAllJournalsDictionary:(void(^)(BOOL))completion{
    DataStore *dataStore = [[DataStore alloc]init];
    //can't run this with childByAppendingPath saying datastore.myRootRef for some reason...(possibly no UUID for comp without phone?)
    
    [[[dataStore.myRootRef childByAppendingPath:@"users"] childByAppendingPath:@"D9F755A7-92DB-4DF4-A4E9-143FA2FCFDD9"]
     observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
         if (snapshot.value == [NSNull null]) {
             NSLog(@"firebase returned null value for path");
             completion(NO);
             return;
         } else {
             NSDictionary *resultDictionary = [snapshot value];
             NSDictionary *journalsDict = resultDictionary[@"journals"];
             for (NSString *journalEntryString in journalsDict) {
                 NSDictionary *journalEntryDetails = journalsDict[journalEntryString];
                 [self.arrayOfJournalDictionaries addObject:journalEntryDetails];
             }
         }
         completion(YES);
     }];
}

//gets all entries from current month
-(void)getEntriesFromCurrentMonth:(void(^)(BOOL))completion {
    [self getAllJournalsDictionary:^(BOOL success) {
        if (success) {
            for (NSDictionary *journalEntryDetails in self.arrayOfJournalDictionaries) {
                NSString *journalDateString = journalEntryDetails[@"date"];
                NSString *journalMonthString = [self getMonthStringFromString:journalDateString];
                NSString *currentMonthString = [self getCurrentMonthString];
                
                if (journalMonthString == currentMonthString) {
                    [self.arrayOfCurrentMonthJournalDictionaries addObject:journalEntryDetails];
                }
            }
            completion(YES);
        }else {
            NSLog(@"could not get journals dictionary for numberOfEntriesOverCurrentMonth method");
            completion(NO);
        }
    }];
}

//edit mood arrays based on the provided array of journal dictionaries (such as current month dictionary or year dictionary)
-(void)addToMoodArrays: (NSDictionary *)givenJournalsArray {
    for (NSDictionary *journalEntryDetails in givenJournalsArray) {
        NSLog(@"journal details dictionary: %@", journalEntryDetails);
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:[NSDate date]];
        NSLog(@"date components %@", components);
        
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
}

//changes sub emotion to a main emotion key (so switches something like blue to sad)
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

-(NSUInteger)calculateEmotionPercentage:(NSArray *)emotionArray ofEntries:(NSUInteger)entryCount {
    NSUInteger emotionCount = [emotionArray count];
    NSUInteger emotionPercentage = (emotionCount / entryCount) * 100;
    return emotionPercentage;
}

-(NSString *)getMonthStringFromString:(NSString *)dateString {
    NSString *removeYearString = [dateString substringFromIndex:5];
    NSString *monthString = [removeYearString substringToIndex:2];
    return monthString;
}

-(NSString *)getCurrentMonthString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM"];
    NSString *stringDate = [dateFormatter stringFromDate:[NSDate date]];
    return stringDate;
}



//DON'T EVEN THINK I USED THESE?

//should I calculate all emotions for the current month?
-(void)calculateEmotionsForCurrentMonth {
    [self getEntriesFromCurrentMonth:^(BOOL success) {
        if (success) {
            self.countOfCurrentMonthEntries = [self.arrayOfCurrentMonthJournalDictionaries count];
        }
    }];
}

-(NSUInteger)numberOfEntriesOverAllTime:(void(^)(BOOL))completion {
    
    [self getAllJournalsDictionary:^(BOOL success) {
        if (success) {
            completion(YES);
        } else {
            NSLog(@"could not get journals dictionary for numberOfEntriesOverAllTime method");
            completion(NO);
        }
    }];
    NSUInteger entriesCount = [self.arrayOfJournalDictionaries count];
    return entriesCount;
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


-(void)addAllHistoryToMoodArrays:(void(^)(BOOL))completion {
    [self getAllJournalsDictionary:^(BOOL success) {
        if (success) {
            //            for (NSString *journalEntryString in [self.journalsDict allKeys]) {
            //                NSDictionary *journalEntryDetails = self.journalsDict[journalEntryString];
            for (NSDictionary *journalEntryDetails in self.arrayOfJournalDictionaries) {
                NSLog(@"journal details dictionary: %@", journalEntryDetails);
                
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:[NSDate date]];
                NSLog(@"date components %@", components);
                
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


/*
 date = "2016-04-13 18:46:10";
 
 NSString *dateString = @"01-02-2010";
 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
 // this is imporant - we set our input date format to match our input string
 // if format doesn't match you'll get nil from your string, so be careful
 [dateFormatter setDateFormat:@"dd-MM-yyyy"];
 NSDate *dateFromString = [[NSDate alloc] init];
 // voila!
 dateFromString = [dateFormatter dateFromString:dateString];
 */





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






@end
