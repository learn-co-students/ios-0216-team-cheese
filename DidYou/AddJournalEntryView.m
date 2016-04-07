//
//  AddJournalEntryView.m
//  DidYou
//
//  Created by Brian Clouser on 3/30/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "AddJournalEntryView.h"


@interface AddJournalEntryView ()


@property (strong, nonatomic) IBOutlet UIImageView *contentView;

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

    
    self.circleView = [self createCircleViewWithRadius:80];
    
    [self addSubview:self.circleView];
    
    
    
    
//    self.circleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) ];
//    
//    self.circleView.clipsToBounds = YES;
//    [self setRoundedView:self.circleView toDiameter:100.0];
    
//    self.circleView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    
    //self.circleView.frame.size.height = 100;
    
    
//    
//    [self.circleView.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:.4].active = YES;
//    [self.circleView.heightAnchor constraintEqualToAnchor:self.circleView.widthAnchor].active = YES;
//    [self.circleView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-15].active = YES;
//    [self.circleView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-15].active = YES;
    
    NSLog(@"The width of the circleView is %f", self.circleView.frame.size.width);
    
    
    
    self.circleView.backgroundColor = [UIColor blueColor];
    
  [UIView animateWithDuration:5 delay:2 options:UIViewAnimationOptionAutoreverse animations:^{
      
      self.circleView.frame = CGRectMake(200, -20, 160, 160);
      
  } completion:^(BOOL finished) {
      
      self.circleView.frame = CGRectMake(200, 40, 160, 160);
  }];
    



    
}

- (UIView*)createCircleViewWithRadius:(int)radius
{
    // circle view
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(200, 40, 2 * radius, 2 * radius)];
    circle.layer.cornerRadius = radius;
    circle.layer.masksToBounds = YES;
    
    // border
    circle.layer.borderColor = [UIColor whiteColor].CGColor;
    circle.layer.borderWidth = 1;
    
    // gradient background color
    CAGradientLayer *gradientBg = [CAGradientLayer layer];
    gradientBg.frame = circle.frame;
    gradientBg.frame = circle.bounds;
    gradientBg.colors = [NSArray arrayWithObjects:
                         (id)[UIColor colorWithRed:70.0/255.0 green:135.0/255.0 blue:255/255 alpha:.7].CGColor,
                         (id)[UIColor lightGrayColor].CGColor,
                         nil];
    // vertical gradient
    gradientBg.locations = [NSArray arrayWithObjects:
                            [NSNumber numberWithFloat:0.0f],
                            [NSNumber numberWithFloat:1.0f],
                            nil];
    
    // gradient background
    CALayer *layer = circle.layer;
    layer.masksToBounds = YES;
    [layer insertSublayer:gradientBg atIndex:0];
    
    return circle;
}





@end
