//
//  JournalEntryTableViewCellAlternate.h
//  DidYou
//
//  Created by Brian Clouser on 4/19/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <SWTableViewCell/SWTableViewCell.h>
#import "JournalEntryTableViewCellView.h"

@interface JournalEntryTableViewCellAlternate : SWTableViewCell

@property (weak, nonatomic) IBOutlet JournalEntryTableViewCellView *cellView;


@end
