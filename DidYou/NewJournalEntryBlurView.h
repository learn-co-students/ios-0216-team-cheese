//
//  NewJournalEntryBlurView.h
//  DidYou
//
//  Created by Brian Clouser on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYUser.h"

@protocol NewJournalEntryBlurViewDelegate <NSObject>

-(void)totalJournalEntryComplete;

@end

@interface NewJournalEntryBlurView : UIVisualEffectView

@property (strong, nonatomic) DYJournalEntry *currentEntry;
@property (strong, nonatomic) id <NewJournalEntryBlurViewDelegate> delegate;

@end
