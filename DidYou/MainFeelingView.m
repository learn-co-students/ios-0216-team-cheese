//
//  MainFeelingView.m
//  DidYou
//
//  Created by Andre Creighton on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "MainFeelingView.h"
#import "DataStore.h"
#import "SpecificFeelingView.h"


@interface MainFeelingView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *feelingQuestionLabel;
@property (strong, nonatomic) IBOutlet UIButton *happyButton;
@property (strong, nonatomic) IBOutlet UIButton *excitedButton;
@property (strong, nonatomic) IBOutlet UIButton *tenderButton;
@property (strong, nonatomic) IBOutlet UIButton *scaredButton;
@property (strong, nonatomic) IBOutlet UIButton *angryButton;
@property (strong, nonatomic) IBOutlet UIButton *sadButton;

@property (strong, nonatomic) SpecificFeelingView *happyView;
@property (strong, nonatomic) SpecificFeelingView *excitedView;
@property (strong, nonatomic) SpecificFeelingView *tenderView;
@property (strong, nonatomic) SpecificFeelingView *scaredView;
@property (strong, nonatomic) SpecificFeelingView *angryView;
@property (strong, nonatomic) SpecificFeelingView *sadView;

@end


@implementation MainFeelingView

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
    [[NSBundle mainBundle] loadNibNamed:@"MainFeeling" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    self.happyView = [[SpecificFeelingView alloc] init];
    self.excitedView = [[SpecificFeelingView alloc] init];
    self.tenderView = [[SpecificFeelingView alloc] init];
    self.scaredView = [[SpecificFeelingView alloc] init];
    self.angryView = [[SpecificFeelingView alloc] init];
    self.sadView = [[SpecificFeelingView alloc] init];
    
}


@end
