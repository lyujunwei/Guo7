//
//  RegisterViewController.h
//  FacebookLogin
//
//  Created by luyun on 13-1-16.
//  Copyright (c) 2013年 luyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RegisterViewController;
@class TestViewController;

@interface RegisterViewController : UIViewController<UITextFieldDelegate>
- (IBAction)backBtn:(id)sender;
- (IBAction)btn:(id)sender;
- (IBAction)protocolBtn:(id)sender;
@property (nonatomic, retain) RegisterViewController *registerViewController;
@property (nonatomic, retain) TestViewController *testViewController;
@property (retain, nonatomic) IBOutlet UIImageView *logoImg;
@property (retain, nonatomic) IBOutlet UITextField *mailTF;
@property (retain, nonatomic) IBOutlet UITextField *passwordTF;
@property (retain, nonatomic) IBOutlet UITextField *nameTF;
@property (retain, nonatomic) IBOutlet UIView *registerV;
@property (retain, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *myAI;

@property (retain, nonatomic) IBOutlet UILabel *lbl;
@property (retain, nonatomic) IBOutlet UIButton *registBtn;


@end
