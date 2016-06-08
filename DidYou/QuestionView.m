//
//  QuestionView.m
//  DidYou
//
//  Created by Andre Creighton on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "QuestionView.h"
#import "DataStore.h"
#import "DYUser.h"
#import "DYJournalEntry.h"

@interface QuestionView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *didYouLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIButton *yesButton;
@property (weak, nonatomic) IBOutlet UIButton *noButton;

@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) DYJournalEntry *currentEntry;
@property (strong, nonatomic) DYQuestion *currentQuestion;
@property (strong, nonatomic) NSString *iconName;

@property (strong, nonatomic) NSLayoutConstraint *iconCenterXConstraintLeft;
@property (strong, nonatomic) NSLayoutConstraint *iconCenterXConstraintCenter;
@property (strong, nonatomic) NSLayoutConstraint *iconCenterXConstraintRight;

@property (strong, nonatomic) NSLayoutConstraint *iconSmallWidth;
@property (strong, nonatomic) NSLayoutConstraint *iconBigWidth;
@property (strong, nonatomic) NSLayoutConstraint *iconSmallHeight;
@property (strong, nonatomic) NSLayoutConstraint *iconBigHeight;

@property (strong, nonatomic) UIImageView *imageIcon;


@end

@implementation QuestionView


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
    [[NSBundle mainBundle] loadNibNamed:@"Question" owner:self options:nil];

    [self addSubview:self.contentView];
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self.contentView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [self.contentView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [self.contentView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    
    self.dataStore = [DataStore sharedDataStore];
    self.currentEntry = [self.dataStore.currentUser.journals lastObject];
    self.currentQuestion = self.currentEntry.questions[0];
    [self setUpButtons];
}

-(void)setUpButtons
{
    self.yesButton.layer.cornerRadius = 40;
    self.noButton.layer.cornerRadius = 40;
    self.yesButton.backgroundColor = [UIColor colorWithRed:34.0/255.0 green:164.0/255.0 blue:0 alpha:.5];
    self.noButton.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:0 blue:17.0/255.0 alpha:.5];
    self.yesButton.enabled = NO;
    self.noButton.enabled = NO;
    
//    [self layoutIfNeeded];
}

-(void)setUpImageSmall
{
    self.imageIcon = [[UIImageView alloc] init];
    
    [self addSubview:self.imageIcon];
    
    self.imageIcon.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.imageIcon.image = [UIImage imageNamed:self.iconName];
    self.imageIcon.clipsToBounds = YES;
    
    
    [self.imageIcon.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    
    self.iconSmallHeight = [self.imageIcon.heightAnchor constraintEqualToConstant:1];
    self.iconSmallWidth = [self.imageIcon.widthAnchor constraintEqualToConstant:1];
    self.iconBigHeight = [self.imageIcon.heightAnchor constraintEqualToConstant:150];
    self.iconBigWidth = [self.imageIcon.widthAnchor constraintEqualToConstant:150];
    
    self.iconCenterXConstraintLeft = [self.imageIcon.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:-400];
    self.iconCenterXConstraintCenter = [self.imageIcon.centerXAnchor constraintEqualToAnchor:self.centerXAnchor];
    self.iconCenterXConstraintRight = [self.imageIcon.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:400];
    
    self.iconBigWidth.active = NO;
    self.iconBigHeight.active = NO;
    self.iconSmallHeight.active = YES;
    self.iconSmallWidth.active = YES;
    
    self.iconCenterXConstraintRight.active = NO;
    self.iconCenterXConstraintLeft.active = NO;
    self.iconCenterXConstraintCenter.active = YES;
    [self layoutIfNeeded];
}

-(void)moveImageToCenter
{
    
    [self layoutIfNeeded];
    
    [UIView animateWithDuration:.3 animations:^{
        [self layoutIfNeeded];
        self.iconSmallHeight.active = NO;
        self.iconSmallWidth.active = NO;
        self.iconBigWidth.active = YES;
        self.iconBigHeight.active = YES;
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        self.yesButton.enabled = YES;
        self.noButton.enabled = YES;
    }];
}


-(void)setQuestionIndex:(NSUInteger)questionIndex
{
    _questionIndex = questionIndex;
    
    self.currentQuestion = self.currentEntry.questions[self.questionIndex];
    self.questionLabel.text = self.currentQuestion.question;
    
    [self generateIconName];
    
    [self setUpImageSmall];
    
    [self layoutIfNeeded];
    
    [self moveImageToCenter];
}

-(void)generateIconName
{
    
    if ([self.currentQuestion.question isEqualToString:@"get a good night's sleep?"])
    {
        self.iconName = @"darkSleep";
    }
    else if ([self.currentQuestion.question isEqualToString:@"eat a healthy breakfast?"])
    {
        self.iconName = @"breakfastDark";
    }
    else if ([self.currentQuestion.question isEqualToString:@"workout today?"])
    {
        self.iconName = @"workoutDark";
    }
    else if ([self.currentQuestion.question isEqualToString:@"do something nice for someone today?"])
    {
        self.iconName = @"niceDark";
    }
    else
    {
        self.iconName = @"hugDark";
    }
    
}

- (IBAction)yesButtonTapped:(id)sender
{
    
    [UIView animateWithDuration:.3 animations:^{
        self.yesButton.enabled = NO;
        self.noButton.enabled = NO;
        self.iconCenterXConstraintCenter.active = NO;
        self.iconCenterXConstraintRight.active = YES;
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        self.currentQuestion.answer = 2;
        [self.delegate questionAnswered:2];
    }];
}

- (IBAction)noButtonTapped:(id)sender
{
    
    [UIView animateWithDuration:.3 animations:^{
        
        self.yesButton.enabled = NO;
        self.noButton.enabled = NO;
        self.iconCenterXConstraintCenter.active = NO;
        self.iconCenterXConstraintLeft.active = YES;
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        self.currentQuestion.answer = 1;
        [self.delegate questionAnswered:1];
    }];
}

@end
