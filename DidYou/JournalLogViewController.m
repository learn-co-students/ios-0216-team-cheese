//
//  JournalLogViewController.m
//  DidYou
//
//  Created by Andre Creighton on 4/11/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "JournalLogViewController.h"

@interface JournalLogViewController ()
@property (strong,nonatomic) UIColor *createdColor;
@end

@implementation JournalLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.createdColor = [[UIColor alloc]initWithRed:0 green:.50 blue:1 alpha:1];
    [self setUpLabelAndButtonViews];
    [self setUpStackView];
    
}
-(void)setUpLabelAndButtonViews
{
    
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.theLabelForTheDate = [UILabel new];
    [self.theLabelForTheDate setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.theLabelForTheDate];
    [self.theLabelForTheDate.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.theLabelForTheDate.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:.075].active = YES;
    [self.theLabelForTheDate.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    self.theLabelForTheDate.backgroundColor = [UIColor whiteColor];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"eeee , MMMM dd"];
    self.theLabelForTheDate.text = [formatter stringFromDate:self.jorunalEntry.date];
    self.theLabelForTheDate.textAlignment = NSTextAlignmentCenter;
    self.theLabelForTheDate.textColor = [UIColor darkGrayColor];
    self.theLabelForTheDate.font = [UIFont fontWithName:@"TimesNewRoman" size:18];

    self.backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.backButton setImage:[UIImage imageNamed:@"downArrow"] forState:UIControlStateNormal];
    [self.backButton setTintColor:[[UIColor alloc]initWithRed:0 green:.50 blue:1 alpha:1]];
    [self.backButton addTarget:self action:@selector(whenBackButtonIsTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.backButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.backButton];
    [self.backButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active = YES;
    [self.backButton.topAnchor  constraintEqualToAnchor:self.theLabelForTheDate.bottomAnchor constant:-35].active =YES;
    
    

}

-(void)setUpStackView
{
    
    NSLog(@"Setting up stackview");

    //Creating the views...
    UIView *bubbleOneView = [[UIView alloc] init];
    bubbleOneView.backgroundColor = self.createdColor;
    [bubbleOneView.heightAnchor constraintEqualToConstant:50].active = YES;
    [bubbleOneView.widthAnchor constraintEqualToConstant:50].active = YES;

    UIView *bubbleTwoView = [[UIView alloc] init];
    bubbleTwoView.backgroundColor = self.createdColor;
    [bubbleTwoView.heightAnchor constraintEqualToConstant:50].active = YES;
    [bubbleTwoView.widthAnchor constraintEqualToConstant:50].active = YES;

    UIView *bubbleThreeView = [[UIView alloc] init];
    bubbleThreeView.backgroundColor = self.createdColor;
    [bubbleThreeView.heightAnchor constraintEqualToConstant:50].active = YES;
    [bubbleThreeView.widthAnchor constraintEqualToConstant:50].active = YES;

    UIView *bubbleFourView = [[UIView alloc] init];
    bubbleFourView.backgroundColor = self.createdColor;
    [bubbleFourView.heightAnchor constraintEqualToConstant:50].active = YES;
    [bubbleOneView.widthAnchor constraintEqualToConstant:50].active = YES;

    UIView *bubbleFiveView = [[UIView alloc] init];
    bubbleFiveView.backgroundColor = self.createdColor;
    [bubbleFiveView.heightAnchor constraintEqualToConstant:50].active = YES;
    [bubbleFiveView.widthAnchor constraintEqualToConstant:50].active = YES;

    
    //Making the views circles
    bubbleOneView.layer.cornerRadius = 25;
    bubbleTwoView.layer.cornerRadius = 25;
    bubbleThreeView.layer.cornerRadius = 25;
    bubbleFourView.layer.cornerRadius = 25;
    bubbleFiveView.layer.cornerRadius = 25;
    
    
    //Creating StackView
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis         = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.alignment    = UIStackViewAlignmentCenter;
    stackView.spacing      = 15;
    
    //Adding views to the StackView
    [stackView addArrangedSubview:bubbleOneView];
    [stackView addArrangedSubview:bubbleTwoView];
    [stackView addArrangedSubview:bubbleThreeView];
    [stackView addArrangedSubview:bubbleFourView];
    [stackView addArrangedSubview:bubbleFiveView];
    
    [stackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview: stackView];
    
    [stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [stackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    
    
    
    
}

-(IBAction)whenBackButtonIsTapped:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];

}


@end
