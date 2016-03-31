//
//  DYQuestion.h
//  DidYou
//
//  Created by Andre Creighton on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYQuestion : NSObject


@property (nonatomic, strong) NSString *question;
@property (nonatomic) NSUInteger answer;




-(instancetype)init;

-(instancetype)initWithQuestion:(NSString *)question;






@end
