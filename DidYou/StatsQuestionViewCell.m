//
//  StatsQuestionViewCell.m
//  DidYou
//
//  Created by Kayla Galway on 4/18/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "StatsQuestionViewCell.h"

@interface StatsQuestionViewCell ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) DYJournalEntry *journalEntry;
@property (strong, nonatomic) DataStore *dataStore;

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
}

//for all journalentry objects in journals array
//call method: -(NSMutableDictionary *)serialize
//take return data object and check keys for journalentry[@"questions"];
//create 5 cgfloats, one for each question
//if 2, add to cgfloat, if 1, do nothing
//take final cgfloats for each question and divide from total journal entries





//-(void)layoutSubviews{
//    [super layoutSubviews];
//    [self addStatisticsCircles];
//    [self createMoodStatsTitles];
//}



/*
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
}

-(void)addStatisticsCircles {
    CGFloat circleDistances = (self.frame.size.width) / 3;
    CGFloat distanceFromCenterX = -circleDistances;
    CGFloat halfDistanceToCenterY = self.frame.size.height / 4;
    [self.statsCirclesArray removeAllObjects];
    for (NSInteger i = 0; i < 3; i++) {
        
        UIView *circleView = [[UIView alloc]init];
        circleView.backgroundColor = [UIColor orangeColor];
        [self addSubview:circleView];
        [self.statsCirclesArray addObject:circleView];
        circleView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [circleView.widthAnchor constraintEqualToConstant:100].active = YES;
        [circleView.heightAnchor constraintEqualToConstant:100].active = YES;
        circleView.layer.cornerRadius = 100 / 2.0;
        [circleView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:distanceFromCenterX].active = YES;
        [circleView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:-halfDistanceToCenterY].active = YES;
        distanceFromCenterX = distanceFromCenterX + circleDistances;
    }
    
    distanceFromCenterX = -circleDistances;
    
    for (NSInteger i = 0; i < 3; i++) {
        
        UIView *circleView = [[UIView alloc]init];
        circleView.backgroundColor = [UIColor orangeColor];
        [self addSubview:circleView];
        [self.statsCirclesArray addObject:circleView];
        circleView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [circleView.widthAnchor constraintEqualToConstant:100].active = YES;
        [circleView.heightAnchor constraintEqualToConstant:100].active = YES;
        circleView.layer.cornerRadius = 100 / 2.0;
        [circleView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:distanceFromCenterX].active = YES;
        [circleView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:halfDistanceToCenterY].active = YES;
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

*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
