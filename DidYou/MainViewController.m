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
#import "CustomTabBarView.h"
#import "LoadingFirstPageView.h"
#import "JournalLogViewController.h"
#import "EmptyTableView.h"
#import "NoInternetView.h"


@interface MainViewController () <NewJournalEntryBlurViewDelegate, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CustomTabBarDelegate, LoadingFirstPageViewDelegate, NoInternetDelegate>

@property (strong, nonatomic) IBOutlet AddJournalEntryView *addEntryTopView;
@property (strong, nonatomic) IBOutlet UITableView *journalEntryTableView;
@property (strong, nonatomic) CustomTabBarView *tabBar;

@property (strong, nonatomic) NewJournalEntryBlurView *addJournalFullScreenBlurView;
@property (strong, nonatomic) AddJournalEntryView *journalView;
@property (strong, nonatomic) LoadingFirstPageView *spinView;
@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) CLPlacemark *placemark;


@property (strong, nonatomic) EmptyTableView *firstTimeScreen;
@property (strong, nonatomic) NoInternetView *noInternetScreen;
@property (strong, nonatomic) LoadingFirstPageView *contentView;
@property (strong, nonatomic) NSLayoutConstraint *blurViewheightConstraint;
@property (strong, nonatomic) NSLayoutConstraint *blurViewWidthConstraint;

@property (nonatomic) BOOL singletonCreated;
@property (nonatomic) BOOL brandNewUser;
@property (nonatomic) BOOL connected;

@property (nonatomic) BOOL firstTimeScreenDisplayed;


@end

@implementation MainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userExists) name:@"connectedAndUserExists" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userIsNew) name:@"connectedAndUserIsNew" object:nil];
    
    self.journalEntryTableView.userInteractionEnabled = NO;
   
    
    [self setUpDelegates];
    
    [self createCustomTabBar];
    
    self.connected = [DataStore isNetworkAvailable];
    
    if (!self.connected)
    {
        self.dataStore = [DataStore sharedDataStore];
        [self launchNoInternetView];
        // show internet screen
        self.journalEntryTableView.userInteractionEnabled = NO;
        self.tabBar.userInteractionEnabled = NO;
    }
    else
    {
        self.singletonCreated = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(singletonBeingCreated) name:@"singletonBeingCreated" object:nil];
        
        self.dataStore = [DataStore sharedDataStore];
        
        if (!self.singletonCreated && self.dataStore.currentUser.journals.count == 0)
        {
            [self launchFirstTimeScreen];
        }
        
    }
    
   
    [self.journalEntryTableView reloadData];
    

    
}

-(void)refreshTapped
{
    NSLog(@"in refresh tapped");
    
    self.connected = [DataStore isNetworkAvailable];
    
    if (self.connected)
    {
    
        [self.noInternetScreen removeFromSuperview];
        
        self.journalEntryTableView.userInteractionEnabled = YES;
        self.tabBar.userInteractionEnabled = YES;
        
        [DataStore sharedDataStore];
        
        [self.journalEntryTableView reloadData];
    }

    
    
}

-(void)singletonBeingCreated
{
    self.singletonCreated = YES;
}


-(void)userExists
{
    
    NSLog(@"in user exists");
    
     self.firstTimeScreenDisplayed = NO;
    
    self.journalEntryTableView.userInteractionEnabled = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveFirebaseNotification)
                                                 name:@"FirebaseNotification"
                                               object:nil];

    
    [self launchSpinView];
    
    
}

-(void)userIsNew
{
    
    NSLog(@"in users is new");
    
    [self launchFirstTimeScreen];
    
    
}

-(void)setUpDelegates
{
    
    
    self.addEntryTopView.delegate = self;
    
    self.journalEntryTableView.delegate = self;
    self.journalEntryTableView.dataSource = self;



}

-(void)launchNoInternetView
{
    self.noInternetScreen = [[NoInternetView alloc] init];
    
    [self.view addSubview:self.noInternetScreen];
    
    self.noInternetScreen.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.noInternetScreen.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.noInternetScreen.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.noInternetScreen.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.noInternetScreen.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:.7].active = YES;
    
    self.noInternetScreen.delegate = self;
    
}


-(void)launchSpinView
{
    self.spinView = [[LoadingFirstPageView alloc]initWithFrame:CGRectZero];
    
    [self.view addSubview:self.spinView];
    self.spinView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.spinView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:.7].active = YES;
    [self.spinView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.spinView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.spinView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    
    self.spinView.delegate = self;
    [self.spinView.activityIndicator startAnimating];
    
    [self.view bringSubviewToFront:self.spinView];
    [self.view bringSubviewToFront:self.tabBar];

}



-(void)receiveFirebaseNotification
{
    
  
        [self.journalEntryTableView reloadData];
        [self.journalEntryTableView reloadData];
        [self.spinView.activityIndicator stopAnimating];
    
    [self.spinView removeFromSuperview];
    
    if (self.dataStore.currentUser.journals.count == 0)
    {
        [self launchFirstTimeScreen];
    }
    
    self.journalEntryTableView.userInteractionEnabled = YES;
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
    

    [UIView animateWithDuration:0.2 delay:0 options:0 animations:^{
        
        self.journalEntryTableView.alpha = 0;
        self.addEntryTopView.alpha = 0;
        
        
        
    } completion:^(BOOL finished) {
        
        [self launchAddJournalFullScreenView];

        
    }];

    
}

-(void)launchFirstTimeScreen
{
    
    NSLog(@"in first time screen launch");
    
    self.firstTimeScreen = [[EmptyTableView alloc] init];
    
    [self.view addSubview:self.firstTimeScreen];
    
    self.firstTimeScreen.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.firstTimeScreen.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.firstTimeScreen.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.firstTimeScreen.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.firstTimeScreen.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:.7].active = YES;
    
    [self.view bringSubviewToFront:self.tabBar];
    
    self.firstTimeScreenDisplayed = YES;
    
}



-(void)launchAddJournalFullScreenView
{
    
    
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    self.addJournalFullScreenBlurView= [[NewJournalEntryBlurView alloc] initWithEffect:blurEffect];
    
    self.addJournalFullScreenBlurView.delegate = self;
    
    self.addJournalFullScreenBlurView.alpha = 0;
    
    
    [UIView animateWithDuration:0 delay:0 options:0 animations:^{
        
        
        [self.view addSubview:self.addJournalFullScreenBlurView];
        
        self.addJournalFullScreenBlurView.alpha = 1;
        
        self.addJournalFullScreenBlurView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.addJournalFullScreenBlurView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
        [self.addJournalFullScreenBlurView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor].active = YES;
        [self.addJournalFullScreenBlurView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
        [self.addJournalFullScreenBlurView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
        
        self.journalEntryTableView.alpha = 1;
        self.addEntryTopView.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0 delay:0 options:0 animations:^{
            
            [self.view bringSubviewToFront:self.addJournalFullScreenBlurView];
            
        } completion:^(BOOL finished) {
            
        }];
        
    }];
    
}




-(void)totalJournalEntryComplete
{
    
    NSLog(@"this is getting called");
    
    if (self.firstTimeScreenDisplayed)
    {
        [self.firstTimeScreen removeFromSuperview];
    }
    
    // Signal firebase push
    [[DataStore sharedDataStore] pushLastJournal];
    [self.journalEntryTableView reloadData];
    
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"in number of rows in section and the answer is: %lu", self.dataStore.currentUser.journals.count);
    NSLog(@"%d is first screen displayed", self.firstTimeScreenDisplayed);
    
       
//    if (self.dataStore.currentUser.journals.count == 0 && !self.firstTimeScreenDisplayed)
//    {
//        
//        [self launchFirstTimeScreen];
//        
//    }
//    else if (self.dataStore.currentUser.journals.count != 0 && self.firstTimeScreenDisplayed)
//    {
//        [self.firstTimeScreen removeFromSuperview];
//    }
    
    return self.dataStore.currentUser.journals.count;
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JournalEntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell"];
    
    NSArray *journalsLIFO = [self.dataStore.currentUser journalArrayLIFO];
    
    DYJournalEntry *journalAtRow = journalsLIFO[indexPath.row];
    
    cell.cellView.journalEntry = journalAtRow;
    
    
    //NSLog(@"%@",cell.cellView.journalEntry.date);
    
    return cell;
}

-(void)createCustomTabBar
{
    
    self.tabBar = [[CustomTabBarView alloc] init];
    
    self.tabBar.currentScreen = @"main";
    
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
    // segue to view
    
    NSLog(@"userNavigates getting called");
    
    if ([viewChosen isEqualToString:@"stats"])
    {
        [self performSegueWithIdentifier:@"segueMainToStats" sender:nil];
    }
    else if ([viewChosen isEqualToString:@"user"])
    {
        [self performSegueWithIdentifier:@"segueMainToUser" sender:nil];
    }
}

# pragma mark - JournalAndPictureView methods below

- (void)buttonTappedFromJournalandPictureView:(id)sender {
    
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"Image value in imagePickerController : %@", chosenImage);
    JournalAndPictureView *journalAndPictureV = [[JournalAndPictureView alloc] init] ;
    UIImageView *imageViewInJournalView = journalAndPictureV.imageView;
    [imageViewInJournalView setImage:chosenImage];
    NSLog(@"%@", imageViewInJournalView.image);
    [self.addJournalFullScreenBlurView recieveImageFromMainViewController:chosenImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)createBlurView
{
    
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    self.addJournalFullScreenBlurView= [[NewJournalEntryBlurView alloc] initWithEffect:blurEffect];
    
    self.addJournalFullScreenBlurView.delegate = self;
    
    [self.view addSubview:self.addJournalFullScreenBlurView];
    
    self.addJournalFullScreenBlurView.translatesAutoresizingMaskIntoConstraints = NO;

    
    [self.addJournalFullScreenBlurView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.addJournalFullScreenBlurView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.addJournalFullScreenBlurView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;

    [self.addJournalFullScreenBlurView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;

}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"journalDetailVC"])
    {
        JournalLogViewController *destVC = segue.destinationViewController;
        NSArray *journals = self.dataStore.currentUser.journals;
        DYJournalEntry *currentJournal = [journals lastObject];
        destVC.jorunalEntry = currentJournal;
    }
    
}

@end
