//
//  DYUser.h
//  DidYou
//
//  Created by Brian Clouser on 3/29/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYUser : NSObject

@property (strong, nonatomic) NSString *userUUID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSDate *signUpDate;

@property (strong, nonatomic) NSMutableArray *journals;

-(instancetype)init;

-(instancetype)initWithUserUUID:(NSString *)userUUID signUpDate:(NSDate *)signUpDate;

-(instancetype)initWithUserUUID:(NSString *)userUUID signUpDate:(NSDate *)signUpDate name:(NSString *)name city:(NSString *)city country:(NSString *)country journals:(NSMutableArray *)journals;









@end
