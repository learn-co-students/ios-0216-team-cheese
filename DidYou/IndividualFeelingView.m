//
//  IndividualFeelingView.m
//  DidYou
//
//  Created by Brian Clouser on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "IndividualFeelingView.h"
#import "DataStore.h"

@interface IndividualFeelingView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *feelingNameLabel;
@property (strong, nonatomic) DataStore *dataStore;

@end

@implementation IndividualFeelingView

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
    
    [[NSBundle mainBundle] loadNibNamed:@"IndividualFeeling" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    

    
}

-(void)setFeelingName:(NSString *)feelingName
{
    _feelingName = feelingName;
    
    self.feelingNameLabel.text = feelingName;
    
    if ([feelingName isEqualToString:@"Happy"])
    {
        self.contentView.backgroundColor = [UIColor redColor];
    }
    else if ([feelingName isEqualToString:@"Excited"])
    {
        self.contentView.backgroundColor = [UIColor blueColor];
    }
    
    else if ([feelingName isEqualToString:@"Tender"])
    {
        self.contentView.backgroundColor = [UIColor orangeColor];
    }
    else if ([feelingName isEqualToString:@"Scared"])
    {
        self.contentView.backgroundColor = [UIColor darkGrayColor];
    }
    else if ([feelingName isEqualToString:@"Angry"])
    {
        self.contentView.backgroundColor = [UIColor yellowColor];
    }
    else if ([feelingName isEqualToString:@"Sad"])
    {
        self.contentView.backgroundColor = [UIColor purpleColor];
    }
    else if ( [[self keyForValue:feelingName] isEqualToString:@"Happy"])
    {
        self.contentView.backgroundColor = [UIColor redColor];
    }
    else if ( [[self keyForValue:feelingName] isEqualToString:@"Excited"])
    {
        self.contentView.backgroundColor = [UIColor blueColor];
    }
    else if ( [[self keyForValue:feelingName] isEqualToString:@"Tender"])
    {
        self.contentView.backgroundColor = [UIColor orangeColor];
    }
    else if ( [[self keyForValue:feelingName] isEqualToString:@"Scared"])
    {
        self.contentView.backgroundColor = [UIColor darkGrayColor];
    }
    else if ( [[self keyForValue:feelingName] isEqualToString:@"Angry"])
    {
        self.contentView.backgroundColor = [UIColor yellowColor];
    }
    else if ( [[self keyForValue:feelingName] isEqualToString:@"Sad"])
    {
        self.contentView.backgroundColor = [UIColor purpleColor];
    }
    
}
        
        
-(NSString *)keyForValue:(NSString *)feeling
{
    
    self.dataStore = [DataStore sharedDataStore];
    
    NSDictionary *emotions = self.dataStore.emotions;
    
    NSArray *keys = [emotions allKeys];
    
    for (NSString *key in keys)
    {
        NSArray *values = emotions[key];
        
        if ([values containsObject:feeling])
        {
            return key;
            
            break;
        }
        
    }
    
    return @"Happy";
    
    
}

@end
