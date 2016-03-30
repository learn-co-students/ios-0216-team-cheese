//
//  ViewController.m
//  DidYou
//
//  Created by Brian Clouser on 3/29/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "MainViewController.h"
#import "DataStore.h"

@interface MainViewController ()

@property (strong, nonatomic) DataStore *dataStore;

@property (weak, nonatomic) IBOutlet AddJournalEntryView *addJournalEntryView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   self.dataStore =  [DataStore sharedDataStore];
    
   // set city and state to current users
    
    // go send to firebase synch with our dataStore
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
