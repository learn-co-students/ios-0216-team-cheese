//
//  StatsCellView.m
//  DidYou
//
//  Created by Kayla Galway on 4/18/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "StatsMoodCellView.h"
#import "DYStatsInfo.h"

@interface StatsMoodCellView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) NSMutableDictionary *moodStatsDictionary;
@property (strong, nonatomic) NSMutableArray *statsCirclesArray;
@property (weak, nonatomic) IBOutlet UILabel *moodsAverageLabel;
@property (strong, nonatomic) NSArray *moodColorsArray;

@end

@implementation StatsMoodCellView

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

-(void)awakeFromNib{
    [super awakeFromNib];
    //    [self makeSubviewCircles];
}

-(void)commonInit
{
    [[NSBundle mainBundle] loadNibNamed:@"StatsMoodsViewCell" owner:self options:nil];
    
    _dataStore = [DataStore sharedDataStore];
    _moodStatsDictionary = [[NSMutableDictionary alloc]init];
    _statsCirclesArray = [[NSMutableArray alloc]init];
    _moodColorsArray = @[];
    
    [self addSubview:self.contentView];
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self.contentView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [self.contentView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    [self.contentView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    
}

-(void)layoutSubviews{
    if (self.dataStore.currentUser.journals.count == 0) {
        self.moodsAverageLabel.alpha = 0;
        return;
    } else {
        [super layoutSubviews];
        //if datastore journals entry is 0
        //load nib
        [self addStatisticsCircles];
        [self createMoodStatsTitles];
        [self addMoodLabels];
    }
    
}

-(void)checkForJournalEntries {
    if (self.dataStore.currentUser.journals.count == 0) {
        
    }
}

-(void)addStatisticsCircles {
    DYStatsInfo *statsInfo = [[DYStatsInfo alloc]init];
    [statsInfo addToMoodArrays];
    [self addMoodColorsToArray];
    NSLog(@"mood colors array: %@", self.moodColorsArray);
    
    
    CGFloat circleDistances = (self.frame.size.width) / 3;
    CGFloat distanceFromCenterX = -circleDistances;
    CGFloat halfDistanceToCenterY = self.frame.size.height / 4.5;
    [self.statsCirclesArray removeAllObjects];
    for (NSInteger i = 0; i < 3; i++) {
        
        UIView *circleView = [[UIView alloc]init];
        circleView.backgroundColor = self.moodColorsArray[i];
        [self addSubview:circleView];
        [self.statsCirclesArray addObject:circleView];
        circleView.translatesAutoresizingMaskIntoConstraints = NO;
        
        CGFloat emotionPercentage = [statsInfo calculateEmotionPercentage:statsInfo.allMoodsArray[i] ofEntries:self.dataStore.currentUser.journals];
        [statsInfo resizeCircles:circleView withPercentage:emotionPercentage];
        [circleView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:distanceFromCenterX].active = YES;
        [circleView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:-(halfDistanceToCenterY - 15)].active = YES;
        distanceFromCenterX = distanceFromCenterX + circleDistances;
    }
    
    distanceFromCenterX = -circleDistances;
    
    for (NSInteger i = 3; i < 6; i++) {
        
        UIView *circleView = [[UIView alloc]init];
        circleView.backgroundColor = self.moodColorsArray[i];
        [self addSubview:circleView];
        [self.statsCirclesArray addObject:circleView];
        circleView.translatesAutoresizingMaskIntoConstraints = NO;
        
        CGFloat emotionPercentage = [statsInfo calculateEmotionPercentage:statsInfo.allMoodsArray[i] ofEntries:self.dataStore.currentUser.journals];
        [statsInfo resizeCircles:circleView withPercentage:emotionPercentage * 2];
        
        [circleView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:distanceFromCenterX].active = YES;
        [circleView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:(halfDistanceToCenterY + 15)].active = YES;
        distanceFromCenterX = distanceFromCenterX + circleDistances;
    }
}

/*
 tender is grey
 excited is green
 sad is purple
 happy is red
 scared is blue
 angry is yellow
 tender
 */

-(void)createMoodStatsTitles {
    DYStatsInfo *statsInfo = [[DYStatsInfo alloc]init];
    CGFloat emotionPercentage = 0;
    [statsInfo addToMoodArrays];
    NSArray *moodName = [self.dataStore.emotions allKeys];
    NSInteger i = 0;
    
    for (NSMutableArray *moodArray in statsInfo.allMoodsArray) {
        
        emotionPercentage = [statsInfo calculateEmotionPercentage:moodArray ofEntries:self.dataStore.currentUser.journals];
        NSString *emotionPercentageString = [NSString stringWithFormat:@"%f", emotionPercentage];
        NSLog(@"%@", emotionPercentageString);
        if (emotionPercentage < 9) {
            emotionPercentageString = [emotionPercentageString substringToIndex:1];
        } else if (emotionPercentage < 100) {
            emotionPercentageString = [emotionPercentageString substringToIndex:2];
        } else {
            emotionPercentageString = [emotionPercentageString substringToIndex:3];
        }
        if ([self.dataStore.currentUser.journals count] == 0) {
            emotionPercentageString = @"0";
        }
        NSLog(@"%@", moodName);
        [self.moodStatsDictionary setObject:emotionPercentageString forKey:moodName[i]];
        i = i + 1;
    }
    NSLog(@"%@", self.moodStatsDictionary);
}

-(void)addMoodLabels {
    [self createMoodStatsTitles];
    NSArray *moodKeysArray = [self.moodStatsDictionary allKeys];
    NSInteger i = 0;
    
    for (UIView *circle in self.statsCirclesArray) {
        
        UILabel *statsLabel = [[UILabel alloc]init];
        statsLabel.numberOfLines = 2;
        statsLabel.textAlignment = NSTextAlignmentCenter;
        NSString *keyString = moodKeysArray[i];
        NSString *percentString = @"%";
        NSLog(@"%@", keyString);
        NSString *numberString = self.moodStatsDictionary[keyString];
        statsLabel.text = [NSString stringWithFormat:@"%@\n %@%@", moodKeysArray[i], numberString, percentString];
        NSLog(@"\n\n\n\nstats label: %@\n\n\n\n\n", statsLabel.text);
        statsLabel.textColor = [UIColor whiteColor];
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

-(void)addMoodColorsToArray {
    UIColor *lavendarColor = [UIColor colorWithRed:211.0f/255.0f green:145.0f/255.0f blue:255.0f/255.0f alpha:0.5];
    UIColor *blueColor = [UIColor colorWithRed:104.0f/255.0f green:183.0f/255.0f blue:255.0f/255.0f alpha:0.5];
    UIColor *redColor = [UIColor colorWithRed:255.0f/255.0f green:59.0f/255.0f blue:59.0f/255.0f alpha:0.4];
    UIColor *orangeColor = [UIColor colorWithRed:253.0f/255.0f green:174.0f/255.0f blue:55.0f/255.0f alpha:0.5];
    UIColor *greenColor = [UIColor colorWithRed:65.0f/255.0f green:194.0f/255.0f blue:65.0f/255.0f alpha:0.5];
    UIColor *grayColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:0.5];
    self.moodColorsArray = @[lavendarColor, redColor, blueColor, orangeColor, grayColor, greenColor];
}

-(void)createCurrentDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM"];
    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
    //    self.timePeriodLabel.text = stringFromDate;
}
@end
