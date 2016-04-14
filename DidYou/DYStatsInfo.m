//
//  DYStatsInfo.m
//  DidYou
//
//  Created by Kayla Galway on 4/11/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "DYStatsInfo.h"

@implementation DYStatsInfo


-(instancetype)init {
    self = [super init];
    if (self) {
        _happyArray = [NSMutableArray new];
        _excitedArray = [NSMutableArray new];
        _tenderArray = [NSMutableArray new];
        _scaredArray = [NSMutableArray new];
        _angryArray = [NSMutableArray new];
        _sadArray = [NSMutableArray new];
        _journalEntry = [[DYJournalEntry alloc]init];
        _currentUser = [[DYUser alloc]init];
        _arrayOfCurrentMonthJournalDictionaries = [NSMutableArray new];
        _allMoodsArray = @[self.happyArray, self.excitedArray, self.tenderArray, self.scaredArray, self.angryArray, self.sadArray];
    }
    return self;
}

//FOLLOWING TEST METHODS FOR ALL TIME BAR GRAPH

-(CGFloat)moodPercentageForBarGraph:(NSArray *)journalArray {
    CGFloat entriesCount = [journalArray count];
    CGFloat moodPercentage = 0;
    [self addToMoodArrays:journalArray];
    for (NSArray *mainMoodArray in self.allMoodsArray) {
        moodPercentage = [self calculateEmotionPercentage:mainMoodArray ofEntries:entriesCount];
    }
    return moodPercentage;
}

-(CGFloat)calculateEmotionPercentage:(NSArray *)emotionArray ofEntries:(CGFloat)entryCount {
    CGFloat emotionCount = [emotionArray count];
    CGFloat emotionPercentage = (emotionCount / entryCount) * 100;
    return emotionPercentage;
}

//edit mood arrays based on the provided array of journal dictionaries (such as current month dictionary or year dictionary)
-(void)addToMoodArrays: (NSArray *)givenJournalsArray {
    for (DYJournalEntry *currentJournal in givenJournalsArray) {
        NSString *mainEmotionKeyString = [self generateMainEmotion:currentJournal.mainEmotion];
        if ([mainEmotionKeyString isEqualToString:@"Happy"]) {
            [self.happyArray addObject:mainEmotionKeyString];
        } else if ([mainEmotionKeyString isEqualToString:@"Excited"]) {
            [self.excitedArray addObject:mainEmotionKeyString];
        } else if ([mainEmotionKeyString isEqualToString:@"Tender"]) {
            [self.tenderArray addObject:mainEmotionKeyString];
        } else if ([mainEmotionKeyString isEqualToString:@"Scared"]) {
            [self.scaredArray addObject:mainEmotionKeyString];
        } else if ([mainEmotionKeyString isEqualToString:@"Angry"]) {
            [self.angryArray addObject:mainEmotionKeyString];
        } else if ([mainEmotionKeyString isEqualToString:@"Sad"]) {
            [self.sadArray addObject:mainEmotionKeyString];
        }
    }
}

//gets all entries from current month
-(void)getEntriesFromCurrentMonth {
    DYUser *currentUser = [[DYUser alloc]init];
    for (DYJournalEntry *currentJournalEntry in currentUser.journals) {
        NSDateComponents *currentDateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
        NSDateComponents *entryDateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:currentJournalEntry.date];
        if ([entryDateComponents month] == [currentDateComponents month]) {
            [self.arrayOfCurrentMonthJournalDictionaries addObject:currentJournalEntry];
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
