//
//  ChangeUserInfoViewController.h
//  guoSeven
//
//  Created by luyun on 13-1-15.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeUserInfoViewController : UITableViewController<UITextFieldDelegate>{
    UITableView *TableView;
}

@property (nonatomic, retain) UITableView *TableView;
@property (nonatomic, retain) NSArray *tableViewList;
@property (nonatomic, retain) NSMutableArray *allList;

@property (nonatomic, retain) UITextField *mailTextFiled;
@property (nonatomic, retain) UITextField *passwordTextField;

@end
