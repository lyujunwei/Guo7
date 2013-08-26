//
//  ChangePasswordViewController.h
//  guoSeven
//
//  Created by luyun on 13-1-15.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardAvoidingScrollView.h"

@interface ChangePasswordViewController : UIViewController<UITextFieldDelegate>{
    UITableView *tableView;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) UITextField *emailF;
@property (nonatomic, retain) UITextField *passwordF;
@property (nonatomic, retain) UITextField *replayPSW;
@property (nonatomic, retain) UITextField *newsPSW;
@property (nonatomic, retain) NSArray *titlelist1;
@property (nonatomic, retain) NSArray *titlelist2;
@property (nonatomic, retain) NSMutableArray *allTitle;
@property (nonatomic, retain) IBOutlet KeyboardAvoidingScrollView *myScrollView;

//@property (nonatomic, retain) UIButton *btn;

@end
