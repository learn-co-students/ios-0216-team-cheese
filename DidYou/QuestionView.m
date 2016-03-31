//
//  QuestionView.m
//  DidYou
//
//  Created by Andre Creighton on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "QuestionView.h"

@interface QuestionView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *didYouLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIButton *yesButton;
@property (weak, nonatomic) IBOutlet UIButton *noButton;


@end

@implementation QuestionView


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
    
    
    [[NSBundle mainBundle] loadNibNamed:@"Question" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
}

-(void)setQuestion:(DYQuestion *)question
{
    _question = question;
    
    self.questionLabel.text = question.question;
    
}




- (IBAction)yesButtonTapped:(id)sender
{
    
    self.question.answer = 2;
    
    [self.delegate questionAnswered:sender];
    
    
}
- (IBAction)noButtonTapped:(id)sender
{
    
    self.question.answer = 1;
    
    [self.delegate questionAnswered:sender];
    
}

@end
