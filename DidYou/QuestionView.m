//
//  QuestionView.m
//  DidYou
//
//  Created by Andre Creighton on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "QuestionView.h"
#import "DataStore.h"

@interface QuestionView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *didYouLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIButton *yesButton;
@property (weak, nonatomic) IBOutlet UIButton *noButton;

@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) DYJournalEntry *currentEntry;
@property (strong, nonatomic) DYQuestion *currentQuestion;


@end

@implementation QuestionView


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
    
    
    [[NSBundle mainBundle] loadNibNamed:@"Question" owner:self options:nil];
    
    [UIView animateWithDuration:2 delay:0 options:0 animations:^{
        
        self.alpha = 0;
        
        [self addSubview:self.contentView];
        
        self.contentView.frame = self.bounds;
        
        self.dataStore = [DataStore sharedDataStore];
        
        self.currentEntry = [self.dataStore.currentUser.journals lastObject];
        
        self.currentQuestion = self.currentEntry.questions[0];
        
        self.alpha = 1;

    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)setQuestionIndex:(NSUInteger)questionIndex
{
    _questionIndex = questionIndex;
    
    self.currentQuestion = self.currentEntry.questions[self.questionIndex];
    
    self.questionLabel.text = self.currentQuestion.question;
    
}




- (IBAction)yesButtonTapped:(id)sender
{
    
    self.currentQuestion.answer = 2;
    
    [self.delegate questionAnswered:2];
    
    
}
- (IBAction)noButtonTapped:(id)sender
{
    
    self.currentQuestion.answer = 1;
    
    [self.delegate questionAnswered:1];
    
}

@end
