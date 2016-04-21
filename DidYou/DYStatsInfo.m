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
        _allMoodsArray = @[self.sadArray, self.happyArray, self.scaredArray, self.angryArray, self.tenderArray, self.excitedArray];

    }
    return self;
}


-(CGFloat)calculateEmotionPercentage:(NSArray *)emotionArray ofEntries:(NSArray *)entryArray
{
    CGFloat emotionCount = [emotionArray count];
    CGFloat entryCount = [entryArray count];
    CGFloat emotionPercentage = (emotionCount / entryCount) * 100;
    return emotionPercentage;
}

//edit mood arrays based on the provided array of journal dictionaries (such as current month dictionary or year dictionary)
-(void)addToMoodArrays
{
    for (DYJournalEntry *currentJournal in self.dataStore.currentUser.journals) {
        NSLog(@"entering the for loop");
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

//changes sub emotion to a main emotion key (so switches something like blue to sad)
-(NSString *)generateMainEmotion:(NSString *)storedEmotion
{
    NSString *mainEmotionKey = @"";
    NSArray *emotionKeysArray = [self.dataStore.emotions allKeys];
    
    for (NSString *emotion in emotionKeysArray) {
        if ([self.dataStore.emotions[emotion] containsObject:storedEmotion]) {
            mainEmotionKey = emotion;
        } else if ([emotion isEqualToString:storedEmotion]){
            mainEmotionKey = emotion;
        }
    }
    return mainEmotionKey;
}

//gets all entries from current month
-(void)getEntriesFromCurrentMonth
{
    DYUser *currentUser = [[DYUser alloc]init];
    for (DYJournalEntry *currentJournalEntry in currentUser.journals) {
        NSDateComponents *currentDateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
        NSDateComponents *entryDateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:currentJournalEntry.date];
        if ([entryDateComponents month] == [currentDateComponents month]) {
            [self.arrayOfCurrentMonthJournalDictionaries addObject:currentJournalEntry];
        }
    }
}

-(void)resizeCircles:(UIView *)circleView withPercentage:(CGFloat)percentage
{
    CGFloat minimumCircleSize = 70;
    CGFloat maximumCircleSize = 100;
    CGFloat range = maximumCircleSize - minimumCircleSize;
    CGFloat sizeIncrement = (range / maximumCircleSize);
    CGFloat calculatedCircleSize = minimumCircleSize + (percentage * sizeIncrement);
    
    [circleView.widthAnchor constraintEqualToConstant:calculatedCircleSize].active = YES;
    [circleView.heightAnchor constraintEqualToConstant:calculatedCircleSize].active = YES;
    circleView.layer.cornerRadius = calculatedCircleSize / 2.0;
}


@end
