//
//  ViewController.m
//  DidYou
//
//  Created by Brian Clouser on 3/29/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "MainViewController.h"
#import "DataStore.h"



@interface MainViewController () <AddJournalEntryViewDelegate>

@property (strong, nonatomic) IBOutlet AddJournalEntryView *addEntryTopVIew;
@property (strong, nonatomic) IBOutlet UITableView *journalEntryTableView;
@property (strong, nonatomic) IBOutlet UIView *addEntryFullScreenView;

@property (strong, nonatomic) DataStore *dataStore;



@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   self.dataStore =  [DataStore sharedDataStore];
    self.addEntryTopVIew.delegate = self;
    
    self.addEntryFullScreenView.alpha = 0;
    
    
    NSLog(@"we got here");
    
   // set city and state to current users
    
    // go send to firebase synch with our dataStore

    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addButtonTapped:(UIButton *)sender {
    
    NSLog(@"we got here");

    self.addEntryFullScreenView.alpha = 1;
}


@end
