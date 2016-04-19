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
//@property (weak, nonatomic) DYStatsInfo *currentStats;
@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) NSMutableDictionary *moodStatsDictionary;
@property (strong, nonatomic) NSMutableArray *statsCirclesArray;

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
    
    [self addSubview:self.contentView];
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self.contentView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [self.contentView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    [self.contentView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    
}

-(void)createMoodStatsTitles {
    DYStatsInfo *currentStats = [[DYStatsInfo alloc]init];
    CGFloat emotionPercentage = 0;
    [currentStats addToMoodArrays];
    NSArray *moodName = [self.dataStore.emotions allKeys];
    NSInteger i = 0;
    
    for (NSMutableArray *moodArray in currentStats.allMoodsArray) {
        emotionPercentage = [currentStats calculateEmotionPercentage:moodArray ofEntries:self.dataStore.currentUser.journals];
        NSLog(@"%@ percentage: %f",moodName[i], emotionPercentage);
        NSString *emotionPercentageString = [NSString stringWithFormat:@"%f", emotionPercentage];
        
        [self.moodStatsDictionary setObject:emotionPercentageString forKey:moodName[i]];
        i = i + 1;
        NSLog(@"%@", self.moodStatsDictionary);
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self addStatisticsCircles];
    [self createMoodStatsTitles];
}

-(void)addStatisticsCircles {
    
    UIColor *lavendarColor = [UIColor colorWithRed:211.0f/255.0f green:145.0f/255.0f blue:255.0f/255.0f alpha:0.7];
    
    CGFloat circleDistances = (self.frame.size.width) / 3;
    CGFloat distanceFromCenterX = -circleDistances;
    CGFloat halfDistanceToCenterY = self.frame.size.height / 4;
    [self.statsCirclesArray removeAllObjects];
    for (NSInteger i = 0; i < 3; i++) {
        
        UIView *circleView = [[UIView alloc]init];
        circleView.backgroundColor = lavendarColor;
        [self addSubview:circleView];
        [self.statsCirclesArray addObject:circleView];
        circleView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [circleView.widthAnchor constraintEqualToConstant:100].active = YES;
        [circleView.heightAnchor constraintEqualToConstant:100].active = YES;
        circleView.layer.cornerRadius = 100 / 2.0;
        [circleView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:distanceFromCenterX].active = YES;
        [circleView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:-(halfDistanceToCenterY - 25)].active = YES;
        distanceFromCenterX = distanceFromCenterX + circleDistances;
    }
    
    distanceFromCenterX = -circleDistances;
    
    for (NSInteger i = 0; i < 3; i++) {
        
        UIView *circleView = [[UIView alloc]init];
        circleView.backgroundColor = lavendarColor;
        [self addSubview:circleView];
        [self.statsCirclesArray addObject:circleView];
        circleView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [circleView.widthAnchor constraintEqualToConstant:100].active = YES;
        [circleView.heightAnchor constraintEqualToConstant:100].active = YES;
        circleView.layer.cornerRadius = 100 / 2.0;
        [circleView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:distanceFromCenterX].active = YES;
        [circleView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:(halfDistanceToCenterY + 25)].active = YES;
        distanceFromCenterX = distanceFromCenterX + circleDistances;
    }
    [self addMoodLabels];
}

-(void)addMoodLabels {
    [self createMoodStatsTitles];
    NSArray *moodKeysArray = [self.moodStatsDictionary allKeys];
    NSInteger i = 0;
    for (UIView *circle in self.statsCirclesArray) {
        UILabel *statsLabel = [[UILabel alloc]init];
        NSString *keyString = moodKeysArray[i];
        NSString *percentString = @"%";
        statsLabel.text = [NSString stringWithFormat:@"%@\n%@%@", moodKeysArray[i], self.moodStatsDictionary[keyString], percentString];
        NSLog(@"\n\n\n\nstats label: %@\n\n\n\n\n", statsLabel.text);
        statsLabel.textColor = [UIColor blackColor];
        [statsLabel setFont:[UIFont fontWithName:@"Arial" size:25.0]];
        [circle addSubview:statsLabel];
        NSLog(@"%lu", circle.subviews.count);
        
        [statsLabel.centerYAnchor constraintEqualToAnchor:circle.centerYAnchor].active = YES;
        [statsLabel.centerXAnchor constraintEqualToAnchor:circle.centerXAnchor].active = YES;
        i = i + 1;
    }
}

-(void)createCurrentDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM"];
    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
    //    self.timePeriodLabel.text = stringFromDate;
}

@end