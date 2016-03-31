//
//  NewJournalEntryBlurView.m
//  DidYou
//
//  Created by Brian Clouser on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "NewJournalEntryBlurView.h"
#import "QuestionView.h"
#import "MainFeelingView.h"
#import "SpecificFeelingView.h"
#import "JournalAndPictureView.h"

@interface NewJournalEntryBlurView ()

@property (nonatomic) NSUInteger currentQuestionIndex;
@property (strong, nonatomic) QuestionView *questionView;
@property (strong, nonatomic) MainFeelingView *mainFeelingView;
@property (strong, nonatomic) SpecificFeelingView *specificFeelingView;
@property (strong, nonatomic) JournalAndPictureView *journalAndPictureView;

@end

@implementation NewJournalEntryBlurView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}

-(instancetype)initWithEffect:(UIVisualEffect *)effect
{
    self = [super initWithEffect:effect];
    
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
    
    _mainFeelingView = [[MainFeelingView alloc] init];
    _questionView = [[QuestionView alloc] init];
    _specificFeelingView = [[SpecificFeelingView alloc] init];
    _journalAndPictureView = [[JournalAndPictureView alloc] init];
    
    [self setUpInitialConstraintsForAllSubViews];

}

-(void)setUpInitialConstraintsForAllSubViews
{
    NSLog(@"getting to constraints for subviews");
    
    [self.contentView addSubview:self.mainFeelingView];
    
    [self.contentView bringSubviewToFront:self.mainFeelingView];
    
    self.mainFeelingView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:self.questionView];
    [self.contentView addSubview:self.specificFeelingView];
    [self.contentView addSubview:self.journalAndPictureView];
    
    [self.questionView removeConstraints:self.questionView.constraints];
    [self.mainFeelingView removeConstraints:self.mainFeelingView.constraints];
    [self.specificFeelingView removeConstraints:self.specificFeelingView.constraints];
    [self.journalAndPictureView removeConstraints:self.journalAndPictureView.constraints];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.questionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.mainFeelingView.translatesAutoresizingMaskIntoConstraints = NO;
    self.specificFeelingView.translatesAutoresizingMaskIntoConstraints = NO;
    self.journalAndPictureView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.mainFeelingView.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor].active = YES;
    [self.mainFeelingView.heightAnchor constraintEqualToAnchor:self.contentView.heightAnchor].active = YES;
    [self.mainFeelingView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    [self.mainFeelingView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
    
    [self.mainFeelingView.widthAnchor constraintEqualToConstant:0].active = YES;
    [self.mainFeelingView.heightAnchor constraintEqualToConstant:0].active = YES;
    [self.mainFeelingView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
    [self.mainFeelingView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
    
    [self.specificFeelingView.widthAnchor constraintEqualToConstant:0].active = YES;
    [self.specificFeelingView.heightAnchor constraintEqualToConstant:0].active = YES;
    [self.specificFeelingView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
    [self.specificFeelingView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
    
    [self.questionView.widthAnchor constraintEqualToConstant:0].active = YES;
    [self.questionView.heightAnchor constraintEqualToConstant:0].active = YES;
    [self.questionView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
    [self.questionView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
    
    [self.journalAndPictureView.widthAnchor constraintEqualToConstant:0].active = YES;
    [self.journalAndPictureView.heightAnchor constraintEqualToConstant:0].active = YES;
    [self.journalAndPictureView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
    [self.journalAndPictureView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
    

}

@end
