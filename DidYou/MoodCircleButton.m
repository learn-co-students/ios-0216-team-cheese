//
//  MoodCircleButton.m
//  DidYou
//
//  Created by Kayla Galway on 4/6/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "MoodCircleButton.h"

@implementation MoodCircleButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat maxDimension = MAX(self.frame.size.width, self.frame.size.height);
    
    self.layer.cornerRadius = maxDimension / 2.0;
}

@end
