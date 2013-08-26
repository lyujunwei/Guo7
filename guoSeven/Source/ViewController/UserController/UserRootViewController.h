//
//  UserRootViewController.h
//  guoSeven
//
//  Created by zucknet on 13/1/7.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"
#import "RespondViewController.h"
@class DetailViewController;
@class UserLobbyViewController;
@class WantViewController;

@interface UserRootViewController : UIViewController<CustomViewDelegate, UIScrollViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UITableViewDelegate, RespondViewControllerDelegate>{
    
//    NSString *user_id;
//    
//    UIView *pushVc;
//    NSString *name; //姓名
//    NSString *signature; //签名
//    UILabel *namelabel;
//    UILabel *signaturelabel;
//    NSString *touxiang; //头像
//    UIImageView *touxiangImg;
//    NSString *form;
//    UILabel *formlab;
//    
//    UIButton *topbtn1;
//    UIButton *topbtn2;
//    UIButton *topbtn3;
//    UIButton *topbtn4;
//    UIButton *topbtn5;
//    UIButton *topbtn6;
//    
//    NSString *feed_count;
//    NSString *recommend_count;
//    NSString *want_count;
//    NSString *follow_count;
//    NSString *discuss_count;
//    NSString *follower_count;
//    
//    NSMutableArray *user_information;

}
@property (nonatomic, retain) NSString *uuid;
//@property (strong, nonatomic) DetailViewController *detailViewController;
//@property(strong,nonatomic) UserLobbyViewController *userLobby;
//
//@property(nonatomic,strong)WantViewController *wantVc;
//
//@property(nonatomic,strong)NSMutableArray *user_information;
//
//@property(nonatomic,strong)UIView *pushVc;
//
//@property(nonatomic,retain)UIScrollView *scrollView;
//@property(nonatomic,retain)UIScrollView *topScroll;
//@property(nonatomic,retain)UITableView *tableView;
//@property(nonatomic,retain)UIView *topView;
//@property(nonatomic,retain)UIView *leftRight;
//@property(nonatomic,retain)UIImageView *imageleft_on;
//@property(nonatomic,retain)UIImageView *imageleft_off;
//@property(nonatomic,retain)UIImageView *imageright_on;
//@property(nonatomic,retain)UIImageView *imageright_off;
//
//@property (nonatomic, retain) UILabel *namelabel;
//@property (nonatomic, retain) UILabel *signaturelabel;
//@property (nonatomic, retain) UIImageView *touxiangImg;
//@property (nonatomic, retain) UILabel *formlab;
//@property (nonatomic, retain) UILabel *nameForm;
//
//@property(nonatomic,strong)UILabel *btnlab1;
//@property(nonatomic,strong)UILabel *numlab1; //动态 feed_count
//
//@property(nonatomic,strong)UILabel *btnlab2;
//@property(nonatomic,strong)UILabel *numlab2; //推荐 recommend_count
//
//@property(nonatomic,strong)UILabel *btnlab3;
//@property(nonatomic,strong)UILabel *numlab3; //愿望 want_count
//
//@property(nonatomic,strong)UILabel *btnlab4;
//@property(nonatomic,strong)UILabel *numlab4; //关注 follow_count
//
//@property(nonatomic,strong)UILabel *btnlab5;
//@property(nonatomic,strong)UILabel *numlab5; //评论 discuss_count
//
//@property(nonatomic,strong)UILabel *btnlab6;
//@property(nonatomic,strong)UILabel *numlab6;
//
//@property(nonatomic,strong)UIButton *topbtn1;
//@property(nonatomic,strong)UIButton *topbtn2;
//@property(nonatomic,strong)UIButton *topbtn3;
//@property(nonatomic,strong)UIButton *topbtn4;
//@property(nonatomic,strong)UIButton *topbtn5;
//@property(nonatomic,strong)UIButton *topbtn6;
//
//
//@property(nonatomic,retain)UIView *review1;

@end
