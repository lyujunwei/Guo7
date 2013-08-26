//
//  TestRelikeViewController.m
//  guoSeven
//
//  Created by zucknet on 12/12/12.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "TestRelikeViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AppsDetailsViewController.h"

#import "RSHttpManager.h"
#import "TopicModel.h"

#import "TestRelikeCell.h"
#import "SVPullToRefresh.h"
#import "SVProgressHUD.h"

@interface TestRelikeViewController ()
@property (nonatomic, retain) NSMutableArray *dataArr;
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) NSString *currentUID;

@end

@implementation TestRelikeViewController
@synthesize like_dataSorce;
@synthesize talk_dataSorce;
@synthesize user_like,user_talk;
@synthesize dataSorce;
@synthesize myTableView;
@synthesize topbtn1, topbtn2;
@synthesize dataArr;
@synthesize currentUID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.currentUID = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUID]];
        
        //    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        //    topView.backgroundColor = [UIImage imageNamed:@"MasterTop.png"];
        //    topView.backgroundColor = [UIColor lightGrayColor];
        
        UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 51)];
        topView.image = [UIImage imageNamed:@"MasterTop.png"];
        topView.userInteractionEnabled = YES;
        
        [self.view addSubview:topView];
        
        self.topbtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.topbtn1 setFrame:CGRectMake(0 , 0, 160.0, 40)];
        [self.topbtn1 setTitle:@"我的推荐" forState:UIControlStateNormal];
        //    topbtn1.backgroundColor = [UIColor lightGrayColor];
        [self.topbtn1 addTarget:self action:@selector(goSomeThing:) forControlEvents:UIControlEventTouchUpInside];
        self.topbtn1.titleLabel.font  = [UIFont systemFontOfSize:14];
        self.topbtn1.tag=1;
        [topView addSubview:self.topbtn1];
        
        self.topbtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.topbtn2 setFrame:CGRectMake(160,0,160,40)];
        [self.topbtn2 setTitle:@"我的评论" forState:UIControlStateNormal];
        //    topbtn2.backgroundColor = [UIColor lightTextColor];
        [self.topbtn2 addTarget:self action:@selector(goSomeThing:) forControlEvents:UIControlEventTouchUpInside];
        self.topbtn2.titleLabel.font  = [UIFont systemFontOfSize:14];
        self.topbtn2.tag=2;
        [topView addSubview:self.topbtn2];
        
        [topbtn1 setTitleColor:[UIColor colorWithRed:51.0f/255.0f green:153.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        [topbtn1 setTitleColor:[UIColor colorWithRed:51.0f/255.0f green:153.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateHighlighted];
        [topbtn2 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        [topbtn2 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateHighlighted];
        
        UIView *tmp = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 320, 1)];
        tmp.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
        //    tmp.backgroundColor = [UIColor redColor];
        [topView addSubview:tmp];
        
        [self.view addSubview:topView];
        self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 41, 320, self.view.frame.size.height - 80.0f)];
        self.myTableView.showsHorizontalScrollIndicator=FALSE;
        self.myTableView.showsVerticalScrollIndicator=FALSE;
        self.myTableView.delegate = self;
        self.myTableView.dataSource = self;
        self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:self.myTableView];
        self.topbtn1.selected = YES;
        //    [self setBroadcasteStat:YES];
        
        [self.myTableView addPullToRefreshWithActionHandler:^{
            if (self.topbtn1.selected) {
                //            [RSHTTPMANAGER showActivityView:YES];
                [RSHTTPMANAGER requestTopicForTalkWithUID:self.currentUID WithSuccess:^(NSArray *topicList) {
                    self.dataArr = [NSMutableArray arrayWithArray:topicList];
                    [self.myTableView reloadData];
                    if ([topicList count]) {
                        
                        //                    NSString *tmp = [NSString stringWithFormat:@"我的推荐 %d", [topicList count]];
                        //
                        //                    [self.topbtn1 setTitle:tmp forState:UIControlStateNormal];
                        
                        [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
                    }
                    
                    [self.myTableView.pullToRefreshView stopAnimating];
                    
                } failure:^(NSError *error) {
                    NSLog(@"///////%@",error.localizedDescription);
                    [self.myTableView.pullToRefreshView stopAnimating];
                }];
            }else{
                //            [RSHTTPMANAGER showActivityView:YES];
                [RSHTTPMANAGER requestTopicForLIKEWithUID:self.currentUID WithSuccess:^(NSArray *topicList) {
                    self.dataArr = [NSMutableArray arrayWithArray:topicList];
                    [self.myTableView reloadData];
                    if ([topicList count]) {
                        
                        //                    NSString *tmp = [NSString stringWithFormat:@"我的评论 %d", [topicList count]];
                        //
                        //                    [self.topbtn1 setTitle:tmp forState:UIControlStateNormal];
                        
                        [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
                    }
                    [self.myTableView.pullToRefreshView stopAnimating];
                    
                } failure:^(NSError *error) {
                    NSLog(@"///////%@",error.localizedDescription);
                    [self.myTableView.pullToRefreshView stopAnimating];
                }];
            }
        }];
        
        //    [self.myTableView triggerPullToRefresh];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
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

}

- (void)getData{
    [SVProgressHUD show];
    if (self.topbtn1.selected) {
        [self xxxx:YES];
        [RSHTTPMANAGER showActivityView:YES];
        [RSHTTPMANAGER requestTopicForTalkWithUID:self.currentUID WithSuccess:^(NSArray *topicList) {
            self.dataArr = [NSMutableArray arrayWithArray:topicList];
            [self.myTableView reloadData];
            if ([topicList count]) {
                
                //                    NSString *tmp = [NSString stringWithFormat:@"我的推荐 %d", [topicList count]];
                //
                //                    [self.topbtn1 setTitle:tmp forState:UIControlStateNormal];
                
                [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
                [SVProgressHUD dismiss];
            }
            
            [self.myTableView.pullToRefreshView stopAnimating];
            
        } failure:^(NSError *error) {
            NSLog(@"///////%@",error.localizedDescription);
            [self.myTableView.pullToRefreshView stopAnimating];
        }];
    }else{
        [self xxxx:NO];
        [RSHTTPMANAGER showActivityView:YES];
        [RSHTTPMANAGER requestTopicForLIKEWithUID:self.currentUID WithSuccess:^(NSArray *topicList) {
            self.dataArr = [NSMutableArray arrayWithArray:topicList];
            [self.myTableView reloadData];
            if ([topicList count]) {
                
                //                    NSString *tmp = [NSString stringWithFormat:@"我的评论 %d", [topicList count]];
                //
                //                    [self.topbtn1 setTitle:tmp forState:UIControlStateNormal];
                
                [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
//                [SVProgressHUD dismiss];
            }
            [self.myTableView.pullToRefreshView stopAnimating];
            
        } failure:^(NSError *error) {
            NSLog(@"///////%@",error.localizedDescription);
            [self.myTableView.pullToRefreshView stopAnimating];
        }];
    }
}

- (void)stopstop:(id)sender{
    [self.myTableView.pullToRefreshView stopAnimating];
}


- (void)xxxx:(BOOL)x{
    if (x) {
        self.topbtn1.selected = YES;
        self.topbtn2.selected = NO;
        
        [topbtn1 setTitleColor:[UIColor colorWithRed:51.0f/255.0f green:153.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        [topbtn1 setTitleColor:[UIColor colorWithRed:51.0f/255.0f green:153.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateHighlighted];
        [topbtn2 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        [topbtn2 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateHighlighted];
    }else{
        self.topbtn1.selected = NO;
        self.topbtn2.selected = YES;
        
        [topbtn2 setTitleColor:[UIColor colorWithRed:51.0f/255.0f green:153.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        [topbtn2 setTitleColor:[UIColor colorWithRed:51.0f/255.0f green:153.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateHighlighted];
        [topbtn1 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        [topbtn1 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateHighlighted];
    }
}

-(void)goSomeThing:(id)sender{
    UIButton * button = (UIButton*)sender;
    if (button.tag==1) {
        self.topbtn1.selected = YES;
        self.topbtn2.selected = NO;
        
        [topbtn1 setTitleColor:[UIColor colorWithRed:51.0f/255.0f green:153.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        [topbtn1 setTitleColor:[UIColor colorWithRed:51.0f/255.0f green:153.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateHighlighted];
        [topbtn2 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        [topbtn2 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateHighlighted];

//        [self setBroadcasteStat:YES];
    }
    if (button.tag==2) {
        self.topbtn1.selected = NO;
        self.topbtn2.selected = YES;
        
        [topbtn2 setTitleColor:[UIColor colorWithRed:51.0f/255.0f green:153.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        [topbtn2 setTitleColor:[UIColor colorWithRed:51.0f/255.0f green:153.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateHighlighted];
        [topbtn1 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        [topbtn1 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateHighlighted];

//        [self setBroadcasteStat:NO];
    }
//    [self.myTableView triggerPullToRefresh];
    [self getData];
}

- (CGSize)customLableSizeWithString:(NSString *)str{
    UIFont *font = [UIFont systemFontOfSize:13];
    CGSize size = CGSizeMake(262, 1000);
    CGSize labelsize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    return labelsize;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TopicModel *topic = [self.dataArr objectAtIndex:indexPath.row];
    if (topic.content.length) {
        CGSize s = [self customLableSizeWithString:topic.content];
        return 80 + 10 + s.height;
    }
    return 80.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row];//@"Cell";

    
    TopicModel *topicModel = [self.dataArr objectAtIndex:indexPath.row];
    
    TestRelikeCell *cell = (TestRelikeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"TestRelikeCell" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    [cell.appIcon setImageWithURL:[NSURL URLWithString:topicModel.application_artwork_url_small] placeholderImage:[UIImage imageNamed:@"hi"]];
    
    cell.appName.text = topicModel.application_title;
    cell.appName.font = [UIFont fontWithName:@"Helvetica" size:15];
    
    cell.appType.text = [NSString stringWithFormat:@"%@ / %@",topicModel.primary_genre_name, topicModel.supported_device_name];
    CGSize sizeOfName = [cell.appName.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:15]];
    cell.appName.frame = CGRectMake(cell.appName.frame.origin.x, cell.appIcon.frame.origin.y, sizeOfName.width, sizeOfName.height);
    cell.appName.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    
    
    if (cell.appName.frame.size.width > 180.0) {
        cell.appName.frame = CGRectMake(cell.appName.frame.origin.x, cell.appName.frame.origin.y, 180, cell.appName.frame.size.height);
        
    }
//    if ([[NSString stringWithFormat:@"%@",topicModel.application_retail_price] isEqualToString:@"免费"]) {
//        cell.appPrice.text = topicModel.application_retail_price;
//       // [cell.appPriceType setImage:[UIImage imageNamed:@"appForFree.png"]];
//    }else if ([[NSString stringWithFormat:@"%@",topicModel.application_retail_price] integerValue] == 0) {
//        cell.appPrice.text = @"免费";
//        
//       // [cell.appPriceType setImage:[UIImage imageNamed:@"appForFree.png"]];
//    }else{
////        topicModel.application_retail_price = [topicModel.application_retail_price stringByReplacingOccurrencesOfString:@".00000" withString:@""];
//        cell.appPrice.text = [NSString stringWithFormat:@"￥%d",[topicModel.application_retail_price integerValue]];
//        if ([topicModel.application_retail_price floatValue] > [topicModel.application_old_price floatValue]) {
//            [cell.appPriceType setImage:[UIImage imageNamed:@"apptip5.png"]];
////        }else if ([topicModel.application_retail_price floatValue] < [topicModel.application_old_price floatValue]){
////            [cell.appPriceType setImage:[UIImage imageNamed:@"appForDPrice.png"]];
//        }else{
//            
//        }
//        
//
//        
//    }

    
    if ([[NSString stringWithFormat:@"%@",topicModel.application_retail_price] isEqualToString:@"免费"]) {
        //            cell.appPrice.text = [NSString stringWithFormat:@"%@",square.application_retail_price];
//        [cell.appPriceType setImage:[UIImage imageNamed:@"apptip1.png"]];
        cell.appPrice.text = @"免费";
        
    }else{
        if ([[NSString stringWithFormat:@"%@",topicModel.application_retail_price] integerValue] == 0) {
            topicModel.application_retail_price = @"免费";
            cell.appPrice.text = @"免费";
//            [cell.appPriceType setImage:[UIImage imageNamed:@"apptip1.png"]];
            
        }else{
            //                square.application_retail_price = [square.application_retail_price stringByReplacingOccurrencesOfString:@".00000" withString:@""];
            cell.appPrice.text = [NSString stringWithFormat:@"￥%d",[topicModel.application_retail_price integerValue]];
//            if ([topicModel.application_retail_price floatValue] > [topicModel.application_old_price floatValue]) {
//                [cell.appPriceType setImage:[UIImage imageNamed:@"apptip5.png"]];
//            }else if ([topicModel.application_retail_price floatValue] < [topicModel.application_old_price floatValue]){
//                [cell.appPriceType setImage:[UIImage imageNamed:@"apptip3.png"]];
//            }else{
//                
//            }
        }
    }
    
    if ([topicModel.limitedStateName isEqualToString:@"首次限免"]) {
        [cell.appPriceType setImage:[UIImage imageNamed:@"apptip1.png"]];
    }else if ([topicModel.limitedStateName isEqualToString:@"多次限免"]){
        [cell.appPriceType setImage:[UIImage imageNamed:@"apptip2.png"]];
    }else if ([topicModel.limitedStateName isEqualToString:@"首次冰点"]){
        [cell.appPriceType setImage:[UIImage imageNamed:@"apptip3.png"]];
    }else if ([topicModel.limitedStateName isEqualToString:@"再次冰点"]){
        [cell.appPriceType setImage:[UIImage imageNamed:@"apptip4.png"]];
    }else if ([topicModel.limitedStateName isEqualToString:@"涨价"]){
        [cell.appPriceType setImage:[UIImage imageNamed:@"apptip5.png"]];
    }
    
    
    cell.appPrice.font = [UIFont fontWithName:@"Helvetica" size:15];
    cell.appPrice.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    CGSize priceSize = [cell.appPrice.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:15]];
    cell.appPrice.frame = CGRectMake(cell.appPrice.frame.origin.x, 59, priceSize.width, priceSize.height);
    
    cell.appPrice.center = CGPointMake(cell.appPriceType.center.x, cell.appName.center.y);
    
    
    if (topicModel.content.length) {
//        cell.leftYinIV.hidden = NO;
//        cell.rightYinIV.hidden = NO;
        CGSize sss = [self customLableSizeWithString:topicModel.content];
        cell.appContent.text = topicModel.content;
        [cell.appContent setNumberOfLines:0];
        cell.appContent.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        
        cell.appContent.font = [UIFont fontWithName:@"Helvetica" size:13];
//        + cell.leftYinIV.frame.size.width
        cell.appContent.frame = CGRectMake(cell.appContent.frame.origin.x , cell.appContent.frame.origin.y, sss.width, sss.height);
//        cell.appContent.backgroundColor = [UIColor redColor];
        
//        cell.rightYinIV.frame = CGRectMake(cell.appContent.frame.origin.x + cell.appContent.frame.size.width, cell.appContent.frame.origin.y + cell.appContent.frame.size.height + cell.rightYinIV.frame.size.height / 2, cell.rightYinIV.frame.size.width, cell.rightYinIV.frame.size.height);
        
        
        cell.backGroundView.frame = CGRectMake(cell.backGroundView.frame.origin.x, cell.backGroundView.frame.origin.y, cell.backGroundView.frame.size.width, cell.backGroundView.frame.size.height + sss.height + 10);
        cell.customView.frame = CGRectMake(cell.customView.frame.origin.x, cell.customView.frame.origin.y, cell.customView.frame.size.width, cell.customView.frame.size.height + sss.height + 10);
        cell.bottomIV.frame = CGRectMake(cell.bottomIV.frame.origin.x, cell.bottomIV.frame.origin.y + sss.height + 10, cell.bottomIV.frame.size.width, cell.bottomIV.frame.size.height);
    }
    cell.customView.delegate = self;
    [cell.customView setIndex:indexPath.row];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppsDetailsViewController *appsVc = [[AppsDetailsViewController alloc]init];
//    appsVc.app_id = [[self.dataSorce objectAtIndex:indexPath.row]objectForKey:@"application_id"];
    [self.navigationController pushViewController:appsVc animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];

}



- (void)touchesBeganWithIndex:(int) index{
    NSLog(@"touchesBeganWithIndex");
    TestRelikeCell *cell = (TestRelikeCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    cell.backGroundView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];

}
- (void)touchesCancelWithIndex:(int) index{
    NSLog(@"touchesCancelWithIndex");
    TestRelikeCell *cell = (TestRelikeCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    cell.backGroundView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
}
- (void)touchesEndWithIndex:(int) index{
    NSLog(@"touchesEndWithIndex");
    TestRelikeCell *cell = (TestRelikeCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    cell.backGroundView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
    TopicModel *topicModel = [self.dataArr objectAtIndex:index];

    AppsDetailsViewController *appsVc = [[AppsDetailsViewController alloc]init];
    SquareModel *squar = [[SquareModel alloc] init];
    [appsVc setApplication_id:topicModel.application_id];
    [squar setApplication_artwork_url_small:topicModel.application_artwork_url_small];
    [squar setApplication_title:topicModel.application_title];
    [squar setPrimary_genre_name:topicModel.primary_genre_name];
    [squar setSupported_device_name:topicModel.supported_device_name];
    [squar setApplication_retail_price:[NSString stringWithFormat:@"%d",[topicModel.application_retail_price integerValue]]];
    DLog(@"topicModel.limitedStateName:%@",topicModel.limitedStateName);
    [squar setLimited_state_name:topicModel.limitedStateName];
    appsVc.sqModel = squar;
    appsVc.application_id = topicModel.application_id;
    appsVc.application_id = topicModel.application_id;
    //    appsVc.app_id = [[self.dataSorce objectAtIndex:indexPath.row]objectForKey:@"application_id"];
    [self.navigationController pushViewController:appsVc animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];

}
- (void)touchesMoveWithIndex:(int) index{
    NSLog(@"touchesMoveWithIndex");
    TestRelikeCell *cell = (TestRelikeCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    cell.backGroundView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
