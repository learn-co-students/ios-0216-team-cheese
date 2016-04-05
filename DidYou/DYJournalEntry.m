//
//  DYJournalEntry.m
//  DidYou
//
//  Created by Brian Clouser on 3/29/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "DYJournalEntry.h"
#import "DYQuestion.h"

@implementation DYJournalEntry


-(instancetype)init
{
    
    self = [self initWithDate:[NSDate date] mainEmotion:@"" journalEntry:@"" picture1Address:@""];
    return self;
}


-(instancetype)initWithDate:(NSDate *)date mainEmotion:(NSString *)mainEmotion journalEntry:(NSString *)journalEntry picture1Address:(NSString *)picture1Address
{
    self = [super init];
    
    if (self)
    {
        _date = date;
        _mainEmotion = mainEmotion;
        _journalEntry = journalEntry;
        _picture1Address = picture1Address;
        _questions = [self generateQuestions];
   
    }
    
    return self;
    
    
}


-(NSArray *)generateQuestions{
    
    
    NSArray *questions = @[ [[DYQuestion alloc] initWithQuestion:@"get a good night's sleep?"] , [[DYQuestion alloc] initWithQuestion:@"do something nice for someone?"] ,[[DYQuestion alloc] initWithQuestion:@"eat a healthy breakfast?"] , [[DYQuestion alloc] initWithQuestion:@"workout in any way?"] , [[DYQuestion alloc] initWithQuestion:@"have sex?"]];
    
    return questions;
                            
}


@end
