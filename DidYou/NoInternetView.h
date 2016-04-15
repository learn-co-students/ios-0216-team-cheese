//
//  noInternetView.h
//  DidYou
//
//  Created by Brian Clouser on 4/14/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NoInternetDelegate <NSObject>

-(void)refreshTapped;

@end

@interface NoInternetView : UIView

@property (strong, nonatomic) id <NoInternetDelegate> delegate;

@end
