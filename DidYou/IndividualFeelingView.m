//
//  IndividualFeelingView.m
//  DidYou
//
//  Created by Brian Clouser on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "IndividualFeelingView.h"

@interface IndividualFeelingView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *feelingNameLabel;

@end

@implementation IndividualFeelingView

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
    
    [[NSBundle mainBundle] loadNibNamed:@"IndividualFeeling" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;

    
}

@end
