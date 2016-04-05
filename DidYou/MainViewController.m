//
//  ViewController.m
//  DidYou
//
//  Created by Brian Clouser on 3/29/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "MainViewController.h"
#import "NewJournalEntryBlurView.h"
#import "DataStore.h"
#import "DYUser.h"
#import <CoreLocation/CoreLocation.h>
#import "AddJournalEntryView.h"
#import "JournalEntryTableViewCell.h"



@interface MainViewController () <NewJournalEntryBlurViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet AddJournalEntryView *addEntryTopView;
@property (strong, nonatomic) IBOutlet UITableView *journalEntryTableView;

@property (strong, nonatomic) NewJournalEntryBlurView *addJournalFullScreenBlurView;
@property (strong, nonatomic) AddJournalEntryView *journalView;

@property (strong, nonatomic) DataStore *dataStore;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) CLPlacemark *placemark;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataStore =  [DataStore sharedDataStore];
    
    self.addEntryTopView.delegate = self;
    self.journalEntryTableView.delegate = self;
    self.journalEntryTableView.dataSource = self;
    
    [self preferredStatusBarStyle];
    
    
    
//    self.addEntryFullScreenView.alpha = 0;
    
    
    
//   // set city and state to current users
//    self.locationManager = [[CLLocationManager alloc]init];
//    self.locationManager.delegate = self;
//    [self.locationManager requestWhenInUseAuthorization];
//    
//    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//        [self.locationManager requestWhenInUseAuthorization];
//    }
//    
//    self.geocoder = [[CLGeocoder alloc]init];
//    
//    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    
//   
//    
//    [self.locationManager startUpdatingLocation];
//    CGRect myFullFrame = [self.view frame];
//    CGRect frame = CGRectMake(0, 0, myFullFrame.size.height, myFullFrame.size.width);
//    AddJournalEntryView *journalView = [[AddJournalEntryView alloc]initWithFrame:frame];
//    [self.view addSubview:journalView];
//    self.journalView = journalView;
//    // go send to firebase synch with our dataStore
    
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {

    NSLog(@"didFailWithError, %@", error);

    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to get where you are" preferredStyle:UIAlertControllerStyleAlert];


    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }];

    [errorAlert addAction:defaultAction];

    [self presentViewController:errorAlert animated:YES completion:nil];

}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    
    CLLocation *currentLocation = locations[0];
    
    if (currentLocation != nil) {
        

        
        //stop location manager
        
        [self.locationManager stopUpdatingLocation];
        
        NSLog(@"resolving the address");
        
        //translate the locate data into a human-readable address
        [self.geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            if (error == nil && [placemarks count] > 0) {
                self.placemark = [placemarks lastObject];

                
            } else {
                
                NSLog(@"@%@", error.debugDescription);
            }
        }];
    }
    
    
}

- (void)addButtonTapped:(UIButton *)sender {
    
    
    [self launchAddJournalFullScreenView];
    
}


-(void)launchAddJournalFullScreenView
{
    
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    self.addJournalFullScreenBlurView= [[NewJournalEntryBlurView alloc] initWithEffect:blurEffect];
    
    self.addJournalFullScreenBlurView.delegate = self;
    
    [self.view addSubview:self.addJournalFullScreenBlurView];
    
    self.addJournalFullScreenBlurView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.addJournalFullScreenBlurView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.addJournalFullScreenBlurView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor].active = YES;
    [self.addJournalFullScreenBlurView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.addJournalFullScreenBlurView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    
    [self.view bringSubviewToFront:self.addJournalFullScreenBlurView];

}

-(void)totalJournalEntryComplete
{
    [self.journalEntryTableView reloadData];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataStore.currentUser.journals.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JournalEntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell"];
    
    NSArray *journalsLIFO = [self.dataStore.currentUser journalArrayLIFO];
    
    DYJournalEntry *journalAtRow = journalsLIFO[indexPath.row];
    
    cell.cellView.journalEntry = journalAtRow;
    
    return cell;

}




@end
