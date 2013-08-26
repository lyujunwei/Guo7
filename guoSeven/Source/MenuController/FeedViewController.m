//
//  FeedViewController.m
//  weShare
//
//  Created by zucknet on 12/11/11.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "FeedViewController.h"
#import "DDMenuController.h"
#import "AppDelegate.h"
#import "SetViewController.h"
#import "TestFriendViewController.h"
#import "TestSearchViewController.h"
#import "TestRelikeViewController.h"
#import "SBJson.h"
#import "MasterViewController.h"
#import "WantViewController.h"
#import "TosearchViewController.h"
#import "UserRootViewController.h"
#import "FriendRootViewController.h"
#import "iMessageViewController.h"
#import "SearchViewController.h"
#import "UIImageView+AFNetworking.h"
#import "RSHttpManager.h"
#import "UIBadgeView.h"
#import "NotificaitonModel.h"
#import "FeedCell.h"
#import "RSHttpManager.h"


@interface FeedViewController ()
@property (nonatomic, retain) NSString *currentUID;
@property (nonatomic, retain) UIBadgeView *ywBV;
@property (nonatomic, retain) UIBadgeView *gzBV;
@property (nonatomic, retain) UIBadgeView *tjBV;
@property (nonatomic, retain) UIBadgeView *sxBV;

@end

@implementation FeedViewController
@synthesize namelabel;
@synthesize touxiangImg;
@synthesize dataSorce;
@synthesize currentUID;
@synthesize ywBV, gzBV, tjBV, sxBV;

@synthesize noteiceString;
@synthesize userInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyiyongle:) name:@"biedianle" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cleanNum:) name:@"cleanNum" object:nil];

    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    //    [self.tableView reloadData];
    NSLog(@"viewWillAppear");
//    [self creatleftViewData];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentUID = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUID]];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    //    self.tableView.separatorColor = [UIColor colorWithRed:35.0/255.0 green:35.0/255.0 blue:35.0/255.0 alpha:1.0f];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = YES;
    
    //    noteiceString = [TableDataSource userNotifcation:[[NSUserDefaults standardUserDefaults]objectForKey:kUID]];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	moreBtn.frame = CGRectMake(0.0, 0.0, 320.0, 20);
    self.tableView.tableHeaderView = moreBtn;
    self.tableView.tableHeaderView.hidden=YES;
    
    notice_sx = [[UIImageView alloc]initWithFrame:CGRectMake(210, 9, 33, 27)];
    notice_sx.image = [UIImage imageNamed:@"notification"];
    
    notice_gz = [[UIImageView alloc]initWithFrame:CGRectMake(210, 9, 33, 27)];
    notice_gz.image = [UIImage imageNamed:@"notification"];
    
    notice_yw = [[UIImageView alloc]initWithFrame:CGRectMake(210, 9, 33, 27)];
    notice_yw.image = [UIImage imageNamed:@"notification"];
    
    notice_tj = [[UIImageView alloc]initWithFrame:CGRectMake(210, 9, 33, 27)];
    notice_tj.image = [UIImage imageNamed:@"notification"];
    
    yw_count = [[NSString alloc] init];
    gz_count = [[NSString alloc] init];
    tj_count = [[NSString alloc] init];
    sx_count = [[NSString alloc] init];
    
    lab_gz = [[UILabel alloc] initWithFrame:CGRectMake(0, -2, 33, 27)];
    lab_tj = [[UILabel alloc] initWithFrame:CGRectMake(0, -2, 33, 27)];
    lab_sx = [[UILabel alloc] initWithFrame:CGRectMake(0, -2, 33, 27)];
    lab_yw = [[UILabel alloc] initWithFrame:CGRectMake(0, -2, 33, 27)];

    
    [self creatleftViewData];
    
    //    [self.tableView reloadData];
    
    
}


- (void)cleanNum:(NSNotification *)noti{
//  [[UIApplication sharedApplication] setStatusBarHidden:NO];
    NSString *uid  = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUID]];

    switch ([[noti object] integerValue]) {
        case 0:
        {
            
        }
            break;
            
        case 1://gz
        {
//            gz_noteiceString = [NSMutableArray arrayWithArray:[TableDataSource gz_Notifcation:[[NSUserDefaults standardUserDefaults] objectForKey:kUID]]];
//            
//            gz_id = [NSMutableArray arrayWithArray:[gz_noteiceString valueForKey:@"message_id"]];
//
//            for (int c = 0; c<[gz_id count]; c++) {
//                gz_send_note = [TableDataSource clear_message:[gz_id objectAtIndex:c]];
//                [UIApplication sharedApplication].applicationIconBadgeNumber --;
//
//            }
//            [gz_id removeAllObjects];
            [RSHTTPMANAGER getNoticationWithType:@"2" WithUserId:uid WithSuccess:^(NSArray *dialogueList) {
                NSLog(@"dialogueList:%@",dialogueList);
                
                gz_id = [NSMutableArray arrayWithArray:[dialogueList valueForKey:@"message_id"]];
                int count = [gz_id count];
                for (int c = 0; c < count; c++) {
                    NSString *tmp = [gz_id objectAtIndex:c];
                    [RSHTTPMANAGER clearNoticationWithMID:tmp WithUserId:uid WithSuccess:^(NSArray *dialogueList) {
                        [UIApplication sharedApplication].applicationIconBadgeNumber --;
                        [gz_id removeObject:tmp];
                        if (c == count - 1) {
                            gz_count = [NSString stringWithFormat:@"0"];
                            for (UIView *tmp in notice_gz.subviews) {
                                if ([tmp isKindOfClass:[UILabel class]]) {
                                    [tmp removeFromSuperview];
                                }
                            }
                            [self.tableView reloadData];
                        }
                    } failure:^(NSError *error) {
                        if (c == count - 1) {
                            gz_count = [NSString stringWithFormat:@"0"];
                            for (UIView *tmp in notice_gz.subviews) {
                                if ([tmp isKindOfClass:[UILabel class]]) {
                                    [tmp removeFromSuperview];
                                }
                            }
                            [self.tableView reloadData];
                        }
                    }];
                }
             
            } failure:^(NSError *error) {
                
            }];

        }
            break;
            
        case 2://yw
        {
//            yw_noteiceString = [NSMutableArray arrayWithArray:[TableDataSource yw_Notifcation:[[NSUserDefaults standardUserDefaults] objectForKey:kUID]]];
//            
//            yw_id = [NSMutableArray arrayWithArray:[yw_noteiceString valueForKey:@"message_id"]];
//
//            for (int c = 0; c<[yw_id count]; c++) {
//                yw_send_note = [TableDataSource clear_message:[yw_id objectAtIndex:c]];
//                [UIApplication sharedApplication].applicationIconBadgeNumber --;
//
//            }
//            
//            [yw_id removeAllObjects];
            [RSHTTPMANAGER getNoticationWithType:@"1" WithUserId:uid WithSuccess:^(NSArray *dialogueList) {
                NSLog(@"dialogueList:%@",dialogueList);
                
                yw_id = [NSMutableArray arrayWithArray:[dialogueList valueForKey:@"message_id"]];
                int count = [yw_id count];
                for (int c = 0; c < count; c++) {
                    NSString *tmp = [yw_id objectAtIndex:c];
                    [RSHTTPMANAGER clearNoticationWithMID:tmp WithUserId:uid WithSuccess:^(NSArray *dialogueList) {
                        [UIApplication sharedApplication].applicationIconBadgeNumber --;
                        [yw_id removeObject:tmp];
                        if (c == count - 1) {
                            yw_count = [NSString stringWithFormat:@"0"];
                            for (UIView *tmp in notice_yw.subviews) {
                                if ([tmp isKindOfClass:[UILabel class]]) {
                                    [tmp removeFromSuperview];
                                }
                            }
                            [self.tableView reloadData];
                        }
                    } failure:^(NSError *error) {
                        if (c == count - 1) {
                            yw_count = [NSString stringWithFormat:@"0"];
                            for (UIView *tmp in notice_yw.subviews) {
                                if ([tmp isKindOfClass:[UILabel class]]) {
                                    [tmp removeFromSuperview];
                                }
                            }
                            [self.tableView reloadData];
                        }
                    }];
                }
                
            } failure:^(NSError *error) {
                
            }];


        }
            break;
            
        case 3://tj
        {
            
//            tj_noteiceString = [NSMutableArray arrayWithArray:[TableDataSource tj_Notifcation:[[NSUserDefaults standardUserDefaults] objectForKey:kUID]]];
//            
//            NSLog(@"tj_noteiceString:%@",tj_noteiceString);
//            tj_id = [NSMutableArray arrayWithArray:[tj_noteiceString valueForKey:@"message_id"]];
//
//        
//            for (int c = 0; c<[tj_id count]; c++) {
//                tj_send_note = [TableDataSource clear_message:[tj_id objectAtIndex:c]];
//                [UIApplication sharedApplication].applicationIconBadgeNumber --;
//
//            }
//            [tj_id removeAllObjects];

            [RSHTTPMANAGER getNoticationWithType:@"3" WithUserId:uid WithSuccess:^(NSArray *dialogueList) {
                NSLog(@"dialogueList:%@",dialogueList);
                
                tj_id = [NSMutableArray arrayWithArray:[dialogueList valueForKey:@"message_id"]];
                int count = [tj_id count];
                for (int c = 0; c < count; c++) {
                    NSString *tmp = [tj_id objectAtIndex:c];
                    [RSHTTPMANAGER clearNoticationWithMID:tmp WithUserId:uid WithSuccess:^(NSArray *dialogueList) {
                        [UIApplication sharedApplication].applicationIconBadgeNumber --;
                        [tj_id removeObject:tmp];
                        if (c == count -1) {
                            tj_count = [NSString stringWithFormat:@"0"];
                            for (UIView *tmp in notice_tj.subviews) {
                                if ([tmp isKindOfClass:[UILabel class]]) {
                                    [tmp removeFromSuperview];
                                }
                            }
                            [self.tableView reloadData];
                        }
                    } failure:^(NSError *error) {
                        if (c == count -1) {
                            tj_count = [NSString stringWithFormat:@"0"];
                            for (UIView *tmp in notice_tj.subviews) {
                                if ([tmp isKindOfClass:[UILabel class]]) {
                                    [tmp removeFromSuperview];
                                }
                            }
                            [self.tableView reloadData];
                        }
                    }];
                }
                
            } failure:^(NSError *error) {
                
            }];

            
        }
            break;
        case 4:
        {
            
        }
            break;
            
        case 5://sx
        {
            
            [RSHTTPMANAGER getNoticationWithType:@"4" WithUserId:uid WithSuccess:^(NSArray *dialogueList) {
                NSLog(@"dialogueList:%@",dialogueList);
                
                sx_id = [NSMutableArray arrayWithArray:[dialogueList valueForKey:@"message_id"]];
                int count = [sx_id count];
                for (int c = 0; c < count; c++) {
                    NSString *tmp = [sx_id objectAtIndex:c];
                    [RSHTTPMANAGER clearNoticationWithMID:tmp WithUserId:uid WithSuccess:^(NSArray *dialogueList) {
                        [UIApplication sharedApplication].applicationIconBadgeNumber --;
                        [sx_id removeObject:tmp];
                        if (c == count - 1) {
                            sx_count = [NSString stringWithFormat:@"0"];
                            for (UIView *tmp in notice_sx.subviews) {
                                if ([tmp isKindOfClass:[UILabel class]]) {
                                    [tmp removeFromSuperview];
                                }
                            }
                            [self.tableView reloadData];
                        }
                    } failure:^(NSError *error) {
                        if (c == count - 1) {
                            sx_count = [NSString stringWithFormat:@"0"];
                            for (UIView *tmp in notice_sx.subviews) {
                                if ([tmp isKindOfClass:[UILabel class]]) {
                                    [tmp removeFromSuperview];
                                }
                            }
                            [self.tableView reloadData];
                        }
                    }];
                }
                
            } failure:^(NSError *error) {
                
            }];

        }
            break;
            
            
        default:
            break;
    }
}


- (void)keyiyongle:(NSNotification *)noti{
    self.view.userInteractionEnabled = YES;
    [self creatleftViewData];

}




-(void)creatleftViewData{
    NSLog(@"creatleftViewData");
    [RSHTTPMANAGER requestNotificationWithUID:self.currentUID WithSuccess:^(NSArray *notiList) {
        if ([notiList count]) {
            NotificaitonModel *noti = [notiList objectAtIndex:0];
            
            
            
            yw_count = [NSString stringWithFormat:@"%@",noti.yw_count];
            gz_count = [NSString stringWithFormat:@"%@",noti.gz_count];
            tj_count = [NSString stringWithFormat:@"%@",noti.tj_count];
            sx_count = [NSString stringWithFormat:@"%@",noti.sx_count];
            
            
            
            for (UIView *tmp in notice_yw.subviews) {
                if ([tmp isKindOfClass:[UILabel class]]) {
                    [tmp removeFromSuperview];
                }
            }
            for (UIView *tmp in notice_gz.subviews) {
                if ([tmp isKindOfClass:[UILabel class]]) {
                    [tmp removeFromSuperview];
                }
            }
            for (UIView *tmp in notice_tj.subviews) {
                if ([tmp isKindOfClass:[UILabel class]]) {
                    [tmp removeFromSuperview];
                }
            }
            for (UIView *tmp in notice_sx.subviews) {
                if ([tmp isKindOfClass:[UILabel class]]) {
                    [tmp removeFromSuperview];
                }
            }
            
            lab_gz = [[UILabel alloc] initWithFrame:CGRectMake(0, -2, 33, 27)];
            lab_tj = [[UILabel alloc] initWithFrame:CGRectMake(0, -2, 33, 27)];
            lab_sx = [[UILabel alloc] initWithFrame:CGRectMake(0, -2, 33, 27)];
            lab_yw = [[UILabel alloc] initWithFrame:CGRectMake(0, -2, 33, 27)];
            
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(IBAction)logoutBtn:(id)sender{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUIcon];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUNickNamm];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUSignature];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUEmail];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 51;
    }
    if (indexPath.row == 1 ||indexPath.row == 4 || indexPath.row == 9 ) {
        return 25;
    }
    if (indexPath.row == 10) {
        return 90;
    }
    return 41;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [@"set" stringByAppendingFormat:@"%d%d", indexPath.section, indexPath.row];
    FeedCell *cell = (FeedCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"FeedCell" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.leftLB.textColor  =[UIColor whiteColor];
    cell.leftLB.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    cell.leftLB.textAlignment = NSTextAlignmentLeft;
    cell.backGoundView.backgroundColor = [UIColor colorWithRed:64.0f/255.0f green:64.0f/255.0f blue:64.0f/255.0f alpha:1.0f];
    
//    celllab = [[UILabel alloc]initWithFrame:CGRectMake(0, -2, 33, 27)];
//    celllab.backgroundColor=[UIColor clearColor];
//    celllab.textColor = [UIColor whiteColor];
//    celllab.textAlignment = NSTextAlignmentCenter;
//    celllab.font=[UIFont systemFontOfSize:15.0f];
//    celllab.font=[UIFont fontWithName:@"Helvetica Neue" size:15];
    
    if (indexPath.row == 0) {
        cell.bGView.hidden = NO;
        cell.bGView.frame = CGRectMake(10, 5, 40, 40);
        
        cell.bGView.backgroundColor = [UIColor colorWithRed:49.0/255.0 green:49.0/255.0 blue:49.0/255.0 alpha:1.0];
        cell.iconImg.frame = CGRectMake(12, 7, 35, 35);
        cell.iconImg.center = cell.bGView.center;
        
        [cell.iconImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUIcon]]] placeholderImage:[UIImage imageNamed:@"hi"]];
        cell.leftLB.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUNickNamm]];
        //        cell.leftLB.text = @"kninioioini";
        //        cell.leftLB.center = CGPointMake(60, cell.iconImg.center.y);
        cell.leftLB.frame = CGRectMake(60, 0, 200, 51);
        //        cell.leftLB.backgroundColor = [UIColor redColor];
        cell.backGoundView.backgroundColor = [UIColor colorWithRed:66.0/255 green:66.0/255 blue:66.0/255 alpha:1.0];
        cell.backGoundView.frame = CGRectMake(0, 0, 320, 51);
        
        cell.iconImg.center = CGPointMake(cell.iconImg.center.x, cell.backGoundView.center.y);
        cell.leftLB.center = CGPointMake(cell.leftLB.center.x, cell.backGoundView.center.y);
        cell.cutomView.frame = cell.backGoundView.frame;
        
        cell.bottomLine.frame = CGRectMake(0, cell.cutomView.frame.size.height - 1, 315, 1);
    }
    
    if (indexPath.row == 1) {
        cell.leftLB.text = @"App";
        cell.backGoundView.backgroundColor = [UIColor colorWithRed:53.0/255 green:53.0/255 blue:53.0/255 alpha:1.0];
        cell.backGoundView.frame = CGRectMake(0, 0, 320, 25);
        cell.leftLB.frame = CGRectMake(21, 0, 320, 25);
        
        cell.leftLB.center = CGPointMake(cell.leftLB.center.x, cell.backGoundView.center.y);
        cell.cutomView.frame = cell.backGoundView.frame;
        cell.bottomLine.frame = CGRectMake(0, cell.cutomView.frame.size.height - 1, 315, 1);
        
    }
    
    if (indexPath.row == 2) {
        cell.bGView.hidden = YES;
        cell.iconImg.frame = CGRectMake(21, 15, 20, 20);
        cell.leftLB.text = @"广播";
        cell.leftLB.frame = CGRectMake(60, 0, 200, 51);
        cell.iconImg.image = [UIImage imageNamed:@"Chat.png"];
        cell.backGoundView.backgroundColor = [UIColor colorWithRed:66.0/255 green:66.0/255 blue:66.0/255 alpha:1.0];
        cell.backGoundView.frame = CGRectMake(0, 0, 320, 41);
        
        cell.iconImg.center = CGPointMake(cell.iconImg.center.x, cell.backGoundView.center.y);
        cell.leftLB.center = CGPointMake(cell.leftLB.center.x, cell.backGoundView.center.y);
        cell.cutomView.frame = cell.backGoundView.frame;
        cell.bottomLine.frame = CGRectMake(0, cell.cutomView.frame.size.height - 1, 315, 1);
        
    }
    if (indexPath.row == 3) {
        cell.bGView.hidden = YES;
        cell.leftLB.text = @"搜索";
        cell.leftLB.frame = CGRectMake(60, 0, 200, 51);
        cell.iconImg.frame = CGRectMake(21, 15, 20, 20);
        cell.iconImg.image = [UIImage imageNamed:@"Search.png"];
        cell.backGoundView.backgroundColor = [UIColor colorWithRed:66.0/255 green:66.0/255 blue:66.0/255 alpha:1.0];
        cell.backGoundView.frame = CGRectMake(0, 0, 320, 41);
        
        cell.iconImg.center = CGPointMake(cell.iconImg.center.x, cell.backGoundView.center.y);
        cell.leftLB.center = CGPointMake(cell.leftLB.center.x, cell.backGoundView.center.y);
        cell.cutomView.frame = cell.backGoundView.frame;
        cell.bottomLine.frame = CGRectMake(0, cell.cutomView.frame.size.height - 1, 315, 1);
        
    }
    if (indexPath.row == 4) {
        cell.bGView.hidden = YES;
        cell.leftLB.text = @"我的";
        cell.leftLB.frame = CGRectMake(21, 0, 320, 25);
        cell.backGoundView.backgroundColor = [UIColor colorWithRed:53.0/255 green:53.0/255 blue:53.0/255 alpha:1.0];
        cell.backGoundView.frame = CGRectMake(0, 0, 320, 25);
        
        cell.leftLB.center = CGPointMake(cell.leftLB.center.x, cell.backGoundView.center.y);
        cell.cutomView.frame = cell.backGoundView.frame;
        cell.bottomLine.frame = CGRectMake(0, cell.cutomView.frame.size.height - 1, 315, 1);
        
    }
    
    
    if (indexPath.row == 5) {
        notice_yw.hidden = YES;
        cell.leftLB.text = @"愿望清单";
        cell.leftLB.frame = CGRectMake(60, 0, 200, 51);
        cell.iconImg.frame = CGRectMake(21, 15, 20, 20);
        cell.iconImg.image = [UIImage imageNamed:@"Wish.png"];
        cell.backGoundView.backgroundColor = [UIColor colorWithRed:66.0/255 green:66.0/255 blue:66.0/255 alpha:1.0];
        cell.backGoundView.frame = CGRectMake(0, 0, 320, 41);
        
        cell.iconImg.center = CGPointMake(cell.iconImg.center.x, cell.backGoundView.center.y);
        cell.leftLB.center = CGPointMake(cell.leftLB.center.x, cell.backGoundView.center.y);
        cell.cutomView.frame = cell.backGoundView.frame;
        cell.bottomLine.frame = CGRectMake(0, cell.cutomView.frame.size.height - 1, 315, 1);
        
        
        if ([yw_count integerValue] !=0) {
            notice_yw.hidden = NO;
            NSString *tmp = [NSString stringWithFormat:@"%@",yw_count];
            lab_yw.text = tmp;
            
            [RSHTTPMANAGER wantlist_notifcationMessage:kUID WithSuccess:^(BOOL isSucceed) {
                
            } failure:^(NSError *error) {
                
            }];
            
            lab_yw.backgroundColor=[UIColor clearColor];
            lab_yw.textColor = [UIColor whiteColor];
            lab_yw.textAlignment = NSTextAlignmentCenter;
            lab_yw.font=[UIFont systemFontOfSize:15.0f];
            lab_yw.font=[UIFont fontWithName:@"Helvetica Neue" size:15];

            if ([lab_yw.text integerValue]>10) {
                notice_yw.frame = CGRectMake(210, 9, 38, 27);
                lab_yw.frame = CGRectMake(0, -2, 38, 27);
            }
            
            [cell addSubview:notice_yw];
            [notice_yw addSubview:lab_yw];
            
        } else if ([tj_count integerValue] == 0){
            notice_yw.hidden = YES;
        }
        
    }
    
    if (indexPath.row == 6){
        notice_gz.hidden = YES;
        cell.leftLB.text = @"关注与粉丝";
        cell.leftLB.frame = CGRectMake(60, 0, 200, 51);
        cell.iconImg.frame = CGRectMake(21, 15, 20, 20);
        cell.iconImg.image = [UIImage imageNamed:@"User.png"];
        cell.backGoundView.backgroundColor = [UIColor colorWithRed:66.0/255 green:66.0/255 blue:66.0/255 alpha:1.0];
        cell.backGoundView.frame = CGRectMake(0, 0, 320, 41);
        cell.iconImg.center = CGPointMake(cell.iconImg.center.x, cell.backGoundView.center.y);
        cell.leftLB.center = CGPointMake(cell.leftLB.center.x, cell.backGoundView.center.y);
        cell.cutomView.frame = cell.backGoundView.frame;
        cell.bottomLine.frame = CGRectMake(0, cell.cutomView.frame.size.height - 1, 315, 1);
        
        
        if ([gz_count integerValue] !=0) {
            notice_gz.hidden = NO;
            NSString *tmp = [NSString stringWithFormat:@"%@",gz_count];
            lab_gz.text = tmp;
            
            [RSHTTPMANAGER gz_notifcationMessage:kUID WithSuccess:^(BOOL isSucceed) {
                
            } failure:^(NSError *error) {
                
            }];

            lab_gz.backgroundColor=[UIColor clearColor];
            lab_gz.textColor = [UIColor whiteColor];
            lab_gz.textAlignment = NSTextAlignmentCenter;
            lab_gz.font=[UIFont systemFontOfSize:15.0f];
            lab_gz.font=[UIFont fontWithName:@"Helvetica Neue" size:15];
            
            if ([lab_gz.text integerValue]>10) {
                notice_gz.frame = CGRectMake(210, 9, 38, 27);
                lab_gz.frame = CGRectMake(0, -2, 38, 27);

            }
            
            [cell addSubview:notice_gz];
            [notice_gz addSubview:lab_gz];
            
        } else if ([tj_count integerValue] == 0){
            notice_gz.hidden = YES;
        }
    }
    
    
    
    if (indexPath.row == 7){
        notice_tj.hidden = YES;
        cell.leftLB.text = @"推荐与评论";
        cell.leftLB.frame = CGRectMake(60, 0, 200, 51);
        cell.iconImg.frame = CGRectMake(21, 15, 20, 20);
        cell.iconImg.image = [UIImage imageNamed:@"Star.png"];
        cell.backGoundView.backgroundColor = [UIColor colorWithRed:66.0/255 green:66.0/255 blue:66.0/255 alpha:1.0];
        cell.backGoundView.frame = CGRectMake(0, 0, 320, 41);
        cell.iconImg.center = CGPointMake(cell.iconImg.center.x, cell.backGoundView.center.y);
        cell.leftLB.center = CGPointMake(cell.leftLB.center.x, cell.backGoundView.center.y);
        cell.cutomView.frame = cell.backGoundView.frame;
        cell.bottomLine.frame = CGRectMake(0, cell.cutomView.frame.size.height - 1, 315, 1);
        
        if ([tj_count integerValue] !=0) {
            notice_tj.hidden = NO;
            NSString *tmp = [NSString stringWithFormat:@"%@",tj_count];
            lab_tj.text = tmp;

            [RSHTTPMANAGER tj_notifcationMessage:kUID WithSuccess:^(BOOL isSucceed) {
                NSLog(@"Yeah");
            } failure:^(NSError *error) {
                NSLog(@"NO...");
            }];
                        
            lab_tj.backgroundColor=[UIColor clearColor];
            lab_tj.textColor = [UIColor whiteColor];
            lab_tj.textAlignment = NSTextAlignmentCenter;
            lab_tj.font=[UIFont systemFontOfSize:15.0f];
            lab_tj.font=[UIFont fontWithName:@"Helvetica Neue" size:15];
            if ([celllab.text integerValue]>10) {
                notice_tj.frame = CGRectMake(210, 9, 38, 27);
                lab_tj.frame = CGRectMake(0, -2, 38, 27);
            }
            
            [cell addSubview:notice_tj];
            
            [notice_tj addSubview:lab_tj];
            
        } else if ([tj_count integerValue] == 0){
            notice_tj.hidden = YES;
        }
    }
    
    if (indexPath.row == 8){
        notice_sx.hidden = YES;
        cell.leftLB.text = @"私信";
        cell.leftLB.frame = CGRectMake(60, 0, 200, 51);
        cell.iconImg.frame = CGRectMake(21, 15, 20, 20);
        cell.iconImg.image = [UIImage imageNamed:@"Message.png"];
        cell.backGoundView.backgroundColor = [UIColor colorWithRed:66.0/255 green:66.0/255 blue:66.0/255 alpha:1.0];
        cell.backGoundView.frame = CGRectMake(0, 0, 320, 41);
        cell.iconImg.center = CGPointMake(cell.iconImg.center.x, cell.backGoundView.center.y);
        cell.leftLB.center = CGPointMake(cell.leftLB.center.x, cell.backGoundView.center.y);
        cell.cutomView.frame = cell.backGoundView.frame;
        cell.bottomLine.frame = CGRectMake(0, cell.cutomView.frame.size.height - 1, 315, 1);
        
        if ([sx_count integerValue] !=0) {
            
            notice_sx.hidden = NO;
            NSString *tmp = [NSString stringWithFormat:@"%@",sx_count];
            NSLog(@"sx_count:%@",sx_count);
            lab_sx.text = tmp;
            
            //获取私信通知
            
            
            [RSHTTPMANAGER sx_notifcationMessage:kUID WithSuccess:^(BOOL isSucceed) {
                NSLog(@"到我了..");
                
//                lab_sx.text = 
                
            } failure:^(NSError *error) {
                NSLog(@"报错了..");
            }];
            
//            sx_noteiceString = [NSMutableArray arrayWithArray:[TableDataSource sx_Notifcation:[[NSUserDefaults standardUserDefaults] objectForKey:kUID]]];
//            NSLog(@"sx_noteiceString:%@",sx_noteiceString);
        
//            sx_id = [NSMutableArray arrayWithArray:[sx_noteiceString valueForKey:@"message_id"]];
//            NSLog(@"sx_id:%@",sx_id);
            lab_sx.backgroundColor=[UIColor clearColor];
            lab_sx.textColor = [UIColor whiteColor];
            lab_sx.textAlignment = NSTextAlignmentCenter;
            lab_sx.font=[UIFont systemFontOfSize:15.0f];
            lab_sx.font=[UIFont fontWithName:@"Helvetica Neue" size:15];
            
            if ([lab_sx.text integerValue]>10) {
                notice_sx.frame = CGRectMake(210, 9, 38, 27);
                lab_sx.frame = CGRectMake(0, -2, 38, 27);
            }
            
            [cell addSubview:notice_sx];
            [notice_sx addSubview:lab_sx];
            
        } else if ( [sx_count integerValue] == 0){
            notice_sx.hidden = YES;
        }
        
    }
    
    if (indexPath.row == 9) {
        cell.bGView.hidden = YES;
        cell.leftLB.text = @"其他";
        cell.leftLB.frame = CGRectMake(21, 0, 320, 25);
        cell.backGoundView.backgroundColor = [UIColor colorWithRed:53.0/255 green:53.0/255 blue:53.0/255 alpha:1.0];
        cell.backGoundView.frame = CGRectMake(0, 0, 320, 25);
        
        cell.leftLB.center = CGPointMake(cell.leftLB.center.x, cell.backGoundView.center.y);
        cell.cutomView.frame = cell.backGoundView.frame;
        cell.bottomLine.frame = CGRectMake(0, cell.cutomView.frame.size.height - 1, 315, 1);
        
    }
    if (indexPath.row == 10) {
        cell.bGView.hidden = YES;
        cell.leftLB.text = @"设置";
        cell.leftLB.frame = CGRectMake(60, 0, 200, 51);
        cell.iconImg.frame = CGRectMake(21, 12, 20, 20);
        cell.iconImg.image = [UIImage imageNamed:@"Setting.png"];
        cell.backGoundView.backgroundColor = [UIColor colorWithRed:66.0/255 green:66.0/255 blue:66.0/255 alpha:1.0];
        cell.backGoundView.frame = CGRectMake(0, 0, 320, 41);
        cell.leftLB.center = CGPointMake(cell.leftLB.center.x, cell.iconImg.center.y);
        cell.backGoundView.backgroundColor = [UIColor clearColor];
        cell.cutomView.frame = cell.backGoundView.frame;
        cell.bottomLine.hidden = YES;
        
    }
    cell.cutomView.delegate = self;
    [cell.cutomView setIndex:indexPath.row];
    return cell;
}

- (void)touchesBeganWithIndex:(int) index{
    NSLog(@"touchesBeganWithIndex");
    if (index == 0 || index == 2 || index == 3 || index == 5 || index == 6 ||index == 7 || index == 8 || index == 10) {
        FeedCell *cell = (FeedCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.backGoundView.backgroundColor = [UIColor colorWithRed:50.0/255 green:50.0/255 blue:50.0/255 alpha:1.0];
    }
}

- (void)touchesCancelWithIndex:(int) index{
    NSLog(@"touchesCancelWithIndex");
    if (index == 0 || index == 2 || index == 3 || index == 5 || index == 6 ||index == 7 || index == 8) {
        FeedCell *cell = (FeedCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.backGoundView.backgroundColor = [UIColor colorWithRed:66.0/255 green:66.0/255 blue:66.0/255 alpha:1.0];
    }else if (index == 10){
        FeedCell *cell = (FeedCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.backGoundView.backgroundColor = [UIColor clearColor];
        
    }
}

- (void)touchesEndWithIndex:(int) index{
    NSLog(@"touchesEndWithIndex");
    NSString *uid  = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUID]];

    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    
    if (index == 0) {
        FeedCell *cell = (FeedCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.backGoundView.backgroundColor = [UIColor colorWithRed:66.0/255 green:66.0/255 blue:66.0/255 alpha:1.0];
        self.view.userInteractionEnabled = NO;
        UserRootViewController *userController =[[UserRootViewController alloc]init];
        userController.uuid = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUID]];
        UINavigationController *navController =[[UINavigationController alloc]initWithRootViewController:userController];
        [menuController setRootController:navController animated:YES];
        userController.title=@"个人首页";
    }
    if (index == 2) {
        FeedCell *cell = (FeedCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.backGoundView.backgroundColor = [UIColor colorWithRed:66.0/255 green:66.0/255 blue:66.0/255 alpha:1.0];
        self.view.userInteractionEnabled = NO;
        MasterViewController *lobbyController =[[MasterViewController alloc]init];
        UINavigationController *navController =[[UINavigationController alloc]initWithRootViewController:lobbyController];
        [menuController setRootController:navController animated:YES];
        lobbyController.title=@"广场";
    }
    if (index == 3) {
        FeedCell *cell = (FeedCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.backGoundView.backgroundColor = [UIColor colorWithRed:66.0/255 green:66.0/255 blue:66.0/255 alpha:1.0];
        self.view.userInteractionEnabled = NO;
        SearchViewController *searchController = [[SearchViewController alloc]init];
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:searchController];
        [menuController setRootController:navController animated:YES];
        searchController.title=@"搜索";
    }
    if (index == 5) {
        FeedCell *cell = (FeedCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.backGoundView.backgroundColor = [UIColor colorWithRed:66.0/255 green:66.0/255 blue:66.0/255 alpha:1.0];
        self.view.userInteractionEnabled = NO;
        
//        for (int c = 0; c<[yw_id count]; c++) {
//            yw_send_note = [TableDataSource clear_message:[yw_id objectAtIndex:c]];
//            [UIApplication sharedApplication].applicationIconBadgeNumber --;
//
//        }

        for (int c = 0; c < [yw_id count]; c++) {
            [RSHTTPMANAGER clearNoticationWithMID:[yw_id objectAtIndex:c] WithUserId:uid WithSuccess:^(NSArray *dialogueList) {
                [UIApplication sharedApplication].applicationIconBadgeNumber --;
                
            } failure:^(NSError *error) {
                
            }];
        }
        [yw_id removeAllObjects];

        notice_yw.hidden = YES;
        
        WantViewController *wantVC =[[WantViewController alloc]init];
        [wantVC getdata];
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:wantVC];
        
        [menuController setRootController:navController animated:YES];
        wantVC.title=@"愿望清单";
    }
    if (index == 6) {
        
        FeedCell *cell = (FeedCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.backGoundView.backgroundColor = [UIColor colorWithRed:66.0/255 green:66.0/255 blue:66.0/255 alpha:1.0];
        self.view.userInteractionEnabled = NO;
        
//        for (int c = 0; c<[gz_id count]; c++) {
//            gz_send_note = [TableDataSource clear_message:[gz_id objectAtIndex:c]];
//            [UIApplication sharedApplication].applicationIconBadgeNumber --;
//
//        }
        for (int c = 0; c < [gz_id count]; c++) {
            [RSHTTPMANAGER clearNoticationWithMID:[gz_id objectAtIndex:c] WithUserId:uid WithSuccess:^(NSArray *dialogueList) {
                [UIApplication sharedApplication].applicationIconBadgeNumber --;
                
            } failure:^(NSError *error) {
                
            }];
        }
        [gz_id removeAllObjects];

        
        notice_gz.hidden = YES;
        
        TestFriendViewController *friendController =[[TestFriendViewController alloc]init];
   

        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:friendController];
        friendController.title=@"关注与粉丝";
        [menuController setRootController:navController animated:YES];
        [friendController.topbtn1 setSelected:YES];
        [friendController.topbtn2 setSelected:NO];

        [friendController getData];

    }
    if (index == 7 ) {
        
        FeedCell *cell = (FeedCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.backGoundView.backgroundColor = [UIColor colorWithRed:66.0/255 green:66.0/255 blue:66.0/255 alpha:1.0];
        self.view.userInteractionEnabled = NO;
        
//        for (int c = 0; c<[tj_id count]; c++) {
//            tj_send_note = [TableDataSource clear_message:[tj_id objectAtIndex:c]];
//            [UIApplication sharedApplication].applicationIconBadgeNumber --;
//
//        }
        for (int c = 0; c < [tj_id count]; c++) {
            [RSHTTPMANAGER clearNoticationWithMID:[tj_id objectAtIndex:c] WithUserId:uid WithSuccess:^(NSArray *dialogueList) {
                [UIApplication sharedApplication].applicationIconBadgeNumber --;
                
            } failure:^(NSError *error) {
                
            }];
        }

        
        
        [tj_id removeAllObjects];

        notice_tj.hidden = YES;
        
        TestRelikeViewController *reviewController = [[TestRelikeViewController alloc]init];
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:reviewController];
    
        [menuController setRootController:navController animated:YES];
        reviewController.title=@"推荐与评论";
        reviewController.topbtn1.selected = YES;
        reviewController.topbtn2.selected = NO;
        [reviewController getData];
    }
    if (index == 8) {
        
        FeedCell *cell = (FeedCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.backGoundView.backgroundColor = [UIColor colorWithRed:66.0/255 green:66.0/255 blue:66.0/255 alpha:1.0];
        self.view.userInteractionEnabled = NO;
        NSLog(@"sx_id:%@",sx_id);
//        for (int c = 0; c<[sx_id count]; c++) {
//            
//            sx_send_note = [TableDataSource clear_message:[sx_id objectAtIndex:c]];
//            NSLog(@"sx_send_note:%@",sx_send_note);
//            [UIApplication sharedApplication].applicationIconBadgeNumber --;
//        }

        
        for (int c = 0; c < [sx_id count]; c++) {
            [RSHTTPMANAGER clearNoticationWithMID:[sx_id objectAtIndex:c] WithUserId:uid WithSuccess:^(NSArray *dialogueList) {
                [UIApplication sharedApplication].applicationIconBadgeNumber --;
                
            } failure:^(NSError *error) {
                
            }];
        }

        
        [sx_id removeAllObjects];
        
        notice_sx.hidden = YES;
        
        iMessageViewController *msgController =[[iMessageViewController alloc]init];
        UINavigationController *navController =[[UINavigationController alloc]initWithRootViewController:msgController];
        
        [menuController setRootController:navController animated:YES];
        msgController.title = @"私信";
        
    }
    
    if (index == 10) {
        FeedCell *cell = (FeedCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.backGoundView.backgroundColor = [UIColor clearColor];
        
        self.view.userInteractionEnabled = NO;
        SetViewController *setController =[[SetViewController alloc]init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:setController];
        [menuController setRootController:navController animated:YES];
        setController.title=@"设置";
    }
}

- (void)touchesMoveWithIndex:(int) index{
    NSLog(@"touchesMoveWithIndex");
    if (index == 0 || index == 2 || index == 3 || index == 5 || index == 6 ||index == 7 || index == 8) {
        FeedCell *cell = (FeedCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.backGoundView.backgroundColor = [UIColor colorWithRed:50.0/255 green:50.0/255 blue:50.0/255 alpha:1.0];
    }else if (index == 10){
        FeedCell *cell = (FeedCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.backGoundView.backgroundColor = [UIColor clearColor];
        
    }
}

@end
