//
//  DoubanViewController.h
//  guoSeven
//
//  Created by David on 13-1-29.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DOUOAuthService.h"


@protocol DoubanViewControllerDelegate <NSObject>

- (void)DoubanSuccess;
- (void)DoubanFail;
@end


@interface DoubanViewController : UIViewController<UIWebViewDelegate, DOUOAuthServiceDelegate>
@property (nonatomic, assign) id<DoubanViewControllerDelegate> delegate;

@end
