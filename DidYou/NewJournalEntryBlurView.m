//
//  NewJournalEntryBlurView.m
//  DidYou
//
//  Created by Brian Clouser on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "NewJournalEntryBlurView.h"
#import "QuestionView.h"
#import "MainFeelingView.h"
#import "CategoryFeelingView.h"
#import "JournalAndPictureView.h"
#import "DataStore.h"
#import "DYJournalEntry.h"
#import "DYUser.h"
#import <JHChainableAnimations/JHChainableAnimations.h>
#import "JournalAndPictureAlternateView.h"


@interface NewJournalEntryBlurView () <MainFeelingViewDelegate, QuestionViewDelegate, JournalAndPictureViewDelegate, UIGestureRecognizerDelegate, JournalAndPictureAlternateViewDelegate>

@property (nonatomic) NSUInteger currentQuestionIndex;
@property (strong, nonatomic) QuestionView *questionView;
@property (strong, nonatomic) MainFeelingView *mainFeelingView;
@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIImageView *cancelButtonImage;

@property (strong, nonatomic) NSLayoutConstraint *journalAndPictureViewBottomConstraint;


@property (nonatomic) NSUInteger questionIndex;


@end

@implementation NewJournalEntryBlurView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}

-(instancetype)initWithEffect:(UIVisualEffect *)effect
{
    self = [super initWithEffect:effect];
    
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
    // create new journal entry
    
    self.dataStore = [DataStore sharedDataStore];
    
    self.currentEntry = [[DYJournalEntry alloc] init];
    
    [self.dataStore.currentUser.journals addObject: self.currentEntry];
    
    // set question index to zero
    self.questionIndex = 0;

    
    //create main feeling view
    _mainFeelingView = [[MainFeelingView alloc] init];
    
    [self setUpInitialConstraintsForAllSubViews];
    
    self.mainFeelingView.delegate = self;
    self.questionView.delegate = self;

}

-(void)whenTapGestureIsRecognized:(UITapGestureRecognizer *)sender
{
    /// delegate for japv
    
}

-(void)setUpInitialConstraintsForAllSubViews
{

    self.cancelButtonImage = [[UIImageView alloc] init];
    self.cancelButtonImage.image = [UIImage imageNamed:@"cross"];
    
    [self.contentView addSubview:self.cancelButtonImage];
    
    self.cancelButtonImage.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.cancelButtonImage.topAnchor constraintEqualToAnchor:self.topAnchor constant:30].active = YES;
    [self.cancelButtonImage.rightAnchor constraintEqualToAnchor:self.rightAnchor constant: - 20].active = YES;
    [self.cancelButtonImage.heightAnchor constraintEqualToConstant:25].active = YES;
    [self.cancelButtonImage.widthAnchor constraintEqualToConstant:25].active = YES;
    
    self.cancelButtonImage.clipsToBounds = YES;
    

    
    UITapGestureRecognizer *cancelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTapped)];
    cancelTap.numberOfTapsRequired = 1;
    cancelTap.delegate = self;
    
    [self.cancelButtonImage addGestureRecognizer:cancelTap];

    

    
    self.cancelButtonImage.userInteractionEnabled = YES;
    
    
    
    // set up main feeling view
    
    self.mainFeelingView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:self.mainFeelingView];
    
    [self.mainFeelingView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [self.mainFeelingView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    [self.mainFeelingView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [self.mainFeelingView.topAnchor constraintEqualToAnchor:self.topAnchor constant:70].active = YES;
    

    
    

}

-(void)feelingChosen:(UIButton *)sender
{
    [self leaveMainFeelingView];
    
    [self layoutIfNeeded];
    
    [self setUpQuestionView];
    
}

-(void)cancelTapped
{
    
    [self.dataStore.currentUser.journals removeObject:self.currentEntry];
    
    [UIView animateWithDuration:.6 animations:^{
        self.contentView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)questionAnswered:(NSUInteger)answer;
{

    self.questionIndex ++;
    
    BOOL questionsDone = (self.questionIndex == self.currentEntry.questions.count);
    
    if (questionsDone)
    {
  
        //[self leaveQuestionView];
        [self performSelectorOnMainThread:@selector(leaveQuestionView) withObject:nil waitUntilDone:NO];
        [self performSelectorOnMainThread:@selector(setUpJournalAndPictureView) withObject:nil waitUntilDone:NO];
        
<<<<<<< HEAD
=======
        [self launchJournalAndPictureView];
>>>>>>> master
    }
    else
    {
        self.questionView.questionIndex = self.questionIndex;
    }
    
}


-(void)setUpQuestionView
{
    
    self.questionView = [[QuestionView alloc] initWithFrame:CGRectZero];
    
    [self.contentView addSubview:self.questionView];
    
    self.questionView.alpha = 0;
    
    self.questionView.delegate = self;
    
    self.questionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.questionView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
    [self.questionView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
    [self.questionView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
    [self.questionView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:70].active = YES;

    


    [self layoutIfNeeded];
    [UIView animateWithDuration:0.8 animations:^{
        self.questionView.alpha = 1.0;
        
    }];

    
    self.questionView.questionIndex = 0;

}

-(void)launchJournalAndPictureView
{
//    self.journalAndPictureView = [[JournalAndPictureView alloc] init];
//    [self.contentView addSubview:self.journalAndPictureView];
//    self.journalAndPictureView.delegate = self;
//    self.journalAndPictureView.translatesAutoresizingMaskIntoConstraints = NO;
//
//    
//    [self.journalAndPictureView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
//    [self.journalAndPictureView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
//    [self.journalAndPictureView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
//    [self.journalAndPictureView.topAnchor constraintEqualToAnchor:self.topAnchor constant:70].active = YES;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    
    
    self.journalAndPictureView = [[JournalAndPictureAlternateView alloc] init];
    
    [self.contentView addSubview:self.journalAndPictureView];
    
    self.journalAndPictureView.delegate = self;
    
    self.journalAndPictureView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.journalAndPictureView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
    [self.journalAndPictureView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
   
    [self.journalAndPictureView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:70].active = YES;
    
    self.journalAndPictureViewBottomConstraint = [self.journalAndPictureView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor];
    
    self.journalAndPictureViewBottomConstraint.active = YES;
    

    
<<<<<<< HEAD
    [self.journalAndPictureView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [self.journalAndPictureView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    [self.journalAndPictureView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [self.journalAndPictureView.topAnchor constraintEqualToAnchor:self.topAnchor constant:70].active = YES;
    [self.journalAndPictureView.textView becomeFirstResponder];
    [self.journalAndPictureView.contentView becomeFirstResponder];
=======
}
>>>>>>> master

-(void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    NSValue *keyboardFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardFrame = keyboardFrameValue.CGRectValue;
    
    CGFloat keyboardHeight = keyboardFrame.size.height;
    
    [UIView animateWithDuration:.25 animations:^{
        
        self.journalAndPictureViewBottomConstraint.active = NO;
        
        self.journalAndPictureViewBottomConstraint = [self.journalAndPictureView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-keyboardHeight];
        
        self.journalAndPictureViewBottomConstraint.active = YES;
        
        [self layoutIfNeeded];
        
    }];
    
  
    
    
    
}

-(void)doneButtonTapped
{
    [self.delegate totalJournalEntryComplete];
    
    [UIView animateWithDuration:.6 animations:^{
        self.contentView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

-(void)moveJournalViewBackDownForKeyboard
{
    
    
}

-(void)leaveQuestionView
{
    
    self.questionView.alpha = 0;
    
    [self.questionView removeFromSuperview];
}

-(void)leaveMainFeelingView
{
    self.mainFeelingView.alpha = 0;
    
    
    [self.mainFeelingView removeFromSuperview];
    
}

-(void)journalComplete:(UIButton *)sender
{
    [self.delegate totalJournalEntryComplete];
    
    [UIView animateWithDuration:.6 animations:^{
        self.contentView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
}

-(void)whenAddPhotoButtonIsTapped:(id)sender
{
    
    [self.delegate buttonTappedFromJournalandPictureView:sender];
}

<<<<<<< HEAD
-(void)whenDeleteButtonIsTapped:(id)sender
{
    self.journalAndPictureView.deletePhotoButton.hidden = YES;
    self.journalAndPictureView.imageView.image = nil;
    self.journalAndPictureView.imageView.layer.borderWidth = 0;

}

-(void)recieveImageFromMainViewController:(UIImage *)imageRecieved
{
    [self.journalAndPictureView.textView becomeFirstResponder];
    self.currentEntry.userImage = imageRecieved;
    self.journalAndPictureView.deletePhotoButton.hidden = NO;
    self.journalAndPictureView.imageView.image = imageRecieved;
    self.journalAndPictureView.imageView.layer.cornerRadius = self.journalAndPictureView.imageView.frame.size.width / 2;
    self.journalAndPictureView.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.journalAndPictureView.imageView.clipsToBounds = YES;
    self.journalAndPictureView.imageView.layer.borderColor = [UIColor darkGrayColor].CGColor;
}
=======
//-(void)whenDeleteButtonIsTapped:(id)sender
//{
//    self.journalAndPictureView.deletePhotoButton.hidden = YES;
//    self.journalAndPictureView.imageView.image = nil;
//    self.journalAndPictureView.imageView.layer.borderWidth = 0;
//
//}
//
//-(void)recieveImageFromMainViewController:(UIImage *)imageRecieved
//{
//    self.currentEntry.userImage = imageRecieved;
//    self.journalAndPictureView.deletePhotoButton.hidden = NO;
//    self.journalAndPictureView.imageView.image = imageRecieved;
//    self.journalAndPictureView.imageView.layer.cornerRadius = self.journalAndPictureView.imageView.frame.size.width / 2;
//    self.journalAndPictureView.imageView.contentMode = UIViewContentModeScaleAspectFill;
//    self.journalAndPictureView.imageView.clipsToBounds = YES;
//    self.journalAndPictureView.imageView.layer.borderColor = [UIColor darkGrayColor].CGColor;
//}
>>>>>>> master

@end
