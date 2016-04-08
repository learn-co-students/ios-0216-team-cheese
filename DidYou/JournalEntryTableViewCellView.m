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
@property (weak, nonatomic) IBOutlet UIImageView *sleepIcon;
@property (weak, nonatomic) IBOutlet UIView *sleepView;
@property (weak, nonatomic) IBOutlet UIImageView *breakfastIcon;
@property (weak, nonatomic) IBOutlet UIView *breakfastView;
@property (weak, nonatomic) IBOutlet UIImageView *workoutIcon;
@property (weak, nonatomic) IBOutlet UIView *workoutView;
@property (weak, nonatomic) IBOutlet UIImageView *niceIcon;
@property (weak, nonatomic) IBOutlet UIView *niceView;
@property (weak, nonatomic) IBOutlet UIImageView *sexIcon;
@property (weak, nonatomic) IBOutlet UIView *sexView;

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
    
    [[NSBundle mainBundle] loadNibNamed:@"JournalEntryTableViewCell2" owner:self options:nil];
    
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
    
//    self.question1Image.image = [UIImage imageNamed:@"sleep"];
//    self.question2Image.image = [UIImage imageNamed:@"breakfast_480"];
//    self.question3Image.image = [UIImage imageNamed:@"workout"];
//    self.question4Image.image = [UIImage imageNamed:@"nice"];
//    self.question5Image.image = [UIImage imageNamed:@"sex"];
    
    self.sleepView.layer.cornerRadius = 16;
    self.breakfastView.layer.cornerRadius = 16;
    self.workoutView.layer.cornerRadius = 16;
    self.niceView.layer.cornerRadius = 16;
    self.sexView.layer.cornerRadius = 16;
    
    self.sleepView.backgroundColor = [self colorGivenQuestionAnswer:question1.answer];
    self.breakfastView.backgroundColor = [self colorGivenQuestionAnswer:question2.answer];
    self.workoutView.backgroundColor = [self colorGivenQuestionAnswer:question3.answer];
    self.niceView.backgroundColor = [self colorGivenQuestionAnswer:question4.answer];
    self.sexView.backgroundColor = [self colorGivenQuestionAnswer:question5.answer];
    
    
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
        return [UIColor colorWithRed:255.0/255.0 green:0 blue:17.0/255.0 alpha:.5];
    }
    else if (answer == 1)
    {
        return [UIColor colorWithRed:255.0/255.0 green:0 blue:17.0/255.0 alpha:.5];
    }
    else
    {
        return [UIColor colorWithRed:34.0/255.0 green:164.0/255.0 blue:0 alpha:.5];
    }
}


@end
