//
//  JournalAndPictureView.h
//  DidYou
//
//  Created by Andre Creighton on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JournalAndPictureViewDelegate <NSObject>

-(void)journalComplete:(UIButton *)sender;

@end

@interface JournalAndPictureView : UIView

@property (strong, nonatomic) id <JournalAndPictureViewDelegate> delegate;

@end
