//
//  TestSearchViewController.h
//  guoSeven
//
//  Created by zucknet on 12/12/11.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackgroundViewController.h"

@class testSearchListViewController;

@class DetailViewController;

@interface TestSearchViewController : BackgroundViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    
    UIView *appCellView; //界面白色背景
    UIImageView *appImg; //App图标
    UILabel *appRank; //App排名
    UILabel *appName; //App名字
    UILabel *appClass; //App 类别
    UIImageView *appRankImg; //App 星级
    
    UILabel *appCost; //价格
    UILabel *appState; //状态＊状态＊
    UILabel *appFree; //免费
    UIView *costView; //红色分割线

    UISearchBar *_searchBar;
    
    NSMutableArray *search_dataSorce;
    NSString *postAppname;
    
    NSString *post_count;
    
    NSArray *post_list;
    
    NSString *app_name;
    
    NSMutableArray *tablelist;
    
    NSArray *testpost_list;
    
    UIView *backView;
    
    NSMutableArray *searchlist;
    
    NSArray *countlist;
        
}

@property(nonatomic,strong)NSMutableArray *search_dataSorce;

@property(nonatomic,strong)NSString *postAppname;

@property (strong, nonatomic) DetailViewController *detailViewController;

@property(nonatomic,strong)testSearchListViewController *testSearlist;


@end
