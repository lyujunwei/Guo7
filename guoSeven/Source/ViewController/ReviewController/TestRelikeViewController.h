//
//  TestRelikeViewController.h
//  guoSeven
//
//  Created by zucknet on 12/12/12.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackgroundViewController.h"
#import "CustomView.h"
@class DetailViewController;

@interface TestRelikeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource, CustomViewDelegate>{
    
    NSMutableArray *talk_dataSorce;  //评论
    NSMutableArray *like_dataSorce;  //推荐
    
    NSMutableArray *dataSorce;
    
    NSString *user_talk; //用户评论id获取
    NSString *user_like;
    
    NSArray *relikeList;
    UIView *appCellView;
    
    UIImageView *appImg; //App图标
    NSString *appimgString;
    
    UIImage *apprank;
    NSString *apprankString;
    
    UILabel *title; //App名
    NSString *titleString;
    
    UILabel *content;
    NSString *contentString;
    
    UILabel *time;
    NSString *timeString; //时间
    
    
    NSString *primary_genre_name; //类型
    NSString *supported_device_name; //设备
    NSString *application_retail_price; //价格

        
    UIView *appView;
    UILabel *appName; // App名字
    UIImageView *appStar; // App 星级图标
    UILabel *appRank; //App排名
    UILabel *appCost; //价格
    UILabel *appState; //状态＊状态＊
    UILabel *appFree; //免费
    UIView *costView; //红色分割线
    UILabel *appClass;
}

@property(nonatomic,strong)DetailViewController *detailVewController;
@property(nonatomic,strong)NSMutableArray *talk_dataSorce;
@property(nonatomic,strong)NSMutableArray *like_dataSorce;

@property(nonatomic,strong)NSString *user_talk;
@property(nonatomic,strong)NSString *user_like;
@property(nonatomic,strong)NSMutableArray *dataSorce;
@property (nonatomic, retain) UIButton *topbtn1;
@property (nonatomic, retain) UIButton *topbtn2;
- (void)getData;

@end
