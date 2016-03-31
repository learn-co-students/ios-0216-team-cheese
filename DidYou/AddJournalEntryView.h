//
//  AddJournalEntryView.h
//  DidYou
//
//  Created by Brian Clouser on 3/30/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYJournalEntry.h"

@protocol AddJournalEntryViewDelegate <NSObject>

- (void)addButtonTapped:(UIButton *)sender;

@end


@interface AddJournalEntryView : UIView

@property (weak, nonatomic) id <AddJournalEntryViewDelegate> delegate;
@property (strong, nonatomic) DYJournalEntry *journalEntry;




@end
