//
//  SetViewController.h
//  GPlay
//
//  Created by zucknet on 12/11/5.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
@private
    NSArray *tablist1;
    NSArray *tablist2;
    NSArray *tablist3;
    NSArray *tablist4;
    NSMutableArray *listAll;
}

- (void)revealSidebar;

@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSArray *tablist1;
@property(nonatomic,retain)NSArray *tablist2;
@property(nonatomic,retain)NSArray *tablist3;
@property(nonatomic,retain)NSArray *tablist4;
@property(nonatomic,retain)NSMutableArray *listAll;
@property(nonatomic,retain)UILabel *number;

@end
