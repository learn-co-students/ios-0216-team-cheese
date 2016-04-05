//
//  JournalEntryTableViewCellView.m
//  DidYou
//
//  Created by Brian Clouser on 4/5/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "JournalEntryTableViewCellView.h"

@interface JournalEntryTableViewCellView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *dayOfWeekView;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayOfMonthLabel;

@property (weak, nonatomic) IBOutlet UILabel *emotionLabel;

@property (weak, nonatomic) IBOutlet UIImageView *question1Image;
@property (weak, nonatomic) IBOutlet UIImageView *question2Image;
@property (weak, nonatomic) IBOutlet UIImageView *question3Image;
@property (weak, nonatomic) IBOutlet UIImageView *question4Image;
@property (weak, nonatomic) IBOutlet UIImageView *question5Image;

@end

@implementation JournalEntryTableViewCellView

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
    
    [[NSBundle mainBundle] loadNibNamed:@"JournalEntryTableViewCell" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    
}

-(void)setJournalEntry:(DYJournalEntry *)journalEntry
{
    _journalEntry = journalEntry;
    
    
    DYQuestion *question1 = self.journalEntry.questions[0];
    DYQuestion *question2 = self.journalEntry.questions[1];
    DYQuestion *question3 = self.journalEntry.questions[2];
    DYQuestion *question4 = self.journalEntry.questions[3];
    DYQuestion *question5 = self.journalEntry.questions[4];
    
    self.question1Image.image = [UIImage imageNamed:[self imageNameGivenQuestionAnswer:question1.answer]];
    self.question2Image.image = [UIImage imageNamed:[self imageNameGivenQuestionAnswer:question2.answer]];
    self.question3Image.image = [UIImage imageNamed:[self imageNameGivenQuestionAnswer:question3.answer]];
    self.question4Image.image = [UIImage imageNamed:[self imageNameGivenQuestionAnswer:question4.answer]];
    self.question5Image.image = [UIImage imageNamed:[self imageNameGivenQuestionAnswer:question5.answer]];
    
    self.emotionLabel.text = self.journalEntry.mainEmotion;
    
 
    
    
                                 
}

-(NSString *)imageNameGivenQuestionAnswer:(NSUInteger)answer
{
    if (answer == 0)
    {
        return @"greenDot";
    }
    else if (answer == 1)
    {
        return @"redDot";
    }
    else
    {
        return @"greenDot";
    }
}


@end
