//
//  CategoryFeelingView.h
//  DidYou
//
//  Created by Andre Creighton on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "CategoryFeelingView.h"
#import "IndividualFeelingView.h"
#import "DataStore.h"

@interface CategoryFeelingView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *feelingCategoryLabel;


@property (strong, nonatomic) DataStore *dataStore;



@end

@implementation CategoryFeelingView

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
    [[NSBundle mainBundle] loadNibNamed:@"CategoryFeeling" owner:self options:nil];
    
        [self addSubview:self.contentView];
    
      self.contentView.frame = self.bounds;

    
}

-(void)setFeeling:(NSString *)feeling
{
    _feeling = feeling;
    
    self.feelingCategoryLabel.text = feeling;
    
    if([feeling isEqualToString:@"Happy"])
    {
        self.contentView.backgroundColor = [UIColor redColor];
    }
    else if([feeling isEqualToString:@"Excited"])
    {
        self.contentView.backgroundColor = [UIColor yellowColor];
    }
    else if([feeling isEqualToString:@"Tender"])
    {
        self.contentView.backgroundColor = [UIColor blueColor];
    }
    else if([feeling isEqualToString:@"Scared"])
    {
        self.contentView.backgroundColor = [UIColor darkGrayColor];
    }
    else if([feeling isEqualToString:@"Angry"])
    {
        self.contentView.backgroundColor = [UIColor purpleColor];
    }
    else if([feeling isEqualToString:@"Sad"])
    {
        self.contentView.backgroundColor = [UIColor orangeColor];
    }
    
}




@end
