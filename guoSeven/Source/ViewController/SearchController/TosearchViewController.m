//
//  TosearchViewController.m
//  guoSeven
//
//  Created by zucknet on 13/1/6.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "TosearchViewController.h"
#import "testSearchListViewController.h"
#import "SearchCell.h"

@interface TosearchViewController ()

@end

@implementation TosearchViewController

@synthesize serList = _serList;

@synthesize myTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    _searchBar.delegate=self;
    _searchBar.placeholder = @"搜索";
    [[_searchBar.subviews objectAtIndex:0] removeFromSuperview];
    self.navigationItem.titleView=_searchBar;
    
    
    
    self.navigationController.navigationBarHidden = NO;
    //[_searchBar resignFirstResponder]; // 键盘交互
//    [_searchBar becomeFirstResponder];

    UIView *helloVc = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 42)];
    helloVc.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1.0];
    [self.view addSubview:helloVc];
    
    UIButton *deviceBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 160, 42)];
//    deviceBtn.backgroundColor = [UIColor yellowColor];
    [deviceBtn setTitle:@"设备不限" forState:UIControlStateNormal];
    [deviceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [deviceBtn addTarget:self action:@selector(deviceAction:) forControlEvents:UIControlEventTouchUpInside];
    [helloVc addSubview:deviceBtn];
    
    UIButton *rankBtn = [[UIButton alloc] initWithFrame:CGRectMake(160, 0, 160, 42)];
//    rankBtn.backgroundColor = [UIColor yellowColor];
    [rankBtn setTitle:@"默认排序" forState:UIControlStateNormal];
    [rankBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rankBtn addTarget:self action:@selector(rankAction:) forControlEvents:UIControlEventTouchUpInside];
    [helloVc addSubview:rankBtn];
    
    myTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 42, 320, 460)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    self.myTableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:myTableView];
    
//    UILabel *helloLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, 320, 30)];
//    helloLab.text=@"试试在千万App中搜索你想要的";
//    helloLab.textAlignment=NSTextAlignmentCenter;
//    helloLab.backgroundColor = [UIColor clearColor];
//    helloLab.font = [UIFont systemFontOfSize:14.0];
//    [helloVc addSubview:helloLab];
    
}

-(void)deviceAction:(id)sender{
    NSLog(@"deviceAction");
}
-(void)rankAction:(id)sender{
    NSLog(@"rankAction");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    SearchCell * cell = (SearchCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"SearchCell" owner:self options:nil] objectAtIndex:0];
    }
    
    SearchCell *searchCell = [[SearchCell alloc] init];
    
    searchCell.name.text = @"hahahhah";
    searchCell.info.text = @"nnananan";
    searchCell.infoPrice.text = @"cvbnm";
    
    // Configure the cell...
//    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)viewWillAppear:(BOOL)animated{
    //[_searchBar resignFirstResponder]; // 键盘交互
//    [_searchBar becomeFirstResponder];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    _serList = [[testSearchListViewController alloc]init];

    _serList.push_app_name = _searchBar.text;
    
    postData = _searchBar.text;

    _serList.view.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    
    [self.navigationController pushViewController:_serList animated:YES];
    
    _serList.title =@"搜索结果";
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
