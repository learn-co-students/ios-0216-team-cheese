//
//  DYJournalEntry.m
//  DidYou
//
//  Created by Brian Clouser on 3/29/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "DYJournalEntry.h"
#import "DYUtility.h"
#import "DYQuestion.h"

@implementation DYJournalEntry


-(instancetype)init
{
    
    self = [self initWithDate:[NSDate date] mainEmotion:@"" journalEntry:@"" picture1Address:@"" userImage:nil];
    return self;
}


-(instancetype)initWithDate:(NSDate *)date mainEmotion:(NSString *)mainEmotion journalEntry:(NSString *)journalEntry picture1Address:(NSString *)picture1Address userImage:(UIImage *)userImage
{
    self = [super init];
    
    if (self)
    {
        _date = date;
        _mainEmotion = mainEmotion;
        _journalEntry = journalEntry;
        _picture1Address = picture1Address;
        _userImage = userImage;
        _questions = [self generateQuestions];
   
    }
    
    return self;
    
    
}

-(instancetype)initWithDeserialize: (NSMutableDictionary*)data
{
    self = [super init];
    if (self)
    {
        DYUtility *util = [DYUtility sharedUtility];
        NSMutableArray *q = [[NSMutableArray alloc] init];
        for (NSMutableDictionary *dict in data[@"questions"])
        {
            [q addObject:[[DYQuestion alloc] initWithDeserialize:dict]];
        }
        _date = [util fromUTCFormatDate:data[@"date"]];
        _mainEmotion = data[@"emotion"];
        _journalEntry = data[@"journalEntry"];
        _picture1Address = data[@"picture1Address"];
        if (!data[@"userImage"]) {
            _userImage = nil;
        } else
        {
            _userImage = [util decodeBase64ToImage: data[@"userImage"]];
        }
        _questions = q;
    }
    return self;
}

-(NSMutableDictionary *)serialize
{
    DYUtility *util = [DYUtility sharedUtility];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    NSMutableArray *questions = [[NSMutableArray alloc] init];

    //UIImage *userImage = [util decodeBase64ToImage: _picture1Address];
    
    for (DYQuestion *question in _questions)
    {
        [questions addObject:[question serialize]];
    }
    data[@"date"] = [util getUTCFormatDate:_date];
    data[@"emotion"] = _mainEmotion;
    data[@"journalEntry"] = _journalEntry;
    data[@"picture1address"] = _picture1Address;
    if (!_userImage)
    {
        data[@"userImage"] = @"nil";
    } else
    {
        data[@"userImage"] = [util encodeToBase64String:[util compressForUpload:_userImage scale:0.5]];
    }
    data[@"questions"] = questions;
    
    return data;
}

-(NSArray *)generateQuestions
{
    
    return @[ [[DYQuestion alloc] initWithQuestion:@"get a good night's sleep?"] , [[DYQuestion alloc] initWithQuestion:@"eat a healthy breakfast?"] ,[[DYQuestion alloc] initWithQuestion:@"workout today?"] , [[DYQuestion alloc] initWithQuestion:@"do something nice for someone today?"] , [[DYQuestion alloc] initWithQuestion:@"share physical intimacy with another in the last 24 hours?"]];
}


@end
