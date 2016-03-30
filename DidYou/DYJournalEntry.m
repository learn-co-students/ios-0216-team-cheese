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
    self = [self initWithDate:[NSDate date] mainEmotion:@"" journalEntry:@"" question1:0 question2:0 question3:0 question4:0 question5:0 picture1Address:@"" picture2Address:@"" picture3Address:@"" picture4Address:@"" picture5Address:@""];
    
    return self;
}


-(instancetype)initWithDate:(NSDate *)date mainEmotion:(NSString *)mainEmotion journalEntry:(NSString *)journalEntry question1:(NSUInteger)question1 question2:(NSUInteger)question2 question3:(NSUInteger)question3 question4:(NSUInteger)question4 question5:(NSUInteger)question5 picture1Address:(NSString *)picture1Address picture2Address:(NSString *)picture2Address picture3Address:(NSString *)picture3Address picture4Address:(NSString *)picture4Address picture5Address:(NSString *)picture5Address
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
        _picture2Address = picture2Address;
        _picture3Address = picture3Address;
        _picture4Address = picture4Address;
        _picture5Address = picture5Address;
    }
    
    return self;
}



@end
