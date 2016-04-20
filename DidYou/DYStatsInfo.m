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
        _timePeriod = 3;
        _happyArray = [NSMutableArray new];
        _excitedArray = [NSMutableArray new];
        _tenderArray = [NSMutableArray new];
        _scaredArray = [NSMutableArray new];
        _angryArray = [NSMutableArray new];
        _sadArray = [NSMutableArray new];
        _dataStore = [DataStore sharedDataStore];
        _allMoodsArray = @[self.happyArray, self.excitedArray, self.tenderArray, self.scaredArray, self.angryArray, self.sadArray];
    }
    return self;
}

-(instancetype)initWithTimePeriod: (NSInteger) TimePeriod {
    self = [self init];
    if (self) {
        _timePeriod = TimePeriod;
    }
    return self;
}


-(CGFloat)calculateEmotionPercentage:(NSArray *)emotionArray ofEntries:(NSArray *)entryArray {
    CGFloat emotionCount = [emotionArray count];
    CGFloat entryCount = [entryArray count];
    CGFloat emotionPercentage = (emotionCount / entryCount) * 100;
    return emotionPercentage;
}

//edit mood arrays based on the provided array of journal dictionaries (such as current month dictionary or year dictionary)
-(void)addToMoodArrays {
    NSLog(@"\n\n\n\n\n\nabout to attempt to add to mood arrays\n\n\n\n\n\n");
    for (DYJournalEntry *currentJournal in [self filterByTimePeriod]) {
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

    NSString *mainEmotionKey = @"";
    NSArray *emotionKeysArray = [self.dataStore.emotions allKeys];
    
    for (NSString *emotion in emotionKeysArray) {
        if ([self.dataStore.emotions[emotion] containsObject:storedEmotion]) {
            mainEmotionKey = emotion;
        } else if ([emotion isEqualToString:storedEmotion]){
            mainEmotionKey = emotion;
        }
    }
    NSLog(@"stats info generateMainEmotionTest %@", mainEmotionKey);
    return mainEmotionKey;
}

-(NSMutableArray *)filterByTimePeriod
{
    switch (_timePeriod)
    {
        case 1:
            return [self filterByMonth];
        case 2:
            return [self filterByWeek];
        case 3:
            return [self getAllJournals];
        default:
            NSLog (@"Unknown time period");
            return [@[] mutableCopy];
    }
    
}

-(NSMutableArray *)filterByMonth
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (DYJournalEntry *currentJournalEntry in [self getAllJournals])
    {
        NSDateComponents *currentDateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitDay fromDate:[NSDate date]];
        
        NSDateComponents *entryDateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitDay fromDate:currentJournalEntry.date];
        
        if ([entryDateComponents month] == [currentDateComponents month])
        {
            [array addObject:currentJournalEntry];
        }
        
    }
    return array;
}

-(NSMutableArray *)filterByWeek
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
 for (DYJournalEntry *currentJournalEntry in [self getAllJournals])
 {
     NSDateComponents *currentDateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitDay fromDate:[NSDate date]];
     
     NSDateComponents *entryDateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitDay fromDate:currentJournalEntry.date];
     
     if (([entryDateComponents year] == [currentDateComponents year]) &&
         ([entryDateComponents weekOfYear] == [currentDateComponents weekOfYear]))
     {
         [array addObject:currentJournalEntry];
     }
     
 }
    return array;
}

-(NSMutableArray *)getAllJournals
{
    return self.dataStore.currentUser.journals;
}


-(void)resizeCircles:(UIView *)circleView withPercentage:(CGFloat)percentage {
    CGFloat minimumCircleSize = 60;
    CGFloat maximumCircleSize = 100;
    CGFloat range = maximumCircleSize - minimumCircleSize;
    //.25
    CGFloat sizeIncrement = (range / maximumCircleSize);
    //.0075
    CGFloat calculatedCircleSize = minimumCircleSize + (percentage * sizeIncrement);
    
    
    [circleView.widthAnchor constraintEqualToConstant:calculatedCircleSize].active = YES;
    [circleView.heightAnchor constraintEqualToConstant:calculatedCircleSize].active = YES;
    circleView.layer.cornerRadius = calculatedCircleSize / 2.0;
}


//then another method that counts the number of total emotion values
//then divides the number of total emotion values by the number of the count of each array to create the percentages required
@end
