//
//  DataStore.h
//  DidYou
//
//  Created by Brian Clouser on 3/29/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYUser.h"
#import "DYJournalEntry.h"
#import <Firebase/Firebase.h>

@interface DataStore : NSObject

@property (strong, nonatomic) NSMutableArray *users;
@property (strong, nonatomic) NSDictionary *emotions;
@property (strong, nonatomic) NSString *userUUID;
@property (strong, nonatomic) DYUser *currentUser;
@property (strong, nonatomic) Firebase *myRootRef;



+ (instancetype)sharedDataStore;

-(NSArray *)usersWithSameCity;
-(NSArray *)usersWithSameCountry;

-(void)setupFirebase;
-(void)addUserToFirebase: (DYUser *)user;
-(void)addJournalToFirebase: (DYUser *)user journalEntry:(DYJournalEntry *)journalEntry;
















  



@end
