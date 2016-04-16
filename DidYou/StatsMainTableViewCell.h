//
//  StatsMainEmotions.h
//  DidYou
//
//  Created by Kayla Galway on 4/15/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYStatsInfo.h"

@interface StatsMainTableViewCell : UITableViewCell

@property (strong, nonatomic) DYStatsInfo *stats;
@property (strong, nonatomic) DYJournalEntry *journalEntry;
@property (strong, nonatomic) DYUser *user;

@end
