//
//  FFViewController.h
//  guoSeven
//
//  Created by David on 13-1-30.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
#import "DoubanViewController.h"

@interface FFViewController : UIViewController<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate,SinaWeiboAuthorizeViewDelegate, SinaWeiboDelegate, SinaWeiboRequestDelegate,DoubanViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end
