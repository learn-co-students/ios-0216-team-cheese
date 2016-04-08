//
//  JournalAndPictureView.h
//  DidYou
//
//  Created by Andre Creighton on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@protocol JournalAndPictureViewDelegate <NSObject>

-(void)journalComplete:(UIButton *)sender;
-(void)whenAddPhotoButtonIsTapped:(id)sender;
-(void)whenDeleteButtonIsTapped:(id)sender;
-(void)whenTapGestureIsRecognized:(UITapGestureRecognizer *)sender;

@end

@interface JournalAndPictureView : UIView

@property (weak, nonatomic) id <JournalAndPictureViewDelegate> delegate;
@property (nonatomic,strong) IBOutlet UIImageView   *imageView;
@property (nonatomic,strong) UITextView             *textView;
@property (nonatomic,strong) UITapGestureRecognizer *tapOutKeyboard;
@property (nonatomic,strong) UIButton               *deletePhotoButton;
@property (nonatomic,strong) UIImage                *imageInImageView;
@property (nonatomic,strong) NSLayoutConstraint     *imageHeightConstraint;
@property (nonatomic,strong) NSLayoutConstraint     *imageWidthConstraint;

-(void)setImageInImageView:(UIImage *)image;


@end
