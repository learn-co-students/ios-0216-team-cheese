//
//  StatsViewController.h
//  DidYou
//
//  Created by Brian Clouser on 3/30/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYStatsInfo.h"

@interface StatsViewController : UIViewController

@property (strong, nonatomic) DYStatsInfo *statsInfo;
@property (strong, nonatomic) NSArray *arrayOfStatsDataDictionaries;
@property (strong, nonatomic) NSDictionary *personalStatsDataDictionary;
@property (strong, nonatomic) NSDictionary *cityStatsDataDictionary;
@property (strong, nonatomic) NSDictionary *worldStatsDataDictionary;


@end
