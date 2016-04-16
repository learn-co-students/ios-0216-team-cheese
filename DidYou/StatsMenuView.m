//
//  StatsMenuView.m
//  DidYou
//
//  Created by Kayla Galway on 4/14/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "StatsMenuView.h"

@interface StatsMenuView ()
@property (weak, nonatomic) IBOutlet UIButton *statsWeekButton;
@property (weak, nonatomic) IBOutlet UIButton *statsMonthButton;
@property (weak, nonatomic) IBOutlet UIButton *statsAllTimeButton;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation StatsMenuView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}


-(void)commonInit
{
    [[NSBundle mainBundle] loadNibNamed:@"StatsMenu" owner:self options:nil];

    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
}

@end
