//
//  DYJournalEntry.m
//  DidYou
//
//  Created by Brian Clouser on 3/29/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "DYJournalEntry.h"

@implementation DYJournalEntry


-(instancetype)init
{
    self = [self initWithDate:[NSDate date] mainEmotion:@"" journalEntry:@"" question1:0 question2:0 question3:0 question4:0 question5:0 picture1Address:@"" ];
    
    return self;
}


-(instancetype)initWithDate:(NSDate *)date mainEmotion:(NSString *)mainEmotion journalEntry:(NSString *)journalEntry question1:(NSUInteger)question1 question2:(NSUInteger)question2 question3:(NSUInteger)question3 question4:(NSUInteger)question4 question5:(NSUInteger)question5 picture1Address:(NSString *)picture1Address
{
    self = [super init];
    
    if (self)
    {
        _date = date;
        _mainEmotion = mainEmotion;
        _journalEntry = journalEntry;
        _question1 = question1;
        _question2 = question2;
        _question3 = question3;
        _question4 = question4;
        _question5 = question5;
        _picture1Address = picture1Address;
   
    }
    
    return self;
}



@end
