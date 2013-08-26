//
//  FriendRootViewController.h
//  guoSeven
//
//  Created by zucknet on 13/1/8.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;
@class UserLobbyViewController;

@interface FriendRootViewController : UIViewController<UIScrollViewDelegate>{
    
    NSString *friend_id;
    
    UIView *pushVc;
    NSString *name; //姓名
    NSString *signature; //签名
    UILabel *namelabel;
    UILabel *signaturelabel;
    NSString *touxiang; //头像
    UIImageView *touxiangImg;
    NSString *form;
    UILabel *formlab;
    
    UIButton *topbtn1;
    UIButton *topbtn2;
    UIButton *topbtn3;
    UIButton *topbtn4;
    UIButton *topbtn5;
    UIButton *topbtn6;
    
    NSString *feed_count;
    NSString *recommend_count;
    NSString *want_count;
    NSString *follow_count;
    NSString *discuss_count;
    NSString *follower_count;
    
    NSMutableArray *frienduser_info;
    
    NSString *nick_name;
    
}
@property (strong, nonatomic) DetailViewController *detailViewController;
@property(strong,nonatomic) UserLobbyViewController *userLobby;

@property(nonatomic,strong)NSMutableArray *frienduser_info;

@property(nonatomic,strong)UIView *pushVc;

@property(nonatomic,strong)NSString *friend_id;

@property(nonatomic,retain)UIScrollView *scrollView;
@property(nonatomic,retain)UIScrollView *topScroll;
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)UIView *topView;
@property(nonatomic,retain)UIView *leftRight;
@property(nonatomic,retain)UIImageView *imageleft_on;
@property(nonatomic,retain)UIImageView *imageleft_off;
@property(nonatomic,retain)UIImageView *imageright_on;
@property(nonatomic,retain)UIImageView *imageright_off;

@property (nonatomic, retain) UILabel *namelabel;
@property (nonatomic, retain) UILabel *signaturelabel;
@property (nonatomic, retain) UIImageView *touxiangImg;
@property (nonatomic, retain) UILabel *formlab;
@property (nonatomic, retain) UILabel *nameForm;

@property(nonatomic,strong)UILabel *btnLab1;
@property(nonatomic,strong)UILabel *numLab1; //动态 feed_count

@property(nonatomic,strong)UILabel *btnLab2;
@property(nonatomic,strong)UILabel *numLab2; //推荐 recommend_count

@property(nonatomic,strong)UILabel *btnLab3;
@property(nonatomic,strong)UILabel *numLab3; //愿望 want_count

@property(nonatomic,strong)UILabel *btnLab4;
@property(nonatomic,strong)UILabel *numLab4; //关注 follow_count

@property(nonatomic,strong)UILabel *btnLab5;
@property(nonatomic,strong)UILabel *numLab5; //评论 discuss_count

@property(nonatomic,strong)UILabel *btnLab6;
@property(nonatomic,strong)UILabel *numLab6;

@property(nonatomic,strong)UILabel *btnLab7;
@property(nonatomic,strong)UILabel *numLab7;

@property(nonatomic,retain)UIView *review1;

@end