//
//  PopularViewController.m
//  Apper
//
//  Created by ZuckBot on 12/9/29.
//  Copyright (c) 2012年 Zack3tt. All rights reserved.
//

#import "SearchViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SearchCell.h"
#import "RSHttpManager.h"
#import "SearchAppModel.h"
#import "UIImageView+AFNetworking.h"
#import "AppsDetailsViewController.h"
#import "SVPullToRefresh.h"
#import "SquareModel.h"

@interface SearchViewController ()
@property (nonatomic, retain) NSString *device;
@property (nonatomic, retain) NSString *sort;
@property (nonatomic, retain) NSMutableArray *searchArr;
@property (nonatomic, retain) UIImageView *noSearchImg;
@property (nonatomic, assign) int page;
@property (nonatomic, retain) UIImageView *errorImg;

@end

@implementation SearchViewController
@synthesize tablelist;
@synthesize myTableView;
@synthesize topView,backView;
@synthesize selectTableView;
@synthesize sortArr;
@synthesize tabbtn1,tabbtn3;
@synthesize device,sort;
@synthesize searchArr;
@synthesize noSearchImg,errorImg;
@synthesize page;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)hidekeyBoard:(NSNotification *)noti{
    if ([_searchBar isFirstResponder]) {
    }
    [_searchBar resignFirstResponder];

}

-(void)showKeyboard:(NSNotification *)noti{
    [_searchBar becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
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
    
//    biedianle
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidekeyBoard:) name:@"biedianle" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard:) name:@"showRightToLeft" object:nil];
    
//    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 10, 250, 44)];
//    _searchBar.delegate=self;
//    _searchBar.placeholder = @"搜索";
//    [[_searchBar.subviews objectAtIndex:0] removeFromSuperview];
//    [_searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"search_bar.png"] forState:UIControlStateNormal];
//    self.navigationItem.titleView = _searchBar;
//    [_searchBar becomeFirstResponder];

    UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 250, 44)];
    titleV.backgroundColor = [UIColor clearColor];
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 250, 44)];
    _searchBar.delegate=self;
    _searchBar.placeholder = @"搜索";
    [[_searchBar.subviews objectAtIndex:1] setBackgroundColor:[UIColor clearColor]];

    [[_searchBar.subviews objectAtIndex:0] removeFromSuperview];
    _searchBar.backgroundColor=[UIColor clearColor];

    UITextField *searchField0 = nil;
    UIImageView *tmp = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, 240, 30)];
    tmp.image = [UIImage imageNamed:@"search@2x.png"];

    [titleV addSubview:tmp];
    for (UIView* subview  in _searchBar.subviews) {
        // 删除searchBar输入框的背景
        if ([subview isKindOfClass:[UITextField class]]) {
            searchField0 = (UITextField*)subview;
            [searchField0 setBackground:nil];
            [searchField0 setBackgroundColor:[UIColor clearColor]];
            [searchField0 setBorderStyle:UITextBorderStyleNone];
            break;
        }
    }

    [titleV addSubview:_searchBar];
//    [_searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"search@2x.png"] forState:UIControlStateNormal];

    self.navigationItem.titleView = titleV;
    [_searchBar becomeFirstResponder];

    
    
    self.device = @"";
    self.sort = @"";
    self.page = 1;
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBarHidden = NO;
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 ,320,self.view.frame.size.height - 40)];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.showsHorizontalScrollIndicator=NO;
    myTableView.showsVerticalScrollIndicator=NO;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    hiddenmyTableView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 40)];
    hiddenmyTableView.backgroundColor = [UIColor whiteColor];
    
    tablelist=[[NSArray alloc]initWithObjects:@"不限",@"iPhone",@"iPad",@"Mac", nil];
    sortArr = [[NSArray alloc] initWithObjects:@"热门应用", @"高星应用",@"新品应用" ,nil];
    
        
    topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
    topView.backgroundColor  = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
    [self.view addSubview:topView];
    
    UIImageView *topBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    topBg.image = [UIImage imageNamed:@"MasterTop.png"];
    [self.topView addSubview:topBg];
    

    
    self.tabbtn1=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.tabbtn1 setFrame:CGRectMake(0 , 0, 159.5, 40)];
    [self.tabbtn1 setTitle:@"设备不限" forState:UIControlStateNormal];
    [self.tabbtn1 setTitle:@"设备不限" forState:UIControlStateHighlighted];
    [self.tabbtn1 addTarget:self action:@selector(deviceBtn:)forControlEvents:UIControlEventTouchUpInside];
    [self.tabbtn1 setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];
    self.tabbtn1.titleLabel.font  = [UIFont systemFontOfSize:14];

    self.tabbtn1.tag = 1;
    
    [self.view addSubview:self.tabbtn1];
    
    self.tabbtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.tabbtn3 setFrame:CGRectMake(160.5,0,159.5,40)];
    [self.tabbtn3 setTitle:@"默认排序" forState:UIControlStateNormal];
    [self.tabbtn3 setTitle:@"默认排序" forState:UIControlStateHighlighted];
    [self.tabbtn3 addTarget:self action:@selector(sortBtn:)forControlEvents:UIControlEventTouchUpInside];
    [self.tabbtn3 setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];
    self.tabbtn3.titleLabel.font  = [UIFont systemFontOfSize:14];

    self.tabbtn3.tag = 2;
    
    [self.view addSubview:self.tabbtn3];
    
    [self.tabbtn1 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
//    [self.tabbtn1 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateHighlighted];
    
    [self.tabbtn3 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
//    [self.tabbtn3 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0] forState:UIControlStateHighlighted];
    
    UIImageView *topBtn1 = [[UIImageView alloc]initWithFrame:CGRectMake(120, 18, 9, 6)];
    topBtn1.image = [UIImage imageNamed:@"ar_d.png"];
    [self.tabbtn1 addSubview:topBtn1];
    
    UIImageView *topBtn2 = [[UIImageView alloc]initWithFrame:CGRectMake(120, 18, 9, 6)];
    topBtn2.image = [UIImage imageNamed:@"ar_d.png"];
    [self.tabbtn3 addSubview:topBtn2];
    
    
    
    self.selectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, 160)];
    self.selectTableView.delegate = self;
    self.selectTableView.dataSource = self;
    selectTableView.scrollEnabled = NO;
    selectTableView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    selectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

//    [self.topView addSubview:selectTableView];
//    self.selectTableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.selectTableView];

    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, 320,self.view.frame.size.height)];
    [self.view addSubview:backView];
//    [self.view bringSubviewToFront:topView];
//    [self setBroadcasteStat:YES];
//
    [self.backView addSubview:myTableView];
    [self.backView addSubview:hiddenmyTableView];

//
////    [self.view addGestureRecognizer:hiddenView];
    self.noSearchImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 174)];
    self.noSearchImg.image = [UIImage imageNamed:@"noSearchApp.png"];
    [self.backView addSubview:self.noSearchImg];
    self.noSearchImg.hidden = YES;
    
    self.errorImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 174)];
    self.errorImg.image = [UIImage imageNamed:@"error.png"];
    [self.backView addSubview:self.errorImg];
    self.errorImg.hidden = YES;
    
//    [self.myTableView addPullToRefreshWithActionHandler:^{
//        self.myTableView.infiniteScrollingView.enabled = YES;
//        [RSHTTPMANAGER requestSearchAppWithStr:_searchBar.text WithDevice:self.device WithSort:self.sort WithPage:@"1" WithSuccess:^(NSArray *searchAppList) {
//            if ([searchAppList count]) {
//                noSearchImg.hidden = YES;
//                myTableView.hidden = NO;
//                [self.searchArr removeAllObjects];
//                self.searchArr = [NSMutableArray arrayWithArray:searchAppList];
//                [self.myTableView reloadData];
//                [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
//                self.page =2;
//            }else{
//                myTableView.hidden = YES;
//                self.noSearchImg.hidden = NO;
//            }
//            
//            [self.myTableView.pullToRefreshView stopAnimating];
//        } failure:^(NSError *error) {
//            [self.myTableView.pullToRefreshView stopAnimating]; 
//        }];
//    }];
    //上拉
    [self.myTableView addInfiniteScrollingWithActionHandler:^{
        UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        la.text = @"正在加载更多";
        la.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        
        la.textAlignment = NSTextAlignmentCenter;
        
        self.myTableView.tableFooterView = la;

        
        [RSHTTPMANAGER requestSearchAppWithStr:_searchBar.text WithDevice:self.device WithSort:self.sort WithPage:[NSString stringWithFormat:@"%d", self.page] WithSuccess:^(NSArray *searchAppList) {
            if ([searchAppList count]) {
                noSearchImg.hidden = YES;
                myTableView.hidden = NO;
                [self.searchArr addObjectsFromArray:searchAppList];
                [self.myTableView reloadData];
                self.page ++;
            }else{
                self.myTableView.infiniteScrollingView.enabled = NO;
                UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
                la.text = @"已没有更多内容";
                la.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
                
                la.textAlignment = NSTextAlignmentCenter;
                self.myTableView.tableFooterView = la;
                self.myTableView.infiniteScrollingView.enabled = NO;
//                myTableView.hidden = YES;
                self.noSearchImg.hidden = YES;
            }
            [self performSelector:@selector(hideFootView) withObject:nil afterDelay:1];

            [self.myTableView.infiniteScrollingView stopAnimating];
        } failure:^(NSError *error) {
            [self performSelector:@selector(hideFootView) withObject:nil afterDelay:1];

            [self.myTableView.infiniteScrollingView stopAnimating];
            
        }];
    }];
//
}

- (void)hideFootView{
    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    la.text = @"";
    la.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    
    la.textAlignment = NSTextAlignmentCenter;
    
    self.myTableView.tableFooterView = la;
    self.myTableView.infiniteScrollingView.enabled = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    hiddenmyTableView.hidden=YES;
    NSLog(@"search.txt:%@",searchBar.text);
    NSLog(@"sort ___________________%@",sort);
    [self triggerPullToRefresh];
    
    
}

-(void)triggerPullToRefresh{
    self.myTableView.infiniteScrollingView.enabled = YES;

    [RSHTTPMANAGER requestSearchAppWithStr:_searchBar.text WithDevice:self.device WithSort:self.sort WithPage:@"1" WithSuccess:^(NSArray *searchAppList) {
        if ([searchAppList count]) {
            noSearchImg.hidden = YES;
            myTableView.hidden = NO;
            self.errorImg.hidden = YES;

            [self.searchArr removeAllObjects];
            self.searchArr = [NSMutableArray arrayWithArray:searchAppList];
            [self.myTableView reloadData];
            [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
            self.page =2;
        }else{
            myTableView.hidden = YES;
            self.noSearchImg.hidden = NO;
            self.errorImg.hidden = YES;
        }
        
//        if (self.myTableView.contentSize.height < self.myTableView.frame.size.height) {
//            self.myTableView.infiniteScrollingView.enabled = NO;
//        }
        [_searchBar resignFirstResponder];
        [self.myTableView.pullToRefreshView stopAnimating];
    } failure:^(NSError *error) {
        [self.myTableView.pullToRefreshView stopAnimating];
        self.noSearchImg.hidden = YES;
        myTableView.hidden = YES;
        self.errorImg.hidden = NO;
    }];
}


-(void)deviceBtn:(id)sender{
    UIButton *tmp = (UIButton *)sender;
    if ([tmp isEqual:self.tabbtn1]) {
//        hiddenmyTableView.hidden = YES;
//        self.tabbtn1.selected = YES;
//        self.tabbtn3.selected = NO;
//        [self setBroadcasteStat:YES];
        self.tabbtn1.selected = YES;
//        self.tabbtn1.userInteractionEnabled = NO;
        self.tabbtn3.selected = NO;        
        [self.selectTableView reloadData];
    }else{
        
//        self.tabbtn1.selected = NO;
//        self.tabbtn3.selected = YES;
//        [self setBroadcasteStat:NO];
        self.tabbtn1.selected = NO;
//        self.tabbtn1.userInteractionEnabled = YES;
        self.tabbtn3.selected = YES;
        [self.selectTableView reloadData];
    }
    if (!showDevice) {
        showDevice = YES;
        [self.tabbtn1 setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]];
        [self.tabbtn3 setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];
        [UIView beginAnimations:@"move" context:nil];
        [UIView setAnimationDuration:0.3f];
        [backView setFrame:CGRectMake(0, 216, 320, self.view.frame.size.height)];
        [UIView commitAnimations];
    }else{
        [backView resignFirstResponder];
        [UIView beginAnimations:@"up" context:nil];
        [UIView setAnimationDuration:0.3f];
        backView.frame=CGRectMake(0, 40, 320, self.view.frame.size.height);
        [UIView commitAnimations];
        showDevice = NO;
        [self.tabbtn1 setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];
        [self.tabbtn3 setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];

    }
    
    
}

-(void)sortBtn:(id)sender{
    UIButton *tmp = (UIButton *)sender;
    if ([tmp isEqual:self.tabbtn1]) {
//        self.tabbtn1.selected = YES;
//        self.tabbtn3.selected = NO;
//        [self setBroadcasteStat:YES];
        self.tabbtn1.selected = YES;
//        self.tabbtn1.userInteractionEnabled = NO;
        self.tabbtn3.selected = NO;
        [self.selectTableView reloadData];
    }else{
//        self.tabbtn1.selected = NO;
//        self.tabbtn3.selected = YES;
//        [self setBroadcasteStat:NO];
        self.tabbtn1.selected = NO;
//        self.tabbtn1.userInteractionEnabled = YES;
        self.tabbtn3.selected = YES;
        [self.selectTableView reloadData];
    }
    if (!showSort) {
        showSort = YES;
        [self.tabbtn3 setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]];
        [self.tabbtn1 setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];
        [UIView beginAnimations:@"move" context:nil];
        [UIView setAnimationDuration:0.3f];
        [backView setFrame:CGRectMake(0, 160, 320, self.view.frame.size.height)];
        [UIView commitAnimations];
    }else{
        [backView resignFirstResponder];
        [UIView beginAnimations:@"up" context:nil];
        [UIView setAnimationDuration:0.3f];
        backView.frame=CGRectMake(0, 40, 320, self.view.frame.size.height);
        [UIView commitAnimations];
        showSort = NO;
        [self.tabbtn3 setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];
        [self.tabbtn1 setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];


    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_searchBar resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == myTableView) {
        return [self.searchArr count];

    }else{
        if (self.tabbtn1.selected) {
            return [self.tablelist count];
        }else{
            return [self.sortArr count];
        }
   }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.myTableView) {
        return 80;
    }else{
        return 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.myTableView) {
        SearchAppModel *searchApp = [self.searchArr objectAtIndex:indexPath.row];
        NSString *CellIdentifier = [NSString stringWithFormat:@"%d%d0",indexPath.section,indexPath.row];//@"Cell";
        SearchCell * cell = (SearchCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"SearchCell" owner:self options:nil] objectAtIndex:0];
        }
        
        
        tableView.separatorColor = UITableViewCellSeparatorStyleNone;;
        
        UIView *bgColorView = [[UIView alloc] init];
        [bgColorView setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]];
        [cell setSelectedBackgroundView:bgColorView];
        
        [cell.img setImageWithURL:[NSURL URLWithString:searchApp.artwork_url_small] placeholderImage:[UIImage imageNamed:@"hi"]];
        cell.name.text = searchApp.title;
        
                
        NSLog(@"//////////%@",searchApp.primary_genre_name);
        cell.info.text = [NSString stringWithFormat:@"%@/%@/%@",searchApp.primary_genre_name, searchApp.supported_device_name,searchApp.download_size];
        if ([[NSString stringWithFormat:@"%@",searchApp.retail_price] integerValue] == 0) {
            cell.price.text = @"免费";
        }else{
            cell.price.text = [NSString stringWithFormat:@"￥%d",[searchApp.retail_price integerValue]];
        }
        if ([searchApp.limitedStateName isEqualToString:@"首次限免"]) {
            [cell.priceImg setImage:[UIImage imageNamed:@"apptip1.png"]];
        }else if ([searchApp.limitedStateName isEqualToString:@"多次限免"]){
            [cell.priceImg setImage:[UIImage imageNamed:@"apptip2.png"]];
        }else if ([searchApp.limitedStateName isEqualToString:@"首次冰点"]){
            [cell.priceImg setImage:[UIImage imageNamed:@"apptip3.png"]];
        }else if ([searchApp.limitedStateName isEqualToString:@"再次冰点"]){
            [cell.priceImg setImage:[UIImage imageNamed:@"apptip4.png"]];
        }else if ([searchApp.limitedStateName isEqualToString:@"涨价"]){
            [cell.priceImg setImage:[UIImage imageNamed:@"apptip5.png"]];
        }

        return cell;

    }else{
        NSString *CellIdentifier = [NSString stringWithFormat:@"%d%d1",indexPath.section,indexPath.row];//@"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            cell.textLabel.font=[UIFont systemFontOfSize:13.0f];
            cell.textLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];


        }
        if (self.tabbtn1.selected) {
            cell.textLabel.text = [tablelist objectAtIndex:indexPath.row];
        }else{
            cell.textLabel.text = [sortArr objectAtIndex:indexPath.row];
        }
        
        UIView *bgColorView = [[UIView alloc] init];
        [bgColorView setBackgroundColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0]];
        [cell setSelectedBackgroundView:bgColorView];
        
        [cell setSelectedTextColor:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0]];
        
        
        return cell;
    }
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tabbtn1.selected) {
    if (tableView == selectTableView) {
        [backView resignFirstResponder];
        [UIView beginAnimations:@"up" context:nil];
        [UIView setAnimationDuration:0.3f];
        backView.frame=CGRectMake(0, 40, 320, self.view.frame.size.height);
        [UIView commitAnimations];
        showDevice = NO;
        if (indexPath.row == 0) {
            device = @"";
            [self.tabbtn1 setTitle:@"设备不限" forState:UIControlStateNormal];
        }else if (indexPath.row == 1){
            device = @"iphone";
            [self.tabbtn1 setTitle:@"iPhone" forState:UIControlStateNormal];
        }else if (indexPath.row == 2){
            device = @"ipad";
            [self.tabbtn1 setTitle:@"iPad" forState:UIControlStateNormal];
        }else if (indexPath.row == 3){
            device = @"mac";
            [self.tabbtn1 setTitle:@"Mac" forState:UIControlStateNormal];


        }
        
            [self.tabbtn1 setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];
        [self.tabbtn3 setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];

        NSLog(@"device________%@",device);
        
        if ([_searchBar.text length] == 0) {
            NSLog(@"kong");
        }else{
            [self triggerPullToRefresh];
        }
        
        }
        
    }else{
        if (tableView == selectTableView) {
            [backView resignFirstResponder];
            [UIView beginAnimations:@"up" context:nil];
            [UIView setAnimationDuration:0.3f];
            backView.frame=CGRectMake(0, 40, 320, self.view.frame.size.height);
            [UIView commitAnimations];
            showSort = NO;
            if (indexPath.row == 0) {
                sort = @"hot-sort";
                [self.tabbtn3 setTitle:@"热门应用" forState:UIControlStateNormal];
            }else if(indexPath.row == 1){
                sort = @"star-sort";
                [self.tabbtn3 setTitle:@"高星应用" forState:UIControlStateNormal];
            }else if (indexPath.row == 2){
                sort = @"new-sort";
                [self.tabbtn3 setTitle:@"新品应用" forState:UIControlStateNormal];


            }
            
            [self.tabbtn1 setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];
            
            [self.tabbtn3 setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];
            
            NSLog(@"sort______+++++++%@",sort);
            
            if ([_searchBar.text length] == 0) {
                NSLog(@"kong");
            }else{
                [self triggerPullToRefresh];
            }
            }
    }
    
    if (tableView == myTableView) {
        [_searchBar resignFirstResponder];
        SearchAppModel *searchApp = [self.searchArr objectAtIndex:indexPath.row];

        AppsDetailsViewController *appsVc = [[AppsDetailsViewController alloc] init];
        SquareModel *sql = [[SquareModel alloc] init];
        [appsVc setApplication_id:searchApp._id];
        [sql setApplication_artwork_url_small:searchApp.artwork_url_small];
        [sql setApplication_title:searchApp.title];
        [sql setPrimary_genre_name:searchApp.primary_genre_name];
        [sql setSupported_device_name:searchApp.supported_device_name];
        NSLog(@"searchApp.limitedStateName:%@",searchApp.limitedStateName);
        NSLog(@"searchApp.limitedState:%@",searchApp.limitedState);
        [sql setLimited_state_name:searchApp.limitedStateName];
        [sql setApplication_retail_price:[NSString stringWithFormat:@"%d",[searchApp.retail_price integerValue]]];
        appsVc.sqModel = sql;
        [self.navigationController pushViewController:appsVc animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];

        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


@end
