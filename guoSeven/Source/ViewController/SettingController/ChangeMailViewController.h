//
//  ChangeMailViewController.h
//  guoSeven
//
//  Created by luyun on 13-1-16.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardAvoidingScrollView.h"

@interface ChangeMailViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{
    
}

@property (nonatomic, retain) UITextField *mailTF;
@property (nonatomic, retain) UITextField *PSW;
@property (nonatomic, retain) UITextField *newsMailTF;
@property (nonatomic, retain) NSMutableArray *muArray;
@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) IBOutlet KeyboardAvoidingScrollView *myScrollView;

@property (nonatomic, retain) UIButton *btn;

@end
