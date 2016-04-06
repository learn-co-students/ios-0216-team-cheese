//
//  AddJournalEntryView.m
//  DidYou
//
//  Created by Brian Clouser on 3/30/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "AddJournalEntryView.h"


@interface AddJournalEntryView ()


@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (strong, nonatomic) UIView *circleView;

@end


@implementation AddJournalEntryView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self setUpView];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setUpView];
    }
    
    return self;
}

-(void)setUpView
{
    
    
    [[NSBundle mainBundle] loadNibNamed:@"AddJournalEntry" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    [self addCircleView];
    
}

- (IBAction)whenAddButtonTapped:(id)sender
{
    
    [self.delegate addButtonTapped:sender];
    

}

-(void)addCircleView
{
  
    
    [self addSubview:self.circleView];
    
    self.circleView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //self.circleView.frame.size.height = 100;
    
    
    
    [self.circleView.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:.4].active = YES;
    [self.circleView.heightAnchor constraintEqualToAnchor:self.circleView.widthAnchor].active = YES;
    [self.circleView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-15].active = YES;
    [self.circleView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-15].active = YES;
    
    NSLog(@"The width of the circleView is %f", self.circleView.frame.size.width);
    
    CGFloat circleSize = MAX(self.circleView.frame.size.width, self.circleView.frame.size.height);
    
    self.circleView.layer.cornerRadius = circleSize / 2 ;
    

    
    self.circleView.backgroundColor = [UIColor blueColor];

    
    
}




@end
