//
//  iChatViewController.h
//  GPlay
//
//  Created by zucknet on 12/11/6.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"



@class DetailViewController;

@interface iChatViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UIButton *rightBtn;
    UITableView *_tableView;
    NSString *user_id;
    NSMutableArray *iChat_dataSorce;
    NSString *content;
    
    NSString *origin_uid;
    
    NSString *origin_img_path;
    NSString *target_nick_name;
    
}

//@property(nonatomic,strong)NSString *user_id;
//@property(nonatomic,strong)NSMutableArray *iChat_dataSorce;
@property (strong, nonatomic) DetailViewController *detailViewController;

@property (nonatomic, retain) MessageModel *messageModel;


@end
