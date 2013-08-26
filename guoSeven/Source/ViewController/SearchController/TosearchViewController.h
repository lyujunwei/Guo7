//
//  TosearchViewController.h
//  guoSeven
//
//  Created by zucknet on 13/1/6.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class testSearchListViewController;

@interface TosearchViewController : UIViewController<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>{
    UISearchBar *_searchBar;
    UITableView *hello;
    
    NSString *postData;
}

@property(nonatomic,strong)testSearchListViewController *serList;
@property (nonatomic, retain) UITableView *myTableView;

@end
