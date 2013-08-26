//
//  FeedViewController.h
//  weShare
//
//  Created by zucknet on 12/11/11.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "TDBadgedCell.h"
#import "CustomView.h"

@class UserInfo;

@interface FeedViewController : UITableViewController<CustomViewDelegate>{
    NSMutableArray *leftViewData;
    
    UIView *touxiangBackground;
    
    NSString *name;
    UILabel *namelabel;
    
    NSString *touxiang;
    UIImageView *touxiangImg;
    
    NSMutableArray *dataSorce;
    
    UIImageView *picsimg;
    UILabel *celllab;
    
    UIView *view1;
    UILabel *lab1;
    
    UIImageView *notice_yw;
    UIImageView *notice_gz;
    UIImageView *notice_tj;
    UIImageView *notice_sx;
    
    UILabel *noticelab;
    UILabel *lab_yw;
    UILabel *lab_gz;
    UILabel *lab_tj;
    UILabel *lab_sx;
    
    NSMutableArray *noteiceString;
    
    NSString *yw_count; //愿望
    NSString *gz_count; //关注
    NSString *tj_count; //推荐
    NSString *sx_count; //私信
    
    UIButton *testbtn;
    
    NSMutableArray *yw_id;
    NSMutableArray *yw_noteiceString;
    NSMutableArray *yw_send_note;
    
    NSMutableArray *gz_id;
    NSMutableArray *gz_noteiceString;
    NSMutableArray *gz_send_note;
    
    NSMutableArray *tj_id;
    NSMutableArray *tj_noteiceString;
    NSMutableArray *tj_send_note;
    
    NSMutableArray *sx_id;
    NSMutableArray *sx_noteiceString;
    NSMutableArray *sx_send_note;
    
    
    NSMutableArray *clear_noteiceString;
    
    //可自定义每列Cell.
}
@property(nonatomic,retain)UILabel *namelabel;
@property(nonatomic,retain)UIImageView *touxiangImg;
@property(nonatomic,strong)NSMutableArray *dataSorce;
@property(nonatomic,strong)NSMutableArray *noteiceString;

@property(nonatomic,strong)UserInfo *userInfo;


-(void)creatleftViewData;

@end
