//
//  StatsViewController.m
//  DidYou
//
//  Created by Brian Clouser on 3/30/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "StatsViewController.h"
#import "CustomTabBarView.h"
#import "StatsMainTableViewCell.h"
#import "StatsMenuView.h"

@interface StatsViewController () <CustomTabBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) CustomTabBarView *tabBar;
@property (weak, nonatomic) IBOutlet StatsMenuView *statsMenuView;
@property (weak, nonatomic) IBOutlet UITableView *statsTableView;

@end

@implementation StatsViewController

-(instancetype)init {
    self = [super init];
    
    if (self) {
        _statsInfo = [[DYStatsInfo alloc]init];
        _personalStatsDataDictionary = @{};
        _cityStatsDataDictionary = @{};
        _worldStatsDataDictionary = @{};
        _arrayOfStatsDataDictionaries = @[self.personalStatsDataDictionary, self.cityStatsDataDictionary, self.worldStatsDataDictionary];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createCustomTabBar];
    [self.view addSubview:self.statsMenuView];


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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StatsMainTableViewCell *cell = [[StatsMainTableViewCell alloc]init];
    return cell;
}


/*
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
 
 // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
 // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
 

 
 @optional
 
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented
 
 - (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;    // fixed font style. use custom view (UILabel) if you want something different
 - (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
