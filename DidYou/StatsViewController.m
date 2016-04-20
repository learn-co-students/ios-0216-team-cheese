//
//  StatsViewController.m
//  DidYou
//
//  Created by Brian Clouser on 3/30/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "StatsViewController.h"
#import "CustomTabBarView.h"
#import "StatsMenuView.h"
#import "DataStore.h"
#import "StatsMoodCellView.h"
#import "StatsQuestionViewCell.h"
#import "DYJournalEntry.h"
#import "NoStatsDataView.h"

@interface StatsViewController () <CustomTabBarDelegate>

@property (strong, nonatomic) CustomTabBarView *tabBar;
@property (weak, nonatomic) IBOutlet StatsMenuView *statsMenuView;
//@property (strong, nonatomic) DataStore *dataStore;
@property (weak, nonatomic) IBOutlet NoStatsDataView *noStatsDataView;
@property (weak, nonatomic) IBOutlet UIImageView *statsIconImageView;

@end

@implementation StatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCustomTabBar];
    DataStore *dataStore = [DataStore sharedDataStore];
    
    if (dataStore.currentUser.journals.count == 0) {
        self.statsIconImageView.alpha = 1;
    } else {
        self.statsIconImageView.alpha = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createCustomTabBar
{
    
    self.tabBar = [[CustomTabBarView alloc] init];
    self.tabBar.currentScreen = @"stats";
    
    [self.view addSubview:self.tabBar];
    
    self.tabBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tabBar.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.tabBar.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.tabBar.heightAnchor constraintEqualToConstant:40].active = YES;
    [self.tabBar.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    self.tabBar.delegate = self;
}

-(void)userNavigates:(NSString *)viewChosen
{
    if ([viewChosen isEqualToString:@"main"])
    {
        [self performSegueWithIdentifier:@"segueStatsToMain" sender:nil];
    }
    else if ([viewChosen isEqualToString:@"user"])
    {
        [self performSegueWithIdentifier:@"segueStatsToUser" sender:nil];
    }
}




@end
