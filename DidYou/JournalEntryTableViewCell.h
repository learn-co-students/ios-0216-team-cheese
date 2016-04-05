//
//  JournalEntryTableViewCell.h
//  DidYou
//
//  Created by Brian Clouser on 4/5/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JournalEntryTableViewCellView.h"

@interface JournalEntryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet JournalEntryTableViewCellView *cellView;

@end
