//
//  DYStatsInfo.h
//  DidYou
//
//  Created by Kayla Galway on 4/11/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataStore.h"

@interface DYStatsInfo : NSObject

//once logic is set, remove these properties and reference malleable keys
@property (strong, nonatomic) NSMutableArray *happyArray;
@property (strong, nonatomic) NSMutableArray *excitedArray;
@property (strong, nonatomic) NSMutableArray *tenderArray;
@property (strong, nonatomic) NSMutableArray *scaredArray;
@property (strong, nonatomic) NSMutableArray *angryArray;
@property (strong, nonatomic) NSMutableArray *sadArray;
@property (strong, nonatomic) NSDictionary *journalsDict;

-(instancetype)init;
-(void)getJournalsDictionary:(void(^)(BOOL))completion;
-(void)addToMoodArrays:(void(^)(BOOL))completion;

/*
 @"Happy"
    @"Excited"
    @"Tender"
    @"Scared"
    @"Angry"
    @"Sad"
 */


@end
