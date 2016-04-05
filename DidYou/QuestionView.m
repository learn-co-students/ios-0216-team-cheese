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
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    self.dataStore = [DataStore sharedDataStore];
    
    self.currentEntry = [self.dataStore.currentUser.journals lastObject];
    
    self.currentQuestion = self.currentEntry.questions[0];
    
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
    
    NSLog(@"answer is: %lu",self.currentQuestion.answer);
    
    ((DYQuestion *)self.currentEntry.questions[self.questionIndex]).answer = 2;
    
    NSLog(@"this answer is: %lu",((DYQuestion *)self.currentEntry.questions[self.questionIndex]).answer);
    
    DYQuestion *whatever = self.currentEntry.questions[self.questionIndex];
    
    whatever.answer = 2;
    
    NSLog(@"Whatever: %lu", whatever.answer);
    
    
    
    [self.delegate questionAnswered:2];
    
    
}
- (IBAction)noButtonTapped:(id)sender
{
    
    self.currentQuestion.answer = 1;
    
    [self.delegate questionAnswered:1];
    
}

@end
