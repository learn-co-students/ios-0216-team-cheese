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

// Serialize date object to string, firebase can't store object, so have to put it in a format, this is a time stamp
- (NSString *)getUTCFormatDate:(NSDate *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return dateString;
}

// Take a UTC string and convert back to date object, reverse of the above method, this is how you insert to your date object, deserialization
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

-(NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

-(UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}



@end
