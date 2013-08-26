//
//  RegisterViewController.h
//  GPlay
//
//  Created by zucknet on 12/10/29.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardAvoidingScrollView.h"
#import "UserInfo.h"
@interface SettingUserInfoViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{
	UITextField *userNameField;
	UITextField *passwordField;
	NSString *userName;
	NSString *password;
    NSString *resultStr;
    NSString *userInfo;
}
@property (nonatomic, retain) UITextField *userNameField;
@property (nonatomic, retain) UITextField *passwordField;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *userInfo;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UITextField *nameField;
@property (nonatomic, retain) UITextField *autographField;
@property (nonatomic, retain) IBOutlet KeyboardAvoidingScrollView *myScrollView;
@property (nonatomic, retain) IBOutlet UITableView *myTableView;

- (IBAction)logoutBtn:(id)sender;


@property(nonatomic,retain)NSArray *tablist1;
@property(nonatomic,retain)NSArray *tablist2;
@property(nonatomic,retain)NSArray *tablist3;


-(NSString *)md5:(NSString *)str;


@end
