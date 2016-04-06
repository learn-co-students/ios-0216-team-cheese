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

@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayOfMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayOfWeekLabel;

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
    
    self.question1Image.image = [UIImage imageNamed:@"sleep"];
    self.question2Image.image = [UIImage imageNamed:@"breakfast_480"];
    self.question3Image.image = [UIImage imageNamed:@"workout"];
    self.question4Image.image = [UIImage imageNamed:@"nice"];
    self.question5Image.image = [UIImage imageNamed:@"sex"];
    
    self.question1Image.layer.backgroundColor = [[self colorGivenQuestionAnswer:question1.answer] CGColor];
    self.question2Image.layer.backgroundColor = [[self colorGivenQuestionAnswer:question2.answer] CGColor];
    self.question3Image.layer.backgroundColor = [[self colorGivenQuestionAnswer:question3.answer] CGColor];
    self.question4Image.layer.backgroundColor = [[self colorGivenQuestionAnswer:question4.answer] CGColor];
    self.question5Image.layer.backgroundColor = [[self colorGivenQuestionAnswer:question5.answer] CGColor];
  

    
    self.emotionLabel.text = self.journalEntry.mainEmotion;
    
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *weekDayFormatter = [[NSDateFormatter alloc] init];
    
    [dayFormatter setDateFormat:@"d"];
    [monthFormatter setDateFormat:@"MMMM"];
    [weekDayFormatter setDateFormat:@"eeee"];
    
    NSString *month = [monthFormatter stringFromDate:self.journalEntry.date];
    NSString *dayOfMonth = [dayFormatter stringFromDate:self.journalEntry.date];
    NSString *dayOfWeek = [weekDayFormatter stringFromDate:self.journalEntry.date];

    self.monthLabel.text = month;
    self.dayOfMonthLabel.text = dayOfMonth;
    self.dayOfWeekLabel.text = dayOfWeek;
    
}

-(UIColor *)colorGivenQuestionAnswer:(NSUInteger)answer
{
    if (answer == 0)
    {
        return [UIColor grayColor];
    }
    else if (answer == 1)
    {
        return [UIColor redColor];
    }
    else
    {
        return [UIColor greenColor];
    }
}


@end
