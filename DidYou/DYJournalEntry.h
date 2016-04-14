//
//  DYJournalEntry.h
//  DidYou
//
//  Created by Brian Clouser on 3/29/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DYJournalEntry : NSObject

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *mainEmotion;
@property (strong, nonatomic) NSString *journalEntry;
@property (strong, nonatomic) NSArray *questions;
@property (strong, nonatomic) NSString *picture1Address;
@property (strong, nonatomic) UIImage *userImage;

-(instancetype)init;

-(instancetype)initWithDate:(NSDate *)date mainEmotion:(NSString *)mainEmotion journalEntry:(NSString *)journalEntry picture1Address:(NSString *)picture1Address userImage:(UIImage *)userImage;

-(instancetype)initWithDeserialize: (NSMutableDictionary*)data;

-(NSMutableDictionary *)serialize;
-(NSArray *)generateQuestions;


@end
