//
//  JournalLogViewController.m
//  DidYou
//
//  Created by Andre Creighton on 4/11/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "JournalLogViewController.h"

@interface JournalLogViewController ()

@end

@implementation JournalLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpViews];
    
}


-(void)setUpViews{
    
    
    self.theLabelForTheDate = [UILabel new];
    [self.theLabelForTheDate setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.theLabelForTheDate];
    [self.theLabelForTheDate.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.theLabelForTheDate.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:.10].active = YES;
    [self.theLabelForTheDate.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    self.theLabelForTheDate.backgroundColor = [UIColor blueColor];
    
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.backButton setTintColor:[UIColor redColor]];
    [self.backButton setTitle:@"Back" forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(whenBackButtonIsTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.backButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.backButton];
    [self.backButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active = YES;
    [self.backButton.topAnchor  constraintEqualToAnchor:self.theLabelForTheDate.bottomAnchor constant:20].active =YES;
    
    

}

-(IBAction)whenBackButtonIsTapped:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];

}




-(BOOL)prefersStatusBarHidden{
    return YES;
}


@end
