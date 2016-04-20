//
//  CustomTabBarView.h
//  DidYou
//
//  Created by Brian Clouser on 4/6/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomTabBarDelegate <NSObject>

- (void)userNavigates:(NSString *)viewChosen;

@end

@interface CustomTabBarView : UIView

@property (strong, nonatomic) id <CustomTabBarDelegate> delegate;
@property (nonatomic) NSString *currentScreen;
@end
