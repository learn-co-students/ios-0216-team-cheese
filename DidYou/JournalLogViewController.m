//
//  JournalLogViewController.m
//  DidYou
//
//  Created by Andre Creighton on 4/11/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "JournalLogViewController.h"

@interface JournalLogViewController ()

@property (strong, nonatomic) IBOutlet UIStackView *stackView;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leftToRightConstraintForStack;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topToBottomConstraintForStack;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topToBottomConstraintForScroll;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong,nonatomic) UIColor *createdColor;
@property (strong,nonatomic) UIColor *anotherColor;
@end

@implementation JournalLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.createdColor = [[UIColor alloc]initWithRed:0 green:.50 blue:1 alpha:1];
    self.anotherColor = [UIColor colorWithRed:34.0/255.0 green:164.0/255.0 blue:0 alpha:.5];
    self.view.backgroundColor = [[UIColor alloc]initWithWhite:.80 alpha:1];
    
    self.topToBottomConstraintForScroll.constant = -1000;
    self.scrollView.alpha = 0;
    self.stackView.alpha = 0;
    [self.view sendSubviewToBack:self.stackView];
    [self.view sendSubviewToBack:self.scrollView];
    
    self.closeButton.enabled = NO;
    
}

-(BOOL)prefersStatusBarHidden{
    
    return YES;

}


- (void)viewDidAppear:(BOOL)animated{
    [UIView animateWithDuration:.5 animations:^{
        
        self.topToBottomConstraintForStack.constant = 15;
       
        self.stackView.alpha = 1;
        [self.view layoutIfNeeded];
    }];
    [UIView animateWithDuration:1.5 animations:^{
        self.topToBottomConstraintForScroll.constant = 0;
        self.scrollView.alpha = 1;
        
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.closeButton.enabled = YES;
    }];
    

}




- (IBAction)whenBackButtonPressed:(id)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



@end
