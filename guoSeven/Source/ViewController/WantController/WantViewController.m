//
//  WantViewController.m
//  guoSeven
//
//  Created by zucknet on 13/1/5.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "WantViewController.h"
#import "DetailViewController.h"
#import "SBJson.h"
#import "UIImageView+AFNetworking.h"
#import "AppsDetailsViewController.h"
#import "RespondViewController.h"

#import "RSHttpManager.h"
#import "WantModel.h"
#import "SquareModel.h"
#import "WishCell.h"
#import "SVProgressHUD.h"

@interface WantViewController ()
@property (nonatomic, retain) NSMutableArray *dataArr;
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) NSString *currentUID;

@end

@implementation WantViewController

@synthesize detailViewController = _detailViewController;

//@synthesize want_dataSorce;
@synthesize dataArr;
@synthesize myTableView;
@synthesize currentUID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.currentUID = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUID]];
        
        self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -10, 320, self.view.frame.size.height - 34)];
        self.myTableView.showsHorizontalScrollIndicator=FALSE;
        self.myTableView.showsVerticalScrollIndicator=FALSE;
        self.myTableView.delegate = self;
        self.myTableView.dataSource = self;
        self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:self.myTableView];
        self.view.backgroundColor=[UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1.0];

    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
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


}

- (void)getdata{
    [RSHttpManager requestWantWithUID:self.currentUID  WithLoginID:self.currentUID WithSuccess:^(NSArray *wantList) {
        if ([wantList count]) {
            self.dataArr = [NSMutableArray arrayWithArray:wantList];
            [self.myTableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@".....%@",error.localizedDescription);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (CGSize)customLableSizeWithString:(NSString *)str withWidth:(float)width{
    UIFont *font = [UIFont systemFontOfSize:13];
    CGSize size = CGSizeMake(width, 1000);
    CGSize labelsize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    return labelsize;
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
    
    WantModel *want = [self.dataArr objectAtIndex:indexPath.row];
    WishCell *cell = (WishCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"WishCell" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    [cell.appIcon setImageWithURL:[NSURL URLWithString:want.application_artwork_url_small] placeholderImage:[UIImage imageNamed:@"hi"]];
    cell.appName.text = want.application_title;
    cell.appName.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    CGSize sizeOfName = [cell.appName.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15]];
    cell.appName.frame = CGRectMake(cell.appName.frame.origin.x, cell.appName.frame.origin.y, sizeOfName.width, sizeOfName.height);
    if (cell.appName.frame.size.width > 180.0) {
        cell.appName.frame = CGRectMake(cell.appName.frame.origin.x, cell.appName.frame.origin.y, 180, sizeOfName.height);

    }
    
    
    cell.appName.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    cell.appType.text = [NSString stringWithFormat:@"%@ / %@",want.primary_genre_name, want.supported_device_name];
    cell.appType.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    cell.appType.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
//
//    if ([[NSString stringWithFormat:@"%@",want.application_retail_price] isEqualToString:@"免费"]) {
//        cell.appPrice.text = [NSString stringWithFormat:@"%@",want.application_retail_price];
//        [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip1.png"]];
//    }else{
////        want.application_retail_price = [want.application_retail_price stringByReplacingOccurrencesOfString:@".00000" withString:@"元"];
//        cell.appPrice.text = [NSString stringWithFormat:@"￥%d",[want.application_retail_price integerValue]];
//        if ([want.application_retail_price floatValue] > [want.application_old_price floatValue]) {
//            [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip5.png"]];
////        }else if ([want.application_retail_price floatValue] < [want.application_old_price floatValue]){
////            [cell.appPriveIV setImage:[UIImage imageNamed:@"appForDPrice.png"]];
//        }else{
//            
//        }
//    }
    
    
    if ([[NSString stringWithFormat:@"%@",want.application_retail_price] isEqualToString:@"免费"]) {
        cell.appPrice.text = [NSString stringWithFormat:@"%@",want.application_retail_price];
//        [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip1.png"]];
        cell.appPrice.text = @"免费";
    }else{
        if ([[NSString stringWithFormat:@"%@",want.application_retail_price] integerValue] == 0) {
            want.application_retail_price = @"免费";
            cell.appPrice.text = @"免费";
//            [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip1.png"]];
            
        }else{
            //                want.application_retail_price = [want.application_retail_price stringByReplacingOccurrencesOfString:@".00000" withString:@""];
            cell.appPrice.text = [NSString stringWithFormat:@"￥%d",[want.application_retail_price integerValue]];
//            if ([want.application_retail_price floatValue] > [want.application_old_price floatValue]) {
//                [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip5.png"]];
//            }else if ([want.application_retail_price floatValue] < [want.application_old_price floatValue]){
//                [cell.appPriveIV setImage:[UIImage imageNamed:@"apptip3.png"]];
//            }else{
//                
//            }
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
    
//    NSString *countLike = [NSString stringWithFormat:@"%@",want.like_count_str];
//    if (countLike.length) {
//        if ([countLike intValue] == 0) {
//            cell.zanLabel.text = @"赞";
//        }else{
//            cell.zanLabel.text = [NSString stringWithFormat:@"%d赞",[countLike intValue]];
//        }
//    }else{
//        cell.zanLabel.text = @"赞";
//    }
    
    
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
    
    
    cell.timeLabel.text = [want.create_time substringWithRange:NSMakeRange(5, 11)];
    cell.timeLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    cell.timeLabel.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];

    
    CGSize sizeOfResp = [cell.respondeLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
    cell.respondeLabel.frame = CGRectMake(10, 10, sizeOfResp.width, sizeOfResp.height);
    
    cell.responserBackIV.frame = CGRectMake(cell.zanBackIV.frame.origin.x + cell.zanBackIV.frame.size.width + 10, cell.responserBackIV.frame.origin.y, cell.respondeLabel.frame.size.width + 20, cell.responserBackIV.frame.size.height);
    
    cell.appPrice.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    cell.appPrice.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    CGSize priceSize = [cell.appPrice.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15]];
    cell.appPrice.frame = CGRectMake(cell.appPrice.frame.origin.x, 59, priceSize.width, priceSize.height);
    
    cell.appPrice.center = CGPointMake(cell.appPriveIV.center.x, cell.appName.center.y);
    [cell.appBtn addTarget:self action:@selector(appBtnClick: event:) forControlEvents:UIControlEventTouchUpInside];

    
    [cell.zanBtn addTarget:self action:@selector(zanBtnClick: event:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.customView setIndex:indexPath.row];
    
    cell.appBtn.frame = CGRectMake(0, 0, 320, 60);
    
    cell.customView.delegate = self;
    
    return cell;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    wantheader.backgroundColor=[UIColor clearColor];
    return wantheader;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    wantheader =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,10)];
    [self.view addSubview:wantheader];
    return wantheader.frame.size.height;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppsDetailsViewController *rootVC = [[AppsDetailsViewController alloc]init];
//    rootVC.app_id = [[self.want_dataSorce objectAtIndex:indexPath.row]objectForKey:@"application_id"];
    [self.navigationController pushViewController:rootVC animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];

    
}
- (void)appBtnClick:(id)sender event:(id)event{
    //Center user / app
    NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.myTableView];
    NSIndexPath *indexPath =[self.myTableView indexPathForRowAtPoint:currentTouchPosition];
    NSLog(@"app///,%d",indexPath.row);
    
    AppsDetailsViewController *appsVc = [[AppsDetailsViewController alloc]init];
    WantModel *want = [self.dataArr objectAtIndex:indexPath.row];
    SquareModel * sql = [[SquareModel alloc] init];
    [appsVc setApplication_id:want.application_id];
    [sql setApplication_artwork_url_small:want.application_artwork_url_small];
    [sql setApplication_title:want.application_title];
    [sql setApplication_retail_price:[NSString stringWithFormat:@"%d", [want.application_retail_price integerValue]]];
    [sql setPrimary_genre_name:want.primary_genre_name];
    [sql setSupported_device_name:want.supported_device_name];
    NSLog(@"want.application_title:%@",want.application_title);
    [sql setApplication_title:want.application_title];
    NSLog(@"want.limitedStateName:%@",want.limitedStateName);
    [sql setLimited_state_name:want.limitedStateName];
    appsVc.sqModel = sql;
    appsVc.application_id = want.application_id;
    [self.navigationController pushViewController:appsVc animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];

}



- (void)touchesBeganWithIndex:(int) index{
    NSLog(@"touchesBeganWithIndex");
//    WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//    cell.backGroundView.backgroundColor = [UIColor lightGrayColor];
    WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    cell.backGroundView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
    cell.responserBackIV.backgroundColor = cell.zanBackIV.backgroundColor = cell.responserBackIV.backgroundColor =[UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1.0];
}
- (void)touchesCancelWithIndex:(int) index{
    NSLog(@"touchesCancelWithIndex");
    WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    cell.backGroundView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
    cell.responserBackIV.backgroundColor = cell.zanBackIV.backgroundColor = cell.responserBackIV.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
}
- (void)touchesEndWithIndex:(int) index{
    NSLog(@"touchesEndWithIndex");
    WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    cell.backGroundView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
    cell.responserBackIV.backgroundColor = cell.zanBackIV.backgroundColor = cell.responserBackIV.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
    RespondViewController *respond = [[RespondViewController alloc] init];
//    AppsDetailsViewController *appsVc = [[AppsDetailsViewController alloc]init];
    WantModel *want = [self.dataArr objectAtIndex:index];
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
    sq.is_like = want.is_like;
    sq.like_count_str = want.like_count_str;
    
    respond.squareModle = sq;
    respond.delegate = self;
    
    
//    squar.application_id = want.application_id;
//    appsVc.application_id = want.application_id;
    //    appsVc.app_id = [[self.dataSorce objectAtIndex:indexPath.row]objectForKey:@"application_id"];
    [self.navigationController pushViewController:respond animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];

}
-(void)refreshData{
    [RSHttpManager requestWantWithUID:self.currentUID  WithLoginID:self.currentUID WithSuccess:^(NSArray *wantList) {
        if ([wantList count]) {
            self.dataArr = [NSMutableArray arrayWithArray:wantList];
            [self.myTableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@".....%@",error.localizedDescription);
    }];
}
- (void)touchesMoveWithIndex:(int) index{
    NSLog(@"touchesMoveWithIndex");
//    WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//    cell.backGroundView.backgroundColor = [UIColor whiteColor];
    WishCell *cell = (WishCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    cell.backGroundView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
    cell.responserBackIV.backgroundColor = cell.zanBackIV.backgroundColor = cell.responserBackIV.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
}

- (void)zanBtnClick:(id)sender event:(id)event{
    //zan
    NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.myTableView];
    NSIndexPath *indexPath =[self.myTableView indexPathForRowAtPoint:currentTouchPosition];
    NSLog(@"Zan///,%d",indexPath.row);
    
    WantModel *want = [self.dataArr objectAtIndex:indexPath.row];
    
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
                
                [SVProgressHUD showSuccessWithStatus:@"取消赞成功"];
                
            }else{
                [SVProgressHUD showErrorWithStatus:@"取消赞失败"];
                
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
                [SVProgressHUD showErrorWithStatus:@"赞失败"];
            }
        } failure:^(NSError *error) {
            NSLog(@"..222222222.....%@",error.localizedDescription);
        }];
        
    }
    
    
}

@end
