//
//  DYJournalEntry.m
//  DidYou
//
//  Created by Brian Clouser on 3/29/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "DYJournalEntry.h"
#import "DYQuestion.h"
#import "DYUtility.h"

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

-(instancetype)initWithDeserialize: (NSMutableDictionary*)data
{
    self = [super init];
    DYUtility *util = [[DYUtility alloc] init];
    if (self)
    {
        NSMutableArray *q = [[NSMutableArray alloc] init];
        for (NSMutableDictionary *dict in data[@"questions"])
        {
            [q addObject:[[DYQuestion alloc] initWithDeserialize:dict]];
        }
        _date = [util fromUTCFormatDate:data[@"date"]];
        _mainEmotion = data[@"emotion"];
        _journalEntry = data[@"journalEntry"];
        _picture1Address = data[@"picture1Address"];
        _questions = q;
    }
    return self;
}


-(NSArray *)generateQuestions{
    
    
    NSArray *questions = @[ [[DYQuestion alloc] initWithQuestion:@"get a good night's sleep?"] , [[DYQuestion alloc] initWithQuestion:@"do something nice for someone?"] ,[[DYQuestion alloc] initWithQuestion:@"eat a healthy breakfast?"] , [[DYQuestion alloc] initWithQuestion:@"workout in any way?"] , [[DYQuestion alloc] initWithQuestion:@"have sex?"]];
    
    return questions;
                            
}

-(NSMutableDictionary *)serialize
{
    DYUtility *util = [[DYUtility alloc] init];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    NSMutableArray *questions = [[NSMutableArray alloc] init];
    
    for (DYQuestion *question in _questions)
    {
        [questions addObject:[question serialize]];
    }
    data[@"date"] = [util getUTCFormatDate:_date];
    data[@"emotion"] = _mainEmotion;
    data[@"journalEntry"] = _journalEntry;
    data[@"picture1address"] = _picture1Address;
    data[@"questions"] = _questions;
    return data;
}


@end
