//
//  AddJournalEntryView.h
//  DidYou
//
//  Created by Brian Clouser on 3/30/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddJournalEntryViewDelegate <NSObject>

- (void)addButtonTapped:(UIButton *)sender;

@end


@interface AddJournalEntryView : UIView

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *addLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) id <AddJournalEntryViewDelegate> delegate;

@end
