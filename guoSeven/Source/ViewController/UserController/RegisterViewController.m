//
//  RegisterViewController.m
//  FacebookLogin
//
//  Created by luyun on 13-1-16.
//  Copyright (c) 2013年 luyun. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "TosearchViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "AppDelegate.h"
#import "DDMenuController.h"
#import "ProtocolViewController.h"

#import "RSHttpManager.h"
#import "common.h"
#import "LoginInfoModel.h"
#import "LoginViewController.h"

#define kDuration 1.25

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize registerViewController;
@synthesize testViewController;
@synthesize nameTF,mailTF,passwordTF,logoImg,registerV,backImage,lbl,registBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myAI.hidden = YES;
    
    // Do any additional setup after loading the view from its nib.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([mailTF isFirstResponder]) {
        [mailTF resignFirstResponder];
        [passwordTF becomeFirstResponder];
    }else if([passwordTF isFirstResponder]){
        [passwordTF resignFirstResponder];
        [nameTF becomeFirstResponder];
    }
    
    if (textField == nameTF) {
        [self performSelector:@selector(btn:) withObject:nil afterDelay:0];
    }
    
    return YES;
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

-(void)keyboardTapped:(UITapGestureRecognizer*)tapGr{
    [mailTF resignFirstResponder];
    [nameTF resignFirstResponder];
    [passwordTF resignFirstResponder];
    if (IS_IPHONE5) {
        [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            registerV.frame = CGRectMake(20, 174, 276, 189);
            logoImg.frame = CGRectMake(98, 80, 126, 52);
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            registerV.frame = CGRectMake(20, 155, 276, 189);
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

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [backImage addGestureRecognizer:tapGr];
    
    [UIView animateWithDuration:.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        registerV.frame = CGRectMake(20, 20, 276, 178);
        logoImg.frame = CGRectMake(98, -100, 126, 52);
    } completion:^(BOOL finished) {
        
    }];
    return YES;
}

-(BOOL)isMailNumber:(NSString*)mailNum{
    NSString *mail = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *telphoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mail];
    
    return [telphoneTest evaluateWithObject:mailNum];
}

-(IBAction)btn:(id)sender{
//    [UIView beginAnimations:@"flipping view" context:nil];
//    
//    [UIView setAnimationDuration:1];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft
//                           forView:self.navigationController.view cache:YES];
//    [UIView commitAnimations];
//    TosearchViewController *searchVC = [[TosearchViewController alloc] init];
//    [self.navigationController pushViewController:searchVC animated:NO];
    
    
    
    if ([self.mailTF isFirstResponder]) {
        [self.mailTF resignFirstResponder];
    }
    
    if ([self.nameTF isFirstResponder]) {
        [self.nameTF resignFirstResponder];
    }
    
    if ([self.passwordTF isFirstResponder]) {
        [self.passwordTF resignFirstResponder];
    }
    if ([self.mailTF.text length] == 0 || [self.nameTF.text length] == 0 || [self.passwordTF.text length] == 0) {
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"警告" message:@"注册信息不完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [a show];
    }else{
        if ([self isMailNumber:self.mailTF.text]) {
            self.myAI.hidden = NO;
  

            [RSHttpManager requestRegisterWithEmail:self.mailTF.text WithPasswd:self.passwordTF.text WithNickName:self.nameTF.text WithCity_id:nil WithCity_name:nil WithSuccess:^(NSArray *RegisterInfo) {
                self.myAI.hidden = NO;
                [self.myAI startAnimating];
                lbl.text = @"注册中...";
                registBtn.userInteractionEnabled = NO;
                if ([RegisterInfo count]) {
                    LoginInfoModel *registerModel = (LoginInfoModel *)[RegisterInfo objectAtIndex:0];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:registerModel.id forKey:kUID];
                    [[NSUserDefaults standardUserDefaults] setObject:registerModel.nick_name forKey:kUNickNamm];
                    [[NSUserDefaults standardUserDefaults] setObject:registerModel.img_path forKey:kUIcon];
                    if (registerModel.signature) {
                        [[NSUserDefaults standardUserDefaults] setObject:registerModel.signature forKey:kUSignature];
                    }else{
                     [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kUSignature];   
                    }
                    //                    [[NSUserDefaults standardUserDefaults] setObject:loginModel.email forKey:kUEmail];
                    [[NSUserDefaults standardUserDefaults] setObject:registerModel.email forKey:kUEmail];                    
                    [[NSUserDefaults standardUserDefaults] setObject:self.passwordTF.text forKey:kUPassd];
                    [APPDELEGATE setCustomRootViewControllerWithSearch];
                }else{
                    lbl.text = @"完成...";
                    self.myAI.hidden = YES;
                    registBtn.userInteractionEnabled = YES;
                    UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"警告" message:@"此账号已被注册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [a show];
                }
                
            } failure:^(NSError *error) {
                
            }];
        }else{
            lbl.text = @"完成...";
            self.myAI.hidden = YES;
            registBtn.userInteractionEnabled = YES;
            UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"警告" message:@"输入的不是一个邮箱" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [a show];
            
        }
    
    }
    
    
}

- (IBAction)protocolBtn:(id)sender {
    ProtocolViewController *protocolVC = [[ProtocolViewController alloc] initWithNibName:@"ProtocolViewController" bundle:nil];
    [self.navigationController pushViewController:protocolVC animated:YES];
}

- (IBAction)backBtn:(id)sender {
        [self dismissViewControllerAnimated:YES completion:^{
        
        }];
}


@end
