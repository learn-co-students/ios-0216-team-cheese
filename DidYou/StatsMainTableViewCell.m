//
//  StatsMainEmotions.m
//  DidYou
//
//  Created by Kayla Galway on 4/15/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "StatsMainTableViewCell.h"

@interface StatsMainTableViewCell ()


@property (weak, nonatomic) IBOutlet UIStackView *horizontalStackView;
@property (strong, nonatomic) IBOutlet UIView *cellContentView;


@end


@implementation StatsMainTableViewCell

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
    [[NSBundle mainBundle] loadNibNamed:@"StatsMainTableViewCell" owner:self options:nil];
    
    [self addSubview:self.cellContentView];
    self.cellContentView.frame = self.bounds;
    [self.cellContentView addSubview:self.horizontalStackView];
    
    
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    
    [self.horizontalStackView addSubview:redView];
    
    [redView.centerXAnchor constraintEqualToAnchor:self.horizontalStackView.centerXAnchor].active= YES;
    [redView.centerYAnchor constraintEqualToAnchor:self.horizontalStackView.centerYAnchor].active = YES;    [redView.heightAnchor constraintEqualToConstant:100].active = YES;
    [redView.widthAnchor constraintEqualToConstant:100].active = YES;
    
    
//    [self addSubview:self.contentView];
//    
//    self.contentView.frame = self.bounds;
//    
//    _circlesArray = [[NSMutableArray alloc]init];
    _stats = [[DYStatsInfo alloc]init];
    _journalEntry = [[DYJournalEntry alloc]init];
    _user = [[DYUser alloc]init];
    
    
}


-(void)createTitle {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM"];
    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
//    self.timePeriodLabel.text = stringFromDate;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
