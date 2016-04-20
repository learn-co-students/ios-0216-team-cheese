//
//  StatsQuestionViewCell.m
//  DidYou
//
//  Created by Kayla Galway on 4/18/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "StatsQuestionViewCell.h"
#import "DYQuestion.h"

@interface StatsQuestionViewCell ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) DYJournalEntry *journalEntry;
@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) DYStatsInfo *statsInfo;
@property (strong, nonatomic) NSMutableArray *answerOneArray;
@property (strong, nonatomic) NSMutableArray *answerTwoArray;
@property (strong, nonatomic) NSMutableArray *answerThreeArray;
@property (strong, nonatomic) NSMutableArray *answerFourArray;
@property (strong, nonatomic) NSMutableArray *answerFiveArray;
@property (strong, nonatomic) NSArray *arrayOfQuestionsArrays;
@property (strong, nonatomic) NSMutableArray *statsCirclesArray;
@property (strong, nonatomic) NSArray *questionsArray;
@property (weak, nonatomic) IBOutlet UILabel *questionsAverageLabel;

@end

@implementation StatsQuestionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
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

-(void)commonInit
{
    
    
    [[NSBundle mainBundle] loadNibNamed:@"StatsQuestionsViewCell" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self.contentView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [self.contentView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    [self.contentView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    
    _dataStore = [DataStore sharedDataStore];
    _answerOneArray = [[NSMutableArray alloc]init];
    _answerTwoArray = [[NSMutableArray alloc]init];
    _answerThreeArray = [[NSMutableArray alloc]init];
    _answerFourArray = [[NSMutableArray alloc]init];
    _answerFiveArray = [[NSMutableArray alloc]init];
    _statsCirclesArray = [[NSMutableArray alloc]init];
    _statsInfo = [[DYStatsInfo alloc]init];
    _arrayOfQuestionsArrays = @[self.answerOneArray, self.answerTwoArray, self.answerThreeArray, self.answerFourArray, self.answerFiveArray];
    _questionsArray = @[@"Sleep", @"Breakfast", @"Exercise", @"Kindness", @"Intimate"];
    /*
     @"get a good night's sleep?"
     @"eat a healthy breakfast?"
     @"workout today?"
     @"do something nice for someone today?"
     @"share physical intimacy with another in the last 24 hours?"]];
     */
    
    [self addQuestionsStats];
}

-(void)layoutSubviews{
    if (self.dataStore.currentUser.journals.count == 0) {
        self.questionsAverageLabel.alpha = 0;
        return;
    } else {
        [super layoutSubviews];
        [self addStatisticsCircles];
        [self addMoodLabels];
    }
}

-(void)addStatisticsCircles {
    
//    UIColor *lavendarColor = [UIColor colorWithRed:211.0f/255.0f green:145.0f/255.0f blue:255.0f/255.0f alpha:0.7];
    CGFloat circleDistances = (self.frame.size.width) / 3;
    CGFloat distanceFromCenterX = -circleDistances;
    CGFloat halfDistanceToCenterY = self.frame.size.height / 5;
    [self.statsCirclesArray removeAllObjects];
    for (NSInteger i = 0; i < 3; i++) {
        
        UIView *circleView = [[UIView alloc]init];
        [self addSubview:circleView];
        [self.statsCirclesArray addObject:circleView];
        circleView.translatesAutoresizingMaskIntoConstraints = NO;
        
        CGFloat calculatedPercent = [self calculateQuestionPercentages:self.arrayOfQuestionsArrays[i]];
        [self.statsInfo resizeCircles:circleView withPercentage:calculatedPercent];
        [self calculateColorAlpha:circleView forPercentage:calculatedPercent];
        [circleView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:distanceFromCenterX].active = YES;
        [circleView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:-(halfDistanceToCenterY - 20)].active = YES;
        distanceFromCenterX = distanceFromCenterX + circleDistances;
    }
    
    
    circleDistances = (self.frame.size.width) / 6;
    distanceFromCenterX = -circleDistances;
    
    for (NSInteger i = 3; i < 5; i++) {
        
        UIView *circleView = [[UIView alloc]init];
        
        [self addSubview:circleView];
        [self.statsCirclesArray addObject:circleView];
        circleView.translatesAutoresizingMaskIntoConstraints = NO;
        
        CGFloat calculatedPercent = [self calculateQuestionPercentages:self.arrayOfQuestionsArrays[i]];
        [self.statsInfo resizeCircles:circleView withPercentage:calculatedPercent];
        [self calculateColorAlpha:circleView forPercentage:calculatedPercent];
        [circleView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:distanceFromCenterX].active = YES;
        [circleView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:(halfDistanceToCenterY + 20)].active = YES;
        distanceFromCenterX = distanceFromCenterX + (circleDistances * 2);
    }
}

-(CGFloat)calculateQuestionPercentages: (NSMutableArray *)questionsArray {
    for (NSMutableArray *questionArray in self.arrayOfQuestionsArrays) {
        [questionArray removeAllObjects];
    }
    [self addQuestionsStats];
    CGFloat percentageOfQuestions = [self.statsInfo calculateEmotionPercentage:questionsArray ofEntries:self.dataStore.currentUser.journals];
    return percentageOfQuestions;
}

-(void)addQuestionsStats {
    for (DYJournalEntry *journalEntry in self.dataStore.currentUser.journals) {
        NSArray *entryQuestionsArray = journalEntry.questions;
        NSInteger i = 0;
        for (DYQuestion *question in entryQuestionsArray) {
            NSLog(@"in addQuestionStats for loop in statsquestionviewcell class");
            if (question.answer == 2) {
                [self.arrayOfQuestionsArrays[i] addObject:question];
            }
            i = i +1;
        }
    }
}

-(NSString *)percentageToString:(CGFloat)calculatedPercentage {
    NSString *emotionPercentageString = [NSString stringWithFormat:@"%f", calculatedPercentage];
    if (calculatedPercentage < 9) {
        emotionPercentageString = [emotionPercentageString substringToIndex:1];
    } else if (calculatedPercentage < 100) {
        emotionPercentageString = [emotionPercentageString substringToIndex:2];
    } else {
        emotionPercentageString = [emotionPercentageString substringToIndex:3];
    }
    if ([self.dataStore.currentUser.journals count] == 0) {
        emotionPercentageString = @"0";
    }
    
    return emotionPercentageString;
}

-(void)calculateColorAlpha:(UIView *)circleView forPercentage:(CGFloat)percentage {
    CGFloat maximumAlpha = 0.7;
    CGFloat minimumAlpha = 0.1;
    CGFloat range = maximumAlpha - minimumAlpha;
    CGFloat alphaIncrement = (range / maximumAlpha);
    
    if (percentage <50) {
        CGFloat calculatedRedAlpha = minimumAlpha + (percentage / 100 * alphaIncrement);
        UIColor *redAlphaColor = [UIColor colorWithRed:255.0f/255.0f green:59.0f/255.0f blue:59.0f/255.0f alpha:calculatedRedAlpha];
        circleView.backgroundColor = redAlphaColor;
        
    } else if (percentage >=50) {
        CGFloat calculatedGreenAlpha = minimumAlpha + (percentage / 100 * alphaIncrement);
        UIColor *greenAlphaColor = [UIColor colorWithRed:65.0f/255.0f green:194.0f/255.0f blue:65.0f/255.0f alpha:calculatedGreenAlpha];
        circleView.backgroundColor = greenAlphaColor;
    }
}

-(void)addMoodLabels {
    
    NSInteger i = 0;
    
    for (UIView *circle in self.statsCirclesArray) {
        UILabel *statsLabel = [[UILabel alloc]init];
        statsLabel.numberOfLines = 2;
        statsLabel.textAlignment = NSTextAlignmentCenter;
        
        CGFloat calculatedPercent = [self calculateQuestionPercentages:self.arrayOfQuestionsArrays[i]];
        NSString *calculatedPercentString = [self percentageToString:calculatedPercent];
        NSString *percentSymbolString = @"%";
        
        statsLabel.text = [NSString stringWithFormat:@"%@\n %@%@", self.questionsArray[i], calculatedPercentString, percentSymbolString];
        NSLog(@"\n\n\n\nstats label: %@\n\n\n\n\n", statsLabel.text);
        statsLabel.textColor = [UIColor blackColor];
        [statsLabel setFont:[UIFont fontWithName:@"Arial" size:14.0]];
        [self addSubview:statsLabel];
        
        statsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        NSLog(@"%lu", circle.subviews.count);
        
        [statsLabel.centerYAnchor constraintEqualToAnchor:circle.centerYAnchor].active = YES;
        [statsLabel.centerXAnchor constraintEqualToAnchor:circle.centerXAnchor].active = YES;
        [statsLabel.heightAnchor constraintEqualToAnchor:circle.heightAnchor multiplier:.5].active = YES;
        i = i + 1;
    }
}
@end
