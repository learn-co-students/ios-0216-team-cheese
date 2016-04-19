//
//  DataStore.h
//  DidYou
//
//  Created by Brian Clouser on 3/29/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>
#import "DYJournalEntry.h"
#import "DYUser.h"
#import <CoreLocation/CoreLocation.h>

@interface DataStore : NSObject

@property (strong, nonatomic) NSMutableArray *users;
@property (strong, nonatomic) NSDictionary *emotions;
@property (strong, nonatomic) NSString *userUUID;
@property (strong, nonatomic) DYUser *currentUser;
@property (strong, nonatomic) Firebase *myRootRef;
@property (nonatomic) BOOL isFirstTime;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) CLPlacemark *placemark;

@property (nonatomic) BOOL gotCreated;

@property (strong, nonatomic) UIImage *userImage;



+ (instancetype)sharedDataStore;

-(NSArray *)usersWithSameCity;
-(NSArray *)usersWithSameCountry;

-(void)setupFirebase;
-(void)addUserToFirebase: (DYUser *)user;
-(void)addJournalToFirebase:(DYUser *)user :(DYJournalEntry *)journalEntry;
-(void)pushLastJournal;

-(void)deleteAllCurrentUserEntries;

//-(NSArray *)generateQuestions;
+ (BOOL)isNetworkAvailable;
-(void)requestLocationPermission;
-(void)setUpLocationManager;

//-(void)createNewCurrentUserFromFirebase:(NSString *)userUUID;



-(void)addPlacemark: (CLPlacemark*)placeMark;

- (void)removeValue;

-(void)updateFirebaseJournals;
















  



@end
