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



@interface MainViewController () <AddJournalEntryViewDelegate>

@property (strong, nonatomic) IBOutlet AddJournalEntryView *addEntryTopVIew;
@property (strong, nonatomic) IBOutlet UITableView *journalEntryTableView;
@property (strong, nonatomic) NewJournalEntryBlurView *addJournalFullScreenBlurView;

@property (strong, nonatomic) DataStore *dataStore;



@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   self.dataStore =  [DataStore sharedDataStore];
    self.addEntryTopVIew.delegate = self;
    
//    self.addEntryFullScreenView.alpha = 0;
    
    
    NSLog(@"we got here");
    
   // set city and state to current users
    
    // go send to firebase synch with our dataStore

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addButtonTapped:(UIButton *)sender {
    
    
    [self launchAddJournalFullScreenView];
    
    DYJournalEntry *entry = [[DYJournalEntry alloc] init];
    
    [self.dataStore.currentUser.journals addObject: entry];
    
    
}




-(void)launchAddJournalFullScreenView
{
    
    
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    self.addJournalFullScreenBlurView= [[NewJournalEntryBlurView alloc] initWithEffect:blurEffect];
    
    [self.view addSubview:self.addJournalFullScreenBlurView];
    
    self.addJournalFullScreenBlurView.translatesAutoresizingMaskIntoConstraints = NO;
    //    [self.addJournalFullScreenBlurView removeConstraints:self.addJournalFullScreenBlurView.constraints];
    
    [self.addJournalFullScreenBlurView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.addJournalFullScreenBlurView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor].active = YES;
    [self.addJournalFullScreenBlurView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.addJournalFullScreenBlurView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    
    [self.view bringSubviewToFront:self.addJournalFullScreenBlurView];

}


@end
