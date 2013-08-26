//
//  AppShareViewController.m
//  guoSeven
//
//  Created by RainSets on 13-1-21.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "AppShareViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RSHttpManager.h"
#import "AppShareModel.h"
#import "DOUAPIEngine.h"
#import "TCWBEngine.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "common.h"
#import "DOUQuery.h"
#import "DOUAPIEngine.h"


@interface DoubanQueryStatus : DOUQuery

+ (id)queryForStatus;

@end


@implementation DoubanQueryStatus

+ (id)queryForStatus {
    NSString *subPath = @"/shuo/v2/statuses/";
    
    DOUQuery *query = [[DOUQuery alloc] initWithSubPath:subPath parameters:nil];
    
    return query;
}

@end




@interface AppShareViewController (){
    NSMutableDictionary *dictParam;
    UITextView *txtVInput;
    NSString *userId;
    NSString *strShareContent;
}
@property (nonatomic, retain) SinaWeibo *sinaWeibo;
@property (nonatomic, retain) TCWBEngine *tcWENEngine;
@end

@implementation AppShareViewController
@synthesize appDetailsInfo;
@synthesize sinaWeibo;
@synthesize tcWENEngine;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];

    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setTitle:@"分享"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *imgBack = [UIImage imageNamed:@"icontop-back@2x.png"];
    UIImage *imgBackH = [UIImage imageNamed:@"icontop-back2@2x.png"];
    btnBack.frame = CGRectMake(-5.0, 0.0, imgBack.size.width / 2, imgBack.size.height / 2);
    [btnBack setBackgroundImage:imgBack forState:UIControlStateNormal];
    [btnBack setBackgroundImage:imgBackH forState:UIControlStateHighlighted];
    [btnBack setTitle:@"返回" forState:UIControlStateNormal];
    [btnBack.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [btnBack addTarget:self action:@selector(backToPreView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    [self.navigationItem setLeftBarButtonItem:leftBarItem];
    
    
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *imgDone = [UIImage imageNamed:@"icontop-normal@2x.png"];
    btnDone.frame = CGRectMake(260.0, 0.0, imgDone.size.width / 2, imgDone.size.height / 2);
    [btnDone setBackgroundImage:imgDone forState:UIControlStateNormal];
    [btnDone setTitle:@"确定" forState:UIControlStateNormal];
    [btnDone.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [btnDone addTarget:self action:@selector(shareDone:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:btnDone];
    [self.navigationItem setRightBarButtonItem:rightBarItem];
    
    txtVInput = [[UITextView alloc] initWithFrame:CGRectMake(10.f, 20.f, 300.f, 140.f)];
    [[txtVInput layer] setCornerRadius:12.f];
    [txtVInput setDelegate:self];
    [txtVInput setTextColor:[UIColor lightGrayColor]];
    [txtVInput setReturnKeyType:UIReturnKeyDone];
    [txtVInput setText:@"输入分享文字"];
    [txtVInput setFont:[UIFont fontWithName:@"HelveticaNeue" size:18]];
    [txtVInput setBackgroundColor:[UIColor clearColor]];
    
    [[txtVInput layer] setBorderColor:[[UIColor colorWithRed:221.f / 255.f green:221.f / 255.f blue:221.f / 255.f alpha:1.f] CGColor]];
    [[txtVInput layer] setBorderWidth:1.f];
    [txtVInput setClipsToBounds:YES];
    [self.view addSubview:txtVInput];
    dictParam = [NSMutableDictionary dictionary];
}

-(void)shareAppWithContent:(NSString *)shareContent{
    
    [dictParam setObject:userId forKey:@"uid"];
    [dictParam setObject:self.appDetailsInfo.application_id forKey:@"aid"];
    [dictParam setObject:shareContent forKey:@"content"];
        
    
    [RSHTTPMANAGER shareBlogWithParameters:dictParam WithSuccess:^(BOOL isSucceed) {
        if (isSucceed) {
            SHOWALERT_WITHTITLE_ANDMESSAGE(@"提示", @"分享成功");
        }else{
            SHOWALERT_WITHTITLE_ANDMESSAGE(@"提示", @"分享失败");
        }
    } failure:^(NSError *_err) {
        
    }];
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView.textColor == [UIColor lightGrayColor]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(textView.text.length == 0){
        textView.textColor = [UIColor lightGrayColor];
        textView.text = @"输入分享文字";
        [textView resignFirstResponder];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(textView.text.length == 0){
            textView.textColor = [UIColor lightGrayColor];
            textView.text = @"输入分享文字";
            [textView resignFirstResponder];
        }else{
             strShareContent = [NSString stringWithFormat:@"在#果7#上推荐了iOS App:%@,%@。%@",appDetailsInfo.title,txtVInput.text, appDetailsInfo.view_url];
            
            NSLog(@"......%@",strShareContent);
            UIActionSheet *aaa = [[UIActionSheet alloc] initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"新浪分享",@"腾讯分享", @"豆瓣分享", nil];
            [aaa showInView:self.view];

        }
        // do something that you want to do
//        [self shareAppWithContent:textView.text];
        

        return NO;
    }
    
    return YES;
}

-(void)backToPreView:(id)sender{
    [txtVInput resignFirstResponder];
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)shareDone:(id)sender{
    if ([[txtVInput text] length] > 0 && txtVInput.textColor == [UIColor lightGrayColor]) {
        SHOWALERT_WITHTITLE_ANDMESSAGE(@"", @"输入分享文字 才能进行分享哦 !");
    }else if(txtVInput.text.length == 0){
    
        SHOWALERT_WITHTITLE_ANDMESSAGE(@"", @"输入分享文字 才能进行分享哦 !");
        
    }else {
        
        [txtVInput resignFirstResponder];
        strShareContent = [NSString stringWithFormat:@"在#果7#上推荐了iOS App:%@,%@。%@",appDetailsInfo.title,txtVInput.text, appDetailsInfo.view_url];
        DLog(@"strShareContent==%@",strShareContent);
//
//        UIActionSheet *action = [UIActionSheet alloc] initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"新浪分享",@"腾讯分享", @"豆瓣分享",nil];
        
        UIActionSheet *aaa = [[UIActionSheet alloc] initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"新浪分享",@"腾讯分享", @"豆瓣分享", nil];
        [aaa showInView:self.view];
        
        
//        [self shareAppWithContent:txtVInput.text];
        
    }
    

    DLog(@"done....");
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSLog(@"0");
        if (!self.sinaWeibo) {
            self.sinaWeibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:self];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
            if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
            {
                self.sinaWeibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
                self.sinaWeibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
                self.sinaWeibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
            }
        }

        if ([self.sinaWeibo isLoggedIn]) {//分享
            [self sendWeiboShare];
        }else{//认证
            [self.sinaWeibo logIn];
        }
        
        
        
    }else if (buttonIndex == 1){
        NSLog(@"1");
        if (!self.tcWENEngine) {
            self.tcWENEngine = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl:REDIRECTURI];
        }
        
        
        if (![self.tcWENEngine isAuthorizeExpired]) {
            [self sendQQ];
        }else{
            [self.tcWENEngine setRootViewController:self];
            [self.tcWENEngine logInWithDelegate:self
                            onSuccess:@selector(sendQQ)
                            onFailure:@selector(onFailureLogin:)];

        }
        
        

    }else if (buttonIndex == 2){
        NSLog(@"2");
        
        DOUService *service = [DOUService sharedInstance];
        service.clientId = kDouBanKey;
        service.clientSecret = kDouBanPrivateKey;
        
        if ([service isValid]) {
            service.apiBaseUrlString = kHttpsApiBaseUrl;
            [self sendDB];
        }else{
            service.apiBaseUrlString = kHttpApiBaseUrl;
            DoubanViewController *vc = [[DoubanViewController alloc] init];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }

    }
}
- (void)DoubanSuccess{
    [SVProgressHUD show];

    [self performSelector:@selector(sendDB) withObject:nil afterDelay:0];

}


- (void)DoubanFail{
    
}

- (void)sendDB{
    [SVProgressHUD show];
//    strShareContent = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/soundcloud/id336353151?mt=8&uo=4&partnerId=30"];
    
    NSMutableString *tmpStr = [NSMutableString stringWithFormat:@"%@",appDetailsInfo.view_url];
    
    strShareContent = [NSString stringWithFormat:@"在#果7#上推荐了iOS App:%@,%@。%@",appDetailsInfo.title,txtVInput.text, [tmpStr substringFromIndex:[tmpStr rangeOfString:@"https://itunes"].location]];

    
    NSLog(@"..strShareContent........:%@",strShareContent);
    DOUQuery *query = [DoubanQueryStatus queryForStatus];
    DOUReqBlock completionBlock = ^(DOUHttpRequest * req) {
        
        NSLog(@"code:%d, str:%@", [req responseStatusCode], [req responseString]);
        NSError *theError = [req doubanError];
        if (!theError) {
            txtVInput.text = @"";
            [SVProgressHUD showSuccessWithStatus:@"豆瓣分享成功"];
        }
        else {
            NSLog(@"%@", theError);
            NSLog(@".....%@",theError.localizedDescription);
            if ([theError.localizedDescription rangeOfString:@"1000"].location != NSNotFound) {
                [SVProgressHUD showErrorWithStatus:@"亲，不能分享同样的内容哦"];
            }else{
                [SVProgressHUD showErrorWithStatus:@"豆瓣分享失败"];
            }
        }
    };
    
    DOUService *service = [DOUService sharedInstance];
    DLog("")
    NSMutableString *postBody = [NSMutableString stringWithFormat:@"text=%@", strShareContent];

    [service post:query postBody:postBody callback:completionBlock];

}



- (void)onFailureLogin:(NSError *)error{

}




- (void)sendQQ{
    [SVProgressHUD show];
    [self.tcWENEngine postTextTweetWithFormat:@"json" content:strShareContent clientIP:@"10.10.1.31" longitude:nil andLatitude:nil parReserved:nil delegate:self onSuccess:@selector(sendQQSuccess) onFailure:@selector(sendQQError)];
}

- (void)sendQQSuccess{
    [SVProgressHUD showSuccessWithStatus:@"腾讯分享成功"];
    txtVInput.text = @"";

}

- (void)sendQQError{
    [SVProgressHUD showErrorWithStatus:@"腾讯分享失败"];

}



- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

- (void)storeAuthData
{
    
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              self.sinaWeibo.accessToken, @"AccessTokenKey",
                              self.sinaWeibo.expirationDate, @"ExpirationDateKey",
                              self.sinaWeibo.userID, @"UserIDKey",
                              self.sinaWeibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



- (void)sendWeiboShare{
    [SVProgressHUD show];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy/MM/dd hh:mm:ss"];
////    NSString *str = [NSString stringWithFormat:@"%@__%@", txtVInput.text, [formatter stringFromDate:[NSDate date]]];
//    NSString *str = [NSString stringWithFormat:@"__%@", [formatter stringFromDate:[NSDate date]]];
//
//    [self.sinaWeibo requestWithURL:@"statuses/update.json"
//                            params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                    str, @"status",nil]
//                        httpMethod:@"POST"
//                          delegate:self];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy/MM/dd hh:mm:ss"];
//    NSString *str = [NSString stringWithFormat:@"%@__%@", txtVInput.text, [formatter stringFromDate:[NSDate date]]];
    //img
    //    [self.sinaWeibo requestWithURL:@"statuses/upload.json"
    //                       params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
    //                               str, @"status",
    //                               [UIImage imageNamed:@"weibo.png"], @"pic", nil]
    //                   httpMethod:@"POST"
    //                     delegate:self];
    
    //str
//    [self.sinaWeibo requestWithURL:@"statuses/update.json"
//                            params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                    strShareContent, @"status",nil]
//                        httpMethod:@"POST"
//                          delegate:self];
    
    [self.sinaWeibo requestWithURL:@"statuses/update.json"
                            params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    strShareContent, @"status",nil]
                        httpMethod:@"POST"
                          delegate:self];
}


#pragma mark - SinaWeibo Delegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    [self storeAuthData];

    [self sendWeiboShare];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [self removeAuthData];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    
    [self removeAuthData];
}

#pragma mark - SinaWeiboRequest Delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"...er:%@", error.localizedDescription);
    [SVProgressHUD showErrorWithStatus:@"新浪分享失败"];
    
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"....././././././:%@",result);
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
//                                                        message:[NSString stringWithFormat:@"Post image status \"%@\" succeed!", [result objectForKey:@"text"]]
//                                                       delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//    [alertView show];
    [SVProgressHUD showSuccessWithStatus:@"新浪分享成功"];
    txtVInput.text = @"";
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
