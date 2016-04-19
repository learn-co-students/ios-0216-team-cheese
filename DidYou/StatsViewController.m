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

@interface StatsViewController () <CustomTabBarDelegate>

@property (strong, nonatomic) CustomTabBarView *tabBar;
@property (weak, nonatomic) IBOutlet StatsMenuView *statsMenuView;
@property (strong, nonatomic) DataStore *datastore;

@end

@implementation StatsViewController

-(instancetype)init {
    self = [super init];
    
    if (self) {
//        _statsInfo = [[DYStatsInfo alloc]init];
//        _personalStatsDataDictionary = @{};
//        _cityStatsDataDictionary = @{};
//        _worldStatsDataDictionary = @{};
//        _arrayOfStatsDataDictionaries = @[self.personalStatsDataDictionary, self.cityStatsDataDictionary, self.worldStatsDataDictionary];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCustomTabBar];
    //[self.view addSubview:self.statsMenuView];
    
//    NSLog(@"in the stats screen, city is: %@ and country is %@", self.datastore.currentUser.city, self.datastore.currentUser.country);
//    
//    [self.statsInfo addToMoodArrays];
//    NSLog(@"test data store journal array contents %@", self.datastore.currentUser.journals);
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
