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
        _dataStore = [DataStore sharedDataStore];
        _journalEntry = [[DYJournalEntry alloc]init];
        _currentUser = [[DYUser alloc]init];
        _arrayOfCurrentMonthJournalDictionaries = [NSMutableArray new];
        _allMoodsArray = @[self.happyArray, self.excitedArray, self.tenderArray, self.scaredArray, self.angryArray, self.sadArray];
    }
    return self;
}

//FOLLOWING TEST METHODS FOR ALL TIME BAR GRAPH


-(CGFloat)calculateEmotionPercentage:(NSArray *)emotionArray ofEntries:(NSArray *)moodArray {
    CGFloat emotionCount = [emotionArray count];
    CGFloat entryCount = [moodArray count];
    CGFloat emotionPercentage = (emotionCount / entryCount) * 100;
    return emotionPercentage;
}

//edit mood arrays based on the provided array of journal dictionaries (such as current month dictionary or year dictionary)
-(void)addToMoodArrays {
    NSLog(@"\n\n\n\n\n\nabout to attempt to add to mood arrays\n\n\n\n\n\n");
    for (DYJournalEntry *currentJournal in self.dataStore.currentUser.journals) {
        NSLog(@"entering the for loop");
        NSString *mainEmotionKeyString = [self generateMainEmotion:currentJournal.mainEmotion];
        if ([mainEmotionKeyString isEqualToString:@"Happy"]) {
            [self.happyArray addObject:mainEmotionKeyString];
            NSLog(@"\n\n\n\n\n\n the happy array is: %@\n\n\n\n\n\n\n", self.happyArray);
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
    NSLog(@"stats info generateMainEmotionTest %@", mainEmotionKey);
    return mainEmotionKey;
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


//then another method that counts the number of total emotion values
//then divides the number of total emotion values by the number of the count of each array to create the percentages required
@end
