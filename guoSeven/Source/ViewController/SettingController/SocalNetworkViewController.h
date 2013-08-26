//
//  SocalNetworkViewController.h
//  GPlay
//
//  Created by zucknet on 12/10/27.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
#import "DoubanViewController.h"


@interface SocalNetworkViewController : UITableViewController<SinaWeiboAuthorizeViewDelegate, SinaWeiboDelegate, SinaWeiboRequestDelegate, DoubanViewControllerDelegate>

@end
