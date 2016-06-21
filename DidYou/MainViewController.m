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
#import "JournalEntryTableViewCellAlternate.h"
//#import "SWTableViewCell.h"


@interface MainViewController () <NewJournalEntryBlurViewDelegate, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CustomTabBarDelegate, LoadingFirstPageViewDelegate, NoInternetDelegate, CLLocationManagerDelegate>

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

@property (strong, nonatomic) NSString *UUID;

@property (nonatomic) BOOL singletonBeingCreatedHit;

@property (nonatomic) BOOL connected;
@property(nonatomic) BOOL firstTimeScreenDisplayed;

@property (nonatomic) BOOL isAlive;


@end

@implementation MainViewController

- (void)viewDidLoad {
    

    [super viewDidLoad];
 
    self.isAlive = YES;
    self.singletonBeingCreatedHit = NO;
    
    [self setUpDelegates];
    [self createCustomTabBar];
    
    [self launchScreenLogic];
}

-(void)launchScreenLogic
{
    
    self.connected = [DataStore isNetworkAvailable];
    
    self.UUID = [self userUUID];
    
    
    if (!self.connected)
    {
        
        [self launchNoInternetView];
        
        self.journalEntryTableView.userInteractionEnabled = NO;
        self.tabBar.userInteractionEnabled = NO;
        
    }
    
    else if ([self.UUID isEqualToString:@"new"])
    {
        [self launchFirstTimeScreen];
        
        self.dataStore = [DataStore sharedDataStore];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(singletonBeingCreated) name:@"singletonBeingCreated" object:nil];
        self.dataStore = [DataStore sharedDataStore];
    
        
        if (self.dataStore.currentUser.journals.count == 0 && !self.singletonBeingCreatedHit)
        {
            [self launchFirstTimeScreen];
        }
 
    }
    
    [self.journalEntryTableView reloadData];
}

-(void)singletonBeingCreated
{
    self.singletonBeingCreatedHit = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveFirebaseNotification) name:@"FirebaseNotification" object:nil];
    [self launchSpinView];
}

- (BOOL)canIAnimate
{
    
    return self.isAlive;
    
}

-(NSString *)userUUID
{
    
    NSDictionary *userDefaultsDictionary = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    
    NSArray *userDefaultsKeys = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys];
    
    BOOL uuidExists = [userDefaultsKeys containsObject:@"userUUID"];
    
    if (uuidExists)
    {
        return   userDefaultsDictionary[@"userUUID"];
    }
    else
    {
        return @"new";
    }

    
//    [self launchSpinView];
}


-(void)refreshTapped
{
    self.connected = [DataStore isNetworkAvailable];
    
    if (self.connected)
    {
        [self.noInternetScreen removeFromSuperview];
        
        if (self.dataStore == nil)
        {
            [self launchSpinView];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveFirebaseNotification) name:@"FirebaseNotification" object:nil];
        
        self.dataStore = [DataStore sharedDataStore];
    }
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
    self.journalEntryTableView.userInteractionEnabled = NO;
    self.tabBar.userInteractionEnabled = NO;
    
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
    
    [self dismissFirstTimeScreen];
    
    if (self.dataStore.currentUser.journals.count == 0)
    {
        [self launchFirstTimeScreen];
    }
    
    //[self startLocationManager];
    self.tabBar.userInteractionEnabled = YES;
    
    self.journalEntryTableView.userInteractionEnabled = YES;
}

-(void)startLocationManager
{
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    self.geocoder = [[CLGeocoder alloc]init];
}


-(void)launchFirstTimeScreen
{
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

-(void)dismissFirstTimeScreen
{
    [self.firstTimeScreen removeFromSuperview];
}

- (void)addButtonTapped:(UIButton *)sender {
    
    __weak typeof(self) tmpself = self;
    [UIView animateWithDuration:0.1 delay:0 options:0 animations:^{
        tmpself.journalEntryTableView.alpha = 0;
        tmpself.addEntryTopView.alpha = 0;
    } completion:^(BOOL finished) {
        [tmpself launchAddJournalFullScreenView];
    }];
}

-(void)launchAddJournalFullScreenView
{
    
    //self.addEntryTopView.shouldAnimate = NO;
    
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    self.addJournalFullScreenBlurView= [[NewJournalEntryBlurView alloc] initWithEffect:blurEffect];
    
    self.addJournalFullScreenBlurView.delegate = self;
    
    self.addJournalFullScreenBlurView.alpha = 0;
    __weak typeof(self) tmpself = self;

    
    [UIView animateWithDuration:0 delay:0 options:0 animations:^{
        
        
        [tmpself.view addSubview:self.addJournalFullScreenBlurView];
        
        tmpself.addJournalFullScreenBlurView.alpha = 1;
        
        tmpself.addJournalFullScreenBlurView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [tmpself.addJournalFullScreenBlurView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
        [tmpself.addJournalFullScreenBlurView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor].active = YES;
        [tmpself.addJournalFullScreenBlurView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
        [tmpself.addJournalFullScreenBlurView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;

        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.15 delay:0 options:0 animations:^{
            
            [tmpself.view bringSubviewToFront:self.addJournalFullScreenBlurView];
            tmpself.journalEntryTableView.alpha = 1;
            tmpself.addEntryTopView.alpha = 1;
            
        } completion:^(BOOL finished) {
            
        }];
        
    }];
    
}




-(void)totalJournalEntryComplete
{
    if (self.firstTimeScreenDisplayed)
    {
        [self.firstTimeScreen removeFromSuperview];
    }
    // Signal firebase push
    [self.dataStore pushLastJournal];
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
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JournalEntryTableViewCellAlternate *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell"];
    
    NSArray *journalsLIFO = [self.dataStore.currentUser journalArrayLIFO];
    
    DYJournalEntry *journalAtRow = journalsLIFO[indexPath.row];
    
    cell.cellView.journalEntry = journalAtRow;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.rightUtilityButtons = [self rightButtons];
    
    cell.delegate = self;
    
    
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

//removing image methods, no longer adding image to journal
/*
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
*/
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
         [self performSegueWithIdentifier:@"journalDetailVC" sender:self];
        
    });
    
    NSLog(@"%lu",indexPath.row);
    
   
}

- (NSArray *)rightButtons
{
    
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    return rightUtilityButtons;
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    
    if (index == 0)
    {
        NSIndexPath *cellIndexPath = [self.journalEntryTableView indexPathForCell:cell];
        
        NSArray *journalsLIFO = [self.dataStore.currentUser journalArrayLIFO];
        
        DYJournalEntry *journalAtRow = journalsLIFO[cellIndexPath.row];
        
        [self.dataStore.currentUser.journals removeObject:journalAtRow];
        
        [self.dataStore updateFirebaseJournals];
        
        [self.journalEntryTableView reloadData];
    }
    
    
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    
    return YES;
}






-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    self.addEntryTopView.shouldAnimate = NO;
    
    if([segue.identifier isEqualToString:@"journalDetailVC"])
    {
        
        JournalLogViewController *destVC = segue.destinationViewController;
        
        NSIndexPath *selectedPath = self.journalEntryTableView.indexPathForSelectedRow;
       
        NSArray *journalsLIFO = [self.dataStore.currentUser journalArrayLIFO];
        
        DYJournalEntry *chosenEntry = journalsLIFO[selectedPath.row];
        
        destVC.journalEntry = chosenEntry;
    }
        
}

@end
