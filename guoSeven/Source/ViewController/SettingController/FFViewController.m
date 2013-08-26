//
//  FFViewController.m
//  guoSeven
//
//  Created by David on 13-1-30.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "FFViewController.h"
#import "DOUAPIEngine.h"
#import "TCWBEngine.h"
//#import "SinaWeibo.h"
#import "AppDelegate.h"
#import "RSHttpManager.h"
#import "UIBadgeView.h"
#import "UserModel.h"
#import "UIImageView+AFNetworking.h"
#import "UserRootViewController.h"
#import "SVProgressHUD.h"
#import "AllModel.h"
#import "WBFriendModel.h"
#import <QuartzCore/QuartzCore.h>
#import "WeiBoShare.h"
#import "FFCell.h"
#import "SVPullToRefresh.h"

@interface FFViewController ()
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) NSMutableArray *dataArr;
@property (nonatomic, retain) UIBadgeView *bageViewOfSina;
@property (nonatomic, retain) UIBadgeView *bageViewOfTC;
@property (nonatomic, retain) UIBadgeView *bageViewOfDB;
@property (nonatomic, assign) int page;
@property (nonatomic, retain) NSString *currentUID;

@property (nonatomic, retain) SinaWeibo *sina;
@property (nonatomic, retain) TCWBEngine *engine;
@property (nonatomic, retain) DOUService *service;


//@property (nonatomic, assign) BOOL isSinaAvaible;
//@property (nonatomic, assign) BOOL isTCAvaible;
//@property (nonatomic, assign) BOOL isDBAvaible;
@property (nonatomic, assign) BOOL isWBSearch;
@property (nonatomic, retain) WBFriendModel *wbFM;

@property (nonatomic, assign) BOOL isSinaAvailBack;
@property (nonatomic, assign) BOOL isQQAvailBack;
@property (nonatomic, assign) BOOL isDoubanAvailBack;
@property (nonatomic, retain) NSString *searchStr;
@end

@implementation FFViewController
@synthesize dataArr;
@synthesize searchBar;
@synthesize bageViewOfDB, bageViewOfSina, bageViewOfTC;
@synthesize page;
@synthesize currentUID;
@synthesize sina;
@synthesize engine;
@synthesize service;
//@synthesize isDBAvaible, isSinaAvaible, isTCAvaible;
@synthesize isWBSearch;
@synthesize wbFM;
@synthesize isSinaAvailBack, isDoubanAvailBack, isQQAvailBack;
@synthesize searchStr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)backToPreVC:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.myTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.currentUID = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUID]];

    
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
    
//    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 10, 180, 44)];
//    self.searchBar.delegate=self;
//    self.searchBar.placeholder = @"输入邮箱地址查找好友";
//    [[self.searchBar.subviews objectAtIndex:0] removeFromSuperview];
//    [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"search_bar.png"] forState:UIControlStateNormal];
//    self.navigationItem.titleView = self.searchBar;
    
    UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 250, 44)];
    titleV.backgroundColor = [UIColor clearColor];
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(-3, 0, 250, 44)];
    self.searchBar.delegate=self;
    //    searchFriend.clearsContextBeforeDrawing=YES;
    
    self.searchBar.placeholder = @"输入邮箱地址查找好友";
    [[self.searchBar.subviews objectAtIndex:1] setBackgroundColor:[UIColor clearColor]];
    
    [[self.searchBar.subviews objectAtIndex:0] removeFromSuperview];
    self.searchBar.backgroundColor=[UIColor clearColor];
    
    UITextField *searchField0 = nil;
    UIImageView *tmp = [[UIImageView alloc] initWithFrame:CGRectMake(4, 7, 240, 30)];
    tmp.image = [UIImage imageNamed:@"search@2x.png"];
    
    [titleV addSubview:tmp];
    for (UIView* subview  in self.searchBar.subviews) {
        // 删除searchBar输入框的背景
        if ([subview isKindOfClass:[UITextField class]]) {
            searchField0 = (UITextField*)subview;
            [searchField0 setBackground:nil];
            [searchField0 setBackgroundColor:[UIColor clearColor]];
            [searchField0 setBorderStyle:UITextBorderStyleNone];
            break;
        }
    }
    
    [titleV addSubview:self.searchBar];
    //    [_searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"search@2x.png"] forState:UIControlStateNormal];
    
    self.navigationItem.titleView = titleV;

    
    
    self.myTableView.showsHorizontalScrollIndicator = NO;
    self.myTableView.showsVerticalScrollIndicator = NO;

    self.page = 2;
    self.dataArr = [[NSMutableArray alloc] init];
    
    
    self.bageViewOfDB = [[UIBadgeView alloc] initWithFrame:CGRectZero];
    self.bageViewOfSina = [[UIBadgeView alloc] initWithFrame:CGRectZero];
    self.bageViewOfTC = [[UIBadgeView alloc] initWithFrame:CGRectZero];
    
    
    


    
//    self.service = [DOUService sharedInstance];
//    service.clientId = kDouBanKey;
//    service.clientSecret = kDouBanPrivateKey;
    
    

//    
//    self.isTCAvaible = [self.engine isAuthorizeExpired];
//    self.isDBAvaible = [self.service isValid];
//    
    self.isWBSearch = NO;
    
    self.isDoubanAvailBack = NO;
    self.isSinaAvailBack = NO;
    self.isQQAvailBack = NO;
    
    self.myTableView.infiniteScrollingView.enabled = NO;

    [self.myTableView addInfiniteScrollingWithActionHandler:^{
        [RSHTTPMANAGER requestSearchFriendWithString:self.searchStr WithPage:[NSString stringWithFormat:@"%d",self.page] WithSuccess:^(NSArray *friendList) {
            if ([friendList count]) {
                [self.dataArr addObjectsFromArray:friendList];;
                self.isWBSearch = NO;
                self.page ++;
                [self.myTableView reloadData];
                self.myTableView.infiniteScrollingView.enabled = YES;
            }else{
                self.myTableView.infiniteScrollingView.enabled = NO;
            }
        } failure:^(NSError *error) {
            self.myTableView.infiniteScrollingView.enabled = NO;
        }];
    }];
    [self getRefreshData];
}

- (void)getRefreshData{
    self.myTableView.infiniteScrollingView.enabled = NO;
    [RSHTTPMANAGER requestShareList:self.currentUID WithSuccess:^(NSArray *squareList) {
        [SVProgressHUD show];
        if ([squareList count]) {
            for (int i = 0; i < [squareList count]; i++) {
                WeiBoShare *wbs = [squareList objectAtIndex:i];
                if ([wbs.weibo_type isEqualToString:@"sina"]) {
                    if ([wbs.is_share boolValue]) {
                        if ([wbs.status isEqualToString:@"1"]) {
                            self.isSinaAvailBack = YES;
                        }else{
                            self.isSinaAvailBack = NO;
                        }
                    }else{
                        self.isSinaAvailBack = NO;
                    }
                }
                
                if ([wbs.weibo_type isEqualToString:@"qq"]) {
                    if ([wbs.is_share boolValue]) {
                        if ([wbs.status isEqualToString:@"1"]) {
                            self.isQQAvailBack = YES;
                        }else{
                            self.isQQAvailBack = NO;
                        }
                        
                    }else{
                        self.isQQAvailBack = NO;
                    }
                }
                
                if ([wbs.weibo_type isEqualToString:@"douban"]) {
                    if ([wbs.is_share boolValue]) {
                        if ([wbs.status isEqualToString:@"1"]) {
                            self.isDoubanAvailBack = YES;
                        }else{
                            self.isDoubanAvailBack = NO;
                        }
                    }else{
                        self.isDoubanAvailBack = NO;
                    }
                }
            }
        }
        [RSHTTPMANAGER requestWBFriendWithUID:self.currentUID WithType:@"" WithSuccess:^(WBFriendModel *userFriends) {
            if (userFriends) {
                if (!self.wbFM) {
                    self.wbFM = [[WBFriendModel alloc] init];                    
                }
                self.wbFM = userFriends;
//                self.wbFM.countModel.sina = @"999";
//                self.wbFM.countModel.qq = @"99";
//                self.wbFM.countModel.douban = @"999";

                if ([userFriends.arrFriendsAll count]) {
                    self.isWBSearch = YES;
                    self.dataArr = [NSMutableArray arrayWithArray:userFriends.arrFriendsAll];
                }
            }
            [self.myTableView reloadData];

            [SVProgressHUD dismiss];
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
        }];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
    
}

-(BOOL)isMailNumber:(NSString*)mailNum{
    NSString *mail = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *telphoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mail];
    
    return [telphoneTest evaluateWithObject:mailNum];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    if ([self isMailNumber:self.searchBar.text]) {
        self.searchStr = [NSString stringWithFormat:@"%@",self.searchBar.text];
        self.myTableView.infiniteScrollingView.enabled = NO;
        [RSHTTPMANAGER requestSearchFriendWithString:self.searchBar.text WithPage:@"1" WithSuccess:^(NSArray *friendList) {
            if ([friendList count]) {
                [self.dataArr removeAllObjects];
                self.dataArr = [NSMutableArray arrayWithArray:friendList];
                self.isWBSearch = NO;
                self.page = 2;
                [self.myTableView reloadData];
                self.myTableView.infiniteScrollingView.enabled = YES;
            }else{
                self.myTableView.infiniteScrollingView.enabled = NO;

            }
        } failure:^(NSError *error) {
            self.myTableView.infiniteScrollingView.enabled = NO;

        }];
        
    }else{
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"警告" message:@"您输入的不是一个邮箱账号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [a show];

    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.searchBar isFirstResponder]) {
        [self.searchBar resignFirstResponder];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 10;
    }
    return 56;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0;
//}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    switch (section) {
//        case 0:
//            return @"发现你其他网站也在用果7的人";
//            break;
//        case 1:{
//            NSString *tmp = [NSString stringWithFormat:@"你的好友已有%d位在使用果7",[self.dataArr count]];
//            return tmp;
//        }
//            break;
//        default:
//            break;
//    }
//    return nil;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
        lb.text = @"发现你其他网站也在用果7的人";
        lb.textAlignment = NSTextAlignmentCenter;
        lb.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        lb.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        return lb;
    }else if (section == 1){
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
        if ([self.dataArr count]) {
            lb.text = [NSString stringWithFormat:@"你的好友已有%d位在使用果7",[self.dataArr count]];
        }else{
            lb.text = @"";
        }
        lb.textAlignment = NSTextAlignmentCenter;
        lb.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        lb.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        return lb;
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else if (section == 1){
        return 1;
    }else{
        return [self.dataArr count];
//        return 10;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [@"set" stringByAppendingFormat:@"%d%d", indexPath.section, indexPath.row];
    FFCell *cell = (FFCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"FFCell" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:17];
    cell.leftLB.font = cell.rightLB.font = font;
    cell.leftLB.textColor = cell.rightLB.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.leftLB.text = @"新浪微博";
            CGSize sss = [cell.leftLB.text sizeWithFont:font];
            cell.leftLB.frame = CGRectMake(cell.leftLB.frame.origin.x, cell.leftLB.frame.origin.y, sss.width, sss.height);
            cell.leftLB.center = CGPointMake(cell.leftLB.center.x + 10, cell.center.y);
            self.bageViewOfSina.hidden = YES;
            if (!self.isSinaAvailBack) {
                cell.rightLB.text = @"未绑定";
                CGSize s = [cell.rightLB.text sizeWithFont:font];
                cell.rightLB.frame = CGRectMake(290 - s.width, 0, s.width, s.height);
                cell.rightLB.center = CGPointMake(cell.rightLB.center.x + 10, cell.center.y);
            }else{
                if ([self.wbFM.countModel.sina intValue] == 0) {
                    cell.rightLB.text = @"暂未发现好友";
                    CGSize s = [cell.rightLB.text sizeWithFont:font];
                    cell.rightLB.frame = CGRectMake(290 - s.width, 0, s.width, s.height);
                    cell.rightLB.center = CGPointMake(cell.rightLB.center.x + 10, cell.center.y);
                }else{
//                    self.wbFM.countModel.sina = @"9";
                    self.bageViewOfSina.badgeString = self.wbFM.countModel.sina;
                    self.bageViewOfSina.badgeColor = [UIColor redColor];
                    self.bageViewOfSina.shadowEnabled = YES;
                    NSString *tmp = [NSString stringWithFormat:@"%@",self.wbFM.countModel.sina];
                    if (tmp.length == 1) {
                        [self.bageViewOfSina setFrame:CGRectMake(310 - 40,  5, 40, 40)];
                    }else if (tmp.length == 2){
                        [self.bageViewOfSina setFrame:CGRectMake(317 - 60,  5, 60, 50)];
                    }else if (tmp.length == 3){
                        [self.bageViewOfSina setFrame:CGRectMake(317 - 75,  5, 80, 50)];
                    }
                    self.bageViewOfSina.hidden = NO;
                    [cell addSubview:self.bageViewOfSina];
                }
            }
        }
        
        if (indexPath.row == 1) {
            cell.leftLB.text = @"腾讯微博";
            CGSize sss = [cell.leftLB.text sizeWithFont:font];
            cell.leftLB.frame = CGRectMake(cell.leftLB.frame.origin.x, cell.leftLB.frame.origin.y, sss.width, sss.height);
            cell.leftLB.center = CGPointMake(cell.leftLB.center.x + 10, cell.center.y);
            self.bageViewOfTC.hidden = YES;
            if (!self.isQQAvailBack) {
                cell.rightLB.text = @"未绑定";
                CGSize s = [cell.rightLB.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:17]];
                cell.rightLB.frame = CGRectMake(290 - s.width, 0, s.width, s.height);
                cell.rightLB.center = CGPointMake(cell.rightLB.center.x + 10, cell.center.y);
            }else{
                if ([self.wbFM.countModel.qq intValue] == 0) {
                    cell.rightLB.text = @"暂未发现好友";
                    CGSize s = [cell.rightLB.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:17]];
                    cell.rightLB.frame = CGRectMake(290 - s.width, 0, s.width, s.height);
                    cell.rightLB.center = CGPointMake(cell.rightLB.center.x + 10, cell.center.y);
                }else{
//                    self.wbFM.countModel.qq = @"99";
                    self.bageViewOfTC.badgeString = self.wbFM.countModel.qq;
                    self.bageViewOfTC.badgeColor = [UIColor redColor];
                    self.bageViewOfTC.shadowEnabled = YES;
                    NSString *tmp = [NSString stringWithFormat:@"%@",self.wbFM.countModel.qq];
                    if (tmp.length == 1) {
                        [self.bageViewOfTC setFrame:CGRectMake(310 - 40,  5, 40, 40)];
                    }else if (tmp.length == 2){
                        [self.bageViewOfTC setFrame:CGRectMake(317 - 60,  5, 60, 50)];
                    }else if (tmp.length == 3){
                        [self.bageViewOfTC setFrame:CGRectMake(317 - 75,  5, 80, 50)];
                    }
                    self.bageViewOfTC.hidden = NO;
                    [cell addSubview:self.bageViewOfTC];
                }
            }
        }
        
        if (indexPath.row == 2) {
            cell.leftLB.text = @"豆瓣";
            CGSize sss = [cell.leftLB.text sizeWithFont:font];
            cell.leftLB.frame = CGRectMake(cell.leftLB.frame.origin.x, cell.leftLB.frame.origin.y, sss.width, sss.height);
            cell.leftLB.center = CGPointMake(cell.leftLB.center.x + 10, cell.center.y);
            self.bageViewOfDB.hidden = YES;
            if (!self.isDoubanAvailBack) {
                cell.rightLB.text = @"未绑定";
                CGSize s = [cell.rightLB.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:17]];
                cell.rightLB.frame = CGRectMake(290 - s.width, 0, s.width, s.height);
                cell.rightLB.center = CGPointMake(cell.rightLB.center.x + 10, cell.center.y);
            }else{
                if ([self.wbFM.countModel.qq intValue] == 0) {
                    cell.rightLB.text = @"暂未发现好友";
                    CGSize s = [cell.rightLB.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:17]];
                    cell.rightLB.frame = CGRectMake(290 - s.width, 0, s.width, s.height);
                    cell.rightLB.center = CGPointMake(cell.rightLB.center.x + 10, cell.center.y);
                }else{
//                    self.wbFM.countModel.douban = @"999";
                    self.bageViewOfDB.badgeString = self.wbFM.countModel.douban;
                    self.bageViewOfDB.badgeColor = [UIColor redColor];
                    self.bageViewOfDB.shadowEnabled = YES;
                    NSString *tmp = [NSString stringWithFormat:@"%@",self.wbFM.countModel.douban];
                    if (tmp.length == 1) {
                        [self.bageViewOfDB setFrame:CGRectMake(310 - 40,  5, 40, 40)];
                    }else if (tmp.length == 2){
                        [self.bageViewOfDB setFrame:CGRectMake(317 - 60,  5, 60, 50)];
                    }else if (tmp.length == 3){
                        [self.bageViewOfDB setFrame:CGRectMake(317 - 75,  5, 80, 50)];
                    }
                    self.bageViewOfDB.hidden = NO;
                    [cell addSubview:self.bageViewOfDB];
                }
            }
        }
    }
    if (indexPath.section == 1 & indexPath.row == 0) {
        cell.leftLB.text = @"全部加为好友";
        CGSize sss = [cell.leftLB.text sizeWithFont:font];
        cell.leftLB.frame = CGRectMake(0, 0, sss.width, sss.height);
        cell.leftLB.center = cell.center;
    }

    if (indexPath.section == 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        if (self.isWBSearch) {
            AllModel *all = [self.dataArr objectAtIndex:indexPath.row];
            [cell.iconIMG setImageWithURL:[NSURL URLWithString:all.img_path] placeholderImage:[UIImage imageNamed:@"hi"]];
            cell.leftLB.text = all.nick_name;
        }else{
            UserModel *model = [self.dataArr objectAtIndex:indexPath.row];
            [cell.iconIMG setImageWithURL:[NSURL URLWithString:model.img_path] placeholderImage:[UIImage imageNamed:@"hi"]];
            cell.leftLB.text = model.nick_name;
        }
        cell.iconIMG.center = CGPointMake(cell.iconIMG.center.x + 10, cell.center.y);
        CGSize sss = [cell.leftLB.text sizeWithFont:font];
        cell.leftLB.frame = CGRectMake(cell.leftLB.frame.origin.x, cell.leftLB.frame.origin.y, sss.width, sss.height);
        cell.leftLB.center = CGPointMake(cell.leftLB.center.x + 50, cell.center.y);

    }
    
    
    return cell;





//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
//                                     reuseIdentifier:CellIdentifier];
//        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
//
//        cell.textLabel.font = cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:17];
//        cell.textLabel.textColor = cell.detailTextLabel.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
//        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
//        cell.backgroundColor = [UIColor whiteColor];
//       
//        if (indexPath.section == 1 && indexPath.row == 0) {
//            [cell.contentView addSubview:self.lbOfAll];
//        }
//        
//        if (indexPath.section == 2) {
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            
//            if (self.isWBSearch) {
//                AllModel *all = [self.dataArr objectAtIndex:indexPath.row];
//                UIImageView *tmp = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 35, 35)];
//                [tmp setImageWithURL:[NSURL URLWithString:all.img_path] placeholderImage:[UIImage imageNamed:@"hi"]];
//                [cell addSubview:tmp];
//                UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 200, 35)];
//                lable.text = all.nick_name;
//                lable.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
//                lable.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
//                [cell addSubview:lable];
//                
//            }else{
//                UserModel *model = [self.dataArr objectAtIndex:indexPath.row];
//                UIImageView *tmp = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 35, 35)];
//                [tmp setImageWithURL:[NSURL URLWithString:model.img_path] placeholderImage:[UIImage imageNamed:@"hi"]];
//                [cell addSubview:tmp];
//                UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 200, 35)];
//                lable.text = model.nick_name;
//                lable.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
//                lable.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
//                [cell addSubview:lable];
//            }
//        }
//    
//    }
//    
//    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//            cell.textLabel.text = @"新浪微博";
//            
//            if (!self.isSinaAvailBack) {
//                self.lbOfSina.text = @"未绑定";
//                self.lbOfSina.backgroundColor = [UIColor clearColor];
//                self.lbOfSina.font =  [UIFont fontWithName:@"Helvetica Neue" size:17];
//                CGSize s = [self.lbOfSina.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:17]];
//                self.lbOfSina.frame = CGRectMake(0, 0, s.width, s.height);
//                cell.accessoryView = self.lbOfSina;
//            }else{
//                if ([self.wbFM.countModel.sina intValue] == 0) {
//                    self.lbOfSina.text = @"暂未发现好友";
//                    self.lbOfSina.backgroundColor = [UIColor clearColor];
//                    self.lbOfSina.font =  [UIFont fontWithName:@"Helvetica Neue" size:17];
//                    CGSize s = [self.lbOfSina.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:17]];
//                    self.lbOfSina.frame = CGRectMake(0, 0, s.width, s.height);
//                    cell.accessoryView = self.lbOfSina;
//                }else{
//                    NSString *tmp = [NSString stringWithFormat:@"%@",self.wbFM.countModel.sina];
//                    //                NSString *tmp = [NSString stringWithFormat:@"40"];
//                    
//                    CGSize sssss = [tmp sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:17]];
//                    
//                    self.bageViewOfSina.badgeString = tmp;
//                    self.bageViewOfSina.badgeColor = [UIColor redColor];
//                    self.bageViewOfSina.shadowEnabled = YES;
//                    [self.bageViewOfSina setFrame:CGRectMake(320 - sssss.width * 3 - 10,  5, sssss.width * 3, 50)];
//                    //                        cell.accessoryView = self.bageViewOfSina;
//                    [cell addSubview:self.bageViewOfSina];
//                    
//                }
//            }
//        }else if (indexPath.row == 1){
//            cell.textLabel.text = @"腾讯微博";
//            if (!self.isQQAvailBack) {
//                self.lbOfTC.text = @"未绑定";
//                self.lbOfTC.backgroundColor = [UIColor clearColor];
//                self.lbOfTC.font =  [UIFont fontWithName:@"Helvetica Neue" size:17];
//                CGSize s = [self.lbOfTC.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:17]];
//                self.lbOfTC.frame = CGRectMake(0, 0, s.width, s.height);
//                cell.accessoryView = self.lbOfTC;
//                
//            }else{
//                if ([self.wbFM.countModel.qq intValue] == 0) {
//                    self.lbOfTC.text = @"暂未发现好友";
//                    self.lbOfTC.backgroundColor = [UIColor clearColor];
//                    self.lbOfTC.font =  [UIFont fontWithName:@"Helvetica Neue" size:17];
//                    CGSize s = [self.lbOfTC.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:17]];
//                    self.lbOfTC.frame = CGRectMake(0, 0, s.width, s.height);
//                    cell.accessoryView = self.lbOfTC;
//                }else{
//                    NSString *tmp = [NSString stringWithFormat:@"%@",self.wbFM.countModel.qq];
//                    CGSize sssss = [tmp sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:17]];
//                    self.bageViewOfTC.badgeString = tmp;
//                    self.bageViewOfTC.badgeColor = [UIColor redColor];
//                    self.bageViewOfTC.shadowEnabled = YES;
//                    [self.bageViewOfTC setFrame:CGRectMake(320 - sssss.width * 3 - 10,  5, sssss.width * 3, 50)];
//                    //                        cell.accessoryView = self.bageViewOfTC;
//                    [cell addSubview:self.bageViewOfTC];
//                    
//                }
//                
//            }
//            
//            
//        }else if (indexPath.row == 2){
//            cell.textLabel.text = @"豆瓣";
//            
//            if (!isDoubanAvailBack) {
//                self.lbOfDB.text = @"未绑定";
//                self.lbOfDB.backgroundColor = [UIColor clearColor];
//                self.lbOfTC.font =  [UIFont fontWithName:@"Helvetica Neue" size:17];
//                CGSize s = [self.lbOfDB.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:17]];
//                self.lbOfDB.frame = CGRectMake(0, 0, s.width, s.height);
//                cell.accessoryView = self.lbOfDB;
//            }else{
//                if ([self.wbFM.countModel.douban intValue] == 0) {
//                    self.lbOfDB.text = @"暂未发现好友";
//                    self.lbOfDB.backgroundColor = [UIColor clearColor];
//                    self.lbOfTC.font =  [UIFont fontWithName:@"Helvetica Neue" size:17];
//                    CGSize s = [self.lbOfDB.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:17]];
//                    self.lbOfDB.frame = CGRectMake(0, 0, s.width, s.height);
//                    cell.accessoryView = self.lbOfDB;
//                }else{
//                    NSString *tmp = [NSString stringWithFormat:@"%@",self.wbFM.countModel.douban];
//                    CGSize sssss = [tmp sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:17]];
//                    self.bageViewOfDB.badgeString = tmp;
//                    self.bageViewOfDB.badgeColor = [UIColor redColor];
//                    self.bageViewOfDB.shadowEnabled = YES;
//                    [self.bageViewOfDB setFrame:CGRectMake(320 - sssss.width * 3 - 10,  5, sssss.width * 3, 50)];
//                    //                        cell.accessoryView = self.bageViewOfDB;
//                    [cell addSubview:self.bageViewOfDB];
//                    
//                }
//            }
//        }
//        cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:17];
//    }
//    
//    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (!self.isSinaAvailBack) {
                if (!self.sina) {
                    self.sina = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:self];
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
                    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
                    {
                        self.sina.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
                        self.sina.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
                        self.sina.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
                    }                    
                }
                [self.sina logIn];
            }
        }
        
        if (indexPath.row == 1) {
            if (!self.isQQAvailBack) {
                if (!self.engine) {
                    self.engine = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl:REDIRECTURI];
                    [self.engine setRootViewController:self];
                }
                [self.engine logInWithDelegate:self
                                onSuccess:@selector(onSuccessLogin)
                                onFailure:@selector(onFailureLogin:)];

            }
        }
        if (indexPath.row == 2) {
            if (!self.isDoubanAvailBack) {
                DoubanViewController *vc = [[DoubanViewController alloc] init];
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        if ([self.dataArr count]) {
            [SVProgressHUD show];
            if (self.isWBSearch) {
                NSMutableString *tmp = [[NSMutableString alloc] init];
                for (int i = 0; i < [self.dataArr count]; i++) {
                    AllModel *all = [self.dataArr objectAtIndex:indexPath.row];
                    [tmp appendFormat:@"%@,",all.uid];
                
                    
                }
                [tmp substringToIndex:(tmp.length - 1)];
                                
                [RSHTTPMANAGER requestGZAllWithUId:self.currentUID WithFollowIDs:tmp WithSuccess:^(BOOL isSuccess) {
                    if (isSuccess) {
                        
                        
                        [SVProgressHUD showSuccessWithStatus:@"全部关注成功"];
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"全部关注失败"];
                    }
                } failure:^(NSError *error) {
                    [SVProgressHUD showErrorWithStatus:@"全部关注失败"];
                }];
            }else{
                NSMutableString *tmp = [[NSMutableString alloc] init];
                for (int i = 0; i < [self.dataArr count]; i++) {
                    UserModel *model = [self.dataArr objectAtIndex:indexPath.row];
                    [tmp appendFormat:@"%@,",model.uid];
                }
                [tmp substringToIndex:(tmp.length - 1)];
                [RSHTTPMANAGER requestGZAllWithUId:self.currentUID WithFollowIDs:tmp WithSuccess:^(BOOL isSuccess) {
                    if (isSuccess) {
                        [SVProgressHUD showSuccessWithStatus:@"全部关注成功"];
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"全部关注失败"];
                    }
                } failure:^(NSError *error) {
                    [SVProgressHUD showErrorWithStatus:@"全部关注失败"];
                }];
            }
        }
    }
    
    if (indexPath.section == 2) {
        UserModel *model = [self.dataArr objectAtIndex:indexPath.row];
        UserRootViewController *vc = [[UserRootViewController alloc] init];
        vc.uuid = model.uid;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)DoubanSuccess{
    DOUOAuthStore *db =  [DOUOAuthStore sharedInstance];
    [RSHTTPMANAGER requestBDDBWithUid:self.currentUID WithType:@"douban" WithWID:[NSString stringWithFormat:@"%d",db.userId] WithWKey:db.refreshToken WithWT:db.accessToken WithSuccess:^(BOOL isSuccess) {
        if (isSuccess) {
            self.isDoubanAvailBack = YES;
            [SVProgressHUD showSuccessWithStatus:@"豆瓣绑定成功"];
            [self getRefreshData];
        }else{
            self.isDoubanAvailBack = NO;
            [SVProgressHUD showErrorWithStatus:@"豆瓣绑定失败"];
            [[DOUOAuthService sharedInstance] logout];
        }
    } failure:^(NSError *error) {
        self.isDoubanAvailBack = NO;
    }];
}


- (void)DoubanFail{
    [[DOUOAuthService sharedInstance] logout];
}

//登录成功回调
- (void)onSuccessLogin{
    TCWBEngine *engineTMp = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl:REDIRECTURI];
    [RSHTTPMANAGER requestBDQQWithUid:self.currentUID WithType:@"qq" WithWID:engineTMp.openId WithWKey:engineTMp.openKey WithWT:engineTMp.accessToken WithWName:engineTMp.name WithSuccess:^(BOOL isSuccess) {
        if (isSuccess) {
            [SVProgressHUD showSuccessWithStatus:@"腾讯微博绑定成功"];
            self.isQQAvailBack = YES;
            [self getRefreshData];
        }else{
            self.isQQAvailBack = NO;
            [SVProgressHUD showErrorWithStatus:@"腾讯微博绑定失败"];
            [engineTMp logOut];
        }
    } failure:^(NSError *error) {
        self.isQQAvailBack = NO;
    }];
}

//登录失败回调
- (void)onFailureLogin:(NSError *)error{
//    [SVProgressHUD showErrorWithStatus:error.localizedDescription];

}



- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

- (void)storeAuthData
{
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              self.sina.accessToken, @"AccessTokenKey",
                              self.sina.expirationDate, @"ExpirationDateKey",
                              self.sina.userID, @"UserIDKey",
                              self.sina.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - SinaWeibo Delegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    [self storeAuthData];
    [RSHTTPMANAGER requestBDWithUid:self.currentUID WithType:@"sina" WithWID:sinaweibo.userID WithWT:sinaweibo.accessToken WithSuccess:^(BOOL isSuccess) {
        if (isSuccess) {
            [SVProgressHUD showSuccessWithStatus:@"Sina微博绑定成功"];
            [self getRefreshData];
        }else{
            [SVProgressHUD showErrorWithStatus:@"Sina微博绑定失败"];
            [self.sina logOut];
        }
    } failure:^(NSError *error) {
        [self.sina logOut];
        [SVProgressHUD showErrorWithStatus:@"Sina微博绑定失败"];
    }];
    
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




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
