//
//  NoStatsDataView.m
//  DidYou
//
//  Created by Kayla Galway on 4/20/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "NoStatsDataView.h"
#import "DataStore.h"

@interface NoStatsDataView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) DataStore *dataStore;

@end

@implementation NoStatsDataView

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
    [[NSBundle mainBundle] loadNibNamed:@"NoStatsDataView" owner:self options:nil];
    
    [self addSubview:self.contentView];
    _dataStore = [DataStore sharedDataStore];
    self.contentView.frame = self.bounds;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.dataStore.currentUser.journals.count == 0) {
        self.alpha = 1;
    } else {
        self.alpha = 0;
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
