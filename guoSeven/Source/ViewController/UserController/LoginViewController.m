//
//  ViewController.m
//  FacebookLogin
//
//  Created by luyun on 13-1-16.
//  Copyright (c) 2013年 luyun. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "LoginInfoModel.h"
#import "common.h"
//#import "MasterViewController.h"
//#import "DDMenuController.h"
//#import "FeedViewController.h"
#import "AppDelegate.h"
#import "RSHttpManager.h"
#import <QuartzCore/QuartzCore.h>

//#import "LaunchImageTransition.h"
#define kDuration 1.2

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize lbl;
@synthesize loginV;
@synthesize zhuceBtn;
@synthesize mailTF,passWordTF;
@synthesize backgroundImg,zhuceImg,logoImg;
@synthesize loginBtn;
@synthesize myAI;
@synthesize btnlbl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    myAI.hidden = YES;
    
    loginV.hidden = YES;
    
    self.navigationController.navigationBarHidden = YES;
    
    [loginBtn setBackgroundImage:[[UIImage imageNamed:@"submit-active.png"]stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateHighlighted];


}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self setWantsFullScreenLayout:YES];
    [UIView animateWithDuration:.9 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        logoImg.frame = CGRectMake(98, 80, 126, 52);
    } completion:^(BOOL finished) {
        loginV.hidden = NO;
        zhuceBtn.hidden = NO;
        zhuceImg.hidden = NO;
        
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [mailTF resignFirstResponder];
    [passWordTF becomeFirstResponder];
    
    if (textField == passWordTF) {
        [self performSelector:@selector(loginBtn:) withObject:nil afterDelay:0];
    }
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [backgroundImg addGestureRecognizer:tapGr];
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self move];
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [backgroundImg addGestureRecognizer:tapGr];
    return YES;
}

-(void)move{
    [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        loginV.frame = CGRectMake(20, 40, 278, 149);
        logoImg.frame = CGRectMake(98, -50, 126, 52);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr{
    [mailTF resignFirstResponder];
    [passWordTF resignFirstResponder];
    if (IS_IPHONE5) {
        [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            loginV.frame = CGRectMake(20, 194, 278, 149);
            logoImg.frame = CGRectMake(98, 80, 126, 52);
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            loginV.frame = CGRectMake(20, 154, 278, 149);
            logoImg.frame = CGRectMake(98, 80, 126, 52);
        } completion:^(BOOL finished) {
            
        }];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)zhuceAction:(id)sender {
    if (IS_IPHONE5) {
                RegisterViewController *registerVC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController_iPhone5" bundle:nil];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:registerVC];
                nav.navigationBarHidden = YES;
        
                //    [UIView commitAnimations];
                //    [self presentModalViewController:registerVC animated:YES];
                [self presentViewController:nav animated:YES completion:^{
                        // logoImg.frame = CGRectMake(98, 80, 126, 52);
                        logoImg.frame = CGRectMake(98, 240, 126, 52);
                        loginV.hidden = YES;
                        zhuceBtn.hidden = YES;
                        zhuceImg.hidden = YES;
                    }];
    }else{
                RegisterViewController *registerVC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController_Normal" bundle:nil];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:registerVC];
                nav.navigationBarHidden = YES;
        
                //    [UIView commitAnimations];
                //    [self presentModalViewController:registerVC animated:YES];
                [self presentViewController:nav animated:YES completion:^{
                        // logoImg.frame = CGRectMake(98, 80, 126, 52);
                        logoImg.frame = CGRectMake(98, 240, 126, 52);
                        loginV.hidden = YES;
                        zhuceBtn.hidden = YES;
                        zhuceImg.hidden = YES;
                    }];
}
}


-(BOOL)isMailNumber:(NSString*)mailNum{
    NSString *mail = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *telphoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mail];
    
    return [telphoneTest evaluateWithObject:mailNum];
}

- (IBAction)loginBtn:(id)sender {

    if (![self.mailTF.text length] || [self.passWordTF.text length] == 0 ) {
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"警告" message:@"邮箱或密码为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [a show];
    }else{
        if ([self isMailNumber:self.mailTF.text]) {
            
            self.myAI.hidden = NO;
            [self.myAI startAnimating];
            btnlbl.text = @"登录中...";
            loginBtn.userInteractionEnabled = NO;
            [RSHttpManager requestLoginWithEmail:self.mailTF.text WithPasswd:self.passWordTF.text WithSuccess:^(NSArray *loginInfo) {
                
                if ([loginInfo count]) {
                    NSLog(@"//////////成功");
                    LoginInfoModel *loginModel = (LoginInfoModel *)[loginInfo objectAtIndex:0];
                    NSString *userId = [loginModel user_id];
                    
                    DLog(@"id===%@",loginModel.id);
                    [[NSUserDefaults standardUserDefaults] setValue:userId forKey:kUID];
                    [[NSUserDefaults standardUserDefaults] setObject:loginModel.nick_name forKey:kUNickNamm];
                    [[NSUserDefaults standardUserDefaults] setObject:loginModel.img_path forKey:kUIcon];
                    if (loginModel.signature) {
                        [[NSUserDefaults standardUserDefaults] setObject:loginModel.signature forKey:kUSignature];
                    }else{
                        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kUSignature];
                    }
//                    [[NSUserDefaults standardUserDefaults] setObject:loginModel.email forKey:kUEmail];
                    [[NSUserDefaults standardUserDefaults] setObject:self.mailTF.text forKey:kUEmail];
                    [[NSUserDefaults standardUserDefaults] setObject:self.passWordTF.text forKey:kUPassd];
                    
                    DLog(@"user_id===%@",[[NSUserDefaults standardUserDefaults] valueForKey:kUID]);
                    
                    
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [APPDELEGATE setCustomRootViewController];
                    [self.myAI stopAnimating];
                    
                }
                else{
                    self.myAI.hidden = YES;
                    btnlbl.text = @"登录";
                    loginBtn.userInteractionEnabled = YES;
                    UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"警告" message:@"账号或密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [a show];
                }
                
            } failure:^(NSError *error) {
                
            }];
        }else{
            self.myAI.hidden = YES;
            btnlbl.text = @"登录";
            loginBtn.userInteractionEnabled = YES;
            UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"警告" message:@"您输入的不是一个邮箱账号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [a show];
            
        }
    }
    
//    [APPDELEGATE setCustomRootViewController];
    
}

-(IBAction)Next:(id)sender{
    NSLog(@"dianjia");
}

- (void)viewDidUnload {
    [self setMyAI:nil];
    [super viewDidUnload];
}
@end
