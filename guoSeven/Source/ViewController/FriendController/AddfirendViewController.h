//
//  AddfirendViewController.h
//  guoSeven
//
//  Created by zucknet on 12/12/5.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"

@interface AddfirendViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,CustomViewDelegate>

@property(nonatomic,strong)UISearchBar *searchFriend;

@end
