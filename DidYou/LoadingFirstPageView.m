//
//  loadingFirstPageView.m
//  DidYou
//
//  Created by Zirui Branton  on 4/11/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "LoadingFirstPageView.h"
#import "DataStore.h"

@interface LoadingFirstPageView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation LoadingFirstPageView

-(instancetype)init {
    self = [super init];
    if (self) {
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
    
    [[NSBundle mainBundle] loadNibNamed:@"loadingView" owner:self options:nil];
    [self addSubview:self.contentView];
    
    [self.contentView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self.contentView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [self.contentView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [self.contentView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;

    
}




@end
