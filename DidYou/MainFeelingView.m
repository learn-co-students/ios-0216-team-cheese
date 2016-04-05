//
//  MainFeelingView.m
//  DidYou
//
//  Created by Andre Creighton on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "MainFeelingView.h"
#import "DataStore.h"
#import "CategoryFeelingView.h"





@interface MainFeelingView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) DYJournalEntry *currentEntry;


@end


@implementation MainFeelingView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}

-(void)commonInit
{
    [[NSBundle mainBundle] loadNibNamed:@"MainFeeling" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    self.dataStore = [DataStore sharedDataStore];
    
    NSArray *journals = self.dataStore.currentUser.journals;
    
    NSLog(@"in the common init for main feeling, the number or journals is: %lu", self.dataStore.currentUser.journals.count);
    
    self.currentEntry = [journals lastObject];
    
}

- (IBAction)happyTapped:(id)sender
{
    self.currentEntry.mainEmotion = @"Happy";
    [self.delegate feelingChosen:sender];
    
    NSLog(@"happy tapped");
    
}

- (IBAction)tenderTapped:(id)sender
{
    self.currentEntry.mainEmotion = @"Tender";
     [self.delegate feelingChosen:sender];
}

- (IBAction)angryTapped:(id)sender
{
    self.currentEntry.mainEmotion = @"Angry";
     [self.delegate feelingChosen:sender];
}
- (IBAction)excitedTapped:(id)sender
{
    self.currentEntry.mainEmotion = @"Excited";
     [self.delegate feelingChosen:sender];
}
- (IBAction)scaredTapped:(id)sender
{
    self.currentEntry.mainEmotion = @"Scared";
     [self.delegate feelingChosen:sender];
}
- (IBAction)sadTapped:(id)sender
{
    self.currentEntry.mainEmotion = @"Sad";
     [self.delegate feelingChosen:sender];
}



@end
