//
//  DYUtility.h
//  DidYou
//
//  Created by Zirui Branton on 4/6/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DYUtility : NSObject

+ (instancetype)sharedUtility;

// Utility functions
-(NSString *)getUTCFormatDate:(NSDate *)localDate;
-(NSDate *)fromUTCFormatDate:(NSString *)dateString;
-(NSArray *) sortEntriesFromArray: (NSArray *) nodeEventArray;





@end
