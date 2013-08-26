//
//  TestFriendViewController.m
//  guoSeven
//
//  Created by zucknet on 12/12/11.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "TestFriendViewController.h"
#import "AddfirendViewController.h"
#import "UIImageView+AFNetworking.h"
#import "UserRootViewController.h"
#import "FriendRootViewController.h"
#import "SVPullToRefresh.h"
#import "RSHttpManager.h"
#import "UserModel.h"
#import "AttentionCell.h"
#import "SVProgressHUD.h"

@interface TestFriendViewController ()
@property (nonatomic, retain) NSMutableArray *dataArr;
@property (nonatomic, retain) UITableView *myTableView;

@property (nonatomic, retain) NSString *currentUID;
@property (nonatomic, assign) int page;

-(IBAction)didPush:(id)sender;

@end

@implementation TestFriendViewController
//@synthesize dataSorce;
@synthesize detailVewController=_detailVewController;
@synthesize dataArr, myTableView;
@synthesize topbtn1, topbtn2;
@synthesize currentUID;
@synthesize page;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [rightBtn setFrame:CGRectMake(10, 3, 55, 32)];
        UILabel *rightlab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 55, 32)];
        rightlab.text=@"添加";
        rightlab.backgroundColor=[UIColor clearColor];
        rightlab.textColor=[UIColor whiteColor];
        rightlab.textAlignment=NSTextAlignmentCenter;
        rightlab.font=[UIFont systemFontOfSize:13];
        [rightBtn addSubview:rightlab];
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"icontop-normal@2x.png"] forState:UIControlStateNormal];
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"icontop-normal2@2x.png"] forState:UIControlStateHighlighted];
        [rightBtn addTarget:self action:@selector(addfriend:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        [self.navigationItem setRightBarButtonItem:rightItem];
        
        UIImageView *tmpV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 41)];
        tmpV.image = [UIImage imageNamed:@"MasterTop.png"];
        tmpV.userInteractionEnabled = YES;
        
        [self.view addSubview:tmpV];
        self.topbtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.topbtn1.frame = CGRectMake(0, 0, 160, 40);
        self.topbtn1.tag = 1;
        [self.topbtn1 addTarget:self action:@selector(goSomeThing:) forControlEvents:UIControlEventTouchUpInside];
        [tmpV addSubview:self.topbtn1];
        
        
        self.topbtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.topbtn2.frame = CGRectMake(160, 0, 160, 40);
        self.topbtn2.tag = 2;
        [self.topbtn2 addTarget:self action:@selector(goSomeThing:) forControlEvents:UIControlEventTouchUpInside];
        
        [tmpV addSubview:self.topbtn2];
        
        [self.topbtn1 setTitle:@"我的关注" forState:UIControlStateNormal];
        [self.topbtn1 setTitle:@"我的关注" forState:UIControlStateHighlighted];
        self.topbtn1.titleLabel.font  = [UIFont systemFontOfSize:14];
        
        
        [self.topbtn2 setTitle:@"我的粉丝" forState:UIControlStateNormal];
        [self.topbtn2 setTitle:@"我的粉丝" forState:UIControlStateHighlighted];
        self.topbtn2.titleLabel.font  = [UIFont systemFontOfSize:14];
        
        
        
        
        UIView *tmp = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 320, 1)];
        tmp.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
        //    tmp.backgroundColor = [UIColor redColor];
        [tmpV addSubview:tmp];
    }
    return self;
}

-(IBAction)addfriend:(id)sender{
    AddfirendViewController *addfriendController =[[AddfirendViewController alloc]init];
    [self.navigationController  pushViewController:addfriendController animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[self.navigationController navigationBar] setFrame:CGRectMake(0.f, 20.f, 320.f, 44.f)];
    if ([self.navigationController.viewControllers count] > 1) {
        NSLog(@">>>>>>1");
    }else{
        NSLog(@"<<<<<<<");
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"YES"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"关注与粉丝";
    
    self.currentUID = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUID]];
    
    //    UIImageView *tmpV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 41)];
    //    tmpV.image = [UIImage imageNamed:@"MasterTop.png"];
    //    tmpV.userInteractionEnabled = YES;
    //
    //    [self.view addSubview:tmpV];
    //    self.topbtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    self.topbtn1.frame = CGRectMake(0, 0, 160, 40);
    //    self.topbtn1.tag = 1;
    //    [self.topbtn1 addTarget:self action:@selector(goSomeThing:) forControlEvents:UIControlEventTouchUpInside];
    //    [tmpV addSubview:self.topbtn1];
    //
    //
    //    self.topbtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    self.topbtn2.frame = CGRectMake(160, 0, 160, 40);
    //    self.topbtn2.tag = 2;
    //    [self.topbtn2 addTarget:self action:@selector(goSomeThing:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    [tmpV addSubview:self.topbtn2];
    //
    //    [self.topbtn1 setTitle:@"我的关注" forState:UIControlStateNormal];
    //    [self.topbtn1 setTitle:@"我的关注" forState:UIControlStateHighlighted];
    //    self.topbtn1.titleLabel.font  = [UIFont systemFontOfSize:14];
    //
    //
    //    [self.topbtn2 setTitle:@"我的粉丝" forState:UIControlStateNormal];
    //    [self.topbtn2 setTitle:@"我的粉丝" forState:UIControlStateHighlighted];
    //    self.topbtn2.titleLabel.font  = [UIFont systemFontOfSize:14];
    //
    //
    //
    //
    //    UIView *tmp = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 320, 1)];
    //    tmp.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
    //    //    tmp.backgroundColor = [UIColor redColor];
    //    [tmpV addSubview:tmp];
    
    [self setBroadcasteStat:YES];
    
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 41, 320, self.view.frame.size.height - 80.0f)];
    self.myTableView.showsHorizontalScrollIndicator=FALSE;
    self.myTableView.showsVerticalScrollIndicator=FALSE;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.myTableView];
    topbtn1.selected = YES;
    topbtn2.selected = NO;
    self.page = 2;
    
    
    [self.myTableView addPullToRefreshWithActionHandler:^{
        if (self.topbtn1.selected) {
            //            [RSHTTPMANAGER isShowActivity];
            [RSHTTPMANAGER requestUserWithUID:self.currentUID WithType:@"following" WithPage:@"1" WithSuccess:^(NSArray *userList) {
                
                if ([userList count]) {
                    self.dataArr = [NSMutableArray arrayWithArray:userList];
                    [self.myTableView reloadData];
                    [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                }
                self.page = 2;
                [self.myTableView.pullToRefreshView stopAnimating];
                topbtn1.userInteractionEnabled = YES;
                topbtn2.userInteractionEnabled = YES;
                if ([userList count] < 10) {
                    self.myTableView.infiniteScrollingView.enabled = NO;
                }else{
                    self.myTableView.infiniteScrollingView.enabled = YES;
                }
            } failure:^(NSError *error) {
                topbtn1.userInteractionEnabled = YES;
                topbtn2.userInteractionEnabled = YES;
                [self.myTableView.pullToRefreshView stopAnimating];
            }];
        }else{
            //            [RSHTTPMANAGER isShowActivity];
            [RSHTTPMANAGER requestUserWithUID:self.currentUID WithType:@"follower" WithPage:@"1" WithSuccess:^(NSArray *userList) {
                if ([userList count]) {
                    self.dataArr = [NSMutableArray arrayWithArray:userList];
                    [self.myTableView reloadData];
                    [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                }
                self.page = 2;
                
                [self.myTableView.pullToRefreshView stopAnimating];
                topbtn1.userInteractionEnabled = YES;
                topbtn2.userInteractionEnabled = YES;
                if ([userList count] < 10) {
                    self.myTableView.infiniteScrollingView.enabled = NO;
                }else{
                    self.myTableView.infiniteScrollingView.enabled = YES;
                }
            } failure:^(NSError *error) {
                topbtn1.userInteractionEnabled = YES;
                topbtn2.userInteractionEnabled = YES;
                [self.myTableView.pullToRefreshView stopAnimating];
            }];
        }
    }];
    
    [self.myTableView addInfiniteScrollingWithActionHandler:^{
        UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        la.text = @"正在加载更多";
        la.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        
        la.textAlignment = NSTextAlignmentCenter;
        
        self.myTableView.tableFooterView = la;
        if (self.topbtn1.selected) {
            //            [RSHTTPMANAGER isShowActivity];
            [RSHTTPMANAGER requestUserWithUID:self.currentUID WithType:@"following" WithPage:[NSString stringWithFormat:@"%d", self.page] WithSuccess:^(NSArray *userList) {
                if ([userList count]) {
                    [self.dataArr addObjectsFromArray:userList];
                    [self.myTableView reloadData];
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
                
            }];
        }else{
            //            [RSHTTPMANAGER isShowActivity];
            [RSHTTPMANAGER requestUserWithUID:self.currentUID WithType:@"follower" WithPage:[NSString stringWithFormat:@"%d", self.page] WithSuccess:^(NSArray *userList) {
                if ([userList count]) {
                    [self.dataArr addObjectsFromArray:userList];
                    [self.myTableView reloadData];
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
                
            }];
        }
        
    }];
    //    [self.myTableView triggerPullToRefresh];
}

-(void)getData{
    [SVProgressHUD show];
    
    NSLog(@"topbtn1:%d, topBtn2:%d",self.topbtn1.selected, self.topbtn2.selected);
    
    
    if (self.topbtn1.selected) {
        [self setBroadcasteStat:YES];
        //        [RSHTTPMANAGER isShowActivity];
        [RSHTTPMANAGER requestUserWithUID:self.currentUID WithType:@"following" WithPage:@"1" WithSuccess:^(NSArray *userList) {
            
            if ([userList count]) {
                self.dataArr = [NSMutableArray arrayWithArray:userList];
                [self.myTableView reloadData];
                [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
            self.page = 2;
            [self.myTableView.pullToRefreshView stopAnimating];
            topbtn1.userInteractionEnabled = YES;
            topbtn2.userInteractionEnabled = YES;
            [SVProgressHUD dismiss];
            if ([userList count] < 10) {
                self.myTableView.infiniteScrollingView.enabled = NO;
            }else{
                self.myTableView.infiniteScrollingView.enabled = YES;
            }
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
            topbtn1.userInteractionEnabled = YES;
            topbtn2.userInteractionEnabled = YES;
            [self.myTableView.pullToRefreshView stopAnimating];
        }];
    }else{
        //        [RSHTTPMANAGER isShowActivity];
        [self setBroadcasteStat:NO];
        
        [RSHTTPMANAGER requestUserWithUID:self.currentUID WithType:@"follower" WithPage:@"1" WithSuccess:^(NSArray *userList) {
            if ([userList count]) {
                self.dataArr = [NSMutableArray arrayWithArray:userList];
                [self.myTableView reloadData];
                [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
            self.page = 1;
            
            [self.myTableView.pullToRefreshView stopAnimating];
            topbtn1.userInteractionEnabled = YES;
            topbtn2.userInteractionEnabled = YES;
            if ([userList count] < 10) {
                self.myTableView.infiniteScrollingView.enabled = NO;
            }else{
                self.myTableView.infiniteScrollingView.enabled = YES;
            }
            [SVProgressHUD dismiss];
        } failure:^(NSError *error) {
            topbtn1.userInteractionEnabled = YES;
            topbtn2.userInteractionEnabled = YES;
            [SVProgressHUD dismiss];
            [self.myTableView.pullToRefreshView stopAnimating];
        }];
    }
}

- (void)hideFootView{
    self.myTableView.tableFooterView = nil;
}

- (void)setBroadcasteStat:(BOOL)isMy{
    if (isMy) {
        [topbtn1 setTitleColor:[UIColor colorWithRed:51.0f/255.0f green:153.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        [topbtn1 setTitleColor:[UIColor colorWithRed:51.0f/255.0f green:153.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateHighlighted];
        [topbtn2 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        [topbtn2 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateHighlighted];
    }else{
        [topbtn1 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        [topbtn1 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateHighlighted];
        [topbtn2 setTitleColor:[UIColor colorWithRed:51.0f/255.0f green:153.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        [topbtn2 setTitleColor:[UIColor colorWithRed:51.0f/255.0f green:153.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateHighlighted];
    }
}

-(void)goSomeThing:(id)sender{
    UIButton * button = (UIButton*)sender;
    if (button.tag == 1) {
        [self setBroadcasteStat:YES];
        self.topbtn1.selected = YES;
        self.topbtn1.userInteractionEnabled = NO;
        self.topbtn2.selected = NO;
    }else if (button.tag == 2){
        [self setBroadcasteStat:NO];
        self.topbtn1.selected = NO;
        self.topbtn2.selected = YES;
        self.topbtn2.userInteractionEnabled = NO;
    }
    //    [self.myTableView triggerPullToRefresh];
    [self.myTableView.pullToRefreshView stopAnimating];
    [self getData];
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row];//@"Cell";
    
    UserModel *user = [self.dataArr objectAtIndex:indexPath.row];
    AttentionCell *cell = (AttentionCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"AttentionCell" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSLog(@".......user.nick_name:%@",user.nick_name);
    cell.userName.text = user.nick_name;
    cell.userName.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    cell.userName.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    
    CGSize userNameSize = [user.nick_name sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15]];
    cell.userName.frame = CGRectMake(cell.userName.frame.origin.x, cell.userName.frame.origin.y, userNameSize.width, userNameSize.height);
    cell.usertLocation.text = user.details;
    cell.usertLocation.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    cell.usertLocation.textColor = [UIColor colorWithRed:187.0/255 green:187.0/255 blue:187.0/255 alpha:1.0];
    
    CGSize userLocationSize = [user.details sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15]];
    cell.usertLocation.frame = CGRectMake(cell.userName.frame.origin.x + cell.userName.frame.size.width + 10.0f, cell.userName.frame.origin.y, userLocationSize.width, userLocationSize.height);
    
    if (user.signature.length) {
        //        cell.userSignature.text = [NSString stringWithFormat:@"\"%@\"",user.signature];
        cell.userSignature.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        cell.userSignature.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        
        CGSize userSigSize = [user.signature sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
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
    //    CGSize userSignatureSize = [user.signature sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
    //    cell.userSignature.frame = CGRectMake(cell.userSignature.frame.origin.x, cell.userSignature.frame.origin.y, userSignatureSize.width, userSignatureSize.height);
    cell.userName.center = CGPointMake(cell.userName.center.x, 22);
    cell.usertLocation.center = CGPointMake(cell.usertLocation.center.x, 22);
    
    
    [cell.userIcon setImageWithURL:[NSURL URLWithString:user.img_path] placeholderImage:[UIImage imageNamed:@"hi"]];
    [cell.customView setIndex:indexPath.row];
    cell.customView.delegate = self;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendRootViewController *friendRootVc = [[FriendRootViewController alloc]init];
    
    //    friendRootVc.friend_id = [[self.dataSorce objectAtIndex:indexPath.row]objectForKey:@"uid"];
    
    [self.navigationController pushViewController:friendRootVc animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];
    
}
- (void)touchesBeganWithIndex:(int) index{
    NSLog(@"touchesBeganWithIndex");
    //    AttentionCell *cell = (AttentionCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    //    cell.backGroundView.backgroundColor = [UIColor lightGrayColor];
    AttentionCell *cell = (AttentionCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    cell.backGroundView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
    
}
- (void)touchesCancelWithIndex:(int) index{
    NSLog(@"touchesCancelWithIndex");
    //    AttentionCell *cell = (AttentionCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    //    cell.backGroundView.backgroundColor = [UIColor whiteColor];
    AttentionCell *cell = (AttentionCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    cell.backGroundView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
    
}
- (void)touchesEndWithIndex:(int) index{
    NSLog(@"touchesEndWithIndex");
    //    AttentionCell *cell = (AttentionCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    //    cell.backGroundView.backgroundColor = [UIColor whiteColor];
    
    AttentionCell *cell = (AttentionCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    cell.backGroundView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
    
    UserModel *user = [self.dataArr objectAtIndex:index];
    
    UserRootViewController *userRootVc = [[UserRootViewController alloc]init];
    userRootVc.uuid = user.uid;    
    [self.navigationController pushViewController:userRootVc animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];
    
    
}
- (void)touchesMoveWithIndex:(int) index{
    NSLog(@"touchesMoveWithIndex");
    //    AttentionCell *cell = (AttentionCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    //    cell.backGroundView.backgroundColor = [UIColor whiteColor];
    AttentionCell *cell = (AttentionCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    cell.backGroundView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
