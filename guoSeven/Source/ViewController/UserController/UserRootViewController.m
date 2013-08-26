//
//  UserRootViewController.m
//  guoSeven
//
//  Created by zucknet on 13/1/7.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "UserRootViewController.h"
#import "AccountViewController.h"
#import "UIImageView+AFNetworking.h"
#import "DetailViewController.h"
#import "SBJson.h"
#import "UserLobbyViewController.h"
#import "WantViewController.h"

#import "RSHttpManager.h"
#import "UserInfo.h"
#import "CustomUserInfoTopView.h"
#import "MasterCell1.h"
#import "SquareModel.h"
#import "WantModel.h"
#import "AppsDetailsViewController.h"
//#import "RespondViewController.h"
#import "WishCell.h"
#import "UserModel.h"
#import "AttentionCell.h"
#import "SVProgressHUD.h"
#import "SVPullToRefresh.h"
#import "SettingUserInfoViewController.h"
#import "iChatViewController.h"
#import "MessageModel.h"
@interface UserRootViewController ()

//-(void)LobbyVc;
//-(void)WantVc;
@property (nonatomic, retain) UILabel *userName;
@property (nonatomic, retain) UILabel *userSignature;
@property (nonatomic, retain) UILabel *userLocation;
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) UIImageView *userIcon;
@property (nonatomic, retain) CustomUserInfoTopView *section0View;
@property (nonatomic, retain) NSMutableArray *squarArr;
@property (nonatomic, assign) int selectIndex;
@property (nonatomic, retain) NSString *currentUID;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) int selectTag;
@property (nonatomic, retain) UserInfo *userInfo;
@property (nonatomic, retain) UIImageView *leftYin;
@property (nonatomic, retain) UIImageView *rightYin;
//@property (nonatomic, retain) UIButton *cancelBtn;
//@property (nonatomic, retain) UIButton *msgBtn;

@end

@implementation UserRootViewController
@synthesize myTableView;
@synthesize section0View;
@synthesize userName, userLocation, userSignature;
@synthesize userIcon;
@synthesize squarArr;
@synthesize selectIndex;
@synthesize currentUID;
@synthesize uuid;
@synthesize selectTag;
@synthesize userInfo;
@synthesize leftYin, rightYin;
//@synthesize cancelBtn, msgBtn;
//@synthesize scrollView,topView,topScroll;
//@synthesize namelabel,signaturelabel,touxiangImg,formlab,nameForm;
//@synthesize leftRight,imageleft_on,imageleft_off,imageright_on,imageright_off;
//@synthesize btnlab1,btnlab2,btnlab3,btnlab4,btnlab5,btnlab6;
//@synthesize numlab1,numlab2,numlab3,numlab4,numlab5,numlab6;
//@synthesize topbtn1,topbtn2,topbtn3,topbtn4,topbtn5,topbtn6;
//@synthesize review1;
//@synthesize detailViewController = _detailViewController;
//@synthesize user_information;
//@synthesize userLobby;
//@synthesize pushVc,wantVc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setFrame:CGRectMake(20, 3, 45, 28)];
        UILabel *leftlab=[[UILabel alloc]initWithFrame:CGRectMake(14, 3, 24, 20)];
        leftlab.text=@"返回";
        leftlab.backgroundColor=[UIColor clearColor];
        [leftlab setTextColor:[UIColor whiteColor]];
        leftlab.font=[UIFont fontWithName:@"Helvetica-Bold" size:12];
        [backButton addSubview:leftlab];
        [backButton setBackgroundImage:[UIImage imageNamed:@"icontop-back@2x.png"] forState:UIControlStateNormal];
        [backButton setBackgroundImage:[UIImage imageNamed:@"icontop-back2@2x.png"] forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(backToPreVC:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
        [self.navigationItem setLeftBarButtonItem:leftItem];
    }
    return self;
}


-(void)backToPreVC:(id)sender{
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)unfollow{
//    self.msgBtn.hidden = YES;
//    self.cancelBtn.hidden = YES;
    [SVProgressHUD show];
    [RSHTTPMANAGER requestUnFollowPeopleWithUID:self.currentUID WithFollwingID:uuid WithSuccess:^(BOOL isSucceed) {
        if (isSucceed) {
            [SVProgressHUD showSuccessWithStatus:@"取消关注"];
            [self.userInfo setIsFollowing:@"0"];
        }else{
            [SVProgressHUD showErrorWithStatus:@"操作失败"];
        }
        
    } failure:^(NSError *_err) {
        
    }];
}


- (void)sendMSG{
//    self.msgBtn.hidden = YES;
//    self.cancelBtn.hidden = YES;
    iChatViewController *vContent = [[iChatViewController alloc] init];
    MessageModel *message = [[MessageModel alloc] init];
    message.uid = self.userInfo.id;
    vContent.title = self.userInfo.nick_name;
    vContent.messageModel = message;

    [self.navigationController pushViewController:vContent animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self unfollow];
    }else if (buttonIndex == 1){
        [self sendMSG];
    }
}


- (void)toAttention:(id)sender{

    if ([self.userInfo.isFollowing boolValue]) {
//        NSLog(@"取消关注");
//        if (!self.cancelBtn) {
//            self.cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//            [self.cancelBtn setTitle:@"取消关注" forState:UIControlStateNormal];
//            [self.cancelBtn addTarget:self action:@selector(unfollow:) forControlEvents:UIControlEventTouchUpInside];
//            self.cancelBtn.frame = CGRectMake(240, 0, 80, 20);
//            [self.view addSubview:self.cancelBtn];
//        }else{
//            if (self.cancelBtn.hidden) {
//                self.cancelBtn.hidden = NO;
//            }else{
//                self.cancelBtn.hidden = YES;
//                
//            }
//        }
//       
//
//        if (!self.msgBtn) {
//            self.msgBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//            [self.msgBtn setTitle:@"发私信" forState:UIControlStateNormal];
//            [self.msgBtn addTarget:self action:@selector(sendMSG:) forControlEvents:UIControlEventTouchUpInside];
//            self.msgBtn.frame = CGRectMake(240, 30, 80, 20);
//            [self.view addSubview:self.msgBtn];
//        }else{
//            if (self.msgBtn.hidden) {
//                self.msgBtn.hidden = NO;
//            }else{
//                self.msgBtn.hidden = YES;
//            }
//        }


        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"取消关注",@"发送私信", nil];
        
        [action showInView:self.view];
        
        
        
    }else{
        NSLog(@"关注");
        [SVProgressHUD show];

        [RSHTTPMANAGER requestFollowPeopleWithUID:self.currentUID WithFollwingID:uuid WithSuccess:^(BOOL isSucceed) {
            if (isSucceed) {
                [SVProgressHUD showSuccessWithStatus:@"关注成功"];
                
            
                [self.userInfo setIsFollowing:@"1"];
                
                
            }else{
                [SVProgressHUD showErrorWithStatus:@"操作失败"];
            }
        } failure:^(NSError *_err) {
            
        }];
        
    }
    
}
-(IBAction)toEditAccount:(id)sender{
    if (IS_IPHONE5) {
        SettingUserInfoViewController *accountController =[[SettingUserInfoViewController alloc]initWithNibName:@"SettingUserInfoViewController_iPhone5" bundle:nil];
        [self.navigationController pushViewController:accountController animated:YES];
    }else{
        SettingUserInfoViewController *accountController =[[SettingUserInfoViewController alloc]initWithNibName:@"SettingUserInfoViewController_Normal" bundle:nil];
        [self.navigationController pushViewController:accountController animated:YES];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];

    if ([self.navigationController.viewControllers count] > 1) {
        NSLog(@">>>>>>1");
    }else{
        NSLog(@"<<<<<<<");
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"YES"];
    }
    
    if ([uuid isEqualToString:self.currentUID]) {
        UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [rightBtn setFrame:CGRectMake(10, 3, 55, 32)];
        UILabel *rightlab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 55, 32)];
        rightlab.text=@"编辑";
        rightlab.backgroundColor=[UIColor clearColor];
        rightlab.textColor=[UIColor whiteColor];
        rightlab.textAlignment=NSTextAlignmentCenter;
        rightlab.font=[UIFont systemFontOfSize:13];
        [rightBtn addSubview:rightlab];
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"icontop-normal@2x.png"] forState:UIControlStateNormal];
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"icontop-normal2@2x.png"] forState:UIControlStateHighlighted];
        [rightBtn addTarget:self action:@selector(toEditAccount:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        [self.navigationItem setRightBarButtonItem:rightItem];
        
        uuid = self.currentUID;
        self.title = @"我";

        
        [RSHttpManager requestTargetUserInfoWithUID:self.currentUID WithTUID:uuid WithSuccess:^(NSArray *userList) {
            //        [RSHttpManager requestUserInfoWithUID:self.currentUID WithSuccess:^(NSArray *userList) {
            for (int i = 0; i < [userList count]; i++) {
                UserInfo *user = [userList objectAtIndex:i];
                NSLog(@"u////%@",user.id);
                [self.userIcon setImageWithURL:[NSURL URLWithString:user.img_path] placeholderImage:[UIImage imageNamed:@"hi"]];
                
                
                if (user.nick_name) {
                    self.userName.text = user.nick_name;
                    self.userName.font = [UIFont fontWithName:@"Helvetica" size:20];
                    CGSize sizeOfName = [self.userName.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:20]];
                    self.userName.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
//                    self.userName.frame = CGRectMake(self.userName.frame.origin.x, self.userName.frame.origin.y, sizeOfName.width, sizeOfName.height);
                    self.userName.frame = CGRectMake(self.userName.frame.origin.x, 15, sizeOfName.width, sizeOfName.height);

                    
                }
                if (user.signature) {
                    if (user.signature.length) {
                        self.leftYin.hidden = NO;
                        
                        self.userSignature.text = [NSString stringWithFormat:@"%@",user.signature];
                        self.userSignature.font = [UIFont fontWithName:@"Helvetica" size:13];
                        CGSize sizeOfSig = [self.userSignature.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
                        if (sizeOfSig.width > 190.0) {
                            self.userSignature.frame = CGRectMake(self.leftYin.frame.origin.x + self.leftYin.frame.size.width, self.userSignature.frame.origin.y, 190, sizeOfSig.height);
                        }else{
                            self.userSignature.frame = CGRectMake(self.leftYin.frame.origin.x + self.leftYin.frame.size.width, self.userSignature.frame.origin.y, sizeOfSig.width, sizeOfSig.height);
                        }
                        self.rightYin.hidden = NO;
                        self.rightYin.frame = CGRectMake(self.userSignature.frame.origin.x + self.userSignature.frame.size.width, self.rightYin.frame.origin.y, 14, 14);
                    }
                   
                }
                
                if (user.location_name) {
                    self.userLocation.text = user.location_name;
                    self.userLocation.font = [UIFont fontWithName:@"Helvetica" size:13];
                }
                
                if (user.feed_count) {
                    self.section0View.dynamicCountLabel.text = [NSString stringWithFormat:@"%@",user.feed_count];
                }
                if (user.want_count) {
                    self.section0View.desireCountLabel.text = [NSString stringWithFormat:@"%@",user.want_count];
                }
                if (user.recommend_count) {
                    self.section0View.recommendCountLabel.text = [NSString stringWithFormat:@"%@",user.recommend_count];
                }
                if (user.follower_count) {
                    self.section0View.attentionCountLabel.text = [NSString stringWithFormat:@"%@",user.follow_count];
                }
                if (user.follower_count) {
                    self.section0View.commentCountLabel.text = [NSString stringWithFormat:@"%@",user.discuss_count];
                }
            }
        } failure:^(NSError *error) {
            NSLog(@".....%@",error.localizedDescription);
        }];
        
        
    }else{
        UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [rightBtn setFrame:CGRectMake(10, 3, 55, 32)];
        UILabel *rightlab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 55, 32)];
        rightlab.text=@"关注...";
        rightlab.backgroundColor=[UIColor clearColor];
        rightlab.textColor=[UIColor whiteColor];
        rightlab.textAlignment=NSTextAlignmentCenter;
        rightlab.font=[UIFont systemFontOfSize:13];
        [rightBtn addSubview:rightlab];
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"icontop-normal@2x.png"] forState:UIControlStateNormal];
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"icontop-normal2@2x.png"] forState:UIControlStateHighlighted];
        [rightBtn addTarget:self action:@selector(toAttention:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        [self.navigationItem setRightBarButtonItem:rightItem];
        
        self.title = @"个人首页";
        
        
        [RSHttpManager requestTargetUserInfoWithUID:self.currentUID WithTUID:uuid WithSuccess:^(NSArray *userList) {
            for (int i = 0; i < [userList count]; i++) {
                self.userInfo = [userList objectAtIndex:i];
                NSLog(@"u////%@",self.userInfo.id);
                if ([self.userInfo.isFollowing boolValue]) {
                    NSLog(@"取消关注");
                }else{
                    NSLog(@"关注");
                }
                [self.userIcon setImageWithURL:[NSURL URLWithString:self.userInfo.img_path] placeholderImage:[UIImage imageNamed:@"hi"]];
                
                
                if (self.userInfo.nick_name) {
                    self.userName.text = self.userInfo.nick_name;
                    self.userName.font = [UIFont fontWithName:@"Helvetica" size:20];
                    CGSize sizeOfName = [self.userName.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:20]];
                    self.userName.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
                    self.userName.frame = CGRectMake(self.userName.frame.origin.x, self.userName.frame.origin.y, sizeOfName.width, sizeOfName.height);
                }
                if (self.userInfo.signature) {
//                    self.userSignature.text = [NSString stringWithFormat:@"\"%@\"",self.userInfo.signature];
                    if (self.userInfo.signature.length) {
                        self.leftYin.hidden = NO;
                        
                        self.userSignature.text = [NSString stringWithFormat:@"%@",self.userInfo.signature];
                        self.userSignature.font = [UIFont fontWithName:@"Helvetica" size:13];
                        CGSize sizeOfSig = [self.userSignature.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
                        if (sizeOfSig.width > 190.0) {
                            self.userSignature.frame = CGRectMake(self.leftYin.frame.origin.x + self.leftYin.frame.size.width, self.userSignature.frame.origin.y, 190, sizeOfSig.height);
                        }else{
                            self.userSignature.frame = CGRectMake(self.leftYin.frame.origin.x + self.leftYin.frame.size.width, self.userSignature.frame.origin.y, sizeOfSig.width, sizeOfSig.height);
                        }
                        self.rightYin.hidden = NO;
                        self.rightYin.frame = CGRectMake(self.userSignature.frame.origin.x + self.userSignature.frame.size.width, self.rightYin.frame.origin.y, 14, 14);
                    }
                }
                
                if (self.userInfo.location_name) {
                    self.userLocation.text = self.userInfo.location_name;
                }
                
                if (self.userInfo.feed_count) {
                    self.section0View.dynamicCountLabel.text = [NSString stringWithFormat:@"%@",self.userInfo.feed_count];
                }
                if (self.userInfo.want_count) {
                    self.section0View.desireCountLabel.text = [NSString stringWithFormat:@"%@",self.userInfo.want_count];
                }
                if (self.userInfo.recommend_count) {
                    self.section0View.recommendCountLabel.text = [NSString stringWithFormat:@"%@",self.userInfo.recommend_count];
                }
                if (self.userInfo.follower_count) {
                    self.section0View.attentionCountLabel.text = [NSString stringWithFormat:@"%@",self.userInfo.follow_count];
                }
                if (self.userInfo.follower_count) {
                    self.section0View.commentCountLabel.text = [NSString stringWithFormat:@"%@",self.userInfo.discuss_count];
                }            }
        } failure:^(NSError *error) {
            
        }];
    }
}
- (void)getData{
    [SVProgressHUD show];
    self.page = 2;
    if (self.selectTag == 0) {
        //动态
//        [RSHTTPMANAGER isShowActivity];
        self.myTableView.infiniteScrollingView.enabled = YES;
        [RSHTTPMANAGER requestUserDynamicWithUid:self.uuid WithLoginID:self.currentUID WithPage:@"1" WithSuccess:^(NSArray *dynamicList) {
            if ([dynamicList count]) {
                [self.squarArr removeAllObjects];
                self.squarArr = [NSMutableArray arrayWithArray:dynamicList];
                self.selectIndex = 0;
                [self.myTableView reloadData];
//                [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
                [self.myTableView.pullToRefreshView stopAnimating];
                self.section0View.dynamicCountLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                self.section0View.dynamicLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                self.section0View.desireCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                self.section0View.desireLabel.textColor = [UIColor blackColor];
                self.section0View.recommendCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                self.section0View.recommendLabel.textColor = [UIColor blackColor];
                self.section0View.attentionCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                self.section0View.attentionLabel.textColor = [UIColor blackColor];
                self.section0View.commentCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                self.section0View.commentLabel.textColor = [UIColor blackColor];
                if ([dynamicList count] < 10) {
                     self.myTableView.infiniteScrollingView.enabled = NO;
                }else{
                     self.myTableView.infiniteScrollingView.enabled = YES;
                }
            }else{
                self.myTableView.infiniteScrollingView.enabled = NO;
            }
            [SVProgressHUD dismiss];
            [self.myTableView.pullToRefreshView stopAnimating];
        } failure:^(NSError *error) {
            NSLog(@"........%@", error.localizedDescription);
            [self.myTableView.pullToRefreshView stopAnimating];
        }];
    }else if (self.selectTag == 1){
        
        //愿望
        [RSHttpManager requestWantWithUID:self.uuid  WithLoginID:self.currentUID WithSuccess:^(NSArray *wantList) {
            if ([wantList count]) {
                [self.squarArr removeAllObjects];
                self.squarArr = [NSMutableArray arrayWithArray:wantList];
                self.selectIndex = 1;
                [self.myTableView reloadData];
//                [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
                self.section0View.desireCountLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                self.section0View.desireLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                self.section0View.dynamicCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                self.section0View.dynamicLabel.textColor = [UIColor blackColor];
                self.section0View.recommendCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                self.section0View.recommendLabel.textColor = [UIColor blackColor];
                self.section0View.attentionCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                self.section0View.attentionLabel.textColor = [UIColor blackColor];
                self.section0View.commentCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                self.section0View.commentLabel.textColor = [UIColor blackColor];
          
                if ([wantList count] < 10) {
                    self.myTableView.infiniteScrollingView.enabled = NO;
                }else{
                    self.myTableView.infiniteScrollingView.enabled = YES;
                }
            }else{
                self.myTableView.infiniteScrollingView.enabled = NO;
            }
            [SVProgressHUD dismiss];
            [self.myTableView.pullToRefreshView stopAnimating];
        } failure:^(NSError *error) {
            NSLog(@"........%@", error.localizedDescription);
            [self.myTableView.pullToRefreshView stopAnimating];
        }];
    }else if (self.selectTag == 2){
        //推荐
//        [RSHTTPMANAGER isShowActivity];
        [RSHTTPMANAGER requestUserRecommendWithUid:self.uuid  WithLoginID:self.currentUID WithSuccess:^(NSArray *recommendList) {
            if ([recommendList count]) {
                [self.squarArr removeAllObjects];
                self.squarArr = [NSMutableArray arrayWithArray:recommendList];
                self.selectIndex = 2;
                [self.myTableView reloadData];
//                [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
                self.section0View.recommendCountLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                self.section0View.recommendLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                self.section0View.dynamicCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                self.section0View.dynamicLabel.textColor = [UIColor blackColor];
                self.section0View.desireCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                self.section0View.desireLabel.textColor = [UIColor blackColor];
                self.section0View.attentionCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                self.section0View.attentionLabel.textColor = [UIColor blackColor];
                self.section0View.commentCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                self.section0View.commentLabel.textColor = [UIColor blackColor];
                if ([recommendList count] < 10) {
                    self.myTableView.infiniteScrollingView.enabled = NO;
                }else{
                    self.myTableView.infiniteScrollingView.enabled = YES;
                }
            
            }else{
                self.myTableView.infiniteScrollingView.enabled = NO;
            }
            [SVProgressHUD dismiss];
            [self.myTableView.pullToRefreshView stopAnimating];
        } failure:^(NSError *error) {
            NSLog(@"\\\\\\%@",error.localizedDescription);
            [self.myTableView.pullToRefreshView stopAnimating];
        }];
    }else if (self.selectTag == 3){
        //关注
//        [RSHTTPMANAGER isShowActivity];
        [RSHTTPMANAGER requestUserWithUID:self.uuid WithType:@"following" WithPage:@"1" WithSuccess:^(NSArray *userList) {
            if ([userList count]) {
                [self.squarArr removeAllObjects];
                self.squarArr = [NSMutableArray arrayWithArray:userList];
                self.selectIndex = 3;
                [self.myTableView reloadData];
//                [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
                self.section0View.attentionCountLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                self.section0View.attentionLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                self.section0View.dynamicCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                self.section0View.dynamicLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                self.section0View.desireCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                self.section0View.desireLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                self.section0View.recommendCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                self.section0View.recommendLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                self.section0View.commentCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                self.section0View.commentLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                if ([userList count] < 10) {
                    self.myTableView.infiniteScrollingView.enabled = NO;
                }else{
                    self.myTableView.infiniteScrollingView.enabled = YES;
                }
            }else{
                self.myTableView.infiniteScrollingView.enabled = NO;
            }
            [SVProgressHUD dismiss];
            [self.myTableView.pullToRefreshView stopAnimating];
        } failure:^(NSError *error) {
            NSLog(@"\\\\\\%@",error.localizedDescription);
            [self.myTableView.pullToRefreshView stopAnimating];
        }];
    }else if (self.selectTag == 4){
        //评论
//        [RSHTTPMANAGER isShowActivity];
        [RSHTTPMANAGER requestCommentWithUID:self.uuid WithLoginID:self.currentUID WithSuccess:^(NSArray *commentList) {
            if ([commentList count]) {
                [self.squarArr removeAllObjects];
                self.squarArr = [NSMutableArray arrayWithArray:commentList];
                self.selectIndex = 4;
                [self.myTableView reloadData];
//                [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
                self.section0View.commentCountLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                self.section0View.commentLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                self.section0View.dynamicCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                self.section0View.dynamicLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                self.section0View.desireCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                self.section0View.desireLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                self.section0View.recommendCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                self.section0View.recommendLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                self.section0View.attentionCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                self.section0View.attentionLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                if ([commentList count] < 10) {
                    self.myTableView.infiniteScrollingView.enabled = NO;
                }else{
                    self.myTableView.infiniteScrollingView.enabled = YES;
                }
            }else{
                self.myTableView.infiniteScrollingView.enabled = NO;
            }
            [SVProgressHUD dismiss];
            [self.myTableView.pullToRefreshView stopAnimating];
        } failure:^(NSError *error) {
            [self.myTableView.pullToRefreshView stopAnimating];
        }];
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.selectIndex = 0;
    self.selectTag = 0;
    self.currentUID = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUID]];
    
   

    self.view.backgroundColor = [UIColor whiteColor];
    if (IS_IPHONE5) {
        self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 548 - 44)];
    }else{
        self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 460 - 44)];
    }
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.showsHorizontalScrollIndicator=FALSE;
    self.myTableView.showsVerticalScrollIndicator=FALSE;
    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 106)];
    tmpView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
    
    self.userName = [[UILabel alloc] initWithFrame:CGRectMake(90, 15, 250, 20 )]; 
    self.userName.backgroundColor = [UIColor clearColor];
    self.userName.font = [UIFont fontWithName:@"Helvetica" size:20];
    self.userName.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    [tmpView addSubview:self.userName];
    
    self.leftYin = [[UIImageView alloc] initWithFrame:CGRectMake(90, 45, 14, 14)];
    self.leftYin.image = [UIImage imageNamed:@"leftYin.png"];
    self.leftYin.hidden = YES;
    [tmpView addSubview:self.leftYin];
    
    
    self.rightYin = [[UIImageView alloc] initWithFrame:CGRectMake(90, 45, 14, 14)];
    self.rightYin.image = [UIImage imageNamed:@"rightYin.png"];
    self.rightYin.hidden = YES;
    [tmpView addSubview:self.rightYin];
    
    self.userSignature = [[UILabel alloc] initWithFrame:CGRectMake(90, 45, 250, 13)];
    self.userSignature.backgroundColor = [UIColor clearColor];
    self.userSignature.font = [UIFont fontWithName:@"Helvetica" size:13];
    self.userSignature.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    [tmpView addSubview:self.userSignature];
    
    self.userLocation = [[UILabel alloc] initWithFrame:CGRectMake(90, 68, 250, 13)];
    self.userLocation.backgroundColor = [UIColor clearColor];
    self.userLocation.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    self.userLocation.font = [UIFont fontWithName:@"Helvetica" size:13];
    [tmpView addSubview:self.userLocation];
    
    
    self.userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 70, 70)];
    self.userIcon.image = [UIImage imageNamed:@"hi"];
    [tmpView addSubview:self.userIcon];
    
    self.myTableView.tableHeaderView = tmpView;
    
    [self.view addSubview:self.myTableView];
    
    [self.myTableView addPullToRefreshWithActionHandler:^{
        self.page = 2;
        if (self.selectTag == 0) {
            //动态
//            [RSHTTPMANAGER isShowActivity];
            self.myTableView.infiniteScrollingView.enabled = YES;
            [RSHTTPMANAGER requestUserDynamicWithUid:self.uuid WithLoginID:self.currentUID WithPage:@"1" WithSuccess:^(NSArray *dynamicList) {
                if ([dynamicList count]) {
                    [self.squarArr removeAllObjects];
                    self.squarArr = [NSMutableArray arrayWithArray:dynamicList];
                    self.selectIndex = 0;
                    [self.myTableView reloadData];
//                    [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
                    [self.myTableView.pullToRefreshView stopAnimating];
                    self.section0View.dynamicCountLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                    self.section0View.dynamicLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                    self.section0View.desireCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                    self.section0View.desireLabel.textColor = [UIColor blackColor];
                    self.section0View.recommendCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                    self.section0View.recommendLabel.textColor = [UIColor blackColor];
                    self.section0View.attentionCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                    self.section0View.attentionLabel.textColor = [UIColor blackColor];
                    self.section0View.commentCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                    self.section0View.commentLabel.textColor = [UIColor blackColor];
                    if ([dynamicList count] < 10) {
                        self.myTableView.infiniteScrollingView.enabled = NO;
                    }else{
                        self.myTableView.infiniteScrollingView.enabled = YES;
                    }
                }else{
                    self.myTableView.infiniteScrollingView.enabled = NO;
                }
                [self.myTableView.pullToRefreshView stopAnimating];
            } failure:^(NSError *error) {
                NSLog(@"........%@", error.localizedDescription);
                [self.myTableView.pullToRefreshView stopAnimating];
            }];
        }else if (self.selectTag == 1){

            //愿望
            [RSHttpManager requestWantWithUID:self.uuid  WithLoginID:self.currentUID WithSuccess:^(NSArray *wantList) {
                if ([wantList count]) {
                    [self.squarArr removeAllObjects];
                    self.squarArr = [NSMutableArray arrayWithArray:wantList];
                    self.selectIndex = 1;
                    [self.myTableView reloadData];
//                    [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
                    self.section0View.desireCountLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                    self.section0View.desireLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                    self.section0View.dynamicCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                    self.section0View.dynamicLabel.textColor = [UIColor blackColor];
                    self.section0View.recommendCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                    self.section0View.recommendLabel.textColor = [UIColor blackColor];
                    self.section0View.attentionCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                    self.section0View.attentionLabel.textColor = [UIColor blackColor];
                    self.section0View.commentCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                    self.section0View.commentLabel.textColor = [UIColor blackColor];
                    if ([wantList count] < 10) {
                        self.myTableView.infiniteScrollingView.enabled = NO;
                    }else{
                        self.myTableView.infiniteScrollingView.enabled = YES;
                    }
                }else{
                    self.myTableView.infiniteScrollingView.enabled = NO;
                }
                [self.myTableView.pullToRefreshView stopAnimating];
            } failure:^(NSError *error) {
                NSLog(@"........%@", error.localizedDescription);
                [self.myTableView.pullToRefreshView stopAnimating];
            }];
        }else if (self.selectTag == 2){
            //推荐
//            [RSHTTPMANAGER isShowActivity];
            [RSHTTPMANAGER requestUserRecommendWithUid:self.uuid  WithLoginID:self.currentUID WithSuccess:^(NSArray *recommendList) {
                if ([recommendList count]) {
                    [self.squarArr removeAllObjects];
                    self.squarArr = [NSMutableArray arrayWithArray:recommendList];
                    self.selectIndex = 2;
                    [self.myTableView reloadData];
//                    [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
                    self.section0View.recommendCountLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                    self.section0View.recommendLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                    self.section0View.dynamicCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                    self.section0View.dynamicLabel.textColor = [UIColor blackColor];
                    self.section0View.desireCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                    self.section0View.desireLabel.textColor = [UIColor blackColor];
                    self.section0View.attentionCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                    self.section0View.attentionLabel.textColor = [UIColor blackColor];
                    self.section0View.commentCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                    self.section0View.commentLabel.textColor = [UIColor blackColor];
                    if ([recommendList count] < 10) {
                        self.myTableView.infiniteScrollingView.enabled = NO;
                    }else{
                        self.myTableView.infiniteScrollingView.enabled = YES;
                    }
                }else{
                    self.myTableView.infiniteScrollingView.enabled = NO;
                }
                [self.myTableView.pullToRefreshView stopAnimating];
            } failure:^(NSError *error) {
                NSLog(@"\\\\\\%@",error.localizedDescription);
                [self.myTableView.pullToRefreshView stopAnimating];
            }];
        }else if (self.selectTag == 3){
            //关注
//            [RSHTTPMANAGER isShowActivity];
            [RSHTTPMANAGER requestUserWithUID:self.uuid WithType:@"following" WithPage:@"1" WithSuccess:^(NSArray *userList) {
                if ([userList count]) {
                    [self.squarArr removeAllObjects];
                    self.squarArr = [NSMutableArray arrayWithArray:userList];
                    self.selectIndex = 3;
                    [self.myTableView reloadData];
//                    [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
                    self.section0View.attentionCountLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                    self.section0View.attentionLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                    self.section0View.dynamicCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                    self.section0View.dynamicLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                    self.section0View.desireCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                    self.section0View.desireLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                    self.section0View.recommendCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                    self.section0View.recommendLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                    self.section0View.commentCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                    self.section0View.commentLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                }
                [self.myTableView.pullToRefreshView stopAnimating];
            } failure:^(NSError *error) {
                NSLog(@"\\\\\\%@",error.localizedDescription);
                [self.myTableView.pullToRefreshView stopAnimating];
            }];
        }else if (self.selectTag == 4){
            //评论
//            [RSHTTPMANAGER isShowActivity];
            [RSHTTPMANAGER requestCommentWithUID:self.uuid WithLoginID:self.currentUID WithSuccess:^(NSArray *commentList) {
                if ([commentList count]) {
                    [self.squarArr removeAllObjects];
                    self.squarArr = [NSMutableArray arrayWithArray:commentList];
                    self.selectIndex = 4;
                    [self.myTableView reloadData];
//                    [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
                    self.section0View.commentCountLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                    self.section0View.commentLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                    self.section0View.dynamicCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                    self.section0View.dynamicLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                    self.section0View.desireCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                    self.section0View.desireLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                    self.section0View.recommendCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                    self.section0View.recommendLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                    self.section0View.attentionCountLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
                    self.section0View.attentionLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                    if ([commentList count] < 10) {
                        self.myTableView.infiniteScrollingView.enabled = NO;
                    }else{
                        self.myTableView.infiniteScrollingView.enabled = YES;
                    }
                }else{
                    self.myTableView.infiniteScrollingView.enabled = NO;
                }
                [self.myTableView.pullToRefreshView stopAnimating];
            } failure:^(NSError *error) {
                [self.myTableView.pullToRefreshView stopAnimating];
            }];
        }
    }];
    
    [self.myTableView addInfiniteScrollingWithActionHandler:^{
        if (self.selectTag == 0) {
//            [RSHTTPMANAGER isShowActivity];
            UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
            la.text = @"正在加载更多";
            la.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
            
            la.textAlignment = NSTextAlignmentCenter;
            
            self.myTableView.tableFooterView = la;
            [RSHTTPMANAGER requestUserDynamicWithUid:self.uuid WithLoginID:self.currentUID WithPage:[NSString stringWithFormat:@"%d", self.page] WithSuccess:^(NSArray *dynamicList) {
                if ([dynamicList count]) {
                    [self.squarArr addObjectsFromArray:dynamicList];
                    [self.myTableView reloadData];
                    self.selectIndex = 0;
                    self.section0View.dynamicCountLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                    self.section0View.dynamicLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                    self.section0View.desireCountLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                    self.section0View.desireLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                    self.section0View.recommendCountLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];                    self.section0View.recommendLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                    self.section0View.attentionCountLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];                    self.section0View.attentionLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                    self.section0View.commentCountLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                    self.section0View.commentLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                    self.page ++;
                    if ([dynamicList count] < 10) {
                        self.myTableView.infiniteScrollingView.enabled = NO;
                    }else{
                        self.myTableView.infiniteScrollingView.enabled = YES;
                    }
                }else{
                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
                    la.text = @"已没有更多内容";
                    la.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
                    
                    la.textAlignment = NSTextAlignmentCenter;
                    
                    self.myTableView.tableFooterView = la;

                    self.myTableView.infiniteScrollingView.enabled = NO;
                }
                [self performSelector:@selector(hideFootView) withObject:nil afterDelay:1];

                [self.myTableView.infiniteScrollingView stopAnimating];
            } failure:^(NSError *error) {
                NSLog(@"........%@", error.localizedDescription);
                [self.myTableView.infiniteScrollingView stopAnimating];
            }];
        }else if (self.selectTag == 1){
            
        }else if (self.selectTag == 2){
            
        }else if (self.selectTag == 3){
//            [RSHTTPMANAGER isShowActivity];
            UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
            la.text = @"正在加载更多";
            la.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
            
            la.textAlignment = NSTextAlignmentCenter;
            
            self.myTableView.tableFooterView = la;

            [RSHTTPMANAGER requestUserWithUID:self.uuid WithType:@"following" WithPage:[NSString stringWithFormat:@"%d", self.page] WithSuccess:^(NSArray *userList) {
                if ([userList count]) {
                    [self.squarArr removeAllObjects];
                    [self.squarArr addObjectsFromArray:userList];
                    self.selectIndex = 3;
                    [self.myTableView reloadData];
                    self.section0View.attentionCountLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                    self.section0View.attentionLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
                    self.section0View.dynamicCountLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                    self.section0View.dynamicLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                    self.section0View.desireCountLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];                    self.section0View.desireLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                    self.section0View.recommendCountLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];                    self.section0View.recommendLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                    self.section0View.commentCountLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                    self.section0View.commentLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
                    self.page ++;
                    if ([userList count] < 10) {
                        self.myTableView.infiniteScrollingView.enabled = NO;
                    }else{
                        self.myTableView.infiniteScrollingView.enabled = YES;
                    }
                }else{
                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
                    la.text = @"已没有更多内容";
                    la.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
                    
                    la.textAlignment = NSTextAlignmentCenter;
                    
                    self.myTableView.tableFooterView = la;

                    self.myTableView.infiniteScrollingView.enabled = NO;
                }
                [self performSelector:@selector(hideFootView) withObject:nil afterDelay:1];

                [self.myTableView.infiniteScrollingView stopAnimating];
            } failure:^(NSError *error) {
                NSLog(@"\\\\\\%@",error.localizedDescription);
                [self.myTableView.infiniteScrollingView stopAnimating];
            }];
        }else if (self.selectTag == 4){
            
        }
    }];
    
    [self getData];
    
//    [self.myTableView triggerPullToRefresh];

}
- (void)hideFootView{   
    self.myTableView.tableFooterView = nil;
}

- (CGSize)customLableSizeWithString:(NSString *)str withWidth:(float)width{
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:13];
    CGSize size = CGSizeMake(width, 1000);
    CGSize labelsize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    return labelsize;
}

- (void)section0ViewBtnClick:(id)sender{
    self.myTableView.infiniteScrollingView.enabled = NO;
    UIButton *tmpBtn = (UIButton *)sender;
    self.selectTag = tmpBtn.tag;
    switch (tmpBtn.tag) {
        case 0:{//动态
            self.myTableView.infiniteScrollingView.enabled = YES;
        }
            break;
        case 1:{//愿望
           
        }
            break;
        case 2:{
            
        }
            break;
        case 3:{
            self.myTableView.infiniteScrollingView.enabled = YES;
        }
            break;
        case 4:{
           
        }
            break;
        default:
            break;
    }
//    [self.myTableView triggerPullToRefresh];
    [self getData];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (!self.section0View) {
        self.section0View = (CustomUserInfoTopView *)[[[NSBundle mainBundle] loadNibNamed:@"CustomUserInfoTopView" owner:self options:nil] objectAtIndex:0];
        
        self.section0View.dynamicCountLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
        self.section0View.dynamicLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
        
        [self.section0View.dynamicBtn addTarget:self action:@selector(section0ViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.section0View.desireBt addTarget:self action:@selector(section0ViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.section0View.recommendBt addTarget:self action:@selector(section0ViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.section0View.attentionBtn addTarget:self action:@selector(section0ViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.section0View.commentBtn addTarget:self action:@selector(section0ViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self.section0View;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (selectIndex == 0) {
        SquareModel *square = [self.squarArr objectAtIndex:indexPath.row];
        if (square.content.length) {
            CGSize s = [self customLableSizeWithString:square.content withWidth:240.0];
            return 175 + 5 + s.height;
        }
        return 175.0;
    }else if (selectIndex == 1){
        return 135;
    }else if (selectIndex == 2){
        SquareModel *square = [self.squarArr objectAtIndex:indexPath.row];
        if (square.content.length) {
            CGSize s = [self customLableSizeWithString:square.content withWidth:300];
            return 135 + 5 + s.height;
        }
        return 135;
    }else if (selectIndex == 3){
        return 80;
    }else if (selectIndex == 4){
        SquareModel *square = [self.squarArr objectAtIndex:indexPath.row];
        if (square.content.length) {
            CGSize s = [self customLableSizeWithString:square.content withWidth:320];
            return 135 + 5 + s.height;
        }
        return 135;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.squarArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row];//@"Cell";
    if (selectIndex == 0) {
        //动态
        SquareModel *square = [self.squarArr objectAtIndex:indexPath.row];
//        NSLog(@"...square.event_id.%@", square.event_id);
        MasterCell1 *cell = (MasterCell1 *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"MasterCell1" owner:self options:nil] objectAtIndex:0];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
        [cell.leftUIcon setImageWithURL:[NSURL URLWithString:square.img_path] placeholderImage:[UIImage imageNamed:@"hi"]];
        cell.userName.text = [NSString stringWithFormat:@"%@",square.nick_name];
        cell.userName.font = [UIFont fontWithName:@"Helvetica" size:15];
        cell.userName.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        
        CGSize userNameSize = [square.nick_name sizeWithFont:[UIFont fontWithName:@"Helvetica" size:15]];
        cell.userName.frame = CGRectMake(cell.userName.frame.origin.x, cell.leftUIcon.frame.origin.y, userNameSize.width, userNameSize.height);
        
        NSString *tmp = [NSString stringWithFormat:@"%@",square.like_count_str];
        
        if (tmp.length) {
            if ([tmp intValue] == 0) {
                cell.zanLabel.text = @"赞";
            }else{
                cell.zanLabel.text = [NSString stringWithFormat:@"%d赞",[tmp intValue]];
            }
        }else{
            cell.zanLabel.text = @"赞";
        }
        
        NSString *temp = [NSString stringWithFormat:@"%@",square.response_count_str];
        
        if (temp.length) {
            if ([temp intValue] == 0) {
                cell.respondLabel.text = @"回应";
            }else{
                cell.respondLabel.text = [NSString stringWithFormat:@"%d回应",[temp intValue]];
            }
        }else{
            cell.respondLabel.text = @"回应";
        }
        
        cell.timeLabel.text = [square.create_time substringWithRange:NSMakeRange(5, 11)];
        cell.timeLabel.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
        
        cell.actionTypeNameLable.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];

        if ([square.action_type_id intValue] == 3) {
            [cell.appIcon setImageWithURL:[NSURL URLWithString:square.obj_img_path] placeholderImage:[UIImage imageNamed:@"hi"]];
            cell.actionTypeNameLable.text = square.obj_action_type_name;
            cell.actionTypeNameLable.frame = CGRectMake(cell.userName.frame.origin.x + cell.userName.frame.size.width + 5, cell.leftUIcon.frame.origin.y, cell.actionTypeNameLable.frame.size.width, cell.actionTypeNameLable.frame.size.height);
            cell.appName.text = [NSString stringWithFormat:@"%@",square.obj_nick_name];
            cell.appName.font = [UIFont fontWithName:@"Helvetica" size:15];
            cell.appName.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];

            CGSize sizeOfobjUserName = [square.obj_nick_name sizeWithFont:[UIFont fontWithName:@"Helvetica" size:15]];
            cell.appName.frame = CGRectMake(cell.appName.frame.origin.x, cell.appName.frame.origin.y, sizeOfobjUserName.width, sizeOfobjUserName.height);
            
            cell.objUserLocation.text = [NSString stringWithFormat:@"%@",square.obj_location];
            cell.objUserLocation.textColor = [UIColor colorWithRed:187.0/255 green:187.0/255 blue:187.0/255 alpha:1.0];
            cell.objUserLocation.font = [UIFont fontWithName:@"Helvetica" size:15];
            
          
            
            CGSize sizeOfobjUserLocation = [square.obj_location sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
            cell.objUserLocation.frame = CGRectMake(cell.appName.frame.origin.x + cell.appName.frame.size.width + 5, cell.appName.frame.origin.y, sizeOfobjUserLocation.width, sizeOfobjUserLocation.height);
            if (!square.obj_signature.length) {
                cell.appType.text = @"";
            }else{
                
                cell.appType.font = [UIFont fontWithName:@"Helvetica" size:13];
                CGSize userSigSize = [square.obj_signature sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
                cell.leftYinIV.hidden = NO;
                cell.appType.text = [NSString stringWithFormat:@"%@",square.obj_signature];
                if (userSigSize.width > 150.0) {
                    cell.appType.frame = CGRectMake(cell.leftYinIV.frame.origin.x + cell.leftYinIV.frame.size.width, cell.appType.frame.origin.y, 150.0, userSigSize.height);
                }else{
                    cell.appType.frame = CGRectMake(cell.leftYinIV.frame.origin.x + cell.leftYinIV.frame.size.width, cell.appType.frame.origin.y, userSigSize.width, userSigSize.height);
                }
                cell.rightYinIV.hidden = NO;
                cell.rightYinIV.frame = CGRectMake(cell.appType.frame.origin.x + cell.appType.frame.size.width, cell.rightYinIV.frame.origin.y, 14, 14);

            }
            
            cell.appBtn.hidden = YES;
            cell.zanBackView.hidden = YES;
            cell.respondBackView.hidden = YES;
            cell.zanBtn.hidden = YES;
            cell.userBtn.hidden = YES;
            
            cell.zanLabel.hidden = YES;
            cell.respondLabel.hidden = YES;
            
        }else{
            [cell.appIcon setImageWithURL:[NSURL URLWithString:square.application_artwork_url_small] placeholderImage:[UIImage imageNamed:@"hi"]];
            cell.actionTypeNameLable.text = square.application_action_type_name;
            cell.actionTypeNameLable.frame = CGRectMake(cell.userName.frame.origin.x + cell.userName.frame.size.width + 5, cell.leftUIcon.frame.origin.y, cell.actionTypeNameLable.frame.size.width, cell.actionTypeNameLable.frame.size.height);
            cell.appName.text = [NSString stringWithFormat:@"%@",square.application_title];
            cell.appName.font = [UIFont fontWithName:@"Helvetica" size:15];
            cell.appName.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
            
            cell.appType.text = [NSString stringWithFormat:@"%@ / %@", square.primary_genre_name, square.supported_device_name];
            if ([[NSString stringWithFormat:@"%@",square.application_retail_price] isEqualToString:@"免费"]) {
//                cell.appPric.text = [NSString stringWithFormat:@"%@",square.application_retail_price];
//                cell.appPric.text = [NSString stringWithFormat:@"%@",square.application_retail_price];
                cell.appPric.text = @"免费";
//                [cell.appPriceIV setImage:[UIImage imageNamed:@"apptip1.png"]];
            }else{
                if ([[NSString stringWithFormat:@"%@",square.application_retail_price] integerValue] == 0) {
                    square.application_retail_price = @"免费";
                     cell.appPric.text = @"免费";
//                    [cell.appPriceIV setImage:[UIImage imageNamed:@"apptip1.png"]];
                }else{
                    cell.appPric.text = [NSString stringWithFormat:@"￥%d",[square.application_retail_price integerValue]];
//                    if ([square.application_retail_price floatValue] > [square.application_old_price floatValue]) {
//                        [cell.appPriceIV setImage:[UIImage imageNamed:@"apptip5.png"]];
//                    }else if ([square.application_retail_price floatValue] < [square.application_old_price floatValue]){
//                        [cell.appPriceIV setImage:[UIImage imageNamed:@"apptip3.png"]];
//                    }else{
//                        
//                    }
                }
               
            }
            if ([square.limited_state_name isEqualToString:@"首次限免"]) {
                [cell.appPriceIV setImage:[UIImage imageNamed:@"apptip1.png"]];
            }else if ([square.limited_state_name isEqualToString:@"多次限免"]){
                [cell.appPriceIV setImage:[UIImage imageNamed:@"apptip2.png"]];
            }else if ([square.limited_state_name isEqualToString:@"首次冰点"]){
                [cell.appPriceIV setImage:[UIImage imageNamed:@"apptip3.png"]];
            }else if ([square.limited_state_name isEqualToString:@"再次冰点"]){
                [cell.appPriceIV setImage:[UIImage imageNamed:@"apptip4.png"]];
            }else if ([square.limited_state_name isEqualToString:@"涨价"]){
                [cell.appPriceIV setImage:[UIImage imageNamed:@"apptip5.png"]];
            }
        
            
            cell.appPric.font = [UIFont fontWithName:@"Helvetica" size:15];
            cell.appPric.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
            CGSize priceSize = [cell.appPric.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:15]];
            cell.appPric.frame = CGRectMake(cell.appPric.frame.origin.x, 59, priceSize.width, priceSize.height);
            
            cell.appPric.center = CGPointMake(cell.appPriceIV.center.x, cell.appName.center.y);
            
            
            NSString *countLike = [NSString stringWithFormat:@"%@",square.like_count_str];
            if (countLike.length) {
                if ([countLike intValue] == 0) {
                    cell.zanLabel.text = @"赞";
                }else{
                    cell.zanLabel.text = [NSString stringWithFormat:@"%d赞",[countLike intValue]];
                }
            }else{
                cell.zanLabel.text = @"赞";
            }
            
            
            CGSize sizeOfZan = [cell.zanLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
            cell.zanLabel.frame = CGRectMake(10, 10, sizeOfZan.width, sizeOfZan.height);
            
            cell.zanBackView.frame = CGRectMake(cell.zanBackView.frame.origin.x, cell.zanBackView.frame.origin.y, cell.zanLabel.frame.size.width + 20, cell.zanBackView.frame.size.height);
//            cell.zanBackView.backgroundColor = [UIColor redColor];
            
            
            
            NSString *countResponse = [NSString stringWithFormat:@"%@",square.response_count_str];
            if (countResponse.length) {
                if ([countResponse intValue] == 0) {
                    cell.respondLabel.text = @"回应";
                }else{
                    cell.respondLabel.text = [NSString stringWithFormat:@"%d回应",[countResponse intValue]];
                }
            }else{
                cell.respondLabel.text = @"回应";
            }
            
            CGSize sizeOfResp = [cell.respondLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
            cell.respondLabel.frame = CGRectMake(10, 10, sizeOfResp.width, sizeOfResp.height);
            
            cell.respondBackView.frame = CGRectMake(cell.zanBackView.frame.origin.x + cell.zanBackView.frame.size.width + 10, cell.respondBackView.frame.origin.y, cell.respondLabel.frame.size.width + 20, cell.respondBackView.frame.size.height);            
        }
        
        
        
        
        if (square.content.length) {
            CGSize sss = [self customLableSizeWithString:square.content withWidth:240.0];
            cell.contentLable.frame = CGRectMake(cell.contentLable.frame.origin.x, cell.contentLable.frame.origin.y, cell.contentLable.frame.size.width, sss.height);
            cell.contentLable.text = square.content;
            [cell.contentLable setNumberOfLines:0];
            cell.contentLable.font = [UIFont fontWithName:@"Helvetica" size:13];
            cell.bottomIV.center = CGPointMake(cell.bottomIV.center.x, cell.bottomIV.center.y + sss.height + 5);
            cell.backGroundView.frame = CGRectMake(cell.backGroundView.frame.origin.x, cell.backGroundView.frame.origin.y, cell.backGroundView.frame.size.width, cell.backGroundView.frame.size.height + sss.height + 5);
            cell.customView.frame = CGRectMake(cell.customView.frame.origin.x, cell.customView.frame.origin.y, cell.customView.frame.size.width, cell.customView.frame.size.height + sss.height + 5);
            cell.zanBtn.frame = CGRectMake(cell.zanBtn.frame.origin.x, cell.zanBtn.frame.origin.y + sss.height + 5, cell.zanBtn.frame.size.width, cell.zanBtn.frame.size.height);
        }
        
        cell.backGroundView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
        cell.respondBackView.backgroundColor = cell.zanBackView.backgroundColor = cell.centerView.backgroundColor = [UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1.0];
        
        cell.userName.center = CGPointMake(cell.userName.center.x, cell.actionTypeNameLable.center.y);
        
        [cell.customView setIndex:indexPath.row];
        cell.customView.delegate = self;
        
        [cell.appBtn addTarget:self action:@selector(appBtnClick: event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.zanBtn addTarget:self action:@selector(zanBtnClick: event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.userBtn addTarget:self action:@selector(userBtnClick: event:) forControlEvents:UIControlEventTouchUpInside];
        return cell;

    }else if (selectIndex == 1){
        WantModel *want = [self.squarArr objectAtIndex:indexPath.row];
        WishCell *cell = (WishCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"WishCell" owner:self options:nil] objectAtIndex:0];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
        [cell.appBtn addTarget:self action:@selector(appBtnClick: event:) forControlEvents:UIControlEventTouchUpInside];
        cell.appBtn.frame = CGRectMake(0, 0, 320, 60);
        
        [cell.appIcon setImageWithURL:[NSURL URLWithString:want.application_artwork_url_small] placeholderImage:[UIImage imageNamed:@"hi"]];
        cell.appName.text = want.application_title;
        cell.appName.font = [UIFont fontWithName:@"Helvetica" size:15];
        CGSize sizeOfName = [cell.appName.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:15]];
        cell.appName.frame = CGRectMake(cell.appName.frame.origin.x, cell.appName.frame.origin.y, sizeOfName.width, sizeOfName.height);
        if (cell.appName.frame.size.width > 180.0) {
            cell.appName.frame = CGRectMake(cell.appName.frame.origin.x, cell.appName.frame.origin.y, 180, sizeOfName.height);
            
        }
        
        cell.appName.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        
        cell.appType.text = [NSString stringWithFormat:@"%@ / %@",want.primary_genre_name, want.supported_device_name];
        cell.appType.font = [UIFont fontWithName:@"Helvetica" size:13];
        cell.appType.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
       
//        CGSize sizeOfZan = [cell.zanLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
//        cell.zanLabel.frame = CGRectMake(10, 10, sizeOfZan.width, sizeOfZan.height);

//        NSString *countLike = [NSString stringWithFormat:@"%@",want.like_count_str];
//        if (countLike.length) {
//            if ([countLike intValue] == 0) {
//                cell.zanLabel.text = @"赞";
//            }else{
//                cell.zanLabel.text = [NSString stringWithFormat:@"%d赞",[countLike intValue]];
//                   cell.zanBackIV.frame = CGRectMake(cell.zanBackIV.frame.origin.x, cell.zanBackIV.frame.origin.y, cell.zanLabel.frame.size.width + 20, cell.zanBackIV.frame.size.height);
//            }
//        }else{
//            cell.zanLabel.text = @"赞";
//        }
//        
//        
//        
//     
//        
//        
//        
//        
//        NSString *countResponse = [NSString stringWithFormat:@"%@",want.response_count_str];
//        if (countResponse.length) {
//            if ([countResponse intValue] == 0) {
//                cell.respondeLabel.text = @"回应";
//            }else{
//                cell.respondeLabel.text = [NSString stringWithFormat:@"%d回应",[countResponse intValue]];
//            }
//        }else{
//            cell.respondeLabel.text = @"回应";
//        }
//        
//        
//        
//        CGSize sizeOfResp = [cell.respondeLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
//        cell.respondeLabel.frame = CGRectMake(10, 10, sizeOfResp.width, sizeOfResp.height);
//        
//        cell.responserBackIV.frame = CGRectMake(cell.zanBackIV.frame.origin.x + cell.zanBackIV.frame.size.width + 10, cell.responserBackIV.frame.origin.y, cell.respondeLabel.frame.size.width + 20, cell.responserBackIV.frame.size.height);
//        

        
        NSString *countLike = [NSString stringWithFormat:@"%@",want.like_count_str];
        if (countLike.length) {
            if ([countLike intValue] == 0) {
                cell.zanLabel.text = @"赞";
            }else{
                cell.zanLabel.text = [NSString stringWithFormat:@"%d赞",[countLike intValue]];
            }
        }else{
            cell.zanLabel.text = @"赞";
        }
        
        cell.zanLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
        cell.zanLabel.textColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
        CGSize sizeOfZan = [cell.zanLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
        cell.zanLabel.frame = CGRectMake(10, 10, sizeOfZan.width, sizeOfZan.height);
        
        cell.zanBackIV.frame = CGRectMake(cell.zanBackIV.frame.origin.x, cell.zanBackIV.frame.origin.y, cell.zanLabel.frame.size.width + 20, cell.zanBackIV.frame.size.height);
//        cell.zanBackIV.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
        
        
        
        
        NSString *countResponse = [NSString stringWithFormat:@"%@",want.response_count_str];
        if (countResponse.length) {
            if ([countResponse intValue] == 0) {
                cell.respondeLabel.text = @"回应";
            }else{
                cell.respondeLabel.text = [NSString stringWithFormat:@"%d回应",[countResponse intValue]];
            }
        }else{
            cell.respondeLabel.text = @"回应";
        }
        
        
        cell.respondeLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
        cell.respondeLabel.textColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];

        CGSize sizeOfResp = [cell.respondeLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
        cell.respondeLabel.frame = CGRectMake(10, 10, sizeOfResp.width, sizeOfResp.height);
        
        cell.responserBackIV.frame = CGRectMake(cell.zanBackIV.frame.origin.x + cell.zanBackIV.frame.size.width + 10, cell.responserBackIV.frame.origin.y, cell.respondeLabel.frame.size.width + 20, cell.responserBackIV.frame.size.height);
        
        

        
        if ([[NSString stringWithFormat:@"%@",want.application_retail_price] isEqualToString:@"免费"]) {
            cell.appPrice.text = [NSString stringWithFormat:@"%@",want.application_retail_price];
//            [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip1.png"]];
             cell.appPrice.text = @"免费";
        }else{
            if ([[NSString stringWithFormat:@"%@",want.application_retail_price] integerValue] == 0) {
                want.application_retail_price = @"免费";
                 cell.appPrice.text = @"免费";
//                [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip1.png"]];

            }else{
//                want.application_retail_price = [want.application_retail_price stringByReplacingOccurrencesOfString:@".00000" withString:@""];
                cell.appPrice.text = [NSString stringWithFormat:@"￥%d",[want.application_retail_price integerValue]];
//                if ([want.application_retail_price floatValue] > [want.application_old_price floatValue]) {
//                    [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip5.png"]];
//                }else if ([want.application_retail_price floatValue] < [want.application_old_price floatValue]){
//                    [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip3.png"]];
//                }else{
//                    
//                }
            }
        }
        if ([want.limitedStateName isEqualToString:@"首次限免"]) {
            [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip1.png"]];
        }else if ([want.limitedStateName isEqualToString:@"多次限免"]){
            [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip2.png"]];
        }else if ([want.limitedStateName isEqualToString:@"首次冰点"]){
            [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip3.png"]];
        }else if ([want.limitedStateName isEqualToString:@"再次冰点"]){
            [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip4.png"]];
        }else if ([want.limitedStateName isEqualToString:@"涨价"]){
            [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip5.png"]];
        }
        
        
        cell.appPrice.font = [UIFont fontWithName:@"Helvetica" size:15];
        cell.appPrice.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        CGSize priceSize = [cell.appPrice.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:15]];
        cell.appPrice.frame = CGRectMake(cell.appPrice.frame.origin.x, 59, priceSize.width, priceSize.height);
        
        cell.appPrice.center = CGPointMake(cell.appPriveIV.center.x, cell.appName.center.y);

        
        
        [cell.zanBtn addTarget:self action:@selector(zanBtnClick: event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.customView setIndex:indexPath.row];
        cell.customView.delegate = self;
        
//        cell.timeLabel.text = [want.create_time substringWithRange:NSMakeRange(5, 11)];
        cell.timeLabel.text = [want.create_time substringWithRange:NSMakeRange(5, 11)];
        cell.timeLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
        cell.timeLabel.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
//        cell.respondBackView.backgroundColor = cell.zanBackView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
//        cell.appBtn.hidden = YES;
        
        return cell;
        
    }else if (selectIndex == 2){
        SquareModel *square = [self.squarArr objectAtIndex:indexPath.row];
        
        WishCell *cell = (WishCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"WishCell" owner:self options:nil] objectAtIndex:0];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        NSString *countLike = [NSString stringWithFormat:@"%@",square.like_count_str];
 
        if (countLike.length) {
            if ([countLike intValue] == 0) {
                cell.zanLabel.text = @"赞";
            }else{
                cell.zanLabel.text = [NSString stringWithFormat:@"%d赞",[countLike intValue]];
            }
        }else{
            cell.zanLabel.text = @"赞";
        }
        
        
        cell.zanLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
        cell.zanLabel.textColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];

        CGSize sizeOfZan = [cell.zanLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
        cell.zanLabel.frame = CGRectMake(10, 10, sizeOfZan.width, sizeOfZan.height);
        
        cell.zanBackIV.frame = CGRectMake(cell.zanBackIV.frame.origin.x, cell.zanBackIV.frame.origin.y, cell.zanLabel.frame.size.width + 20, cell.zanBackIV.frame.size.height);
        
        

        NSString *countResponse = [NSString stringWithFormat:@"%@",square.response_count_str];
        if (countResponse.length) {
            if ([countResponse intValue] == 0) {
                cell.respondeLabel.text = @"回应";
            }else{
                cell.respondeLabel.text = [NSString stringWithFormat:@"%d回应",[countResponse intValue]];
            }
        }else{
            cell.respondeLabel.text = @"回应";
        }
        
        
        cell.respondeLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
        cell.respondeLabel.textColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
        
        CGSize sizeOfResp = [cell.respondeLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
        cell.respondeLabel.frame = CGRectMake(10, 10, sizeOfResp.width, sizeOfResp.height);
        
        cell.responserBackIV.frame = CGRectMake(cell.zanBackIV.frame.origin.x + cell.zanBackIV.frame.size.width + 10, cell.responserBackIV.frame.origin.y, cell.respondeLabel.frame.size.width + 20, cell.responserBackIV.frame.size.height);
        
        

        
        [cell.appIcon setImageWithURL:[NSURL URLWithString:square.application_artwork_url_small] placeholderImage:[UIImage imageNamed:@"hi"]];
        cell.appName.text = square.application_title;
        cell.appName.font = [UIFont fontWithName:@"Helvetica" size:15];
        
        
        
        CGSize sizeOfName = [cell.appName.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:15]];
        if (sizeOfName.width > 170) {
            cell.appName.frame = CGRectMake(cell.appName.frame.origin.x, cell.appName.frame.origin.y, 170, sizeOfName.height);
        }else{
            cell.appName.frame = CGRectMake(cell.appName.frame.origin.x, cell.appName.frame.origin.y, sizeOfName.width, sizeOfName.height);
        }

        cell.appName.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];

        cell.appType.text = [NSString stringWithFormat:@"%@ / %@",square.primary_genre_name, square.supported_device_name];
        cell.appType.font = [UIFont fontWithName:@"Helvetica" size:13];
        cell.appType.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];

        if ([[NSString stringWithFormat:@"%@",square.application_retail_price] isEqualToString:@"免费"]) {
            cell.appPrice.text = [NSString stringWithFormat:@"%@",square.application_retail_price];
//            [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip1.png"]];
        }else{
            if ([[NSString stringWithFormat:@"%@",square.application_retail_price] integerValue] == 0) {
                square.application_retail_price = @"免费";
                 cell.appPrice.text = @"免费";
//                [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip1.png"]];

            }else{
//                square.application_retail_price = [square.application_retail_price stringByReplacingOccurrencesOfString:@".00000" withString:@""];
                cell.appPrice.text = [NSString stringWithFormat:@"￥%d",[square.application_retail_price integerValue]];
//                if ([square.application_retail_price floatValue] > [square.application_old_price floatValue]) {
//                    [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip5.png"]];
//                }else if ([square.application_retail_price floatValue] < [square.application_old_price floatValue]){
//                    [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip3.png"]];
//                }else{
//                    
//                }
            }
        }
        if ([square.limited_state_name isEqualToString:@"首次限免"]) {
            [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip1.png"]];
        }else if ([square.limited_state_name isEqualToString:@"多次限免"]){
            [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip2.png"]];
        }else if ([square.limited_state_name isEqualToString:@"首次冰点"]){
            [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip3.png"]];
        }else if ([square.limited_state_name isEqualToString:@"再次冰点"]){
            [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip4.png"]];
        }else if ([square.limited_state_name isEqualToString:@"涨价"]){
            [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip5.png"]];
        }
        
        
        cell.appPrice.font = [UIFont fontWithName:@"Helvetica" size:15];
        cell.appPrice.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        CGSize priceSize = [cell.appPrice.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:15]];
        cell.appPrice.frame = CGRectMake(cell.appPrice.frame.origin.x, 59, priceSize.width, priceSize.height);
        
        cell.appPrice.center = CGPointMake(cell.appPriveIV.center.x, cell.appName.center.y);
        
        

        
        
        
        if (square.content.length) {
            CGSize sss = [self customLableSizeWithString:square.content withWidth:300.0];
            cell.contentLabel.frame = CGRectMake(cell.contentLabel.frame.origin.x, cell.contentLabel.frame.origin.y, cell.contentLabel.frame.size.width, sss.height);
            cell.contentLabel.text = square.content;
            cell.contentLabel.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
            [cell.contentLabel setNumberOfLines:0];
            cell.contentLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
            cell.bottomView.frame = CGRectMake(cell.bottomView.frame.origin.x, cell.bottomView.frame.origin.y  + sss.height + 5, cell.bottomView.frame.size.width, cell.bottomView.frame.size.height);
            cell.backGroundView.frame = CGRectMake(cell.backGroundView.frame.origin.x, cell.backGroundView.frame.origin.y, cell.backGroundView.frame.size.width, cell.backGroundView.frame.size.height + sss.height + 5);
            cell.customView.frame = CGRectMake(cell.customView.frame.origin.x, cell.customView.frame.origin.y, cell.customView.frame.size.width, cell.customView.frame.size.height + sss.height + 5);
            cell.zanBtn.frame = CGRectMake(cell.zanBtn.frame.origin.x, cell.zanBtn.frame.origin.y  + sss.height + 5, cell.zanBtn.frame.size.width, cell.zanBtn.frame.size.height);
        }
//        cell.respondBackView.backgroundColor = cell.zanBackView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];

        
        
        
        
        
        
        cell.timeLabel.text = [square.create_time substringWithRange:NSMakeRange(5, 11)];
        cell.timeLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
        cell.timeLabel.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];

        [cell.customView setIndex:indexPath.row];
        cell.customView.delegate = self;
        cell.appBtn.hidden = YES;
        [cell.zanBtn addTarget:self action:@selector(zanBtnClick: event:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }else if (selectIndex == 3){
        UserModel *user = [self.squarArr objectAtIndex:indexPath.row];
        AttentionCell *cell = (AttentionCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"AttentionCell" owner:self options:nil] objectAtIndex:0];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
        cell.userName.text = user.nick_name;
        cell.userName.font = [UIFont fontWithName:@"Helvetica" size:15];
        cell.userName.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];

        CGSize userNameSize = [user.nick_name sizeWithFont:[UIFont fontWithName:@"Helvetica" size:15]];
        cell.userName.frame = CGRectMake(cell.userName.frame.origin.x, cell.userName.frame.origin.y, userNameSize.width, userNameSize.height);
        cell.usertLocation.text = user.details;
        cell.usertLocation.font = [UIFont fontWithName:@"Helvetica" size:15];
        cell.usertLocation.textColor = [UIColor colorWithRed:187.0/255 green:187.0/255 blue:187.0/255 alpha:1.0];

        CGSize userLocationSize = [user.details sizeWithFont:[UIFont fontWithName:@"Helvetica" size:15]];
        cell.usertLocation.frame = CGRectMake(cell.userName.frame.origin.x + cell.userName.frame.size.width + 5, cell.userName.frame.origin.y, userLocationSize.width, userLocationSize.height);
        
        if (user.signature.length) {
            cell.userSignature.font = [UIFont fontWithName:@"Helvetica" size:13];
            cell.userSignature.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];

            CGSize userSigSize = [user.signature sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
            cell.leftYinIV.hidden = NO;
            cell.userSignature.text = [NSString stringWithFormat:@"%@",user.signature];
           
            if (userSigSize.width > 190.0) {
                cell.userSignature.frame = CGRectMake(cell.leftYinIV.frame.origin.x + cell.leftYinIV.frame.size.width, cell.userSignature.frame.origin.y, 190.0, userSigSize.height);
            }else{
                cell.userSignature.frame = CGRectMake(cell.leftYinIV.frame.origin.x + cell.leftYinIV.frame.size.width, cell.userSignature.frame.origin.y, userSigSize.width, userSigSize.height);
            }
            cell.rightYinIV.hidden = NO;
            cell.rightYinIV.frame = CGRectMake(cell.userSignature.frame.origin.x + cell.userSignature.frame.size.width, cell.rightYinIV.frame.origin.y, 14, 14);
            
            
            
        }else{
            cell.userSignature.text = @"";
        }
//        CGSize userSignatureSize = [user.signature sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
//        cell.userSignature.frame = CGRectMake(cell.userSignature.frame.origin.x, cell.userSignature.frame.origin.y, userSignatureSize.width, userSignatureSize.height);

        cell.userName.center = CGPointMake(cell.userName.center.x, 22);
        cell.usertLocation.center = CGPointMake(cell.usertLocation.center.x, 22);
        
        
        [cell.userIcon setImageWithURL:[NSURL URLWithString:user.img_path] placeholderImage:[UIImage imageNamed:@"hi"]];
        [cell.customView setIndex:indexPath.row];
        cell.customView.delegate = self;
        return cell;

    }else if (selectIndex == 4){
        SquareModel *square = [self.squarArr objectAtIndex:indexPath.row];
        
        WishCell *cell = (WishCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"WishCell" owner:self options:nil] objectAtIndex:0];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
//        if (square.application_remind_count.length) {
//            if ([square.application_remind_count intValue] == 0) {
//                cell.zanLabel.text = @"赞";
//            }else{
//                cell.zanLabel.text = [NSString stringWithFormat:@"%@赞",square.application_remind_count];
//            }
//        }else{
//            cell.zanLabel.text = @"赞";
//        }
        
        NSString *countLike = [NSString stringWithFormat:@"%@",square.like_count_str];
        
        if (countLike.length) {
            if ([countLike intValue] == 0) {
                cell.zanLabel.text = @"赞";
            }else{
                cell.zanLabel.text = [NSString stringWithFormat:@"%d赞",[countLike intValue]];
            }
        }else{
            cell.zanLabel.text = @"赞";
        }
        
        
        cell.zanLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
        cell.zanLabel.textColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
        
        CGSize sizeOfZan = [cell.zanLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
        cell.zanLabel.frame = CGRectMake(10, 10, sizeOfZan.width, sizeOfZan.height);
        
        cell.zanBackIV.frame = CGRectMake(cell.zanBackIV.frame.origin.x, cell.zanBackIV.frame.origin.y, cell.zanLabel.frame.size.width + 20, cell.zanBackIV.frame.size.height);
        
        
        
        NSString *countResponse = [NSString stringWithFormat:@"%@",square.response_count_str];
        if (countResponse.length) {
            if ([countResponse intValue] == 0) {
                cell.respondeLabel.text = @"回应";
            }else{
                cell.respondeLabel.text = [NSString stringWithFormat:@"%d回应",[countResponse intValue]];
            }
        }else{
            cell.respondeLabel.text = @"回应";
        }
        
        
        cell.respondeLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
        cell.respondeLabel.textColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
        
        CGSize sizeOfResp = [cell.respondeLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
        cell.respondeLabel.frame = CGRectMake(10, 10, sizeOfResp.width, sizeOfResp.height);
        
        cell.responserBackIV.frame = CGRectMake(cell.zanBackIV.frame.origin.x + cell.zanBackIV.frame.size.width + 10, cell.responserBackIV.frame.origin.y, cell.respondeLabel.frame.size.width + 20, cell.responserBackIV.frame.size.height);
        
        
        [cell.appIcon setImageWithURL:[NSURL URLWithString:square.application_artwork_url_small] placeholderImage:[UIImage imageNamed:@"hi"]];
        cell.appName.text = square.application_title;
        cell.appName.font = [UIFont fontWithName:@"Helvetica" size:15];
        
        cell.appType.text = [NSString stringWithFormat:@"%@ / %@",square.primary_genre_name, square.supported_device_name];
        CGSize sizeOfName = [cell.appName.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:15]];
        cell.appName.frame = CGRectMake(cell.appName.frame.origin.x, cell.appIcon.frame.origin.y, sizeOfName.width, sizeOfName.height);
        
        cell.appName.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];

        
        if (cell.appName.frame.size.width > 180.0) {
            cell.appName.frame = CGRectMake(cell.appName.frame.origin.x, cell.appName.frame.origin.y, 180, cell.appName.frame.size.height);

        }
        
        
        
        
        if ([[NSString stringWithFormat:@"%@",square.application_retail_price] isEqualToString:@"免费"]) {
//            cell.appPrice.text = [NSString stringWithFormat:@"%@",square.application_retail_price];
//            [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip1.png"]];
             cell.appPrice.text = @"免费";
            
        }else{
            if ([[NSString stringWithFormat:@"%@",square.application_retail_price] integerValue] == 0) {
                square.application_retail_price = @"免费";
                cell.appPrice.text = @"免费";
//                [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip1.png"]];

            }else{
//                square.application_retail_price = [square.application_retail_price stringByReplacingOccurrencesOfString:@".00000" withString:@""];
                cell.appPrice.text = [NSString stringWithFormat:@"￥%d",[square.application_retail_price integerValue]];
//                if ([square.application_retail_price floatValue] > [square.application_old_price floatValue]) {
//                    [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip5.png"]];
//                }else if ([square.application_retail_price floatValue] < [square.application_old_price floatValue]){
//                    [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip3.png"]];
//                }else{
//                    
//                }
            }
        }
        
        if ([square.limited_state_name isEqualToString:@"首次限免"]) {
            [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip1.png"]];
        }else if ([square.limited_state_name isEqualToString:@"多次限免"]){
            [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip2.png"]];
        }else if ([square.limited_state_name isEqualToString:@"首次冰点"]){
            [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip3.png"]];
        }else if ([square.limited_state_name isEqualToString:@"再次冰点"]){
            [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip4.png"]];
        }else if ([square.limited_state_name isEqualToString:@"涨价"]){
            [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip5.png"]];
        }
        
        
        cell.appPrice.font = [UIFont fontWithName:@"Helvetica" size:15];
        cell.appPrice.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        CGSize priceSize = [cell.appPrice.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:15]];
        cell.appPrice.frame = CGRectMake(cell.appPrice.frame.origin.x, 59, priceSize.width, priceSize.height);
        
        cell.appPrice.center = CGPointMake(cell.appPriveIV.center.x, cell.appName.center.y);
        
        
        if (square.content.length) {
            CGSize sss = [self customLableSizeWithString:square.content withWidth:300.0];
            cell.contentLabel.frame = CGRectMake(cell.contentLabel.frame.origin.x, cell.contentLabel.frame.origin.y, cell.contentLabel.frame.size.width, sss.height);
            cell.contentLabel.text = square.content;
            [cell.contentLabel setNumberOfLines:0];
            cell.contentLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
            cell.bottomView.frame = CGRectMake(cell.bottomView.frame.origin.x, cell.bottomView.frame.origin.y  + sss.height + 5, cell.bottomView.frame.size.width, cell.bottomView.frame.size.height);
            cell.backGroundView.frame = CGRectMake(cell.backGroundView.frame.origin.x, cell.backGroundView.frame.origin.y, cell.backGroundView.frame.size.width, cell.backGroundView.frame.size.height + sss.height + 5);
            cell.customView.frame = CGRectMake(cell.customView.frame.origin.x, cell.customView.frame.origin.y, cell.customView.frame.size.width, cell.customView.frame.size.height + sss.height + 5);
            cell.zanBtn.frame = CGRectMake(cell.zanBtn.frame.origin.x, cell.zanBtn.frame.origin.y  + sss.height + 5, cell.zanBtn.frame.size.width, cell.zanBtn.frame.size.height);

        }
        
        cell.timeLabel.text = [square.create_time substringWithRange:NSMakeRange(5, 11)];
        [cell.customView setIndex:indexPath.row];
        cell.customView.delegate = self;
        [cell.zanBtn addTarget:self action:@selector(zanBtnClick: event:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }
}


- (void)userBtnClick:(id)sender event:(id)event{
    //LeftUser
    NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.myTableView];
    NSIndexPath *indexPath =[self.myTableView indexPathForRowAtPoint:currentTouchPosition];
    NSLog(@"User///,%d",indexPath.row);
    SquareModel *sql = [self.squarArr objectAtIndex:indexPath.row];
    NSLog(@"....User...ID.....:%@",sql.uid);
    UserRootViewController *vc = [[UserRootViewController alloc] init];
    vc.uuid = [NSString stringWithFormat:@"%@",sql.uid];
    [self.navigationController pushViewController:vc animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];
    
}

- (void)appBtnClick:(id)sender event:(id)event{
    //Center user / app
    NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.myTableView];
    NSIndexPath *indexPath =[self.myTableView indexPathForRowAtPoint:currentTouchPosition];
    NSLog(@"app///,%d",indexPath.row);
    if (selectIndex == 0) {
        SquareModel *square = [self.squarArr objectAtIndex:indexPath.row];
        if ([square.action_type_id intValue] == 3){
            UserRootViewController *uvc = [[UserRootViewController alloc] init];
            uvc.uuid = [NSString stringWithFormat:@"%@",square.obj_uid];
            
            [self.navigationController pushViewController:uvc animated:YES];
        }else{
            AppsDetailsViewController *appsVc = [[AppsDetailsViewController alloc] init];
            appsVc.application_id = square.application_id;
            appsVc.sqModel = square;
            [appsVc.sqModel setApplication_retail_price:[NSString stringWithFormat:@"%d",[square.application_retail_price integerValue]]];
            
            [self.navigationController pushViewController:appsVc animated:YES];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];

    }else if (selectIndex == 1){
        SquareModel *sql = [[SquareModel alloc] init];
        WantModel *square = [self.squarArr objectAtIndex:indexPath.row];

        AppsDetailsViewController *appsVc = [[AppsDetailsViewController alloc] init];
        [appsVc setApplication_id:square.application_id];
        [sql setApplication_artwork_url_small:square.application_artwork_url_small];
        [sql setApplication_title:square.application_title];
        [sql setPrimary_genre_name:square.primary_genre_name];
        [sql setSupported_device_name:square.supported_device_name];
        NSLog(@"square.limitedStateName:%@",square.limitedStateName);
        [sql setApplication_retail_price:[NSString stringWithFormat:@"%d",[square.application_retail_price integerValue]]];
        [sql setLimited_state_name:square.limitedStateName];
        appsVc.sqModel = sql;
        appsVc.application_id = square.application_id;
        [self.navigationController pushViewController:appsVc animated:YES];

    }
    
//    if (IS_IPHONE5) {
//        appsVc = [appsVc initWithNibName:@"AppsDetailsViewController_iPhone5" bundle:nil];
//    }else{
//        appsVc = [appsVc initWithNibName:@"AppsDetailsViewController_Normal" bundle:nil];
//    }
}

- (void)zanBtnClick:(id)sender event:(id)event{
    //zan
    NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.myTableView];
    NSIndexPath *indexPath =[self.myTableView indexPathForRowAtPoint:currentTouchPosition];
    NSLog(@"Zan///,%d",indexPath.row);
    
    if (selectIndex == 0) {
        SquareModel *square = [self.squarArr objectAtIndex:indexPath.row];
        
        NSString *tmp = [NSString stringWithFormat:@"%@",square.is_like];
        
        if ([tmp boolValue]) {
            [RSHTTPMANAGER showActivityView:YES];
            [RSHTTPMANAGER requestUnZanWithEvent_id:square.event_id WithUid:self.currentUID WithSuccess:^(BOOL isSuccess) {
                if (isSuccess) {
                    square.is_like = @"0";
                    MasterCell1 *cell = (MasterCell1 *)[self.myTableView cellForRowAtIndexPath:indexPath];
                    
                    int amount = [[NSString stringWithFormat:@"%@",square.like_count_str] integerValue] ;
                    amount --;
                    if (amount < 0) {
                        amount = 0;
                    }
                    square.like_count_str = [NSString stringWithFormat:@"%d", amount];
                    //            cell.zanLabel.text = [NSString stringWithFormat:@"%@赞",square.application_remind_count];
                    
                    
                    NSString *countLike = [NSString stringWithFormat:@"%@",square.like_count_str];
                    if (countLike.length) {
                        if ([countLike intValue] == 0) {
                            cell.zanLabel.text = @"赞";
                        }else{
                            cell.zanLabel.text = [NSString stringWithFormat:@"%d赞",[countLike intValue]];
                        }
                    }else{
                        cell.zanLabel.text = @"赞";
                    }
                    
                    
                    CGSize sizeOfZan = [cell.zanLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                    cell.zanLabel.frame = CGRectMake(10, 10, sizeOfZan.width, sizeOfZan.height);
                    
                    cell.zanBackView.frame = CGRectMake(cell.zanBackView.frame.origin.x, cell.zanBackView.frame.origin.y, cell.zanLabel.frame.size.width + 20, cell.zanBackView.frame.size.height);
                    
                    
                    
                    
                    NSString *countResponse = [NSString stringWithFormat:@"%@",square.response_count_str];
                    if (countResponse.length) {
                        if ([countResponse intValue] == 0) {
                            cell.respondLabel.text = @"回应";
                        }else{
                            cell.respondLabel.text = [NSString stringWithFormat:@"%d回应",[countResponse intValue]];
                        }
                    }else{
                        cell.respondLabel.text = @"回应";
                    }
                    
                    
                    
                    CGSize sizeOfResp = [cell.respondLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                    cell.respondLabel.frame = CGRectMake(10, 10, sizeOfResp.width, sizeOfResp.height);
                    
                    cell.respondBackView.frame = CGRectMake(cell.zanBackView.frame.origin.x + cell.zanBackView.frame.size.width + 10, cell.respondBackView.frame.origin.y, cell.respondLabel.frame.size.width + 20, cell.respondBackView.frame.size.height);
                    
//                    [SVProgressHUD showSuccessWithStatus:@"取消赞成功"];
                    
                }else{
//                    [SVProgressHUD showErrorWithStatus:@"取消赞失败"];
                    
                }
                
            } failure:^(NSError *error) {
                
            }];
            
        }else{
            [RSHTTPMANAGER requestZanWithEvent_id:square.event_id WithUid:self.currentUID WithSuccess:^(BOOL isSuccess) {
                if (isSuccess) {
                    square.is_like = @"1";
                    MasterCell1 *cell = (MasterCell1 *)[self.myTableView cellForRowAtIndexPath:indexPath];
                    
                    int amount = [[NSString stringWithFormat:@"%@",square.like_count_str] integerValue] ;
                    amount ++;
                    square.like_count_str = [NSString stringWithFormat:@"%d", amount];
                    //            cell.zanLabel.text = [NSString stringWithFormat:@"%@赞",square.application_remind_count];
                    
                    
                    NSString *countLike = [NSString stringWithFormat:@"%@",square.like_count_str];
                    if (countLike.length) {
                        if ([countLike intValue] == 0) {
                            cell.zanLabel.text = @"赞";
                        }else{
                            cell.zanLabel.text = [NSString stringWithFormat:@"%d赞",[countLike intValue]];
                        }
                    }else{
                        cell.zanLabel.text = @"赞";
                    }
                    
                    
                    CGSize sizeOfZan = [cell.zanLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                    cell.zanLabel.frame = CGRectMake(10, 10, sizeOfZan.width, sizeOfZan.height);
                    
                    cell.zanBackView.frame = CGRectMake(cell.zanBackView.frame.origin.x, cell.zanBackView.frame.origin.y, cell.zanLabel.frame.size.width + 20, cell.zanBackView.frame.size.height);
                    
                    
                    
                    
                    NSString *countResponse = [NSString stringWithFormat:@"%@",square.response_count_str];
                    if (countResponse.length) {
                        if ([countResponse intValue] == 0) {
                            cell.respondLabel.text = @"回应";
                        }else{
                            cell.respondLabel.text = [NSString stringWithFormat:@"%d回应",[countResponse intValue]];
                        }
                    }else{
                        cell.respondLabel.text = @"回应";
                    }
                    
                    
                    
                    CGSize sizeOfResp = [cell.respondLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                    cell.respondLabel.frame = CGRectMake(10, 10, sizeOfResp.width, sizeOfResp.height);
                    
                    cell.respondBackView.frame = CGRectMake(cell.zanBackView.frame.origin.x + cell.zanBackView.frame.size.width + 10, cell.respondBackView.frame.origin.y, cell.respondLabel.frame.size.width + 20, cell.respondBackView.frame.size.height);
                    
                    
                    
                    
                    
//                    [SVProgressHUD showSuccessWithStatus:@"赞成功"];
                }else{
//                    [SVProgressHUD showErrorWithStatus:@"请不要重复赞"];
                }
            } failure:^(NSError *error) {
                NSLog(@"..222222222.....%@",error.localizedDescription);
            }];
            
        }
    }else if (selectIndex == 1){
        WantModel *want = [self.squarArr objectAtIndex:indexPath.row];
        
        NSString *tmp = [NSString stringWithFormat:@"%@",want.is_like];
        
        if ([tmp boolValue]) {
            [RSHTTPMANAGER showActivityView:YES];
            [RSHTTPMANAGER requestUnZanWithEvent_id:want.event_id WithUid:self.currentUID WithSuccess:^(BOOL isSuccess) {
                if (isSuccess) {
                    want.is_like = @"0";
                    WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:indexPath];
                    
                    int amount = [[NSString stringWithFormat:@"%@",want.like_count_str] integerValue] ;
                    amount --;
                    if (amount < 0) {
                        amount = 0;
                    }
                    want.like_count_str = [NSString stringWithFormat:@"%d", amount];
                    //            cell.zanLabel.text = [NSString stringWithFormat:@"%@赞",square.application_remind_count];
                    
                    
                    NSString *countLike = [NSString stringWithFormat:@"%@",want.like_count_str];
                    if (countLike.length) {
                        if ([countLike intValue] == 0) {
                            cell.zanLabel.text = @"赞";
                        }else{
                            cell.zanLabel.text = [NSString stringWithFormat:@"%d赞",[countLike intValue]];
                        }
                    }else{
                        cell.zanLabel.text = @"赞";
                    }
                    
                    
                    CGSize sizeOfZan = [cell.zanLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                    cell.zanLabel.frame = CGRectMake(10, 10, sizeOfZan.width, sizeOfZan.height);
                    
                    cell.zanBackIV.frame = CGRectMake(cell.zanBackIV.frame.origin.x, cell.zanBackIV.frame.origin.y, cell.zanLabel.frame.size.width + 20, cell.zanBackIV.frame.size.height);
                    
                    
                    
                    
                    NSString *countResponse = [NSString stringWithFormat:@"%@",want.response_count_str];
                    if (countResponse.length) {
                        if ([countResponse intValue] == 0) {
                            cell.respondeLabel.text = @"回应";
                        }else{
                            cell.respondeLabel.text = [NSString stringWithFormat:@"%d回应",[countResponse intValue]];
                        }
                    }else{
                        cell.respondeLabel.text = @"回应";
                    }
                    
                    
                    
                    CGSize sizeOfResp = [cell.respondeLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                    cell.respondeLabel.frame = CGRectMake(10, 10, sizeOfResp.width, sizeOfResp.height);
                    
                    cell.responserBackIV.frame = CGRectMake(cell.zanBackIV.frame.origin.x + cell.zanBackIV.frame.size.width + 10, cell.responserBackIV.frame.origin.y, cell.respondeLabel.frame.size.width + 20, cell.responserBackIV.frame.size.height);
                    
//                    [SVProgressHUD showSuccessWithStatus:@"取消赞成功"];
                    
                }else{
//                    [SVProgressHUD showErrorWithStatus:@"取消赞失败"];
                    
                }
                
            } failure:^(NSError *error) {
                
            }];
            
        }else{
            [RSHTTPMANAGER requestZanWithEvent_id:want.event_id WithUid:self.currentUID WithSuccess:^(BOOL isSuccess) {
                if (isSuccess) {
                    want.is_like = @"1";
                    WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:indexPath];
                    
                    int amount = [[NSString stringWithFormat:@"%@",want.like_count_str] integerValue] ;
                    amount ++;
                    want.like_count_str = [NSString stringWithFormat:@"%d", amount];
                    //            cell.zanLabel.text = [NSString stringWithFormat:@"%@赞",square.application_remind_count];
                    
                    
                    NSString *countLike = [NSString stringWithFormat:@"%@",want.like_count_str];
                    if (countLike.length) {
                        if ([countLike intValue] == 0) {
                            cell.zanLabel.text = @"赞";
                        }else{
                            cell.zanLabel.text = [NSString stringWithFormat:@"%d赞",[countLike intValue]];
                        }
                    }else{
                        cell.zanLabel.text = @"赞";
                    }
                    
                    
                    CGSize sizeOfZan = [cell.zanLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                    cell.zanLabel.frame = CGRectMake(10, 10, sizeOfZan.width, sizeOfZan.height);
                    
                    cell.zanBackIV.frame = CGRectMake(cell.zanBackIV.frame.origin.x, cell.zanBackIV.frame.origin.y, cell.zanLabel.frame.size.width + 20, cell.zanBackIV.frame.size.height);
                    
                    
                    
                    
                    NSString *countResponse = [NSString stringWithFormat:@"%@",want.response_count_str];
                    if (countResponse.length) {
                        if ([countResponse intValue] == 0) {
                            cell.respondeLabel.text = @"回应";
                        }else{
                            cell.respondeLabel.text = [NSString stringWithFormat:@"%d回应",[countResponse intValue]];
                        }
                    }else{
                        cell.respondeLabel.text = @"回应";
                    }
                    
                    
                    
                    CGSize sizeOfResp = [cell.respondeLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                    cell.respondeLabel.frame = CGRectMake(10, 10, sizeOfResp.width, sizeOfResp.height);
                    
                    cell.responserBackIV.frame = CGRectMake(cell.zanBackIV.frame.origin.x + cell.zanBackIV.frame.size.width + 10, cell.responserBackIV.frame.origin.y, cell.respondeLabel.frame.size.width + 20, cell.responserBackIV.frame.size.height);
                    
                    
                    
                    
                    
                    [SVProgressHUD showSuccessWithStatus:@"赞成功"];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"请不要重复赞"];
                }
            } failure:^(NSError *error) {
                NSLog(@"..222222222.....%@",error.localizedDescription);
            }];
            
        }

    }else if (selectIndex == 2){
        SquareModel *square = [self.squarArr objectAtIndex:indexPath.row];
        
        NSString *tmp = [NSString stringWithFormat:@"%@",square.is_like];
        
        if ([tmp boolValue]) {
            [RSHTTPMANAGER showActivityView:YES];
            [RSHTTPMANAGER requestUnZanWithEvent_id:square.event_id WithUid:self.currentUID WithSuccess:^(BOOL isSuccess) {
                if (isSuccess) {
                    square.is_like = @"0";
                    WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:indexPath];
                    
                    int amount = [[NSString stringWithFormat:@"%@",square.like_count_str] integerValue] ;
                    amount --;
                    if (amount < 0) {
                        amount = 0;
                    }
                    square.like_count_str = [NSString stringWithFormat:@"%d", amount];
                    //            cell.zanLabel.text = [NSString stringWithFormat:@"%@赞",square.application_remind_count];
                    
                    
                    NSString *countLike = [NSString stringWithFormat:@"%@",square.like_count_str];
                    if (countLike.length) {
                        if ([countLike intValue] == 0) {
                            cell.zanLabel.text = @"赞";
                        }else{
                            cell.zanLabel.text = [NSString stringWithFormat:@"%d赞",[countLike intValue]];
                        }
                    }else{
                        cell.zanLabel.text = @"赞";
                    }
                    
                    
                    CGSize sizeOfZan = [cell.zanLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                    cell.zanLabel.frame = CGRectMake(10, 10, sizeOfZan.width, sizeOfZan.height);
                    
                    cell.zanBackIV.frame = CGRectMake(cell.zanBackIV.frame.origin.x, cell.zanBackIV.frame.origin.y, cell.zanLabel.frame.size.width + 20, cell.zanBackIV.frame.size.height);
                    
                    
                    
                    
                    NSString *countResponse = [NSString stringWithFormat:@"%@",square.response_count_str];
                    if (countResponse.length) {
                        if ([countResponse intValue] == 0) {
                            cell.respondeLabel.text = @"回应";
                        }else{
                            cell.respondeLabel.text = [NSString stringWithFormat:@"%d回应",[countResponse intValue]];
                        }
                    }else{
                        cell.respondeLabel.text = @"回应";
                    }
                    
                    
                    
                    CGSize sizeOfResp = [cell.respondeLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                    cell.respondeLabel.frame = CGRectMake(10, 10, sizeOfResp.width, sizeOfResp.height);
                    
                    cell.responserBackIV.frame = CGRectMake(cell.zanBackIV.frame.origin.x + cell.zanBackIV.frame.size.width + 10, cell.responserBackIV.frame.origin.y, cell.respondeLabel.frame.size.width + 20, cell.responserBackIV.frame.size.height);
                    
//                    [SVProgressHUD showSuccessWithStatus:@"取消赞成功"];
                    
                }else{
//                    [SVProgressHUD showErrorWithStatus:@"取消赞失败"];
                    
                }
                
            } failure:^(NSError *error) {
                
            }];
            
        }else{
            [RSHTTPMANAGER requestZanWithEvent_id:square.event_id WithUid:self.currentUID WithSuccess:^(BOOL isSuccess) {
                if (isSuccess) {
                    square.is_like = @"1";
                    WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:indexPath];
                    
                    int amount = [[NSString stringWithFormat:@"%@",square.like_count_str] integerValue] ;
                    amount ++;
                    square.like_count_str = [NSString stringWithFormat:@"%d", amount];
                    //            cell.zanLabel.text = [NSString stringWithFormat:@"%@赞",square.application_remind_count];
                    
                    
                    NSString *countLike = [NSString stringWithFormat:@"%@",square.like_count_str];
                    if (countLike.length) {
                        if ([countLike intValue] == 0) {
                            cell.zanLabel.text = @"赞";
                        }else{
                            cell.zanLabel.text = [NSString stringWithFormat:@"%d赞",[countLike intValue]];
                        }
                    }else{
                        cell.zanLabel.text = @"赞";
                    }
                    
                    
                    CGSize sizeOfZan = [cell.zanLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                    cell.zanLabel.frame = CGRectMake(10, 10, sizeOfZan.width, sizeOfZan.height);
                    
                    cell.zanBackIV.frame = CGRectMake(cell.zanBackIV.frame.origin.x, cell.zanBackIV.frame.origin.y, cell.zanLabel.frame.size.width + 20, cell.zanBackIV.frame.size.height);
                    
                    
                    
                    
                    NSString *countResponse = [NSString stringWithFormat:@"%@",square.response_count_str];
                    if (countResponse.length) {
                        if ([countResponse intValue] == 0) {
                            cell.respondeLabel.text = @"回应";
                        }else{
                            cell.respondeLabel.text = [NSString stringWithFormat:@"%d回应",[countResponse intValue]];
                        }
                    }else{
                        cell.respondeLabel.text = @"回应";
                    }
                    
                    
                    
                    CGSize sizeOfResp = [cell.respondeLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                    cell.respondeLabel.frame = CGRectMake(10, 10, sizeOfResp.width, sizeOfResp.height);
                    
                    cell.responserBackIV.frame = CGRectMake(cell.zanBackIV.frame.origin.x + cell.zanBackIV.frame.size.width + 10, cell.responserBackIV.frame.origin.y, cell.respondeLabel.frame.size.width + 20, cell.responserBackIV.frame.size.height);
                    
                    
                    
                    
                    
                    [SVProgressHUD showSuccessWithStatus:@"赞成功"];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"请不要重复赞"];
                }
            } failure:^(NSError *error) {
                NSLog(@"..222222222.....%@",error.localizedDescription);
            }];
            
        }


    }else if (selectIndex == 4){
        SquareModel *square = [self.squarArr objectAtIndex:indexPath.row];
        
        NSString *tmp = [NSString stringWithFormat:@"%@",square.is_like];
        
        if ([tmp boolValue]) {
            [RSHTTPMANAGER showActivityView:YES];
            [RSHTTPMANAGER requestUnZanWithEvent_id:square.event_id WithUid:self.currentUID WithSuccess:^(BOOL isSuccess) {
                if (isSuccess) {
                    square.is_like = @"0";
                    WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:indexPath];
                    
                    int amount = [[NSString stringWithFormat:@"%@",square.like_count_str] integerValue] ;
                    amount --;
                    if (amount < 0) {
                        amount = 0;
                    }
                    square.like_count_str = [NSString stringWithFormat:@"%d", amount];
                    //            cell.zanLabel.text = [NSString stringWithFormat:@"%@赞",square.application_remind_count];
                    
                    
                    NSString *countLike = [NSString stringWithFormat:@"%@",square.like_count_str];
                    if (countLike.length) {
                        if ([countLike intValue] == 0) {
                            cell.zanLabel.text = @"赞";
                        }else{
                            cell.zanLabel.text = [NSString stringWithFormat:@"%d赞",[countLike intValue]];
                        }
                    }else{
                        cell.zanLabel.text = @"赞";
                    }
                    
                    
                    CGSize sizeOfZan = [cell.zanLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                    cell.zanLabel.frame = CGRectMake(10, 10, sizeOfZan.width, sizeOfZan.height);
                    
                    cell.zanBackIV.frame = CGRectMake(cell.zanBackIV.frame.origin.x, cell.zanBackIV.frame.origin.y, cell.zanLabel.frame.size.width + 20, cell.zanBackIV.frame.size.height);
                    
                    
                    
                    
                    NSString *countResponse = [NSString stringWithFormat:@"%@",square.response_count_str];
                    if (countResponse.length) {
                        if ([countResponse intValue] == 0) {
                            cell.respondeLabel.text = @"回应";
                        }else{
                            cell.respondeLabel.text = [NSString stringWithFormat:@"%d回应",[countResponse intValue]];
                        }
                    }else{
                        cell.respondeLabel.text = @"回应";
                    }
                    
                    
                    
                    CGSize sizeOfResp = [cell.respondeLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                    cell.respondeLabel.frame = CGRectMake(10, 10, sizeOfResp.width, sizeOfResp.height);
                    
                    cell.responserBackIV.frame = CGRectMake(cell.zanBackIV.frame.origin.x + cell.zanBackIV.frame.size.width + 10, cell.responserBackIV.frame.origin.y, cell.respondeLabel.frame.size.width + 20, cell.responserBackIV.frame.size.height);
                    
                    [SVProgressHUD showSuccessWithStatus:@"取消赞成功"];
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:@"取消赞失败"];
                    
                }
                
            } failure:^(NSError *error) {
                
            }];
            
        }else{
            [RSHTTPMANAGER requestZanWithEvent_id:square.event_id WithUid:self.currentUID WithSuccess:^(BOOL isSuccess) {
                if (isSuccess) {
                    square.is_like = @"1";
                    WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:indexPath];
                    
                    int amount = [[NSString stringWithFormat:@"%@",square.like_count_str] integerValue] ;
                    amount ++;
                    square.like_count_str = [NSString stringWithFormat:@"%d", amount];
                    //            cell.zanLabel.text = [NSString stringWithFormat:@"%@赞",square.application_remind_count];
                    
                    
                    NSString *countLike = [NSString stringWithFormat:@"%@",square.like_count_str];
                    if (countLike.length) {
                        if ([countLike intValue] == 0) {
                            cell.zanLabel.text = @"赞";
                        }else{
                            cell.zanLabel.text = [NSString stringWithFormat:@"%d赞",[countLike intValue]];
                        }
                    }else{
                        cell.zanLabel.text = @"赞";
                    }
                    
                    
                    CGSize sizeOfZan = [cell.zanLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                    cell.zanLabel.frame = CGRectMake(10, 10, sizeOfZan.width, sizeOfZan.height);
                    
                    cell.zanBackIV.frame = CGRectMake(cell.zanBackIV.frame.origin.x, cell.zanBackIV.frame.origin.y, cell.zanLabel.frame.size.width + 20, cell.zanBackIV.frame.size.height);
                    
                    
                    
                    
                    NSString *countResponse = [NSString stringWithFormat:@"%@",square.response_count_str];
                    if (countResponse.length) {
                        if ([countResponse intValue] == 0) {
                            cell.respondeLabel.text = @"回应";
                        }else{
                            cell.respondeLabel.text = [NSString stringWithFormat:@"%d回应",[countResponse intValue]];
                        }
                    }else{
                        cell.respondeLabel.text = @"回应";
                    }
                    
                    
                    
                    CGSize sizeOfResp = [cell.respondeLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                    cell.respondeLabel.frame = CGRectMake(10, 10, sizeOfResp.width, sizeOfResp.height);
                    
                    cell.responserBackIV.frame = CGRectMake(cell.zanBackIV.frame.origin.x + cell.zanBackIV.frame.size.width + 10, cell.responserBackIV.frame.origin.y, cell.respondeLabel.frame.size.width + 20, cell.responserBackIV.frame.size.height);
                    
                    
                    
                    
                    
                    [SVProgressHUD showSuccessWithStatus:@"赞成功"];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"请不要重复赞"];
                }
            } failure:^(NSError *error) {
                NSLog(@"..222222222.....%@",error.localizedDescription);
            }];
            
        }
        
    }
}


- (void)touchesBeganWithIndex:(int) index{
    NSLog(@"touchesBeganWithIndex");
    if (selectIndex == 0) {
        [self setCellHightState:index withSelectedIndex:0];        
    }else if (selectIndex == 1){
        [self setCellHightState:index withSelectedIndex:1];
//        WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//        cell.backGroundView.backgroundColor = [UIColor lightGrayColor];
    }else if (selectIndex == 2){
        [self setCellHightState:index withSelectedIndex:2];

//        WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//        cell.backGroundView.backgroundColor = [UIColor lightGrayColor];
    }else if (selectIndex == 3){
        [self setCellHightState:index withSelectedIndex:3];

//        AttentionCell *cell = (AttentionCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//        cell.backGroundView.backgroundColor = [UIColor lightGrayColor];
    }else if (selectIndex == 4){
        [self setCellHightState:index withSelectedIndex:4];

//        WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//        cell.backGroundView.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void)touchesCancelWithIndex:(int) index{
    NSLog(@"touchesCancelWithIndex");
    if (selectIndex == 0) {
        [self setCellNormalState:index withSelectedIndex:0];        
    }else if (selectIndex == 1){
        [self setCellNormalState:index withSelectedIndex:1];

//        WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//        cell.backGroundView.backgroundColor = [UIColor whiteColor];
    }else if (selectIndex == 2){
        [self setCellNormalState:index withSelectedIndex:2];

//        WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//        cell.backGroundView.backgroundColor = [UIColor whiteColor];
    }else if (selectIndex == 3){
        [self setCellNormalState:index withSelectedIndex:3];

//        AttentionCell *cell = (AttentionCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//        cell.backGroundView.backgroundColor = [UIColor whiteColor];
    }else if (selectIndex == 4){
        [self setCellNormalState:index withSelectedIndex:4];

//        WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//        cell.backGroundView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)touchesEndWithIndex:(int) index{
    NSLog(@"touchesEndWithIndex");
    if (selectIndex == 0) {
        NSLog(@"动态");
        [self setCellNormalState:index withSelectedIndex:0];
        
        SquareModel *square = [self.squarArr objectAtIndex:index];
        if ([square.action_type_id intValue] == 3){
            UserRootViewController *uvc = [[UserRootViewController alloc] init];
            uvc.uuid = [NSString stringWithFormat:@"%@",square.obj_uid];
            
            [self.navigationController pushViewController:uvc animated:YES];
        }else{
//            AppsDetailsViewController *appsVc = [[AppsDetailsViewController alloc] init];
//            appsVc.application_id = square.application_id;
//            [self.navigationController pushViewController:appsVc animated:YES];

            RespondViewController *revc = [[RespondViewController alloc] init];
            revc.delegate = self;
            revc.squareModle = square;
            [self.navigationController pushViewController:revc animated:YES];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];
        
    }else if (selectIndex == 1){
        NSLog(@"愿望");
        [self setCellNormalState:index withSelectedIndex:1];

//        SquareModel *squar = [[SquareModel alloc] init];
//        squar.application_id = want.application_id;
        
        WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.backGroundView.backgroundColor = [UIColor whiteColor];
        
        RespondViewController *appsVc = [[RespondViewController alloc] init];
        appsVc.delegate = self;
//        appsVc.application_id = want.application_id;
        WantModel *want = [self.squarArr objectAtIndex:index];
        //    SquareModel *squar = [[SquareModel alloc] init];
        
        SquareModel *sq = [[SquareModel alloc] init];
        //    sq.img_path = want.
        sq.event_id = want.event_id;
        sq.application_retail_price = want.application_retail_price;
        sq.primary_genre_name = want.primary_genre_name;
        sq.supported_device_name = want.supported_device_name;
        sq.application_artwork_url_small = want.application_artwork_url_small;
        sq.img_path = want.img_path;
        sq.nick_name = want.nick_name;
        sq.application_action_type_name = want.application_action_type_name;
        sq.application_title = want.application_title;
        sq.limited_state_name = want.limitedStateName;
        sq.like_count_str = want.like_count_str;
        sq.is_like = want.is_like;
        appsVc.squareModle = sq;
        [self.navigationController pushViewController:appsVc animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];

    }else if (selectIndex == 2){
        NSLog(@"推荐");
        [self setCellNormalState:index withSelectedIndex:2];

        WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.backGroundView.backgroundColor = [UIColor whiteColor];
        SquareModel *square = [self.squarArr objectAtIndex:index];
        RespondViewController *revc = [[RespondViewController alloc] init];
        revc.delegate = self;
        revc.squareModle = square;
        [self.navigationController pushViewController:revc animated:YES];
//        AppsDetailsViewController *appsVc = [[AppsDetailsViewController alloc] init];
//        appsVc.application_id = square.application_id;
//        [self.navigationController pushViewController:appsVc animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];

    }else if (selectIndex == 3){
        NSLog(@"关注");
        [self setCellNormalState:index withSelectedIndex:3];

        AttentionCell *cell = (AttentionCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.backGroundView.backgroundColor = [UIColor whiteColor];
        
        UserModel *user = [self.squarArr objectAtIndex:index];

        UserRootViewController *uvc = [[UserRootViewController alloc] init];
        uvc.uuid = user.uid;
        
        
        [self.navigationController pushViewController:uvc animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];

    }else if (selectIndex == 4){
        NSLog(@"评论");
        [self setCellNormalState:index withSelectedIndex:4];

        WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.backGroundView.backgroundColor = [UIColor whiteColor];
        RespondViewController *revc = [[RespondViewController alloc] init];
        revc.delegate = self;
        revc.squareModle = [self.squarArr objectAtIndex:index];
        [self.navigationController pushViewController:revc animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];

    }
}

- (void)refreshData{
    [self getData];
}

- (void)touchesMoveWithIndex:(int) index{
    NSLog(@"touchesMoveWithIndex");
    if (selectIndex == 0) {
        [self setCellNormalState:index withSelectedIndex:0];
    }else if (selectIndex == 1){
        [self setCellNormalState:index withSelectedIndex:1];
        
//        WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//        cell.backGroundView.backgroundColor = [UIColor whiteColor];
    }else if (selectIndex == 2){
        [self setCellNormalState:index withSelectedIndex:2];

//        WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//        cell.backGroundView.backgroundColor = [UIColor whiteColor];
    }else if (selectIndex == 3){
        [self setCellNormalState:index withSelectedIndex:3];

//        AttentionCell *cell = (AttentionCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//        cell.backGroundView.backgroundColor = [UIColor whiteColor];
    }else if (selectIndex == 4){
        [self setCellNormalState:index withSelectedIndex:4];

//        WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//        cell.backGroundView.backgroundColor = [UIColor whiteColor];
    }
}



- (void)setCellNormalState:(int)indexPath withSelectedIndex:(int)selectedIndex{
    if (selectedIndex == 0) {
        MasterCell1 *cell = (MasterCell1 *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath inSection:0]];
        cell.backGroundView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
        cell.respondBackView.backgroundColor = cell.zanBackView.backgroundColor = cell.centerView.backgroundColor = [UIColor colorWithRed:247.0/255 green:247.0/255 blue:240.0/255 alpha:1.0];
    }else if (selectIndex == 1){
        WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath inSection:0]];
        cell.backGroundView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
        cell.responserBackIV.backgroundColor = cell.zanBackIV.backgroundColor = cell.responserBackIV.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];

    }else if (selectIndex == 2){
        WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath inSection:0]];
        cell.backGroundView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
        cell.responserBackIV.backgroundColor = cell.zanBackIV.backgroundColor = cell.responserBackIV.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
    }else if (selectIndex == 3){
        AttentionCell *cell = (AttentionCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath inSection:0]];
        cell.backGroundView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
//        cell.customView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
    }else if (selectIndex == 4){
        WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath inSection:0]];
        cell.backGroundView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
        cell.responserBackIV.backgroundColor = cell.zanBackIV.backgroundColor = cell.responserBackIV.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];

    }
}


- (void)setCellHightState:(int)indexPath withSelectedIndex:(int)selectedIndex{
    if (selectedIndex == 0) {
        MasterCell1 *cell = (MasterCell1 *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath inSection:0]];
        cell.backGroundView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
        cell.respondBackView.backgroundColor = cell.zanBackView.backgroundColor = cell.centerView.backgroundColor = [UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1.0];
    }else if (selectIndex == 1){
        WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath inSection:0]];
        cell.backGroundView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
        cell.responserBackIV.backgroundColor = cell.zanBackIV.backgroundColor = cell.responserBackIV.backgroundColor =[UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1.0];
    }else if (selectIndex == 2){
        WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath inSection:0]];
        cell.backGroundView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
        cell.responserBackIV.backgroundColor = cell.zanBackIV.backgroundColor = cell.responserBackIV.backgroundColor =[UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1.0];
    }else if (selectIndex == 3){
        AttentionCell *cell = (AttentionCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath inSection:0]];
        cell.backGroundView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
//        cell.customView.backgroundColor = [UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1.0];
        
    }else if (selectIndex == 4){
        WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath inSection:0]];
        cell.backGroundView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
        cell.responserBackIV.backgroundColor = cell.zanBackIV.backgroundColor = cell.responserBackIV.backgroundColor =[UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1.0];
    }
}

@end

