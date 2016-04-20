//
//  DYQuestion.m
//  DidYou
//
//  Created by Andre Creighton on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "DYQuestion.h"

@implementation DYQuestion



-(instancetype) init
{
    self = [self initWithQuestion:@""];
    return self;
}


-(instancetype)initWithQuestion:(NSString *)question 
{
    self = [super init];
    if(self){
        _question = question;
        _answer = 0;
    }
    return self;
}

-(instancetype)initWithDeserialize:(NSMutableDictionary *)data
{
    self = [super init];
    if (self) {
        // grab question and answer from the dict
        _question = data[@"question"];
        _answer = [data[@"answer"] unsignedIntegerValue];
    }
    return self;
}

-(NSMutableDictionary *)serialize
{
    // convert into firebase friendly dict
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"question"] = self.question;
    dict[@"answer"] = [NSNumber numberWithUnsignedInteger:_answer];
    return dict;
}

@end
