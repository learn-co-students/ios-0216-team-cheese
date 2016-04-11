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

@property (strong, nonatomic) UIView *blueCircle;
@property (strong, nonatomic) UIView *yellowCircle;
@property (strong, nonatomic) UIView *redCircle;
@property (strong, nonatomic) UIView *orangeCircle;
@property (strong, nonatomic) UIView *purpleCircle;
@property (strong, nonatomic) UIView *grayCircle;

@property (weak, nonatomic) IBOutlet UIView *addButtonView;


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
    self.alpha = 1;
    
    [[NSBundle mainBundle] loadNibNamed:@"AddJournalEntry" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    [self addCircleView];
    
    //[self addTitle];
    
}

- (IBAction)whenAddButtonTapped:(id)sender
{
    
        [self.delegate addButtonTapped:sender];
        
        self.contentView.frame = self.bounds;


}

-(void)addCircleView
{

    
    UIColor *lavendarColor = [UIColor colorWithRed:211.0f/255.0f green:145.0f/255.0f blue:255.0f/255.0f alpha:0.4];
    UIColor *blueColor = [UIColor colorWithRed:104.0f/255.0f green:183.0f/255.0f blue:255.0f/255.0f alpha:0.4];
    UIColor *redColor = [UIColor colorWithRed:255.0f/255.0f green:59.0f/255.0f blue:59.0f/255.0f alpha:0.4];
    UIColor *orangeColor = [UIColor colorWithRed:253.0f/255.0f green:174.0f/255.0f blue:55.0f/255.0f alpha:0.4];
    UIColor *greenColor = [UIColor colorWithRed:65.0f/255.0f green:194.0f/255.0f blue:65.0f/255.0f alpha:0.4];
    UIColor *grayColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:0.4];
    
//    UIColor *blueColor2 = [UIColor colorWithRed:70.0/255.0 green:135.0/255.0 blue:255/255 alpha:.2];
//    UIColor *yellowColor2 = [UIColor colorWithRed:247.0/255.0 green:255.0/255.0 blue:0.0/255 alpha:.2];
//    UIColor *redColor2 = [UIColor colorWithRed:255.0/255.0 green:9.0/255.0 blue:9.0/255.0 alpha:.2];
//    UIColor *orangeColor2 = [UIColor colorWithRed:255.0/255.0 green:128.0/255.0 blue:0.0/255.0 alpha:.2];
//    UIColor *purpleColor2 = [UIColor colorWithRed:127.0/255.0 green:0.0/255.0 blue:255.0/255.0 alpha:.2];
//    UIColor *grayColor2 = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:.2];
    
    self.blueCircle = [self createCircleViewWithRadius:50 originX:200 originY:40 color:lavendarColor];
    self.yellowCircle = [self createCircleViewWithRadius:30 originX:100 originY:60 color:blueColor];
    self.redCircle = [self createCircleViewWithRadius:60 originX:20 originY:20 color:redColor];
    self.orangeCircle = [self createCircleViewWithRadius:20 originX:150 originY:100 color:orangeColor];
    self.purpleCircle = [self createCircleViewWithRadius:50 originX:250 originY:10 color:greenColor];
    self.grayCircle = [self createCircleViewWithRadius:35 originX:5 originY:20 color:grayColor];
    
    UITapGestureRecognizer *blueCircleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(circleTapped)];
    blueCircleTap.numberOfTapsRequired = 1;
    //blueCircleTap.numberOfTouchesRequired = 1;
    blueCircleTap.cancelsTouchesInView = NO;
    blueCircleTap.delaysTouchesBegan = NO;
    blueCircleTap.delaysTouchesEnded = NO;
    
    UITapGestureRecognizer *yellowCircleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(circleTapped)];
    yellowCircleTap.numberOfTapsRequired = 1;
    //yellowCircleTap.numberOfTouchesRequired = 1;
    yellowCircleTap.cancelsTouchesInView = NO;
    yellowCircleTap.delaysTouchesEnded = NO;
    yellowCircleTap.delaysTouchesBegan = NO;
    
    
    UITapGestureRecognizer *redCircleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(circleTapped)];
    redCircleTap.numberOfTapsRequired = 1;
    //redCircleTap.numberOfTouchesRequired = 1;
    redCircleTap.cancelsTouchesInView = NO;
    redCircleTap.delaysTouchesBegan = NO;
    redCircleTap.delaysTouchesEnded = NO;
    
    UITapGestureRecognizer *orangeCircleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(circleTapped)];
    orangeCircleTap.numberOfTapsRequired = 1;
    //orangeCircleTap.numberOfTouchesRequired = 1;
    orangeCircleTap.cancelsTouchesInView = NO;
    orangeCircleTap.delaysTouchesEnded = NO;
    orangeCircleTap.delaysTouchesBegan = NO;
    
    
    UITapGestureRecognizer *purpleCircleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(circleTapped)];
    purpleCircleTap.numberOfTapsRequired = 1;
    //purpleCircleTap.numberOfTouchesRequired = 1;
    purpleCircleTap.cancelsTouchesInView = NO;
    purpleCircleTap.delaysTouchesBegan = NO;
    purpleCircleTap.delaysTouchesBegan = NO;
    
    UITapGestureRecognizer *grayCircleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(circleTapped)];
    grayCircleTap.numberOfTapsRequired = 1;
    //grayCircleTap.numberOfTouchesRequired = 1;
    grayCircleTap.cancelsTouchesInView = NO;
    grayCircleTap.delaysTouchesBegan = NO;
    grayCircleTap.delaysTouchesEnded = NO;
    
    [self addSubview:self.blueCircle];
    [self addSubview:self.yellowCircle];
    [self addSubview:self.redCircle];
    [self addSubview:self.orangeCircle];
    [self addSubview:self.purpleCircle];
    [self addSubview:self.grayCircle];
    
    [self.blueCircle addGestureRecognizer:blueCircleTap];
    [self.yellowCircle addGestureRecognizer:yellowCircleTap];
    [self.orangeCircle addGestureRecognizer:redCircleTap];
    [self.purpleCircle addGestureRecognizer:orangeCircleTap];
    [self.redCircle addGestureRecognizer:purpleCircleTap];
    [self.grayCircle addGestureRecognizer:grayCircleTap];
    
    self.userInteractionEnabled = YES;
    
    self.blueCircle.userInteractionEnabled = YES;
    self.yellowCircle.userInteractionEnabled = YES;
    self.redCircle.userInteractionEnabled = YES;
    self.orangeCircle.userInteractionEnabled = YES;
    self.purpleCircle.userInteractionEnabled = YES;
    self.grayCircle.userInteractionEnabled = YES;
    

    
    
    [self animateView:self.blueCircle withRadius:50];
    [self animateView:self.yellowCircle withRadius:30];
    [self animateView:self.redCircle withRadius:60];
    [self animateView:self.orangeCircle withRadius:20];
    [self animateView:self.purpleCircle withRadius:50];
    [self animateView:self.grayCircle withRadius:35];
    
}

- (UIView*)createCircleViewWithRadius:(int)radius originX:(CGFloat)originX originY:(CGFloat)originY color:(UIColor *)color
{
    // circle view
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 2 * radius, 2 * radius)];
    circle.layer.cornerRadius = radius;
    circle.layer.masksToBounds = YES;
    
    // border
//    circle.layer.borderColor = [UIColor whiteColor].CGColor;
//    circle.layer.borderWidth = 1;
    
    // gradient background color
    CAGradientLayer *gradientBg = [CAGradientLayer layer];
    gradientBg.frame = circle.frame;
    gradientBg.frame = circle.bounds;
    gradientBg.colors = [NSArray arrayWithObjects:
                         (id)color.CGColor,
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

-(void)animateView: (UIView *)circleView withRadius:(CGFloat)radius
{
    NSUInteger xPosition = arc4random_uniform(351);
    NSUInteger yPosition = arc4random_uniform(151);
    NSUInteger time = arc4random_uniform(5);
    
    [UIView animateWithDuration:time + 8 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        circleView.frame = CGRectMake(xPosition, yPosition, radius*2.0, radius*2.0);
    } completion:^(BOOL finished) {
        [self animateView:circleView withRadius:radius];
    }];
    

}


- (IBAction)menuTapped:(id)sender
{
    
    [self.delegate addButtonTapped:sender];
}

-(void)circleTapped
{
    
    NSLog(@"circle tapped");
      [self.delegate addButtonTapped:nil];
}





@end
