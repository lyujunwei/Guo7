//
//  iMessageViewController.h
//  GPlay
//
//  Created by zucknet on 12/11/5.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"

@class DetailViewController;

@interface iMessageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, CustomViewDelegate>{
    NSMutableArray *dataSorce;

    UIButton *rightBtn;
    UIView *testheader;
    
    UIView *cellView;

    UILabel *obj_namelabel;
    NSString *obj_name;
    
    UILabel *obj_msglabel;
    NSString *obj_msg;
    
    UIImageView *obj_imgView;
    NSString *obj_img;
    
    UILabel *timeLabel;
    NSString *time;
    
    NSString *user_id;
    
    NSString *uid;
    NSString *obj_uid;
    
    NSString *nextTitle;
}

//@property(nonatomic,strong)UITableView *tableView;
//@property(nonatomic,strong)NSMutableArray *dataSorce;
@property(nonatomic,strong)DetailViewController *detailViewController;

-(IBAction)editbtn:(id)sender;
-(void)getData;
@end
