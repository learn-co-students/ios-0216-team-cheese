//
//  DYQuestion.m
//  DidYou
//
//  Created by Andre Creighton on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "DYQuestion.h"

@implementation DYQuestion



-(instancetype) init{
    
    
    self = [self initWithQuestion:@""];
    
    
    return self;
    
}


-(instancetype)initWithQuestion:(NSString *)question{
    
    
    self = [super init];
    
    if(self){
        
        
        _question = question;
        _answer = 0;
        
        
        
        
    }
    
    return self;
    
    
}

@end
