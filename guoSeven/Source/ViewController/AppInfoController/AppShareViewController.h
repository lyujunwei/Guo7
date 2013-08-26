//
//  AppShareViewController.h
//  guoSeven
//
//  Created by RainSets on 13-1-21.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDetailsInfo.h"
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
#import "DoubanViewController.h"

@interface AppShareViewController : UIViewController <UITextViewDelegate, UIActionSheetDelegate,SinaWeiboAuthorizeViewDelegate, SinaWeiboDelegate, SinaWeiboRequestDelegate, DoubanViewControllerDelegate>

@property (nonatomic, strong) AppDetailsInfo *appDetailsInfo;
@end
