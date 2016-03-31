//
//  NewJournalEntryBlurView.h
//  DidYou
//
//  Created by Brian Clouser on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYUser.h"

@interface NewJournalEntryBlurView : UIVisualEffectView

@property (strong, nonatomic) DYJournalEntry *currentEntry;

@end
