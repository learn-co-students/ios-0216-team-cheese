//
//  DYJournalEntry.h
//  DidYou
//
//  Created by Brian Clouser on 3/29/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYJournalEntry : NSObject

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *mainEmotion;
@property (strong, nonatomic) NSString *journalEntry;
@property (nonatomic) NSUInteger question1;
@property (nonatomic) NSUInteger question2;
@property (nonatomic) NSUInteger question3;
@property (nonatomic) NSUInteger question4;
@property (nonatomic) NSUInteger question5;
@property (strong, nonatomic) NSString *picture1Address;
@property (strong, nonatomic) NSString *picture2Address;
@property (strong, nonatomic) NSString *picture3Address;
@property (strong, nonatomic) NSString *picture4Address;
@property (strong, nonatomic) NSString *picture5Address;

-(instancetype)init;

-(instancetype)initWithDate:(NSDate *)date mainEmotion:(NSString *)mainEmotion journalEntry:(NSString *)journalEntry question1:(NSUInteger)question1 question2:(NSUInteger)question2 question3:(NSUInteger)question3 question4:(NSUInteger)question4 question5:(NSUInteger)question5 picture1Address:(NSString *)picture1Address picture2Address:(NSString *)picture2Address picture3Address:(NSString *)picture3Address picture4Address:(NSString *)picture4Address picture5Address:(NSString *)picture5Address;




@end
