//
//  DYStatsInfo.h
//  DidYou
//
//  Created by Kayla Galway on 4/11/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataStore.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "DYUser.h"
#import "DYJournalEntry.h"

@interface DYStatsInfo : NSObject

@property (strong, nonatomic) DYUser *currentUser;
@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) DYJournalEntry *journalEntry;
@property (strong, nonatomic) NSMutableArray *happyArray;
@property (strong, nonatomic) NSMutableArray *excitedArray;
@property (strong, nonatomic) NSMutableArray *tenderArray;
@property (strong, nonatomic) NSMutableArray *scaredArray;
@property (strong, nonatomic) NSMutableArray *angryArray;
@property (strong, nonatomic) NSMutableArray *sadArray;
@property (strong, nonatomic) NSArray *allMoodsArray;
@property (strong, nonatomic) NSMutableArray *arrayOfCurrentMonthJournalDictionaries;
@property (nonatomic) NSInteger countOfAllEntries;
@property (nonatomic) NSInteger countOfCurrentMonthEntries;

-(CGFloat)calculateEmotionPercentage:(NSArray *)emotionArray ofEntries:(NSArray *)moodArray;
-(void)addToMoodArrays;
-(void)getEntriesFromCurrentMonth;
-(NSString *)generateMainEmotion:(NSString *)storedEmotion;
-(void)resizeCircles:(UIView *)circleView withPercentage:(CGFloat)percentage;
-(instancetype)init;



@end
