//
//  TestRankViewController.h
//  guoSeven
//
//  Created by zucknet on 12/12/11.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackgroundViewController.h"

@interface TestRankViewController : BackgroundViewController<UITableViewDataSource,UITableViewDelegate>{
    NSArray *appsRank;
        
    UIView *appCellView; //界面白色背景
    UIView *appView;
    
    UIImageView *appImg; //App图标
    NSString *appimgString;
    
    UIImage *apprank;
    NSString *apprankString;

    UILabel *title; //App名
    NSString *titleString;
    
    UILabel *content;
    NSString *contentString;
    
    UILabel *time;
    NSString *timeString;
    
    
    
    UILabel *appName; //App名字
    UILabel *appClass; //App 类别
    UIImageView *appRankImg; //App 星级
    
    UILabel *appCost; //价格
    UILabel *appState; //状态＊状态＊
    UILabel *appFree; //免费
    UIView *costView; //红色分割线
}



@end
