//
//  JournalLogViewController.m
//  DidYou
//
//  Created by Andre Creighton on 4/11/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "JournalLogViewController.h"
#import "DYQuestion.h"

@interface JournalLogViewController ()
@property (strong,nonatomic) UIColor *createdColor;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *emotionLabel;


@property (weak, nonatomic) IBOutlet UIView *question1View;
@property (weak, nonatomic) IBOutlet UIView *question2View;
@property (weak, nonatomic) IBOutlet UIView *question3View;
@property (weak, nonatomic) IBOutlet UIView *question4View;
@property (weak, nonatomic) IBOutlet UIView *question5View;
@property (weak, nonatomic) IBOutlet UITextView *journalTextField;
@property (nonatomic) NSUInteger answer1;
@property (nonatomic) NSUInteger answer2;
@property (nonatomic) NSUInteger answer3;
@property (nonatomic) NSUInteger answer4;
@property (nonatomic) NSUInteger answer5;





@end

@implementation JournalLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.answer1 = ((DYQuestion *)self.journalEntry.questions[0]).answer;
    self.answer2 = ((DYQuestion *)self.journalEntry.questions[1]).answer;
    self.answer3 = ((DYQuestion *)self.journalEntry.questions[2]).answer;
    self.answer4 = ((DYQuestion *)self.journalEntry.questions[3]).answer;
    self.answer5 = ((DYQuestion *)self.journalEntry.questions[4]).answer;
    
    NSLog(@"%lu", self.answer1);
     NSLog(@"%lu", self.answer2);
     NSLog(@"%lu", self.answer3);
     NSLog(@"%lu", self.answer4);
     NSLog(@"%lu", self.answer5);
    
    NSLog(@"%@", self.journalEntry.mainEmotion);
    
    
    
    if (self.journalEntry.journalEntry.length == 0)
    {
        self.journalTextField.text = @"You didn't record a journal for this entry.  Do it next time! Reading your old journals is extremely helpful.";
    }
    else
    {
        self.journalTextField.text = self.journalEntry.journalEntry;
    }
    

    [self makeIconsCircles];
    
    [self generateEmotionLabel];
    
    
//    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
//    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
//    NSDateFormatter *weekDayFormatter = [[NSDateFormatter alloc] init];
//    
//    [dayFormatter setDateFormat:@"d"];
//    [monthFormatter setDateFormat:@"MMMM"];
//    [weekDayFormatter setDateFormat:@"eeee"];
//    
//    NSString *month = [monthFormatter stringFromDate:self.journalEntry.date];
//    NSString *dayOfMonth = [dayFormatter stringFromDate:self.journalEntry.date];
//    NSString *dayOfWeek = [weekDayFormatter stringFromDate:self.journalEntry.date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"eeee, MMMM dd"];
    
    NSString *dateString = [formatter stringFromDate:self.journalEntry.date];
    
    self.dateLabel.text = dateString;

    
    
    

    
  
    
    
    
    
    
    
//    self.createdColor = [[UIColor alloc]initWithRed:0 green:.50 blue:1 alpha:1];
//    [self setUpLabelAndButtonViews];
//    [self setUpStackView];
    
    
}

-(void)makeIconsCircles
{
    
    self.question1View.layer.cornerRadius = 25;
    self.question2View.layer.cornerRadius = 25;
    self.question3View.layer.cornerRadius = 25;
    self.question4View.layer.cornerRadius = 25;
    self.question5View.layer.cornerRadius = 25;
    
    self.question1View.backgroundColor = [self colorGivenQuestionAnswer:self.answer1];
    self.question2View.backgroundColor = [self colorGivenQuestionAnswer:self.answer2];
    self.question3View.backgroundColor = [self colorGivenQuestionAnswer:self.answer3];
    self.question4View.backgroundColor = [self colorGivenQuestionAnswer:self.answer4];
    self.question5View.backgroundColor = [self colorGivenQuestionAnswer:self.answer5];
    
}





-(UIColor *)colorGivenQuestionAnswer:(NSUInteger)answer
{
    if (answer == 0)
    {
        return [UIColor colorWithRed:255.0/255.0 green:0 blue:17.0/255.0 alpha:.5];
    }
    else if (answer == 1)
    {
        return [UIColor colorWithRed:255.0/255.0 green:0 blue:17.0/255.0 alpha:.5];
    }
    else
    {
        return [UIColor colorWithRed:34.0/255.0 green:164.0/255.0 blue:0 alpha:.5];
    }
}

-(void)generateEmotionLabel
{
    self.emotionLabel.text = [NSString stringWithFormat:@"You were feeling %@", self.journalEntry.mainEmotion.lowercaseString];
}


- (IBAction)backButtonTap:(id)sender
{
    NSLog(@"getting tapped");
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
          [self dismissViewControllerAnimated:YES completion:nil];
        
    });

  

}






//-(void)setUpLabelAndButtonViews
//{
//    
//    
//    self.view.backgroundColor = [UIColor lightGrayColor];
//    self.theLabelForTheDate = [UILabel new];
//    [self.theLabelForTheDate setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.view addSubview:self.theLabelForTheDate];
//    [self.theLabelForTheDate.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
//    [self.theLabelForTheDate.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:.075].active = YES;
//    [self.theLabelForTheDate.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
//    self.theLabelForTheDate.backgroundColor = [UIColor whiteColor];
//    NSDateFormatter *formatter = [NSDateFormatter new];
//    [formatter setDateFormat:@"eeee , MMMM dd"];
//    self.theLabelForTheDate.text = [formatter stringFromDate:self.jorunalEntry.date];
//    self.theLabelForTheDate.textAlignment = NSTextAlignmentCenter;
//    self.theLabelForTheDate.textColor = [UIColor darkGrayColor];
//    self.theLabelForTheDate.font = [UIFont fontWithName:@"TimesNewRoman" size:18];
//
//    self.backButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [self.backButton setImage:[UIImage imageNamed:@"downArrow"] forState:UIControlStateNormal];
//    [self.backButton setTintColor:[[UIColor alloc]initWithRed:0 green:.50 blue:1 alpha:1]];
//    [self.backButton addTarget:self action:@selector(whenBackButtonIsTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [self.backButton setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.view addSubview:self.backButton];
//
//    [self.backButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active = YES;
//    [self.backButton.topAnchor  constraintEqualToAnchor:self.theLabelForTheDate.bottomAnchor constant:-40].active =YES;
//    
//    
//
//}
//
//-(void)setUpStackView
//{
//    
//    NSLog(@"Setting up stackview");
//
//    //Creating the views...
//    UIView *bubbleOneView = [[UIView alloc] init];
//    bubbleOneView.backgroundColor = self.createdColor;
//    [bubbleOneView.heightAnchor constraintEqualToConstant:50].active = YES;
//    [bubbleOneView.widthAnchor constraintEqualToConstant:50].active = YES;
//
//    UIView *bubbleTwoView = [[UIView alloc] init];
//    bubbleTwoView.backgroundColor = self.createdColor;
//    [bubbleTwoView.heightAnchor constraintEqualToConstant:50].active = YES;
//    [bubbleTwoView.widthAnchor constraintEqualToConstant:50].active = YES;
//
//    UIView *bubbleThreeView = [[UIView alloc] init];
//    bubbleThreeView.backgroundColor = self.createdColor;
//    [bubbleThreeView.heightAnchor constraintEqualToConstant:50].active = YES;
//    [bubbleThreeView.widthAnchor constraintEqualToConstant:50].active = YES;
//
//    UIView *bubbleFourView = [[UIView alloc] init];
//    bubbleFourView.backgroundColor = self.createdColor;
//    [bubbleFourView.heightAnchor constraintEqualToConstant:50].active = YES;
//    [bubbleOneView.widthAnchor constraintEqualToConstant:50].active = YES;
//
//    UIView *bubbleFiveView = [[UIView alloc] init];
//    bubbleFiveView.backgroundColor = self.createdColor;
//    [bubbleFiveView.heightAnchor constraintEqualToConstant:50].active = YES;
//    [bubbleFiveView.widthAnchor constraintEqualToConstant:50].active = YES;
//
//    
//    //Making the views circles
//    bubbleOneView.layer.cornerRadius = 25;
//    bubbleTwoView.layer.cornerRadius = 25;
//    bubbleThreeView.layer.cornerRadius = 25;
//    bubbleFourView.layer.cornerRadius = 25;
//    bubbleFiveView.layer.cornerRadius = 25;
//    
//    
//    //Creating StackView
//    UIStackView *stackView = [[UIStackView alloc] init];
//    stackView.axis         = UILayoutConstraintAxisHorizontal;
//    stackView.distribution = UIStackViewDistributionFillEqually;
//    stackView.alignment    = UIStackViewAlignmentCenter;
//    stackView.spacing      = 15;
//    
//    //Adding views to the StackView
//    [stackView addArrangedSubview:bubbleOneView];
//    [stackView addArrangedSubview:bubbleTwoView];
//    [stackView addArrangedSubview:bubbleThreeView];
//    [stackView addArrangedSubview:bubbleFourView];
//    [stackView addArrangedSubview:bubbleFiveView];
//    
//    [stackView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.view addSubview: stackView];
//    
//    [stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
//    [stackView.topAnchor constraintEqualToAnchor:self.theLabelForTheDate.bottomAnchor constant:20].active = YES;
//    
//    
//    
//}
//
//-(void)setUpScrollView
//{
//    UIScrollView *scrollView  = [UIScrollView new];
//    //scrollView.contentSize = CGSizeMake(300, 800);
//    scrollView.showsVerticalScrollIndicator = YES;
//    
//    scrollView.backgroundColor = [UIColor greenColor];
//    
//    [scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.view addSubview:scrollView];
//    
//    [scrollView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
//    [scrollView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
//    [scrollView.heightAnchor constraintEqualToConstant:100].active = YES;
//    [scrollView.widthAnchor  constraintEqualToConstant:100].active = YES;
//    
//
//
//}
//
//-(IBAction)whenBackButtonIsTapped:(id)sender
//{
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//
//}


@end
