//
//  AddJournalEntryView.m
//  DidYou
//
//  Created by Brian Clouser on 3/30/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "AddJournalEntryView.h"

@interface AddJournalEntryView ()


@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *addLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end


@implementation AddJournalEntryView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self setUpView];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setUpView];
    }
    
    return self;
}

-(void)setUpView
{
    
    
    [[NSBundle mainBundle] loadNibNamed:@"AddJournalEntry" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
}

-(void)setAddLabel:(UILabel *)addLabel
{
    
    self.addLabel.text = @"hey there";
     
}
- (IBAction)whenAddButtonTapped:(id)sender
{
    
    [self.delegate addButtonTapped:sender];
    

}






@end
