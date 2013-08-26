//
//  MasterViewController.h
//  SDWebImage Demo
//
//  Created by Olivier Poitrey on 09/05/12.
//  Copyright (c) 2012 Dailymotion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"
#import "RespondViewController.h"
@class DetailViewController;

@interface MasterViewController : UIViewController<CustomViewDelegate, UITableViewDataSource, UITableViewDelegate, RespondViewControllerDelegate>{
//    NSMutableArray *dataSorce;
//    NSMutableArray *appdataSorce;
//    UIImageView *appimg;
//    UIImageView *userimg;
//    
//    NSString *appString;
//    NSString *userString;
//    
//    UIImageView *seeView;
//    
//    UIView *seeBackView; //灰色View
//    
//    NSString *uString; //用户图标参数
//    UIImageView *uimg; //用户图标
//    
//    UILabel *titlename; //名字，动作，所有操作
//    
//    NSString *name;  //姓名
//    NSString *obj_name;
//    NSString *obj_signature;
//    NSString *obj_review;
//    NSString *obj_details;
//    
//    UILabel *datelabel; //时间
//    NSString *date; 
//    
//    UILabel *appnamelabel; //软件名
//    NSString *appname;
//    
//    UILabel *seenamelabel;   //判断参数 显示
//    NSString *seename;
//    UILabel *obj_signaturelabel;
//    
//    NSString *user_rating;
//    UILabel *user_ratinglabel;
//    
//    NSString *act_user; //关注了
//    NSString *act_appcation; //推荐了
//    NSString *act_addapp; //添加到愿望
//    
//    UIView *allView; //所有View
//    
//    UIView *lobbyheader;
//    
//    NSString *application_count;
//    
//    NSString *pushNametitle;
//    NSString *pushApptitle;
//    NSString *pushAppimage;
//    NSString *pushApp_id;
//    NSString *pushApp_artistname; // 应用出产公司 artist_name
//    NSString *pushApp_rankimage; // 应用评分图片 
//    
//    NSString *pushApp_description; // 应用介绍 description
//    NSString *pushApp_Seller_name; // 应用介绍_开发厂商
//    
//    NSString *pushApp_version; //version 版本 
//    NSString *pushApp_primary_genre_name; //primary_genre_name 类型
//    NSString *pushApp_supported_device_name; //supported_device_name 平台
//    NSString *pushApp_download_size; //download_size 容量
//    NSString *pushApp_language_code; //language_code 语言
//    //NSString *pushApp_old_price; //old_price
//    //NSString *pushApp_retail_price; //retail_price
//
//    NSString *push_screenshot_url_1;
//    NSString *push_iPad_screenshot_url_1;
//
//    NSString *push_screenshot_url_2;
//    NSString *push_iPad_screenshot_url_2;
//    
//    NSString *push_screenshot_url_3;
//    NSString *push_iPad_screenshot_url_3;
//    
//    NSString *push_screenshot_url_4;
//    NSString *push_iPad_screenshot_url_4;
//    
//    NSString *push_screenshot_url_5;
//    NSString *push_iPad_screenshot_url_5;
//    
//    //图片Url
//    NSURL *sc1;
//    NSURL *sc2;
//    NSURL *sc3;
//    NSURL *sc4;
//    NSURL *sc5;
//    
//    NSString *push_AppUrl;
//    
//    
//    NSString *push_userId; //用户id
//    NSString *push_username; //用户昵称
//    NSString *push_userFrom; //用户来源
//    NSString *push_userSignature; //用户签名
//    NSString *push_userImage;
//    
//    // 数据数量
//	NSUInteger dataNumber;
//    
//    
//    NSString *create_time;
//    NSString *primary_genre_name;
//    NSString *supported_device_name;
//    
//    UILabel *App_titleinfo;
//    
//    NSString *push_user_id;
    
}

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (nonatomic, assign) BOOL isLogin;
//@property(nonatomic,retain)NSMutableArray *dataSorce;
//@property(nonatomic,retain)NSString *push_userId;
//@property(nonatomic,strong)NSString *pushApp_id;
//@property(nonatomic,retain)NSMutableArray *appdataSorce;
//@property(nonatomic,retain)NSMutableArray *userdataSorce;
//@property(nonatomic,retain)NSString *pushApp_description;
//
//@property(nonatomic,retain)UIButton *moreBtn;


@end
