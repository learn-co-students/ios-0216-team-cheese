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
#import "CategoryFeelingView.h"
#import "JournalAndPictureView.h"
#import "DataStore.h"

@interface NewJournalEntryBlurView () <MainFeelingViewDelegate, QuestionViewDelegate, JournalAndPictureViewDelegate>

@property (nonatomic) NSUInteger currentQuestionIndex;
@property (strong, nonatomic) QuestionView *questionView;
@property (strong, nonatomic) MainFeelingView *mainFeelingView;
@property (strong, nonatomic) JournalAndPictureView *journalAndPictureView;
@property (strong, nonatomic) DataStore *dataStore;

@property (nonatomic) NSUInteger questionIndex;


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
    
    // create new journal entry
    
    self.dataStore = [DataStore sharedDataStore];
    
    self.currentEntry = [[DYJournalEntry alloc] init];
    
    [self.dataStore.currentUser.journals addObject: self.currentEntry];
    
    // set question index to zero
    self.questionIndex = 0;

    
    //create main feeling view
    _mainFeelingView = [[MainFeelingView alloc] init];
    
    [self setUpInitialConstraintsForAllSubViews];
    
    self.mainFeelingView.delegate = self;
    self.questionView.delegate = self;
    
  
    

    
    
    NSLog(@"in the common init the number of journals now is: %lu", self.dataStore.currentUser.journals.count);

}

-(void)setUpInitialConstraintsForAllSubViews
{
    
    [self.contentView addSubview:self.mainFeelingView];
    
    [self.mainFeelingView removeConstraints:self.mainFeelingView.constraints];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.mainFeelingView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.mainFeelingView.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor].active = YES;
    [self.mainFeelingView.heightAnchor constraintEqualToAnchor:self.contentView.heightAnchor].active = YES;
    [self.mainFeelingView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    [self.mainFeelingView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
    
    [self.mainFeelingView addInitialCirclesWithAnimation:self.mainFeelingView];
    

}

-(void)feelingChosen:(UIButton *)sender
{
    [self leaveMainFeelingView];
    
    [self setUpQuestionView];
    
}

-(void)questionAnswered:(NSUInteger)answer;
{

    self.questionIndex ++;
    
    BOOL questionsDone = (self.questionIndex == self.currentEntry.questions.count);
    
    if (questionsDone)
    {
        [self leaveQuestionView];
        
        [self setUpJournalAndPictureView];
    }
    else
    {
        self.questionView.questionIndex = self.questionIndex;
    }
    
}


-(void)setUpQuestionView
{
    
    self.questionView = [[QuestionView alloc] init];
    
    [self.contentView addSubview:self.questionView];
    
    self.questionView.delegate = self;
    
    self.questionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.questionView.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor].active = YES;
    [self.questionView.heightAnchor constraintEqualToAnchor:self.contentView.heightAnchor].active = YES;
    [self.questionView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    [self.questionView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
    
    DYQuestion *question = self.currentEntry.questions[0];
    
    self.questionView.questionIndex = 0;

}

-(void)setUpJournalAndPictureView
{
    self.journalAndPictureView = [[JournalAndPictureView alloc] init];
    
    [self.contentView addSubview:self.journalAndPictureView];
    
    self.journalAndPictureView.delegate = self;
    
    self.journalAndPictureView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.journalAndPictureView.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor].active = YES;
    [self.journalAndPictureView.heightAnchor constraintEqualToAnchor:self.contentView.heightAnchor].active = YES;
    [self.journalAndPictureView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    [self.journalAndPictureView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
    
}

-(void)leaveQuestionView
{
    self.questionView.alpha = 0;
}

-(void)leaveMainFeelingView
{
    self.mainFeelingView.alpha = 0;
}

-(void)journalComplete:(UIButton *)sender
{
    [self.delegate totalJournalEntryComplete];
    
    [self removeFromSuperview];
}

@end
