//
//  SpecificFeelingView.m
//  DidYou
//
//  Created by Andre Creighton on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "SpecificFeelingView.h"

@implementation SpecificFeelingView

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
    [[NSBundle mainBundle] loadNibNamed:@"SpecficFeeling" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    
}


@end
