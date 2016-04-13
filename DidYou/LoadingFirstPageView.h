//
//  loadingFirstPageView.h
//  DidYou
//
//  Created by Zirui Branton  on 4/11/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoadingFirstPageViewDelegate <NSObject>

@end

@interface LoadingFirstPageView : UIView

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) id <LoadingFirstPageViewDelegate> delegate;

@end
