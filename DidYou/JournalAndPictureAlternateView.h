//
//  JournalAndPictureAlternateView.h
//  DidYou
//
//  Created by Brian Clouser on 4/18/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JournalAndPictureAlternateViewDelegate <NSObject>

-(void)doneButtonTapped;

@end

@interface JournalAndPictureAlternateView : UIView


@property (weak, nonatomic) id <JournalAndPictureAlternateViewDelegate> delegate;

@end
