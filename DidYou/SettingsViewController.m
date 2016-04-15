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

@interface SettingsViewController () <CustomTabBarDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *locationSwitch;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIView *locationView;

@property (strong, nonatomic) CustomTabBarView *tabBar;
@property (weak, nonatomic) IBOutlet UIView *termsView;
@property (weak, nonatomic) IBOutlet UIView *deleteView;


@property (strong, nonatomic) DataStore *dataStore;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createCustomTabBar];
    
    
    self.dataStore = [DataStore sharedDataStore];
    
    // set switch to location services boolean
    
    self.termsView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.termsView.layer.borderWidth = .5;
    
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

    
     //launch alert - are you sure you want to delete all your entries?
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete all Journal Entries" message:@"Are you sure?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertViewStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
       
        NSLog(@"yes hit");
        
        [self.dataStore deleteAllCurrentUserEntries];
        
    }];
    
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertViewStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"no hit");
    }];
    
    [alert addAction:yesAction];
    [alert addAction:noAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)locationSwitchFlipped:(id)sender {
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
