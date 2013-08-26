//
//  AppDelegate.m
//  guoSeven
//
//  Created by zucknet on 12/12/4.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "AppDelegate.h"
#import "DDMenuController.h"
#import "FeedViewController.h"
#import "MasterViewController.h"
#import "MenuViewController.h"
#import "LaunchImageTransition.h"
#import "LoginViewController.h"
#import "TosearchViewController.h"
#import "RSHttpManager.h"
#import "UserInfo.h"
#import "iMessageViewController.h"
#import "TestFriendViewController.h"
#import "WantViewController.h"
#import "TestRelikeViewController.h"

@implementation AppDelegate
@synthesize devicetype;
@synthesize isEnterBackground;
- (void)getNewDataForUserInfoToUserDefault:(void (^)(BOOL show))success failure:(void (^)(NSError *error))failure {
    NSString *uid = kUserDefault(kUID);
    [RSHttpManager requestTargetUserInfoWithUID:uid WithTUID:uid WithSuccess:^(NSArray *userList) {
        UserInfo *info = [userList objectAtIndex:0];
        NSLog(@"//////%@",info.nick_name);
        kUserDefaultSet(info.img_path, kUIcon);
//        kUserDefaultSet(info.nick_name, kUNickNamm);
//        kUserDefaultSet(info.signature, kUSignature);
//        kUserDefaultSet(info.nick_name, kUNickNamm);
        [[NSUserDefaults standardUserDefaults] synchronize];
        if (success) {
            success(YES);
        }
    } failure:^(NSError *error) {
        NSLog(@".....%@",error.localizedDescription);
        if (failure) {
            failure(error);
        }
    }];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    isEnterBackground = NO;
    
    [[UIApplication sharedApplication]
     registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
//    application.applicationIconBadgeNumber = 0;

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIImage *naviImg=[UIImage imageNamed:@"navBar"];
    [[UINavigationBar appearance]setBackgroundImage:naviImg forBarMetrics:UIBarMetricsDefault];

    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:kUID];
    if (obj != nil) {
        NSLog(@"=---------");
        
    }
    
    NSString *tmpStr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUID]];

    NSLog(@"......%@",tmpStr);
    if (![tmpStr caseInsensitiveCompare:@"(null)"] == NSOrderedSame) {
        NSDictionary *localNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (localNotif) {
            application.applicationIconBadgeNumber = [[localNotif valueForKeyPath:@"aps.badge"] integerValue];
            [self viewRemoteNotificationWith:localNotif];
//            [self performSelector:@selector(viewRemoteNotificationWith:) withObject:localNotif afterDelay:1];
        }else{
            [self setCustomRootViewController];
        }
    }else{
        LoginViewController *vc;
        if (IS_IPHONE5) {
            vc = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPhone5" bundle:nil];
        }else{
            vc = [[LoginViewController alloc] initWithNibName:@"LoginViewController_Normal" bundle:nil];
        }
        UIDevice *device = [UIDevice currentDevice];
        DLog(@"device.model = %@",device.model);
        if ([device.model caseInsensitiveCompare:@"iPhone"] == NSOrderedSame) {
            devicetype = iPhone;
        }else if ([device.model caseInsensitiveCompare:@"iPad"] == NSOrderedSame){
            devicetype = iPad;
        }else if ([device.model caseInsensitiveCompare:@"iPod touch"] == NSOrderedSame){
            devicetype = iPodtouch;
        }
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        nav.navigationBarHidden = YES;
        
        self.window.rootViewController = nav;
        
    }


    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    

    return YES;
}


-(void)viewRemoteNotificationWith:(NSDictionary *)userInfo{
    switch ([[userInfo valueForKeyPath:@"aps.push_type"] integerValue]) {
        case 0:
        {
            
        }
            break;
            
        case 1:
        {
            TestFriendViewController *friendController =[[TestFriendViewController alloc]init];
            
            UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:friendController];
//            [_menuController setRootController:navController animated:YES];
            friendController.title=@"关注与粉丝";
            friendController.topbtn1.selected = NO;
            friendController.topbtn2.selected = YES;
            [friendController getData];
            DDMenuController *rootController =[[DDMenuController alloc]initWithRootViewController:navController];
            rootController.delegate = self;
            _menuController=rootController;
            _menuController.view.backgroundColor =  [UIColor colorWithRed:64.0f/255.0f green:64.0f/255.0f blue:64.0f/255.0f alpha:1.0f];
            
            FeedViewController *feedController =[[FeedViewController alloc]init];
            rootController.leftViewController=feedController;
            self.window.rootViewController = [[LaunchImageTransition alloc] initWithViewController:rootController animation:UIModalTransitionStyleCrossDissolve];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cleanNum" object:@"1"];
   
        }
            break;
            
        case 2:
        {//愿望清单表
            
            WantViewController *wantVC =[[WantViewController alloc]init];
            UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:wantVC];
//            [_menuController setRootController:navController animated:YES];
            wantVC.title=@"愿望清单";
            [wantVC getdata];
            DDMenuController *rootController =[[DDMenuController alloc]initWithRootViewController:navController];
            rootController.delegate = self;
            _menuController=rootController;
            _menuController.view.backgroundColor =  [UIColor colorWithRed:64.0f/255.0f green:64.0f/255.0f blue:64.0f/255.0f alpha:1.0f];
            
            FeedViewController *feedController =[[FeedViewController alloc]init];
            rootController.leftViewController=feedController;
            self.window.rootViewController = [[LaunchImageTransition alloc] initWithViewController:rootController animation:UIModalTransitionStyleCrossDissolve];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cleanNum" object:@"2"];

        }
            break;
        case 3:
        {//评论表
            TestRelikeViewController *reviewController = [[TestRelikeViewController alloc]init];
            UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:reviewController];
//            [_menuController setRootController:navController animated:YES];
            reviewController.title=@"推荐与评论";
            reviewController.topbtn1.selected = NO;
            reviewController.topbtn2.selected = YES;
            [reviewController getData];
            
            
            DDMenuController *rootController =[[DDMenuController alloc]initWithRootViewController:navController];
            rootController.delegate = self;
            _menuController=rootController;
            _menuController.view.backgroundColor =  [UIColor colorWithRed:64.0f/255.0f green:64.0f/255.0f blue:64.0f/255.0f alpha:1.0f];
            
            FeedViewController *feedController =[[FeedViewController alloc]init];
            rootController.leftViewController=feedController;
            self.window.rootViewController = [[LaunchImageTransition alloc] initWithViewController:rootController animation:UIModalTransitionStyleCrossDissolve];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cleanNum" object:@"3"];

        }
            break;
        case 4:
        {//推荐表
            TestRelikeViewController *reviewController = [[TestRelikeViewController alloc]init];
            UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:reviewController];
//            [_menuController setRootController:navController animated:YES];
            reviewController.title=@"推荐与评论";
            reviewController.topbtn1.selected = YES;
            reviewController.topbtn2.selected = NO;
            [reviewController getData];
            
            
            DDMenuController *rootController =[[DDMenuController alloc]initWithRootViewController:navController];
            rootController.delegate = self;
            _menuController=rootController;
            _menuController.view.backgroundColor =  [UIColor colorWithRed:64.0f/255.0f green:64.0f/255.0f blue:64.0f/255.0f alpha:1.0f];
            
            FeedViewController *feedController =[[FeedViewController alloc]init];
            rootController.leftViewController=feedController;
            self.window.rootViewController = [[LaunchImageTransition alloc] initWithViewController:rootController animation:UIModalTransitionStyleCrossDissolve];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cleanNum" object:@"3"];

        }
            break;
        case 5:
        {
            iMessageViewController *msgController =[[iMessageViewController alloc]init];
            UINavigationController *navController =[[UINavigationController alloc]initWithRootViewController:msgController];
            [_menuController setRootController:navController animated:YES];
            msgController.title = @"私信";
            
            DDMenuController *rootController =[[DDMenuController alloc]initWithRootViewController:navController];
            rootController.delegate = self;
            _menuController=rootController;
            _menuController.view.backgroundColor =  [UIColor colorWithRed:64.0f/255.0f green:64.0f/255.0f blue:64.0f/255.0f alpha:1.0f];
            
            FeedViewController *feedController =[[FeedViewController alloc]init];
            rootController.leftViewController=feedController;
            if (IS_IPHONE5) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"imessage" object:nil];
            }
            self.window.rootViewController = [[LaunchImageTransition alloc] initWithViewController:rootController animation:UIModalTransitionStyleCrossDissolve];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cleanNum" object:@"5"];

        }
            break;
            
        default:
            break;
    }
}

- (void)setCustomRootViewController{
    
    MasterViewController *lobbyController=[[MasterViewController alloc]init];
     lobbyController.isLogin = YES;
    UINavigationController *navController =[[UINavigationController alloc]initWithRootViewController:lobbyController];
    
    DDMenuController *rootController =[[DDMenuController alloc]initWithRootViewController:navController];
    rootController.delegate = self;
    _menuController=rootController;
    _menuController.view.backgroundColor =  [UIColor colorWithRed:64.0f/255.0f green:64.0f/255.0f blue:64.0f/255.0f alpha:1.0f];
    
    FeedViewController *feedController =[[FeedViewController alloc]init];
    rootController.leftViewController=feedController;
    
//    self.window.rootViewController = rootController;
    self.window.rootViewController = [[LaunchImageTransition alloc] initWithViewController:rootController animation:UIModalTransitionStyleCrossDissolve];
    
    NSString *uid = kUserDefault(kUID);
    NSString *token = kUserDefault(kTokenID);
//    9c9b8d43f5c4a9570bfb08352a00abcded2a85073c4c59976e2f1572a04b3a15
    
    
        
    [RSHTTPMANAGER registePushDeviceTokenID:uid WithTokenID:token WithSuccess:^(BOOL isSucceed) {

        NSLog(@"push..");
    
    } failure:^(NSError *_err) {
        
    }];
    
}


- (void)setCustomRootViewControllerWithSearch{
    MasterViewController *lobbyController=[[MasterViewController alloc]init];
    lobbyController.isLogin = NO;
    UINavigationController *navController =[[UINavigationController alloc]initWithRootViewController:lobbyController];
    
    DDMenuController *rootController =[[DDMenuController alloc]initWithRootViewController:navController];
    rootController.delegate = self;
    _menuController=rootController;
    _menuController.view.backgroundColor =  [UIColor colorWithRed:64.0f/255.0f green:64.0f/255.0f blue:64.0f/255.0f alpha:1.0f];

    FeedViewController *feedController =[[FeedViewController alloc]init];
    rootController.leftViewController=feedController;
    
//    self.window.rootViewController = rootController;

    self.window.rootViewController = [[LaunchImageTransition alloc] initWithViewController:rootController animation:UIModalTransitionStyleFlipHorizontal];

}
- (UITextField *)showTextFieldWithPlaceholder:(NSString *)placeholder
                                 keyboardType:(UIKeyboardType)keyboardType
                                returnKeyType:(UIReturnKeyType)returnKeyType
                              secureTextEntry:(BOOL)entry
                                     delegate:(id)delegate {
    UITextField *texF = [[UITextField alloc] initWithFrame:CGRectMake(90, 10, 190 , 20)];
    texF.backgroundColor = [UIColor clearColor];
    texF.font = [UIFont systemFontOfSize:16];
    texF.clearButtonMode = YES;
    texF.placeholder = placeholder;
    texF.returnKeyType = returnKeyType;//UIReturnKeyNext;
    texF.keyboardType = keyboardType;
    texF.delegate = delegate;
    texF.textAlignment = NSTextAlignmentRight;
    texF.secureTextEntry = entry;
    return texF;
}
- (UIBarButtonItem *)showBarItemWithTitle:(NSString *)title normalImg:(UIImage *)norimage hightImg:(UIImage *)higimage viewController:(id)vc action:(SEL)action {

    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, norimage.size.width/2, norimage.size.height/2)];//20, 3, 45, 28
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [btn setBackgroundImage:norimage forState:UIControlStateNormal];
    [btn setBackgroundImage:higimage forState:UIControlStateHighlighted];
    [btn addTarget:vc action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}
- (void)menuController:(DDMenuController *)controller willShowViewController:(UIViewController *)controller{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"biedianle" object:nil];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    isEnterBackground = YES;
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSArray* scheduledNotifications = [NSArray arrayWithArray:application.scheduledLocalNotifications];
    application.scheduledLocalNotifications = scheduledNotifications;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notif {
    application.applicationIconBadgeNumber = notif.applicationIconBadgeNumber;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSLog(@"deviceToken:%@",[deviceToken class]);
    NSString *token = [[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]
                                             stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"token:%@",token);
    kUserDefaultSet(token, kTokenID);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"error----------------");
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    DLog(@"userinfo==%@",userInfo);
    DLog(@"userinfo.alert==%@",[userInfo valueForKeyPath:@"aps.alert"]);
    
//    SHOWALERT_WITHTITLE_ANDMESSAGE(@"", [userInfo valueForKeyPath:@"aps.alert"]);
    /*
     push type
     1: xx关注了你
     2: 你关注了xx降价了
     3: 你评论的xx有了新的回应
     4: 你推荐的xx有了新的回应
     5: 你有一条新的私信
     */
//    if (application.applicationState == UIApplicationStateActive) {
//        application.applicationIconBadgeNumber = 0;
//    }
        NSString *tmpStr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUID]];
        
        NSLog(@"......%@",tmpStr);
        if (![tmpStr caseInsensitiveCompare:@"(null)"] == NSOrderedSame) {
            
            application.applicationIconBadgeNumber = [[userInfo valueForKeyPath:@"aps.badge"] integerValue];
            
            //app running
            NSLog(@"[[userInfo:%d",[[userInfo valueForKeyPath:@"aps.push_type"] integerValue]);
            switch ([[userInfo valueForKeyPath:@"aps.push_type"] integerValue]) {
                case 0:
                {
                    
                }
                    break;
                    
                case 1:
                {
                    if ([[[(UINavigationController *)_menuController.rootViewController viewControllers] lastObject] isKindOfClass:[TestFriendViewController class]]) {
                        TestFriendViewController *tmp = [[(UINavigationController *)_menuController.rootViewController viewControllers] lastObject];
                        tmp.topbtn1.selected = NO;
                        tmp.topbtn2.selected = YES;
                        [tmp getData];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"cleanNum" object:@"1"];
                        application.applicationIconBadgeNumber --;

                    }else{
                        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:[userInfo valueForKeyPath:@"aps.alert"] delegate:self
                                                              cancelButtonTitle:@"取消" otherButtonTitles:@"前往", nil];
                        alter.tag = 1;
                        [alter show];
                        
                    }
                }
                    break;
                    
                case 2:
                {//愿望清单表
                    if ([[[(UINavigationController *)_menuController.rootViewController viewControllers] lastObject] isKindOfClass:[WantViewController class]]) {
                        WantViewController *wantVC  = [[(UINavigationController *)_menuController.rootViewController viewControllers] lastObject];
                        [wantVC getdata];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"cleanNum" object:@"2"];
                        application.applicationIconBadgeNumber --;

                    }else{
                        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:[userInfo valueForKeyPath:@"aps.alert"] delegate:self
                                                              cancelButtonTitle:@"取消" otherButtonTitles:@"前往", nil];
                        alter.tag = 2;
                        [alter show];
                        
                    }
                    
                }
                    break;
                case 3:
                {//评论表
                    if ([[[(UINavigationController *)_menuController.rootViewController viewControllers] lastObject] isKindOfClass:[TestRelikeViewController class]]) {
                        TestRelikeViewController *tmp = [[(UINavigationController *)_menuController.rootViewController viewControllers] lastObject];
                        tmp.topbtn1.selected = NO;
                        tmp.topbtn2.selected = YES;
                        [tmp getData];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"cleanNum" object:@"3"];
                        application.applicationIconBadgeNumber --;

                    }else{
                        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:[userInfo valueForKeyPath:@"aps.alert"] delegate:self
                                                              cancelButtonTitle:@"取消" otherButtonTitles:@"前往", nil];
                        alter.tag = 3;
                        [alter show];
                        
                    }
                }
                    break;
                case 4:
                {//推荐表
                    if ([[[(UINavigationController *)_menuController.rootViewController viewControllers] lastObject] isKindOfClass:[TestRelikeViewController class]]) {
                        TestRelikeViewController *tmp = [[(UINavigationController *)_menuController.rootViewController viewControllers] lastObject];
                        tmp.topbtn1.selected = YES;
                        tmp.topbtn2.selected = NO;
                        [tmp getData];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"cleanNum" object:@"3"];
                        application.applicationIconBadgeNumber --;

                    }else{
                        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:[userInfo valueForKeyPath:@"aps.alert"] delegate:self
                                                              cancelButtonTitle:@"取消" otherButtonTitles:@"前往", nil];
                        alter.tag = 4;
                        [alter show];
                        
                    }
                }
                    break;
                case 5:
                {
                    if ([[[(UINavigationController *)_menuController.rootViewController viewControllers] lastObject] isKindOfClass:[iMessageViewController class]]) {
//                        [self performSelectorInBackground:@selector(remarkMM:) withObject:userInfo];
                        iMessageViewController *tmp = [[(UINavigationController *)_menuController.rootViewController viewControllers] lastObject];
                        [tmp getData];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"cleanNum" object:@"5"];
                        application.applicationIconBadgeNumber --;

                    }else{
                        
                        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:[userInfo valueForKeyPath:@"aps.alert"] delegate:self
                                                              cancelButtonTitle:@"取消" otherButtonTitles:@"前往", nil];
                        alter.tag = 5;
                        [alter show];
                    }
                }
                    break;
                    
                default:
                    break;
            }
        
    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:kPushNotification object:[userInfo valueForKeyPath:@"aps.alert"]];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (alertView.tag) {
        case 0:
        case 1:{
            if (buttonIndex == 1) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"cleanNum" object:@"1"];

                TestFriendViewController *friendController =[[TestFriendViewController alloc]init];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:friendController];
                [_menuController setRootController:navController animated:YES];                
                friendController.title=@"关注与粉丝";
                friendController.topbtn1.selected = NO;
                friendController.topbtn2.selected = YES;
                [friendController getData];
            }
        }
            break;
        case 2:
            if (buttonIndex == 1) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"cleanNum" object:@"2"];

                WantViewController *wantVC =[[WantViewController alloc]init];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:wantVC];
                [_menuController setRootController:navController animated:YES];
                wantVC.title=@"愿望清单";
                [wantVC getdata];
            }
            break;
        case 3:
            if (buttonIndex == 1) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"cleanNum" object:@"3"];

                TestRelikeViewController *reviewController = [[TestRelikeViewController alloc]init];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:reviewController];
                [_menuController setRootController:navController animated:YES];
                reviewController.title=@"推荐与评论";
                reviewController.topbtn1.selected = NO;
                reviewController.topbtn2.selected = YES;
                [reviewController getData];
            }
            break;
        case 4:
            if (buttonIndex == 1) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"cleanNum" object:@"3"];

                TestRelikeViewController *reviewController = [[TestRelikeViewController alloc]init];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:reviewController];
                [_menuController setRootController:navController animated:YES];
                reviewController.title=@"推荐与评论";

                reviewController.topbtn1.selected = YES;
                reviewController.topbtn2.selected = NO;
                [reviewController getData];
            }
            break;
        case 5:{
            NSLog(@"....:%d", buttonIndex);
            if (buttonIndex == 1) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"cleanNum" object:@"5"];
                iMessageViewController *msgController =[[iMessageViewController alloc]init];
                UINavigationController *navController =[[UINavigationController alloc]initWithRootViewController:msgController];
                [_menuController setRootController:navController animated:YES];
                msgController.title = @"私信";

            }
        }
            break;
            
        default:
            break;
    }
}


@end
