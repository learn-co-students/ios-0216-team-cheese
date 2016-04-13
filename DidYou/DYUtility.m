//
//  DYUtility.m
//  DidYou
//
//  Created by Zirui Branton on 4/6/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "DYUtility.h"

@implementation DYUtility

+ (instancetype)sharedUtility
{
    static DYUtility *_sharedUtility = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedUtility = [[DYUtility alloc] init];
    });
    
    return _sharedUtility;
}

-(instancetype)init
{
    return [super init];
}

// Serialize date object to string
- (NSString *)getUTCFormatDate:(NSDate *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return dateString;
}

// Take a UTC string and convert back to date object
- (NSDate *)fromUTCFormatDate:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString: dateString];
    return date;
}

//add a sortbydate method to DYUtility and call it after deseriaize the objects and before set the journals property.

-(NSMutableArray *)sortEntriesFromArray: (NSMutableArray *) nodeEventArray{
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor
                                        sortDescriptorWithKey:@"date"
                                        ascending:YES];
    NSArray *sortDescriptors = @[dateDescriptor];
    
    NSArray *sortedEventArray = [nodeEventArray
                                 sortedArrayUsingDescriptors:sortDescriptors];
    NSLog(@"%@", sortedEventArray);
    return [sortedEventArray mutableCopy];

}

@end
