//
//  JournalAndPictureAlternateView.m
//  DidYou
//
//  Created by Brian Clouser on 4/18/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "JournalAndPictureAlternateView.h"
#import "DataStore.h"
#import "DYJournalEntry.h"

@interface JournalAndPictureAlternateView () <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UIView *textFieldBackground;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (strong, nonatomic) DataStore *datastore;
@property (strong, nonatomic) DYJournalEntry *currentEntry;

@end

@implementation JournalAndPictureAlternateView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

-(void)commonInit
{
    [[NSBundle mainBundle] loadNibNamed:@"JournalAndPictureAlternate" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
    self.datastore = [DataStore sharedDataStore];
    self.currentEntry = [self.datastore.currentUser.journals lastObject];
    self.textView.delegate = self;
}

- (IBAction)doneButtonTapped:(id)sender
{
    BOOL noJournal = [self.textView.text isEqualToString:@"Record your thoughts and feelings here.  It will be very helpful and therapuetic to come back and read this later on. "];
    
    if (noJournal)
    {
        self.currentEntry.journalEntry = @"";
    }
    else
    {
        self.currentEntry.journalEntry = self.textView.text;
    }
    [self.delegate doneButtonTapped];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.textView.text = @"";
}

@end
