//
//  SettingsViewController.m
//  DidYou
//
//  Created by Brian Clouser on 4/6/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "SettingsViewController.h"
#import "CustomTabBarView.h"
#import "DataStore.h"

@interface SettingsViewController () <CustomTabBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *settingsTableView;

@property (strong, nonatomic) CustomTabBarView *tabBar;
@property (weak, nonatomic) IBOutlet UISwitch *locationSwitch;
@property (weak, nonatomic) IBOutlet UIButton *deleteEntriesButton;

@property (strong, nonatomic) DataStore *dataStore;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createCustomTabBar];
    
    self.settingsTableView.delegate = self;
    self.settingsTableView.dataSource = self;
    
    self.settingsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.dataStore = [DataStore sharedDataStore];
    
    // set switch to location services boolean
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locationCell"];
        
        return cell;
    }
    
    else if (indexPath.row == 1)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"termsCell"];
        
        return cell;
    }
    
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deleteEntriesCell"];
        
        return cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    
    return 100;
 
    
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createCustomTabBar
{
    
    self.tabBar = [[CustomTabBarView alloc] init];
    
    self.tabBar.currentScreen = @"user";
    
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
        [self performSegueWithIdentifier:@"segueUserToMain" sender:nil];
    }
    else if ([viewChosen isEqualToString:@"stats"])
    {
        [self performSegueWithIdentifier:@"segueUserToStats" sender:nil];
    }
}
- (IBAction)deleteButtonTapped:(id)sender
{
    
    // launch alert - are you sure you want to delete all your entries?
    
}
- (IBAction)switchChanged:(id)sender
{
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
