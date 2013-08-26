//
//  TestSearchViewController.m
//  guoSeven
//
//  Created by zucknet on 12/12/11.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "TestSearchViewController.h"
#import "SBJson.h"
#import "DetailViewController.h"
#import "testSearchListViewController.h"

@interface TestSearchViewController ()

@end

@implementation TestSearchViewController
@synthesize search_dataSorce,postAppname;
@synthesize detailViewController = _detailViewController;

@synthesize testSearlist;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [rightBtn setFrame:CGRectMake(10, 3, 55, 32)];
        UILabel *rightlab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 55, 32)];
        rightlab.text=@"iPhone";
        rightlab.backgroundColor=[UIColor clearColor];
        rightlab.textColor=[UIColor whiteColor];
        rightlab.textAlignment=NSTextAlignmentCenter;
        rightlab.font=[UIFont systemFontOfSize:13];
        [rightBtn addSubview:rightlab];
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"icontop-normal@2x.png"] forState:UIControlStateNormal];
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"icontop-normal2@2x.png"] forState:UIControlStateHighlighted];
        //[rightBtn addTarget:self action:@selector(swDevice:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        [self.navigationItem setRightBarButtonItem:rightItem];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [topbtn1 setTitle:@"全部分类" forState:UIControlStateNormal];
    [topbtn2 setTitle:@"价格不变" forState:UIControlStateNormal];
    [topbtn3 setTitle:@"默认排序" forState:UIControlStateNormal];
    
    [_tableView removeFromSuperview];
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    _searchBar.delegate=self;
    _searchBar.placeholder = @"搜索";
    [[_searchBar.subviews objectAtIndex:0] removeFromSuperview];
    self.navigationItem.titleView=_searchBar;
        
    [_searchBar resignFirstResponder]; // 键盘交互
    [_searchBar becomeFirstResponder];
    
    testSearlist.view.frame = CGRectMake(0, 0, 320, 500);
    [self.view addSubview:testSearlist.view];
        
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
