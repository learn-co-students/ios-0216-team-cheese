//
//  MainFeelingView.h
//  DidYou
//
//  Created by Andre Creighton on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoodCircleButton.h"

@protocol MainFeelingViewDelegate <NSObject>

- (void)feelingChosen:(UIButton *)sender;

@end

@interface MainFeelingView : UIView

@property (weak, nonatomic) id <MainFeelingViewDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIView *circleMenuView;

-(UIView *)addCircles;
-(void)addInitialCirclesWithAnimation:(UIView *)currentView;



@end
