//
//  MasterViewController.m
//  SDWebImage Demo
//
//  Created by Olivier Poitrey on 09/05/12.
//  Copyright (c) 2012 Dailymotion. All rights reserved.
//

#import "MasterViewController.h"
#import "UIImageView+AFNetworking.h"
#import "DetailViewController.h"
#import "SBJson.h"
#import "SVPullToRefresh.h"
#import "friendUserViewController.h"
#import "AppsDetailsViewController.h"
#import "FriendRootViewController.h"

#import "RSHttpManager.h"
#import "SquareModel.h"

#import "MasterCell1.h"
#import "common.h"

//#import "RespondViewController.h"
#import "SVProgressHUD.h"
#import <QuartzCore/QuartzCore.h>

#import "UserRootViewController.h"
#import "UserRootViewController.h"

@interface MasterViewController () {
    }
@property (nonatomic, retain) NSMutableArray *squarArr;
@property (nonatomic, retain) UIButton *myBroadcastBt;
@property (nonatomic, retain) UIButton *publicBroadcastBt;
@property (nonatomic, assign) int page;
@property (nonatomic, retain) UITableView *myTableview;
@property (nonatomic, retain) NSString *currentUID;

@end

@implementation MasterViewController

//@synthesize dataSorce,pushApp_id,push_userId;
//
//@synthesize detailViewController = _detailViewController;
//
//@synthesize appdataSorce,userdataSorce;
//
//@synthesize moreBtn;
//@synthesize pushApp_description;
@synthesize squarArr;
@synthesize page;
@synthesize myBroadcastBt, publicBroadcastBt;
@synthesize myTableview;
@synthesize currentUID;
@synthesize isLogin;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {

    }
    return self;
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


- (CGSize)customLableSizeWithString:(NSString *)str{
    UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    CGSize size = CGSizeMake(250, 1000);
    CGSize labelsize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    return labelsize;
}
- (CGSize)customLable13SizeWithString:(NSString *)str{
    UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    CGSize size = CGSizeMake(250, 1000);
    CGSize labelsize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    return labelsize;
}



- (void)getData{
    [SVProgressHUD show];
//    [RSHTTPMANAGER showActivityView:YES];
    if (self.myBroadcastBt.selected) {
        [RSHTTPMANAGER requestUSquareWithUID:self.currentUID WithPage:@"1" WithSuccess:^(NSArray *squareList) {
            NSLog(@"更新数据..00000.");
            if ([squareList count]) {
                [self.squarArr removeAllObjects];
                self.squarArr = [NSMutableArray arrayWithArray:squareList];
                [self.myTableview reloadData];
                self.page = 2;
                [SVProgressHUD dismiss];
            }else{
                [self.squarArr removeAllObjects];
                [self.myTableview reloadData];
                [SVProgressHUD showSuccessWithStatus:@"没有内容"];
            }
            self.myBroadcastBt.userInteractionEnabled = YES;
            self.publicBroadcastBt.userInteractionEnabled = YES;
        } failure:^(NSError *error) {
            self.myBroadcastBt.userInteractionEnabled = YES;
            self.publicBroadcastBt.userInteractionEnabled = YES;
        }];
        
    }else{
        [RSHttpManager requestSquareWithUID:self.currentUID WithPage:@"1" WithSuccess:^(NSArray *squareList) {
            NSLog(@"更新数据..1111.");
            if ([squareList count]) {
                [self.squarArr removeAllObjects];
                self.squarArr = [NSMutableArray arrayWithArray:squareList];
                [self.myTableview reloadData];
                self.page = 2;
                [SVProgressHUD dismiss];
            }else{
                [self.squarArr removeAllObjects];
                [self.myTableview reloadData];
                [SVProgressHUD showSuccessWithStatus:@"没有内容"];
            }
            self.myBroadcastBt.userInteractionEnabled = YES;
            self.publicBroadcastBt.userInteractionEnabled = YES;
        } failure:^(NSError *error) {
            self.myBroadcastBt.userInteractionEnabled = YES;
            self.publicBroadcastBt.userInteractionEnabled = YES;
        }];
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];
//    [self showStatusbar];
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.title = @"广播";

    
    NSLog(@"................%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUID]);
    self.currentUID = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUID]];

    [self.view addSubview:[self setCustomTopView:isLogin]];
  
    self.view.backgroundColor=[UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1.0];
    NSLog(@"......%@",NSStringFromCGRect(self.view.frame));
    self.myTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, self.view.frame.size.height - 40)];
    self.myTableview.showsHorizontalScrollIndicator=FALSE;
    self.myTableview.showsVerticalScrollIndicator=FALSE;
    self.myTableview.delegate = self;
    self.myTableview.dataSource = self;
    self.myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.myTableview];
    self.page = 2;
    self.squarArr = [[NSMutableArray alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    [formatter setDateFormat:@"yyyy年MM月dd日"];

//    [self.myTableview.pullToRefreshView setLastUpdatedDate:date];
//    [self.myTableview.pullToRefreshView setDateFormatter:formatter];
    
    
    [self.myTableview addPullToRefreshWithActionHandler:^{
        if (self.myBroadcastBt.selected) {
//            [RSHTTPMANAGER showActivityView:YES];
            [RSHTTPMANAGER requestUSquareWithUID:self.currentUID WithPage:@"1" WithSuccess:^(NSArray *squareList) {
                NSLog(@"更新数据..00000.");
                if ([squareList count]) {
                    [self.squarArr removeAllObjects];
                    self.squarArr = [NSMutableArray arrayWithArray:squareList];
                    [self.myTableview reloadData];
                    [self.myTableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
                 self.page = 2;
                    self.myTableview.infiniteScrollingView.enabled = YES;

                }else{
                    [self.squarArr removeAllObjects];
                    [self.myTableview reloadData];
                    self.myTableview.infiniteScrollingView.enabled = NO;
                }
                [self.myTableview.pullToRefreshView stopAnimating];
                self.myBroadcastBt.userInteractionEnabled = YES;
                self.publicBroadcastBt.userInteractionEnabled = YES;
            } failure:^(NSError *error) {
                self.myBroadcastBt.userInteractionEnabled = YES;
                self.publicBroadcastBt.userInteractionEnabled = YES;
                [self.myTableview.pullToRefreshView stopAnimating];
            }];
            
        }else{
            [RSHttpManager requestSquareWithUID:self.currentUID WithPage:@"1" WithSuccess:^(NSArray *squareList) {
                 NSLog(@"更新数据..1111.");
                if ([squareList count]) {
                        [self.squarArr removeAllObjects];
                        self.squarArr = [NSMutableArray arrayWithArray:squareList];
                        [self.myTableview reloadData];
                    [self.myTableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
                        self.page = 2;
                    self.myTableview.infiniteScrollingView.enabled = YES;

                }else{
                    [self.squarArr removeAllObjects];
                    [self.myTableview reloadData];
                    self.myTableview.infiniteScrollingView.enabled = NO;

                }
                self.myBroadcastBt.userInteractionEnabled = YES;
                self.publicBroadcastBt.userInteractionEnabled = YES;
                [self.myTableview.pullToRefreshView stopAnimating];
            } failure:^(NSError *error) {
                self.myBroadcastBt.userInteractionEnabled = YES;
                self.publicBroadcastBt.userInteractionEnabled = YES;
                [self.myTableview.pullToRefreshView stopAnimating];
            }];
        }
    }];
    
    [self.myTableview addInfiniteScrollingWithActionHandler:^{
        UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        la.text = @"正在加载更多";
        la.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        
        la.textAlignment = NSTextAlignmentCenter;
        
        self.myTableview.tableFooterView = la;
        if (self.myBroadcastBt.selected) {
//            [RSHTTPMANAGER showActivityView:YES];
            [RSHTTPMANAGER requestUSquareWithUID:self.currentUID WithPage:[NSString stringWithFormat:@"%d", self.page] WithSuccess:^(NSArray *squareList) {
                NSLog(@"加载更多");
                if ([squareList count]) {
                    [self.squarArr addObjectsFromArray:squareList];
                    [self.myTableview reloadData];
                    self.page ++;
                }else{
                    self.myTableview.infiniteScrollingView.enabled = NO;
                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
                    la.text = @"已没有更多内容";
                    la.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
                    
                    la.textAlignment = NSTextAlignmentCenter;
                    
                    self.myTableview.tableFooterView = la;
                }
                [self.myTableview.infiniteScrollingView stopAnimating];
                [self performSelector:@selector(hideFootView) withObject:nil afterDelay:1];

                
            } failure:^(NSError *error) {
                [self.myTableview.pullToRefreshView stopAnimating];
                [self performSelector:@selector(hideFootView) withObject:nil afterDelay:1];

            }];
        }else{
            self.myTableview.frame = CGRectMake(0, 40, 320, self.view.frame.size.height - 40);
            [RSHttpManager requestSquareWithUID:self.currentUID WithPage:[NSString stringWithFormat:@"%d", self.page] WithSuccess:^(NSArray *squareList) {
                   NSLog(@"加载更多");
                if ([squareList count]) {
                    [self.squarArr addObjectsFromArray:squareList];
                    [self.myTableview reloadData];
                    self.page ++;
                }else{
                    self.myTableview.infiniteScrollingView.enabled = NO;
                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
                    la.text = @"已没有更多内容";
                    la.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
                    
                    la.textAlignment = NSTextAlignmentCenter;
                    
                    self.myTableview.tableFooterView = la;
                }
                [self performSelector:@selector(hideFootView) withObject:nil afterDelay:1];

                [self.myTableview.infiniteScrollingView stopAnimating];
            } failure:^(NSError *error) {
                [self performSelector:@selector(hideFootView) withObject:nil afterDelay:1];

                [self.myTableview.infiniteScrollingView stopAnimating];
            }];
        }
    }];
//    [self.myTableview triggerPullToRefresh];
    [self getData];
    
}

- (void)hideFootView{
    self.myTableview.tableFooterView = nil;
//    [self.myTableview setContentOffset:CGPointMake(0, self.myTableview.contentOffset.y + 5) animated:YES];

    self.myTableview.infiniteScrollingView.enabled = YES;
}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation = UIInterfaceOrientationPortraitUpsideDown);
//}

#pragma mark - Table View

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SquareModel *square = [self.squarArr objectAtIndex:indexPath.row];
//    if ([square.action_type_id intValue] == 4) {
//        return 240.0;
//    }else if ([square.action_type_id intValue] == 1){
        if (square.content.length) {
            CGSize s = [self customLable13SizeWithString:square.content];
            return 175 + 5 + s.height;
        }        
        return 175.0;
//    }
//    
//    return 175.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.squarArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row];//@"Cell";

    SquareModel *square = [self.squarArr objectAtIndex:indexPath.row];
    
    MasterCell1 *cell = (MasterCell1 *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"MasterCell1" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    [cell.leftUIcon setImageWithURL:[NSURL URLWithString:square.img_path] placeholderImage:[UIImage imageNamed:@"hi"]];
    cell.userName.text = square.nick_name;
    cell.userName.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    cell.userName.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    
    CGSize userNameSize = [square.nick_name sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    cell.userName.frame = CGRectMake(cell.userName.frame.origin.x, cell.userName.frame.origin.y, userNameSize.width, userNameSize.height);
    
    
    
    cell.timeLabel.text = [square.create_time substringWithRange:NSMakeRange(5, 11)];
    if ([square.action_type_id intValue] == 3) {
        [cell.appIcon setImageWithURL:[NSURL URLWithString:square.obj_img_path] placeholderImage:[UIImage imageNamed:@"hi"]];
        cell.actionTypeNameLable.text = square.obj_action_type_name;
        cell.actionTypeNameLable.frame = CGRectMake(cell.userName.frame.origin.x + cell.userName.frame.size.width + 5, cell.actionTypeNameLable.frame.origin.y, cell.actionTypeNameLable.frame.size.width, cell.actionTypeNameLable.frame.size.height);
        cell.appName.text = [NSString stringWithFormat:@"%@",square.obj_nick_name];
        cell.appName.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
        cell.objUserLocation.text = [NSString stringWithFormat:@"%@",square.obj_location];
            
        CGSize sizeOfobjUserName = [square.obj_nick_name sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15]];
        cell.appName.frame = CGRectMake(cell.appName.frame.origin.x, cell.appName.frame.origin.y, sizeOfobjUserName.width + 5, sizeOfobjUserName.height);
        
        CGSize sizeOfobjUserLocation = [square.obj_location sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15]];
        cell.objUserLocation.frame = CGRectMake(cell.appName.frame.origin.x + cell.appName.frame.size.width + 5, cell.appName.frame.origin.y, sizeOfobjUserLocation.width, sizeOfobjUserLocation.height);
        cell.objUserLocation.textColor = [UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1.0];
        if (!square.obj_signature.length) {
            cell.appType.text = @"";
        }else{
            
            
            cell.appType.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
            CGSize userSigSize = [square.obj_signature sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
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
//    cell.userBtn.hidden = YES;
    }else{
        
//        if (square.application_remind_count.length) {
//            if ([square.application_remind_count intValue] == 0) {
//                cell.zanLabel.text = @"赞";
//            }else{
//                cell.zanLabel.text = [NSString stringWithFormat:@"%@赞",square.application_remind_count];
//            }
//        }else{
//            cell.zanLabel.text = @"赞";
//        }
//        
//        cell.respondLabel.text = @"回应";
//        
        
        [cell.appIcon setImageWithURL:[NSURL URLWithString:square.application_artwork_url_small] placeholderImage:[UIImage imageNamed:@"hi"]];
        cell.actionTypeNameLable.text = square.application_action_type_name;
        cell.actionTypeNameLable.frame = CGRectMake(cell.userName.frame.origin.x + cell.userName.frame.size.width + 5, cell.actionTypeNameLable.frame.origin.y, cell.actionTypeNameLable.frame.size.width, cell.actionTypeNameLable.frame.size.height);
        cell.appName.text = [NSString stringWithFormat:@"%@",square.application_title];
        cell.appName.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
        CGSize sizeOfobjUserName = [square.application_title sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15]];
        
        if (sizeOfobjUserName.width > 120.0) {
            cell.appName.frame = CGRectMake(cell.appName.frame.origin.x, cell.appName.frame.origin.y, 120.0, sizeOfobjUserName.height);
        }else{
            cell.appName.frame = CGRectMake(cell.appName.frame.origin.x, cell.appName.frame.origin.y, sizeOfobjUserName.width, sizeOfobjUserName.height);

        }
        
        
        
        cell.appType.text = [NSString stringWithFormat:@"%@ / %@", square.primary_genre_name, square.supported_device_name];
        if ([[NSString stringWithFormat:@"%@",square.application_retail_price] isEqualToString:@"免费"]) {
            cell.appPric.text = [NSString stringWithFormat:@"%@",square.application_retail_price];
            
            
        }else{
            
        
            cell.appPric.text = [NSString stringWithFormat:@"￥%@",square.application_retail_price];
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
        
        
        
        
        

cell.appPric.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
cell.appPric.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
CGSize priceSize = [cell.appPric.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15]];
cell.appPric.frame = CGRectMake(cell.appPric.frame.origin.x, 59, priceSize.width, priceSize.height);

cell.appPric.center = CGPointMake(cell.appPriceIV.center.x, cell.appName.center.y);


}
    if (square.content.length) {
        CGSize sss = [self customLable13SizeWithString:square.content];
        cell.contentLable.frame = CGRectMake(cell.contentLable.frame.origin.x, cell.contentLable.frame.origin.y, sss.width, sss.height - 4);
        cell.contentLable.text = square.content;
        [cell.contentLable setNumberOfLines:0];
        cell.contentLable.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        cell.contentLable.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        cell.bottomIV.center = CGPointMake(cell.bottomIV.center.x, cell.bottomIV.center.y + sss.height + 5);
        cell.backGroundView.frame = CGRectMake(cell.backGroundView.frame.origin.x, cell.backGroundView.frame.origin.y, cell.backGroundView.frame.size.width, cell.backGroundView.frame.size.height + sss.height + 5);
        cell.customView.frame = CGRectMake(cell.customView.frame.origin.x, cell.customView.frame.origin.y, cell.customView.frame.size.width, cell.customView.frame.size.height + sss.height + 5);
        cell.zanBtn.frame = CGRectMake(cell.zanBtn.frame.origin.x, cell.zanBtn.frame.origin.y + sss.height + 5, cell.zanBtn.frame.size.width, cell.zanBtn.frame.size.height);
    }
    
    
    
    
    cell.userName.center = CGPointMake(cell.userName.center.x, cell.actionTypeNameLable.center.y);
    cell.userName.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    
    cell.actionTypeNameLable.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
    
    
    
    
    cell.backGroundView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
    cell.respondBackView.backgroundColor = cell.zanBackView.backgroundColor = cell.centerView.backgroundColor = [UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1.0];
    
    
    [cell.customView setIndex:indexPath.row];
    cell.customView.delegate = self;
    
    [cell.appBtn addTarget:self action:@selector(appBtnClick: event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.zanBtn addTarget:self action:@selector(zanBtnClick: event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.userBtn addTarget:self action:@selector(userBtnClick: event:) forControlEvents:UIControlEventTouchUpInside];
    
//    cell.zanBackView.backgroundColor = [UIColor colorWithRed:247.0/250 green:247.0/250 blue:247.0/250 alpha:1.0];

    return cell;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    application_count = [[self.dataSorce objectAtIndex:indexPath.row]objectForKey:@"application_remind_count"];
//    
//    if (application_count != nil)
//    {                               //如果用户名为空,显示应用页
//        AppsDetailsViewController *appsVc = [AppsDetailsViewController alloc];
//    if (IS_IPHONE5) {
//        appsVc = [appsVc initWithNibName:@"AppsDetailsViewController_iPhone5" bundle:nil];
//    }else{
//        appsVc = [appsVc initWithNibName:@"AppsDetailsViewController_Normal" bundle:nil];
//    }
////        appsVc.app_id = [[self.dataSorce objectAtIndex:indexPath.row]objectForKey:@"application_id"];
////        appsVc.title = @"详情";
//        [self.navigationController pushViewController:appsVc animated:YES];
    
//     } else {           //如果app名为空，显示应用页
//        FriendRootViewController *friendInfo = [[FriendRootViewController alloc]init];
//         
//         friendInfo.friend_id = [[self.dataSorce objectAtIndex:indexPath.row]objectForKey:@"obj_uid"];
//         
//         [self.navigationController pushViewController:friendInfo animated:YES];
//    }
}

- (void)userBtnClick:(id)sender event:(id)event{
    //LeftUser
    NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.myTableview];
    NSIndexPath *indexPath =[self.myTableview indexPathForRowAtPoint:currentTouchPosition];
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
	CGPoint currentTouchPosition = [touch locationInView:self.myTableview];
    NSIndexPath *indexPath =[self.myTableview indexPathForRowAtPoint:currentTouchPosition];
    NSLog(@"app///,%d",indexPath.row);
    SquareModel *sqModel = [self.squarArr objectAtIndex:indexPath.row];
    NSLog(@"price====%@",sqModel.application_retail_price);
//    NSMutableArray *muarrImgUrl = [NSMutableArray arrayWithObjects:@"http://hiphotos.baidu.com/ashine0917/pic/item/e36ab2ecc03770a3b21cb1f9.jpg",@"http://hiphotos.baidu.com/___srj___/pic/item/00f96ed7637dcc7c07088bae.jpg",@"http://hiphotos.baidu.com/salaaio/pic/item/44c5500f9d5a620a6159f329.jpg", nil];

    AppsDetailsViewController *appsVc = [[AppsDetailsViewController alloc] init];
    appsVc.sqModel = sqModel;
//    if (IS_IPHONE5) {
//        appsVc = [appsVc initWithNibName:@"AppsDetailsViewController_iPhone5" bundle:nil];
//    }else{
//        appsVc = [appsVc initWithNibName:@"AppsDetailsViewController_Normal" bundle:nil];
//    }
//    DLog(@"self.squarArr==%@  sqModel==%@",self.squarArr,sqModel.application_id);
    [appsVc setApplication_id:[NSString stringWithFormat:@"%@",sqModel.application_id]];
    [self.navigationController pushViewController:appsVc animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];

}

- (void)zanBtnClick:(id)sender event:(id)event{
    //zan
    NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.myTableview];
    NSIndexPath *indexPath =[self.myTableview indexPathForRowAtPoint:currentTouchPosition];
    NSLog(@"Zan///,%d",indexPath.row);
    
    SquareModel *square = [self.squarArr objectAtIndex:indexPath.row];
    
    NSString *tmp = [NSString stringWithFormat:@"%@",square.is_like];
    
    if ([tmp boolValue]) {
        [RSHTTPMANAGER showActivityView:YES];
        [RSHTTPMANAGER requestUnZanWithEvent_id:square.event_id WithUid:self.currentUID WithSuccess:^(BOOL isSuccess) {
            if (isSuccess) {
                square.is_like = @"0";
                MasterCell1 *cell = (MasterCell1 *)[self.myTableview cellForRowAtIndexPath:indexPath];
                
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
//                [SVProgressHUD showSuccessWithStatus:@"取消赞成功"];
                
            }else{
//                [SVProgressHUD showErrorWithStatus:@"取消赞失败"];
                
            }
            
        } failure:^(NSError *error) {
            
        }];
        
    }else{
        [RSHTTPMANAGER requestZanWithEvent_id:square.event_id WithUid:self.currentUID WithSuccess:^(BOOL isSuccess) {
            if (isSuccess) {
                square.is_like = @"1";
                MasterCell1 *cell = (MasterCell1 *)[self.myTableview cellForRowAtIndexPath:indexPath];
                
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
                
                
                
                
                
                [SVProgressHUD showSuccessWithStatus:@"赞成功"];
            }else{
                [SVProgressHUD showErrorWithStatus:@"请不要重复赞"];
            }
        } failure:^(NSError *error) {
            NSLog(@"..222222222.....%@",error.localizedDescription);
        }];
        
    }

    
}


- (void)touchesBeganWithIndex:(int) index{
    NSLog(@"touchesBeganWithIndex");
    [self setCellHightState:index];
    
}
- (void)touchesCancelWithIndex:(int) index{
     NSLog(@"touchesCancelWithIndex");
    [self setCellNormalState:index];
}
- (void)touchesEndWithIndex:(int) index{
     NSLog(@"touchesEndWithIndex");
   [self setCellNormalState:index];
    
    SquareModel *square = [self.squarArr objectAtIndex:index];
    if ([square.action_type_id intValue] == 3) {
        UserRootViewController *vc = [[UserRootViewController alloc] init];
        vc.uuid = [NSString stringWithFormat:@"%@",square.obj_uid];
        [self.navigationController pushViewController:vc animated:YES];

    }else{
        RespondViewController *revc = [[RespondViewController alloc] init];
        revc.delegate = self;
        revc.squareModle = square;
        [self.navigationController pushViewController:revc animated:YES];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];
}
- (void)touchesMoveWithIndex:(int) index{
     NSLog(@"touchesMoveWithIndex");
    [self setCellNormalState:index];
}

- (void)refreshData{
    [self getData];
}

- (void)setCellNormalState:(int)index{
    MasterCell1 *cell = (MasterCell1 *)[self.myTableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    cell.backGroundView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
    cell.respondBackView.backgroundColor = cell.zanBackView.backgroundColor = cell.centerView.backgroundColor = [UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1.0];
}


- (void)setCellHightState:(int)index{
    MasterCell1 *cell = (MasterCell1 *)[self.myTableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    cell.backGroundView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
    cell.respondBackView.backgroundColor = cell.zanBackView.backgroundColor = cell.centerView.backgroundColor = [UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1.0];
}



- (UIImageView *)setCustomTopView:(BOOL)isLogin{
    UIImageView *tmpV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    tmpV.image = [UIImage imageNamed:@"MasterTop.png"];
    tmpV.userInteractionEnabled = YES;
    self.myBroadcastBt = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myBroadcastBt.frame = CGRectMake(160, 0, 160, 39);
    self.myBroadcastBt.tag = 1;
    [self.myBroadcastBt addTarget:self action:@selector(broadcastBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tmpV addSubview:self.myBroadcastBt];
    
    self.publicBroadcastBt = [UIButton buttonWithType:UIButtonTypeCustom];
    self.publicBroadcastBt.frame = CGRectMake(0, 0, 160, 39);
    self.publicBroadcastBt.tag = 2;
    [self.publicBroadcastBt addTarget:self action:@selector(broadcastBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [tmpV addSubview:self.publicBroadcastBt];
    
    [self.myBroadcastBt setTitle:@"我的广播" forState:UIControlStateNormal];
    [self.myBroadcastBt setTitle:@"我的广播" forState:UIControlStateHighlighted];
    self.myBroadcastBt.titleLabel.font  = [UIFont fontWithName:@"Helvetica Neue" size:14];
    
    [self.publicBroadcastBt setTitle:@"公共广播" forState:UIControlStateNormal];
    [self.publicBroadcastBt setTitle:@"公共广播" forState:UIControlStateHighlighted];
    self.publicBroadcastBt.titleLabel.font  = [UIFont fontWithName:@"Helvetica Neue" size:14];

    UIView *tmp = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 320, 1)];
    tmp.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
    
    [tmpV addSubview:tmp];
    
    
    if (isLogin) {
        [self setBroadcasteStat:YES];
    }else{
        [self setBroadcasteStat:NO];
    }
    return tmpV;
}

- (void)setBroadcasteStat:(BOOL)isMy{
    if (isMy) {
        [self.myBroadcastBt setTitleColor:[UIColor colorWithRed:51.0f/255.0f green:153.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        [self.myBroadcastBt setTitleColor:[UIColor colorWithRed:51.0f/255.0f green:153.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateHighlighted];
        [self.publicBroadcastBt setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        [self.publicBroadcastBt setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateHighlighted];
        self.myBroadcastBt.selected = YES;
        self.publicBroadcastBt.selected = NO;
    }else{
        [self.myBroadcastBt setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        [self.myBroadcastBt setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateHighlighted];
        [self.publicBroadcastBt setTitleColor:[UIColor colorWithRed:51.0f/255.0f green:153.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        [self.publicBroadcastBt setTitleColor:[UIColor colorWithRed:51.0f/255.0f green:153.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateHighlighted];
        self.myBroadcastBt.selected = NO;
        self.publicBroadcastBt.selected = YES;
    }
}

- (void)broadcastBtnClick:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 1) {
        [self setBroadcasteStat:YES];
        self.myBroadcastBt.selected = YES;
        self.myBroadcastBt.userInteractionEnabled = NO;
        self.publicBroadcastBt.selected = NO;
    }else if (btn.tag == 2){
        [self setBroadcasteStat:NO];
        self.myBroadcastBt.selected = NO;
        self.publicBroadcastBt.selected = YES;
        self.publicBroadcastBt.userInteractionEnabled = NO;
    }
//    [self.myTableview triggerPullToRefresh];
    [self getData];
}

@end
