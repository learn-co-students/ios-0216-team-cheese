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

@interface DYStatsInfo : NSObject

//once logic is set, remove these properties and reference malleable keys
@property (strong, nonatomic) NSMutableArray *happyArray;
@property (strong, nonatomic) NSMutableArray *excitedArray;
@property (strong, nonatomic) NSMutableArray *tenderArray;
@property (strong, nonatomic) NSMutableArray *scaredArray;
@property (strong, nonatomic) NSMutableArray *angryArray;
@property (strong, nonatomic) NSMutableArray *sadArray;
@property (strong, nonatomic) NSMutableArray *arrayOfJournalDictionaries;
//@property (strong, nonatomic) NSDictionary *journalsDict; -- don't need? replaced with arrayOfJournalDictionaries to reduce lines of code
@property (strong, nonatomic) NSMutableArray *arrayOfCurrentMonthJournalDictionaries;
@property (nonatomic) NSInteger countOfAllEntries;
@property (nonatomic) NSInteger countOfCurrentMonthEntries;

-(instancetype)init;
-(void)getAllJournalsDictionary:(void(^)(BOOL))completion;
-(void)addAllHistoryToMoodArrays:(void(^)(BOOL))completion;
-(void)getEntriesFromCurrentMonth:(void(^)(BOOL))completion;

/*
 @"Happy"
    @"Excited"
    @"Tender"
    @"Scared"
    @"Angry"
    @"Sad"
 */


@end
