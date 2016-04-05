//
//  JournalEntryTableViewCellView.h
//  DidYou
//
//  Created by Brian Clouser on 4/5/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYJournalEntry.h"

@interface JournalEntryTableViewCellView : UIView

@property (strong, nonatomic) DYJournalEntry *journalEntry;

@end
