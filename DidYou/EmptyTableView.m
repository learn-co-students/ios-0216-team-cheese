//
//  EmptyTableView.m
//  DidYou
//
//  Created by Brian Clouser on 4/14/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "EmptyTableView.h"

@interface EmptyTableView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation EmptyTableView

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
    [[NSBundle mainBundle] loadNibNamed:@"EmptyTable" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;

    
}








@end
