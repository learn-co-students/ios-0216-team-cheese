//
//  JournalLogViewController.m
//  DidYou
//
//  Created by Andre Creighton on 4/11/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "JournalLogViewController.h"
#import "DYQuestion.h"

@interface JournalLogViewController ()
@property (strong,nonatomic) UIColor *createdColor;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *emotionLabel;


@property (weak, nonatomic) IBOutlet UIView *question1View;
@property (weak, nonatomic) IBOutlet UIView *question2View;
@property (weak, nonatomic) IBOutlet UIView *question3View;
@property (weak, nonatomic) IBOutlet UIView *question4View;
@property (weak, nonatomic) IBOutlet UIView *question5View;
@property (weak, nonatomic) IBOutlet UITextView *journalTextField;
@property (nonatomic) NSUInteger answer1;
@property (nonatomic) NSUInteger answer2;
@property (nonatomic) NSUInteger answer3;
@property (nonatomic) NSUInteger answer4;
@property (nonatomic) NSUInteger answer5;





@end

@implementation JournalLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.answer1 = ((DYQuestion *)self.journalEntry.questions[0]).answer;
    self.answer2 = ((DYQuestion *)self.journalEntry.questions[1]).answer;
    self.answer3 = ((DYQuestion *)self.journalEntry.questions[2]).answer;
    self.answer4 = ((DYQuestion *)self.journalEntry.questions[3]).answer;
    self.answer5 = ((DYQuestion *)self.journalEntry.questions[4]).answer;
    
    NSLog(@"%lu", self.answer1);
     NSLog(@"%lu", self.answer2);
     NSLog(@"%lu", self.answer3);
     NSLog(@"%lu", self.answer4);
     NSLog(@"%lu", self.answer5);
    
    NSLog(@"%@", self.journalEntry.mainEmotion);
    
    
    
    if (self.journalEntry.journalEntry.length == 0)
    {
        self.journalTextField.text = @"You didn't record a journal for this entry.  Do it next time! Reading your old journals is extremely helpful.";
    }
    else
    {
        self.journalTextField.text = self.journalEntry.journalEntry;
    }
    

    [self makeIconsCircles];
    
    [self generateEmotionLabel];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"eeee, MMMM dd"];
    
    NSString *dateString = [formatter stringFromDate:self.journalEntry.date];
    
    self.dateLabel.text = dateString;
    
}

-(void)makeIconsCircles
{
    
    self.question1View.layer.cornerRadius = 25;
    self.question2View.layer.cornerRadius = 25;
    self.question3View.layer.cornerRadius = 25;
    self.question4View.layer.cornerRadius = 25;
    self.question5View.layer.cornerRadius = 25;
    
    self.question1View.backgroundColor = [self colorGivenQuestionAnswer:self.answer1];
    self.question2View.backgroundColor = [self colorGivenQuestionAnswer:self.answer2];
    self.question3View.backgroundColor = [self colorGivenQuestionAnswer:self.answer3];
    self.question4View.backgroundColor = [self colorGivenQuestionAnswer:self.answer4];
    self.question5View.backgroundColor = [self colorGivenQuestionAnswer:self.answer5];
    
}





-(UIColor *)colorGivenQuestionAnswer:(NSUInteger)answer
{
    if (answer == 0)
    {
        return [UIColor colorWithRed:255.0/255.0 green:0 blue:17.0/255.0 alpha:.5];
    }
    else if (answer == 1)
    {
        return [UIColor colorWithRed:255.0/255.0 green:0 blue:17.0/255.0 alpha:.5];
    }
    else
    {
        return [UIColor colorWithRed:34.0/255.0 green:164.0/255.0 blue:0 alpha:.5];
    }
}

-(void)generateEmotionLabel
{
    self.emotionLabel.text = [NSString stringWithFormat:@"You were feeling %@", self.journalEntry.mainEmotion.lowercaseString];
}


- (IBAction)backButtonTap:(id)sender
{
    NSLog(@"getting tapped");
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
          [self dismissViewControllerAnimated:YES completion:nil];
        
    });

  

}

@end
