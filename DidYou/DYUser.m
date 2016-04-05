//
//  DYUser.m
//  DidYou
//
//  Created by Brian Clouser on 3/29/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "DYUser.h"

@implementation DYUser




-(instancetype)init
{
    self = [self initWithUserUUID:@"" signUpDate:[NSDate date] name:@"" city:@"" country:@"" journals:[[NSMutableArray alloc] init]];
    
    return self;
}

-(instancetype)initWithUserUUID:(NSString *)userUUID signUpDate:(NSDate *)signUpDate
{
    self = [self initWithUserUUID:userUUID signUpDate:signUpDate name:@"" city:@"" country:@"" journals:[[NSMutableArray alloc] init]];
    
    return self;
    
}

-(instancetype)initWithUserUUID:(NSString *)userUUID signUpDate:(NSDate *)signUpDate name:(NSString *)name city:(NSString *)city country:(NSString *)country journals:(NSMutableArray *)journals
{
    self = [super init];
    
    if (self)
    {
        _userUUID = userUUID;
        _signUpDate = signUpDate;
        _name = name;
        _city = city;
        _country = country;
        _journals = journals;

    }
    
    return self;
    
}

-(NSArray *)journalArrayLIFO
{
    NSMutableArray *journalsLIFO = [[NSMutableArray alloc] init];
    
    for (NSInteger i = self.journals.count - 1; i >= 0; i--)
    {
        [journalsLIFO addObject:self.journals[i]];
        
    }
    
    return journalsLIFO;
}

@end
