//
//  ViewController.h
//  FacebookLogin
//
//  Created by luyun on 13-1-16.
//  Copyright (c) 2013年 luyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>{
    UILabel *lbl;
}

@property (nonatomic, retain) IBOutlet UILabel *lbl;
@property (nonatomic, retain) IBOutlet UIView *loginV;
@property (nonatomic, retain) IBOutlet UIButton *zhuceBtn;
@property (nonatomic, retain) IBOutlet UITextField *mailTF;
@property (nonatomic, retain) IBOutlet UITextField *passWordTF;
- (IBAction)zhuceAction:(id)sender;
- (IBAction)loginBtn:(id)sender;
-(IBAction)Next:(id)sender;
@property (retain, nonatomic) IBOutlet UIImageView *backgroundImg;
@property (retain, nonatomic) IBOutlet UIImageView *zhuceImg;
@property (retain, nonatomic) IBOutlet UIImageView *logoImg;
@property (retain, nonatomic) IBOutlet UILabel *btnlbl;


@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *myAI;
@property(nonatomic,strong) IBOutlet UIButton *loginBtn;


@end
