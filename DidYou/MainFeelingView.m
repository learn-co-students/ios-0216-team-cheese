//
//  MainFeelingView.m
//  DidYou
//
//  Created by Andre Creighton on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "MainFeelingView.h"
#import "CategoryFeelingView.h"





@interface MainFeelingView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) DYJournalEntry *currentEntry;
@property (strong, nonatomic) UILabel *topLabel;
@property (strong, nonatomic) NSMutableArray *circleButtons;


@end


@implementation MainFeelingView

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
    
    self.dataStore = [DataStore sharedDataStore];
    
    NSArray *journals = self.dataStore.currentUser.journals;
    
  //  NSLog(@"in the common init for main feeling, the number or journals is: %lu", self.dataStore.currentUser.journals.count);
    
    self.currentEntry = [journals lastObject];
    self.circleButtons = [[NSMutableArray alloc] init];
    
    [self addInitialCirclesWithAnimation];
  
    
}

-(IBAction)firstCircleMenuButtonTapped:(id)sender
{
    

    UIButton *firstTappedButton = sender;
    
    [self tappedButtonPulseWithAnimation:firstTappedButton];
    
    [self newButtonMenuWithAnimation:sender];
    
    NSString *chosenEmotion = firstTappedButton.titleLabel.text;
    
    self.topLabel.text = [NSString stringWithFormat:@"Just %@, or", [chosenEmotion lowercaseString]];

    
}

-(IBAction)secondCircleMenuButtonTapped:(id)sender
{
    UIButton *secondTappedButton = sender;
    
    [self tappedButtonPulseWithAnimation:secondTappedButton];
    
    self.currentEntry.mainEmotion = secondTappedButton.titleLabel.text;
    
    [UIView animateWithDuration:.5 delay:0 options:0 animations:^{
        
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self.delegate feelingChosen:sender];
        
    }];
    
}

-(void)originalTitle
{
    self.topLabel = [[UILabel alloc] init];
    self.topLabel.text = @"How are you feeling?";
    self.topLabel.textAlignment = NSTextAlignmentCenter;
    
    self.topLabel.font = [self.topLabel.font fontWithSize:35];
    
    self.topLabel.adjustsFontSizeToFitWidth = YES;
    
    self.topLabel.textColor = [UIColor colorWithRed:111.0/255 green:113.0/255 blue:121.0/255 alpha:1];
    
    [self addSubview:self.topLabel];
    
    self.topLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.topLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:40].active = YES;
    [self.topLabel.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:.9].active = YES;
    [self.topLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [self.topLabel.heightAnchor constraintEqualToConstant:70];
    
}



-(void)addCircles {
    
    self.backgroundColor = [UIColor clearColor];
    
    NSArray *moodsArray = [self.dataStore.emotions allKeys];
    
    NSLog(@"%lu", moodsArray.count);
    
    CGFloat r = 115;
    
    for (NSUInteger i = 0; i < moodsArray.count; i++) {
        CGFloat angle = i * M_PI * 2 / moodsArray.count;
        CGFloat centerXOffset = r * cosf(angle);
        CGFloat centerYOffset = r * sinf(angle);
        
        MoodCircleButton *outerCircleButton = [[MoodCircleButton alloc] init];
        
        outerCircleButton.alpha = 0;
        
        [outerCircleButton setTitle:moodsArray[i] forState:UIControlStateNormal];
        [outerCircleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //outerCircleButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        outerCircleButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:outerCircleButton];
        
        [self.circleButtons addObject:outerCircleButton];
        
        outerCircleButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        [outerCircleButton.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:centerXOffset].active = YES;
        [outerCircleButton.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:centerYOffset].active = YES;
        [outerCircleButton.widthAnchor constraintEqualToConstant:100].active = YES;
        [outerCircleButton.heightAnchor constraintEqualToConstant:100].active = YES;
        
        [outerCircleButton addTarget:self
                              action:@selector(firstCircleMenuButtonTapped:)
                    forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}

-(void)addInitialCirclesWithAnimation
{
   
    
    
    [UIButton animateWithDuration:.2
                            delay:1
                          options:0
                       animations:^{
                           
                           [self originalTitle];
                           
                           [self addCircles];
                           
                           [self layoutIfNeeded];
                           
                       } completion:^(BOOL finished) {
                           
                           CGFloat totalduration = 1;
                           
                           for (NSInteger i = 0; i < self.circleButtons.count; i++) {
                               
                               //CGFloat number = (i + 10);
                               
                               CGFloat duration = (i * totalduration / self.circleButtons.count);
                               
                               [self initialButtonsAppearWithAnimation:self.circleButtons[i]
                                                          withDuration:duration
                                                           withButtons:self.circleButtons[i]
                                                             withIndex:i];
                               
                           }
                           
                       }];
}


-(void)initialButtonsAppearWithAnimation:(UIView *)view  withDuration:(NSTimeInterval)duration withButtons:(UIButton *)buttons withIndex:(NSInteger)index {
    
    NSLog(@"%lu",index);
    
    UIColor *lavendarColor = [UIColor colorWithRed:211.0f/255.0f green:145.0f/255.0f blue:255.0f/255.0f alpha:0.7];
    UIColor *blueColor = [UIColor colorWithRed:104.0f/255.0f green:183.0f/255.0f blue:255.0f/255.0f alpha:0.7];
    UIColor *redColor = [UIColor colorWithRed:255.0f/255.0f green:59.0f/255.0f blue:59.0f/255.0f alpha:0.5];
    UIColor *orangeColor = [UIColor colorWithRed:253.0f/255.0f green:174.0f/255.0f blue:55.0f/255.0f alpha:0.8];
    UIColor *greenColor = [UIColor colorWithRed:65.0f/255.0f green:194.0f/255.0f blue:65.0f/255.0f alpha:0.7];
    UIColor *grayColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:0.7];
    
    NSArray *buttonColorsArray = @[lavendarColor, redColor, blueColor, orangeColor, grayColor, greenColor];
    
    
    [UIView animateWithDuration:duration
                     animations:^{
                         
                         UIColor *currentColor = buttonColorsArray[index];
                         
                         buttons.layer.backgroundColor = currentColor.CGColor;
                         
                         //below are the gradients that we could either turn off or on
                         /*
                          CAGradientLayer *gradientLayer = [CAGradientLayer layer];
                          gradientLayer.frame = buttons.layer.bounds;
                          
                          gradientLayer.colors = [NSArray arrayWithObjects:
                          (id)[UIColor colorWithWhite:1.0f alpha:0.1f].CGColor,
                          (id)[UIColor colorWithWhite:0.4f alpha:0.5f].CGColor,
                          nil];
                          
                          gradientLayer.locations = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.0f],
                          [NSNumber numberWithFloat:1.0f],
                          nil];
                          
                          gradientLayer.cornerRadius = buttons.layer.cornerRadius;
                          [buttons.layer addSublayer:gradientLayer];
                          */
                         
                         //                         buttons.backgroundColor= [UIColor colorWithRed:(204 / 255) green:(229 / 255) blue:(255 / 255) alpha:0.2];
                         //                         buttons.layer.borderColor = [UIColor colorWithRed:(160 / 255) green:(160 / 255) blue:(160 / 255) alpha:0.1].CGColor;
                         //                         buttons.layer.borderWidth = 2.0;
                         
                         view.alpha = 1.0;
                         
                     }];
    
}



-(void)newButtonMenuWithAnimation:(MoodCircleButton *)tappedButton
{
    for (UIView *view in self.circleButtons) {
        view.alpha = 0.0;
        [view removeFromSuperview];
    }
    
    [self createInvisibleOuterCircles:tappedButton];
    [tappedButton removeConstraints:tappedButton.constraints];
    [self addSubview:tappedButton];
    
    tappedButton.alpha = 1.0;
    
    [UIButton animateWithDuration:0.9
                            delay:0.2
                          options:0
                       animations:^{
                           
                           tappedButton.translatesAutoresizingMaskIntoConstraints = NO;
                           
                           [tappedButton.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
                           [tappedButton.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
                           
                           [tappedButton.widthAnchor constraintEqualToConstant:100].active = YES;
                           [tappedButton.heightAnchor constraintEqualToConstant:100].active = YES;
                           
                           
                           [self layoutIfNeeded];
                           
                       } completion:^(BOOL finished) {
                           
                           for (NSInteger i = 0; i < self.subviews.count; i++) {
                               
                               CGFloat totalduration = 1;
                                   
                                   CGFloat duration = (i * totalduration / self.circleButtons.count);
                               
                               [self buttonsAppearWithAnimation:self.subviews[i]
                                                   withDuration:duration];
                               
                           }
                           
                       }];
    
    [tappedButton addTarget:self
                     action:@selector(secondCircleMenuButtonTapped:)
           forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)buttonsAppearWithAnimation:(UIView *)view  withDuration:(NSTimeInterval)duration {
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:0
                     animations:^{
                         
                         view.alpha = 1.0;
                         
                     } completion:^(BOOL finished) {
                         
                     }];
    
}

-(void)createInvisibleOuterCircles: (UIButton *)tappedButton {
    
    NSString *mainMoodString = tappedButton.titleLabel.text;
    NSArray *specificMoodsArray = self.dataStore.emotions[mainMoodString];
    
    CGFloat r = 115;
    
    for (NSUInteger i = 0; i < specificMoodsArray.count; i++) {
        CGFloat angle = i * M_PI * 2 / specificMoodsArray.count;
        CGFloat centerXOffset = r * cosf(angle);
        CGFloat centerYOffset = r * sinf(angle);
        
        MoodCircleButton *outerCircleButtons = [[MoodCircleButton alloc] init];
        
        
        outerCircleButtons.backgroundColor = tappedButton.backgroundColor;
        /*
         [UIColor colorWithRed:(100 / 255) green:(229 / 255) blue:(255 / 255) alpha:0.1];
         outerCircleButtons.backgroundColor = [UIColor orangeColor];
         outerCircleButtons.layer.borderColor = [UIColor colorWithRed:(160 / 255) green:(160 / 255) blue:(160 / 255) alpha:0.1].CGColor;
         outerCircleButtons.layer.borderWidth = 2.0;
         */
        
        [outerCircleButtons setTitle:specificMoodsArray[i] forState:UIControlStateNormal];
        [outerCircleButtons setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        //[UIColor colorWithRed:(160 / 255) green:(160 / 255) blue:(160 / 255) alpha:0.6] forState:UIControlStateNormal];
        //outerCircleButtons.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        outerCircleButtons.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:outerCircleButtons];
        
        outerCircleButtons.translatesAutoresizingMaskIntoConstraints = NO;
        
        [outerCircleButtons.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:centerXOffset].active = YES;
        [outerCircleButtons.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:centerYOffset].active = YES;
        [outerCircleButtons.widthAnchor constraintEqualToConstant:100].active = YES;
        [outerCircleButtons.heightAnchor constraintEqualToConstant:100].active = YES;
        
        outerCircleButtons.alpha = 0.0;
        
        [outerCircleButtons addTarget:self
                               action:@selector(secondCircleMenuButtonTapped:)
                     forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}

-(void)tappedButtonPulseWithAnimation:(UIButton *)tappedButton {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    //you would set this fromValue to 1.0 if you want it to start at it's current size
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.05)];
    
    //you would set this toValue to 0.0 if you want it to disappear completely
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
    
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 0.3 ;
    [tappedButton.layer addAnimation:animation forKey:@"transform.scale"];
}


@end
