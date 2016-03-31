//
//  QuestionView.h
//  DidYou
//
//  Created by Andre Creighton on 3/31/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYQuestion.h"

@protocol QuestionViewDelegate <NSObject>

-(void)questionAnswered:(UIButton *)sender;

@end


@interface QuestionView : UIView

@property (strong, nonatomic) DYQuestion *question;
@property (weak, nonatomic) id <QuestionViewDelegate> delegate;

@end
