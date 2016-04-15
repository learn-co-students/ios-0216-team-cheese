//
//  JournalAndPictureView.m
//  DidYou
//
//  Created by Andre Creighton on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "JournalAndPictureView.h"
#import "DataStore.h"


@interface JournalAndPictureView () <UITextViewDelegate>

@property (strong, nonatomic) UIButton *finishedButton;
@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) NSString *emotion;
@property (strong, nonatomic) IBOutlet UIButton *doneButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *doneButtonAppearFromBottom;



@end

@implementation JournalAndPictureView



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
    
    
    
    [[NSBundle mainBundle] loadNibNamed:@"JournalAndPicture" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
    
    
    [self viewsAreSet];
    
}

-(void)viewsAreSet

{
    self.doneButton.alpha = 0;
    
    self.dataStore = [DataStore sharedDataStore];
    NSArray *journals = self.dataStore.currentUser.journals;
    DYJournalEntry *currentJournal = [journals lastObject];
    self.emotion = currentJournal.mainEmotion;
    
    self.tapOutKeyboard = [[UITapGestureRecognizer alloc] init];
    [self.contentView addGestureRecognizer:self.tapOutKeyboard];
    [self.tapOutKeyboard addTarget:self action:@selector(whenTapGestureIsRecognized:)];
    self.tapOutKeyboard.enabled = NO;
    
    self.textView = [UITextView new];
    self.textView.backgroundColor = [UIColor clearColor]; // made the textView transparent
    [self.textView setFont:[UIFont fontWithName:@"Arial" size:18]];
    self.textView.text = [NSString stringWithFormat:@"Why are you feeling %@?", self.emotion];
    self.textView.textColor = [UIColor lightGrayColor];
    [self.textView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview: self.textView];
    
    self.imageView = [[UIImageView alloc] initWithImage:nil];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    [self.imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.imageView];
    self.imageHeightConstraint = [self.imageView.heightAnchor constraintEqualToConstant:100];
    self.imageWidthConstraint = [self.imageView.widthAnchor constraintEqualToConstant:100];
    self.imageHeightConstraint.active = YES;
    self.imageWidthConstraint.active = YES;
    [self.imageView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    [self.imageView.bottomAnchor constraintEqualToAnchor:self.textView.topAnchor constant:-10].active = YES;
    
    [self.textView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:150].active = YES;
    [self.textView.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor constant:-20].active = YES;
    [self.textView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant: 5].active = YES;
    [self.textView.heightAnchor constraintEqualToAnchor:self.contentView.heightAnchor multiplier:.325].active = YES;
    
    self.textView.delegate = self;
    
    UIButton *addPhotoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [addPhotoButton setImage:[UIImage imageNamed:@"cameraImage"] forState:UIControlStateNormal];
    //[addPhotoButton setTintColor:[[UIColor alloc]initWithRed:0 green:.50 blue:1 alpha:1]];
    [addPhotoButton setTintColor:[UIColor darkGrayColor]];
    [[addPhotoButton imageView] setContentMode:UIViewContentModeScaleAspectFill];
    [addPhotoButton addTarget:self action:@selector(whenAddPhotoButtonIsTapped:) forControlEvents:UIControlEventTouchUpInside];
    [addPhotoButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:addPhotoButton];
    [addPhotoButton.heightAnchor constraintEqualToConstant:30].active = YES;
    [addPhotoButton.widthAnchor constraintEqualToConstant:30].active = YES;
    [addPhotoButton.rightAnchor constraintEqualToAnchor:self.imageView.leftAnchor constant:-40].active = YES;
    [addPhotoButton.bottomAnchor constraintEqualToAnchor:self.textView.topAnchor constant:-40].active = YES;
    
    self.finishedButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.finishedButton setTitle:@"Finished!" forState:UIControlStateNormal];
    [self.finishedButton addTarget:self action:@selector(whenDoneEditingButtonIsTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.finishedButton.heightAnchor constraintEqualToConstant:40].active = YES;
    [self.finishedButton.widthAnchor constraintEqualToConstant:80].active = YES;
    [self.finishedButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.finishedButton];
    [self.finishedButton.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-10].active = YES;
    [self.finishedButton.topAnchor constraintEqualToAnchor:self.textView.bottomAnchor].active = YES;
    self.finishedButton.hidden = YES;
    
    self.deletePhotoButton =[UIButton buttonWithType:UIButtonTypeSystem];
    [self.deletePhotoButton setTintColor:[UIColor redColor]];
    [self.deletePhotoButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [self.deletePhotoButton addTarget:self action:@selector(whenDeleteButtonIsTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.deletePhotoButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.deletePhotoButton];
    
    [self.deletePhotoButton.leftAnchor constraintEqualToAnchor:self.imageView.rightAnchor constant:40].active = YES;
    [self.deletePhotoButton.topAnchor constraintEqualToAnchor:self.textView.topAnchor constant:-65].active = YES;
    [self.deletePhotoButton.heightAnchor constraintEqualToConstant:20].active = YES;
    [self.deletePhotoButton.widthAnchor constraintEqualToConstant:20].active = YES;
    
    
    self.labelOverKeyboard = [[UILabel alloc] init];
    self.labelOverKeyboard.text = [NSString stringWithFormat:@"Feeling %@? Write about it..", self.emotion];
    [self.labelOverKeyboard setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.labelOverKeyboard];
    [self.labelOverKeyboard.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor ].active = YES;
    [self.labelOverKeyboard.heightAnchor constraintEqualToConstant:40].active = YES;
    [self.labelOverKeyboard.topAnchor constraintEqualToAnchor:self.textView.bottomAnchor constant:30].active = YES;
    self.labelOverKeyboard.textAlignment = NSTextAlignmentCenter;
    self.labelOverKeyboard.textColor = [UIColor whiteColor];
    self.labelOverKeyboard.backgroundColor = [UIColor colorWithRed:34.0/255.0 green:164.0/255.0 blue:0 alpha:.5];
    
    
    
    
    self.deletePhotoButton.hidden = YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
    if(self.textView.textColor == [UIColor lightGrayColor])
    {
        self.textView.text = @"";
        self.textView.textColor = [UIColor darkGrayColor];
        
    }
    self.tapOutKeyboard.enabled = YES;
    self.finishedButton.hidden = NO;
  
    
    [UIView animateWithDuration:0.2f animations:^{
        self.labelOverKeyboard.alpha = 1;
        self.finishedButton.enabled = YES;
    }];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    
    if(self.textView.text.length == 0)
    {
        self.textView.text = [NSString stringWithFormat:@"Why are you feeling %@?", self.emotion];
        self.textView.textColor = [UIColor lightGrayColor];
        
    }
    
    self.tapOutKeyboard.enabled = NO;
    self.finishedButton.enabled = NO;
    self.finishedButton.hidden = YES;
    
    
}

-(void)textViewDidChange:(UITextView *)textView
{
    
    self.finishedButton.enabled = YES;
    
}

-(IBAction)whenTapGestureIsRecognized:(id)sender
{
    [self.contentView endEditing:YES];
    self.finishedButton.hidden = YES;
    
    [UIView animateWithDuration:0.2f animations:^{
        self.labelOverKeyboard.alpha = 0;
        self.doneButton.alpha = 1;
    }];
    
    
}

-(IBAction)whenDoneEditingButtonIsTapped:(id)sender
{
    
    [self.contentView endEditing:YES];
    self.finishedButton.hidden = YES;
    
    [UIView animateWithDuration:0.2f animations:^{
        self.labelOverKeyboard.alpha = 0;
        self.doneButton.alpha = 1;
        self.doneButtonAppearFromBottom.constant = 50;
    }];
}

-(IBAction)whenAddPhotoButtonIsTapped:(id)sender
{
    [UIView animateWithDuration:0.2f animations:^{
        self.labelOverKeyboard.alpha = 0;
    }];
    [self.delegate whenAddPhotoButtonIsTapped:sender];
}

-(IBAction)whenDeleteButtonIsTapped:(id)sender
{
    [self.delegate whenDeleteButtonIsTapped:sender];
    
}
- (IBAction)doneButtonTapped:(id)sender
{
    [self.delegate journalComplete:sender];
}

@end
