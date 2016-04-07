//
//  NewJournalEntryBlurView.h
//  DidYou
//
//  Created by Brian Clouser on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYUser.h"
@class JournalAndPictureView;

@protocol NewJournalEntryBlurViewDelegate <NSObject>

-(void)totalJournalEntryComplete;
- (void)buttonTappedFromJournalandPictureView:(id)sender;

@end

@interface NewJournalEntryBlurView : UIVisualEffectView

@property (strong, nonatomic) DYJournalEntry *currentEntry;
@property (strong, nonatomic) JournalAndPictureView *journalAndPictureView;
@property (strong, nonatomic) id <NewJournalEntryBlurViewDelegate> delegate;


-(void)recieveImageFromMainViewController:(UIImage *)imageRecieved;

@end
