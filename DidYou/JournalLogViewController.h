//
//  JournalLogViewController.h
//  DidYou
//
//  Created by Andre Creighton on 4/11/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYJournalEntry.h"


@interface JournalLogViewController : UIViewController



@property (nonatomic, strong) DYJournalEntry *jorunalEntry;
@property (nonatomic, strong) UILabel *theLabelForTheDate;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) NSDate *dateOfPost;

@end
