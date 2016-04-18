//
//  JournalLogViewController.m
//  DidYou
//
//  Created by Andre Creighton on 4/11/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "JournalLogViewController.h"

@interface JournalLogViewController ()
@property (strong, nonatomic) IBOutlet UIView *clearView;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIView *borderSurroundingButton;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;



@property (strong,nonatomic) UIColor *createdColor;
@property (strong,nonatomic) UIColor *anotherColor;
@end

@implementation JournalLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.createdColor = [[UIColor alloc]initWithRed:0 green:.50 blue:1 alpha:1];
    self.anotherColor = [UIColor colorWithRed:34.0/255.0 green:164.0/255.0 blue:0 alpha:.5];
    self.view.backgroundColor = [UIColor whiteColor];

    //self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    self.borderSurroundingButton.layer.borderWidth = 1.5f;
    self.borderSurroundingButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.borderSurroundingButton.layer.cornerRadius = self.borderSurroundingButton.frame.size.height / 2;
    self.clearView.layer.borderWidth = 1.0f;
    self.clearView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.textView.textColor = [UIColor darkGrayColor];
}

-(BOOL)prefersStatusBarHidden{
    
    return YES;

}


- (void)viewDidAppear:(BOOL)animated{

    [UIView animateWithDuration:1 animations:^{
        
        
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {

        
    }];
    

}



- (IBAction)whenBackButtonPressed:(id)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



@end
