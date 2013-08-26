//
//  SocalNetworkViewController.m
//  GPlay
//
//  Created by zucknet on 12/10/27.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "SocalNetworkViewController.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "DOUAPIEngine.h"
#import "TCWBEngine.h"
#import "RSHttpManager.h"
//#import "DOUOAuthStore.h"
#import "WeiBoShare.h"

@interface SocalNetworkViewController ()

@property(nonatomic,retain)NSArray *tablelist;
@property(nonatomic,retain)UISwitch *sinaws;
@property(nonatomic,retain)UISwitch *qqws;
@property(nonatomic,retain)UISwitch *renrenws;
@property(nonatomic,retain)UISwitch *doubanws;
@property (nonatomic,retain) NSString *currentUID;

@property (nonatomic, assign) BOOL isSinaAvailBack;
@property (nonatomic, assign) BOOL isQQAvailBack;
@property (nonatomic, assign) BOOL isDoubanAvailBack;
@property (nonatomic, retain) SinaWeibo *sinaWeibo;
@property (nonatomic, retain) UILabel *lbl1;
@property (nonatomic, retain) UILabel *lbl2;
@property (nonatomic, retain) UILabel *lbl3;

@end

@implementation SocalNetworkViewController
@synthesize tablelist;
@synthesize sinaws,qqws,renrenws,doubanws;
@synthesize currentUID;
@synthesize isSinaAvailBack, isDoubanAvailBack, isQQAvailBack;
@synthesize lbl1,lbl2,lbl3;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    
//    APPDELEGATE.menuController.view.backgroundColor =  [UIColor colorWithRed:64.0f/255.0f green:64.0f/255.0f blue:64.0f/255.0f alpha:1.0f];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currentUID = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUID]];

    
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
    self.isDoubanAvailBack = NO;
    self.isSinaAvailBack = NO;
    self.isQQAvailBack = NO;
    
//    [RSHTTPMANAGER requestShareList:self.currentUID WithSuccess:^(NSArray *squareList) {
//        if ([squareList count]) {
//            for (int i = 0; i < [squareList count]; i++) {
//                WeiBoShare *wbs = [squareList objectAtIndex:i];
//                if ([wbs.weibo_type isEqualToString:@"sina"]) {
//                    if ([wbs.is_share boolValue]) {
//                        if ([wbs.status isEqualToString:@"1"]) {
//                            self.isSinaAvailBack = YES;
//                        }else{
//                            self.isSinaAvailBack = NO;
//                        }
//                    }else{
//                        self.isSinaAvailBack = NO;
//                    }
//                }
//                
//                if ([wbs.weibo_type isEqualToString:@"qq"]) {
//                    if ([wbs.is_share boolValue]) {
//                        if ([wbs.status isEqualToString:@"1"]) {
//                            self.isQQAvailBack = YES;
//                        }else{
//                            self.isQQAvailBack = NO;
//                        }
//                    }else{
//                        self.isQQAvailBack = NO;
//                    }
//                }
//                
//                if ([wbs.weibo_type isEqualToString:@"douban"]) {
//                    if ([wbs.is_share boolValue]) {
//                        if ([wbs.status isEqualToString:@"1"]) {
//                            self.isDoubanAvailBack = YES;
//                        }else{
//                            self.isDoubanAvailBack = NO;
//                        }
//                    }else{
//                        self.isDoubanAvailBack = NO;
//                    }
//                }
//                
//                
//            }
//        }
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
//        
//    }];
    
//    self.lbl1.text = @"开启同步功能，点亮你个人主页的社交图标，把你在！";
//    self.lbl1.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
//    self.lbl1.textAlignment = NSTextAlignmentLeft;
    
    
    self.title=@"同步分享";
    self.view.backgroundColor=[UIColor colorWithRed:247.0 / 255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0];
    self.tableView.backgroundView=nil;

    tablelist=[[NSArray alloc]initWithObjects:@"新浪微博",@"腾讯微博",@"豆瓣", nil];
    
    UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(20, 3, 45, 28)];
    UILabel *leftlab=[[UILabel alloc]initWithFrame:CGRectMake(14, 3, 24, 20)];
    leftlab.text=@"返回";
    leftlab.backgroundColor=[UIColor clearColor];
    [leftlab setTextColor:[UIColor whiteColor]];
    leftlab.font=[UIFont fontWithName:@"Helvetica Neue" size:12];
    [backButton addSubview:leftlab];
    [backButton setBackgroundImage:[UIImage imageNamed:@"icontop-back@2x.png"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"icontop-back2@2x.png"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(setBackView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
}

-(void)setBackView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tablelist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.text=[self.tablelist objectAtIndex:row];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:17.0f];
    cell.textLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    if (indexPath.row == 0) {
        sinaws=[[UISwitch alloc]initWithFrame:CGRectZero];
        cell.accessoryView=self.sinaws;
        [self.sinaws setOn:[self.sinaWeibo isLoggedIn]];
//        [self.sinaws setOn:self.isSinaAvailBack];
        [self.sinaws addTarget:self action:@selector(updateSwitchWithSinaws:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (indexPath.row == 1) {
        qqws=[[UISwitch alloc]initWithFrame:CGRectZero];
        cell.accessoryView=self.qqws;

        TCWBEngine *engine = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl:REDIRECTURI];
        [self.qqws setOn:![engine isAuthorizeExpired]];

//        [self.qqws setOn:self.isQQAvailBack];
        
        [self.qqws addTarget:self action:@selector(updateSwitchWithQQ:) forControlEvents:UIControlEventTouchUpInside];
    }
    
//    if (indexPath.row == 2) {
//        renrenws=[[UISwitch alloc]initWithFrame:CGRectZero];
//        cell.accessoryView=self.renrenws;
//        [self.renrenws addTarget:self action:@selector(updateSwitchAtIndexPath) forControlEvents:UIControlEventTouchUpInside];
//    }
    
    if (indexPath.row == 2) {
        doubanws=[[UISwitch alloc]initWithFrame:CGRectZero];
        cell.accessoryView=self.doubanws;
        DOUService *service = [DOUService sharedInstance];
        service.clientId = kDouBanKey;
        service.clientSecret = kDouBanPrivateKey;
//
        [self.doubanws setOn:[service isValid]];
        
//        [self.doubanws setOn:self.isDoubanAvailBack];
        
        [self.doubanws addTarget:self action:@selector(updateSwitchWithDouBan:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

- (void)updateSwitchWithSinaws:(id)sender{
    if ([self.sinaws isOn]) {
        [self.sinaWeibo logIn];
    }else{
//        [SVProgressHUD show];
//        [RSHTTPMANAGER requestDelShareWithUid:self.currentUID WithType:@"sina" WithSuccess:^(BOOL isSuccess) {
//            if (isSuccess) {
//                [SVProgressHUD showSuccessWithStatus:@"解除Sina微博绑定成功"];
//                [self.sinaWeibo logOut];
//                [self.sinaws setOn:NO];
//            }else{
//                [SVProgressHUD showErrorWithStatus:@"解除Sina微博绑定失败"];
//                [self.sinaws setOn:YES];
//            }
//        } failure:^(NSError *error) {
//            [self.sinaws setOn:YES];
//            [SVProgressHUD dismiss];
//        }];
        
        
        [self.sinaWeibo logOut];

    }
}



- (void)updateSwitchWithQQ:(id)sender{
    TCWBEngine *engine = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl:REDIRECTURI];
    if ([self.qqws isOn]) {
//        APPDELEGATE.menuController.view.backgroundColor =  [UIColor whiteColor];
        [engine setRootViewController:self];
        [engine logInWithDelegate:self
                        onSuccess:@selector(onSuccessLogin)
                        onFailure:@selector(onFailureLogin:)];

    }else{
//        [SVProgressHUD show];
//        [RSHTTPMANAGER requestDelShareWithUid:self.currentUID WithType:@"qq" WithSuccess:^(BOOL isSuccess) {
//            if (isSuccess) {
//                [SVProgressHUD showSuccessWithStatus:@"解除腾讯微博绑定成功"];
//                [engine logOut];
//                [self.qqws setOn:NO];
//            }else{
//                [SVProgressHUD showErrorWithStatus:@"解除腾讯微博绑定失败"];
//                [self.qqws setOn:YES];
//            }
//        } failure:^(NSError *error) {
//            [self.qqws setOn:YES];
//            [SVProgressHUD dismiss];
//        }];

        [engine logOut];

    }
    
    
}

//登录成功回调
- (void)onSuccessLogin
{
//    TCWBEngine *engine = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl:REDIRECTURI];
//    [RSHTTPMANAGER requestBDQQWithUid:self.currentUID WithType:@"qq" WithWID:engine.openId WithWKey:engine.openKey WithWT:engine.accessToken WithWName:engine.name WithSuccess:^(BOOL isSuccess) {
//        if (isSuccess) {
//            [SVProgressHUD showSuccessWithStatus:@"腾讯微博绑定成功"];
//            [self.qqws setOn:YES];
//
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"腾讯微博绑定失败"];
//            [self.qqws setOn:NO];
//            [engine logOut];
//        }
//    } failure:^(NSError *error) {
//        
//    }];

    [SVProgressHUD showSuccessWithStatus:@"腾讯微博绑定成功"];

}

//登录失败回调
- (void)onFailureLogin:(NSError *)error{
    [self.qqws setOn:NO];
}


- (void)updateSwitchWithDouBan:(id)sender{
    if ([self.doubanws isOn]) {
        DoubanViewController *vc = [[DoubanViewController alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
//        [SVProgressHUD show];
//        [RSHTTPMANAGER requestDelShareWithUid:self.currentUID WithType:@"douban" WithSuccess:^(BOOL isSuccess) {
//            if (isSuccess) {
//                [SVProgressHUD showSuccessWithStatus:@"解除豆瓣绑定成功"];
//                [[DOUOAuthService sharedInstance] logout];
//
//                [self.doubanws setOn:NO];
//            }else{
//                [SVProgressHUD showErrorWithStatus:@"解除豆瓣绑定失败"];
//                [self.doubanws setOn:YES];
//            }
//        } failure:^(NSError *error) {
//            [self.doubanws setOn:YES];
//            [SVProgressHUD dismiss];
//        }];

        [[DOUOAuthService sharedInstance] logout];

    }
}

- (void)DoubanSuccess{
   
    
//    DOUOAuthStore *db =  [DOUOAuthStore sharedInstance];
//    [RSHTTPMANAGER requestBDDBWithUid:self.currentUID WithType:@"douban" WithWID:[NSString stringWithFormat:@"%d",db.userId] WithWKey:db.refreshToken WithWT:db.accessToken WithSuccess:^(BOOL isSuccess) {
//        if (isSuccess) {
//            [SVProgressHUD showSuccessWithStatus:@"豆瓣绑定成功"];
//            [self.doubanws setOn:YES];
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"豆瓣绑定失败"];
//            [self.doubanws setOn:NO];
//            [[DOUOAuthService sharedInstance] logout];
//        }
//    } failure:^(NSError *error) {
//        
//    }];
    
    
    [SVProgressHUD showSuccessWithStatus:@"豆瓣绑定成功"];

    
}


- (void)DoubanFail{
    [self.doubanws setOn:NO];
    [[DOUOAuthService sharedInstance] logout];

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


#pragma mark - SinaWeibo Delegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    [self storeAuthData];
//    [self.sinaws setOn:YES];
//    [RSHTTPMANAGER requestBDWithUid:self.currentUID WithType:@"sina" WithWID:sinaweibo.userID WithWT:sinaweibo.accessToken WithSuccess:^(BOOL isSuccess) {
//        if (isSuccess) {
//            [SVProgressHUD showSuccessWithStatus:@"Sina微博绑定成功"];
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"Sina微博绑定失败"];
//            [self.sinaWeibo logOut];
//        }
//    } failure:^(NSError *error) {
//        [self.sinaWeibo logOut];
//    }];
    [SVProgressHUD showSuccessWithStatus:@"Sina微博绑定成功"];

    
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [self.sinaws setOn:NO];
    [self removeAuthData];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
    [self.sinaws setOn:NO];
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

- (void)updateSwitchAtIndexPath {
   
    if ([self.qqws isOn]) {
        NSLog(@")>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ON");
        UIAlertView *alert2 = [[UIAlertView alloc]initWithTitle:@"Message" message:@"已打开腾讯绑定" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert2 show];
    }
    if ([self.renrenws isOn]) {
        NSLog(@")>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ON");
        UIAlertView *alert3 = [[UIAlertView alloc]initWithTitle:@"Message" message:@"已打开人人绑定" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert3 show];
    }
    if ([self.doubanws isOn]) {
        NSLog(@")>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ON");
     
        
        
        
        
    }else{
        NSLog(@")>>>>>>>>>>>>>>>>>>>>>>>>>>>>> OFF");
    }

}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow]animated:YES];

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 95;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    switch (section) {
//        default:
//            return @"开启同步功能，点亮个人主页的社交图标，把你在果7的动态同步到其他社交网站，让更多朋友享受你在App世界的新发现！";
//            break;
//    }
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *tmp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
//        tmp.backgroundColor = [UIColor redColor];
       
        
        lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(12, 19, 320, 13)];
        lbl1.text = @"开启同步功能， 点亮个人主页的社交图标， 把你在";
//        [lbl1 setNumberOfLines:0];
        lbl1.textAlignment = NSTextAlignmentLeft;
        lbl1.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        lbl1.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        lbl1.backgroundColor = [UIColor clearColor];
        [tmp addSubview:lbl1];
        
        lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(12, 13+19+8, 320, 13)];
        lbl2.text = @"果7的动态同步到其他社交网站，让更多朋友享受你";
        //        [lbl1 setNumberOfLines:0];
        lbl2.textAlignment = NSTextAlignmentLeft;
        lbl2.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        lbl2.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        lbl2.backgroundColor = [UIColor clearColor];
        [tmp addSubview:lbl2];
        
        lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(12, 26+19+16, 320, 13)];
        lbl3.text = @"在App世界的新发现！";
        //        [lbl1 setNumberOfLines:0];
        lbl3.textAlignment = NSTextAlignmentLeft;
        lbl3.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        lbl3.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        lbl3.backgroundColor = [UIColor clearColor];
        [tmp addSubview:lbl3];
         return tmp;
//        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
//        lb.text = @"开启同步功能，点亮你个人主页的社交图标，把你在\n果7的动向同步到其他社交网站，让更多朋友享受你\n在App世界的新发现！";
//        [lb setNumberOfLines:0];
//        lb.textAlignment = NSTextAlignmentCenter;
//        lb.textColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
//        lb.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
//        lb.backgroundColor = [UIColor clearColor];
//        return lb;
        
    }
    return nil;
}
@end
