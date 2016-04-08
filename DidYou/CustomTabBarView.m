//
//  CustomTabBarView.m
//  DidYou
//
//  Created by Brian Clouser on 4/6/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "CustomTabBarView.h"

@interface CustomTabBarView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *userView;
@property (weak, nonatomic) IBOutlet UIView *statsView;
@property (weak, nonatomic) IBOutlet UIView *mainPageView;
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UIImageView *statsIcon;
@property (weak, nonatomic) IBOutlet UIImageView *mainPageIcon;
@property (weak, nonatomic) IBOutlet UIView *mainPageBackView;

@property (strong, nonatomic) UIColor *lightGray;
@property (strong, nonatomic) UIColor *DYBlue;
@property (strong, nonatomic) UIColor *otherGray;

@end

@implementation CustomTabBarView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}

-(void)commonInit
{
    [[NSBundle mainBundle] loadNibNamed:@"CustomTabBar" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    self.DYBlue = [UIColor colorWithRed:70.0/255.0 green:135.0/255.0 blue:255/255 alpha:1];
    self.lightGray = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
    self.otherGray = [UIColor lightGrayColor];
    
    self.mainPageView.layer.cornerRadius = 5;
    
    self.currentScreen = @"main";
    
}

-(void)setCurrentScreen:(NSString *)currentScreen
{
    _currentScreen = currentScreen;
    
    if ([currentScreen isEqualToString:@"main"])
    {
        [self changeTabBarToMainScreen];
    }
    else if ([currentScreen isEqualToString:@"stats"])
    {
        [self changeTabBarToStatsScreen];
    }
    else
    {
        [self changeTabBarToUserScreen];
    }
}


- (IBAction)userIconTapped:(id)sender
{
    // change background colors
    
    [self.delegate userNavigates:@"user"];
    
    NSLog(@"user is getting tapped");
}

- (IBAction)mainPageIconTapped:(id)sender
{

    
    // change both icons to black;
    
    [self.delegate userNavigates:@"main"];
    
}
- (IBAction)statsIconTapped:(id)sender
{
    // change background colors
    
    [self.delegate userNavigates:@"stats"];
}

-(void)changeTabBarToMainScreen
{
    
    self.mainPageView.backgroundColor =  self.DYBlue;
    self.mainPageBackView.backgroundColor = self.DYBlue;
    
    self.mainPageIcon.image = [UIImage imageNamed:@"mainWhite-1"];
    
    self.statsView.backgroundColor = self.lightGray;
    self.userView.backgroundColor = self.lightGray;
    
    self.statsIcon.image = [UIImage imageNamed:@"statsBlack"];
    self.userIcon.image = [UIImage imageNamed:@"userBlack"];
    
    self.mainPageView.alpha = 1;
    self.mainPageBackView.alpha = 1;
    self.statsView.alpha = 1;
    self.userView.alpha = 1;
    
}

-(void)changeTabBarToUserScreen
{
    self.mainPageView.backgroundColor =  self.otherGray;
    self.mainPageBackView.backgroundColor = self.otherGray;
    
    self.mainPageIcon.image = [UIImage imageNamed:@"mainBlack-1"];
    
    self.statsView.backgroundColor = self.lightGray;
    self.statsIcon.image = [UIImage imageNamed:@"statsBlack"];
    
    self.userView.backgroundColor = self.DYBlue;
    self.userIcon.image = [UIImage imageNamed:@"userWhite"];
    
    self.mainPageView.alpha = 1;
    self.mainPageBackView.alpha = 1;
    self.userView.alpha = 1;
    self.statsView.alpha = 1;

}

-(void)changeTabBarToStatsScreen
{
    self.mainPageView.backgroundColor =  self.otherGray;
    self.mainPageBackView.backgroundColor = self.otherGray;
    
    self.mainPageIcon.image = [UIImage imageNamed:@"mainBlack-1"];
    
    self.statsView.backgroundColor = self.DYBlue;
    self.statsIcon.image = [UIImage imageNamed:@"statsWhite"];
    
    self.userView.backgroundColor = self.lightGray;
    self.userIcon.image = [UIImage imageNamed:@"userBlack"];
    
    self.mainPageBackView.alpha = 1;

    self.mainPageView.alpha = 1;
    self.userView.alpha = 1;
    self.statsView.alpha = 1;
}

@end
