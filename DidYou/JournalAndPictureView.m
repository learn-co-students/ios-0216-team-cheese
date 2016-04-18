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


@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) NSString *emotion;
@property (strong, nonatomic) IBOutlet UIButton *postButton;





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
    
    
    self.dataStore = [DataStore sharedDataStore];
    NSArray *journals = self.dataStore.currentUser.journals;
    DYJournalEntry *currentJournal = [journals lastObject];
    self.emotion = currentJournal.mainEmotion;

    
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
    [addPhotoButton setTintColor:[UIColor darkGrayColor]];
    [[addPhotoButton imageView] setContentMode:UIViewContentModeScaleAspectFill];
    [addPhotoButton addTarget:self action:@selector(whenAddPhotoButtonIsTapped:) forControlEvents:UIControlEventTouchUpInside];
    [addPhotoButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:addPhotoButton];
    [addPhotoButton.heightAnchor constraintEqualToConstant:30].active = YES;
    [addPhotoButton.widthAnchor constraintEqualToConstant:30].active = YES;
    [addPhotoButton.rightAnchor constraintEqualToAnchor:self.imageView.leftAnchor constant:-40].active = YES;
    [addPhotoButton.bottomAnchor constraintEqualToAnchor:self.textView.topAnchor constant:-40].active = YES;
    
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
    
    [self.textView becomeFirstResponder];
    
    self.postButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.postButton addTarget:self action:@selector(doneButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.postButton setTitle:@"Post" forState:UIControlStateNormal];
    [self.postButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.postButton];
    [self.postButton.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor multiplier:0.2].active = YES;
    [self.postButton.heightAnchor constraintEqualToAnchor:self.contentView.heightAnchor multiplier:0.05].active = YES;
    [self.postButton.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-10].active = YES;
    [self.postButton.topAnchor constraintEqualToAnchor:self.textView.bottomAnchor].active = YES;
    
    self.deletePhotoButton.hidden = YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
    if(self.textView.textColor == [UIColor lightGrayColor])
    {
        self.textView.text = @"";
        self.textView.textColor = [UIColor darkGrayColor];
        
    }
    [UIView animateWithDuration:0.2f animations:^{
        self.labelOverKeyboard.alpha = 1;
        
    }];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    
    if(self.textView.text.length == 0)
    {
        self.textView.text = [NSString stringWithFormat:@"Why are you feeling %@?", self.emotion];
        self.textView.textColor = [UIColor lightGrayColor];
        
    }
    
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
