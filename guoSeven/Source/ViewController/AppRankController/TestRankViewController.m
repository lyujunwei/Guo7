//
//  TestRankViewController.m
//  guoSeven
//
//  Created by zucknet on 12/12/11.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "TestRankViewController.h"

@interface TestRankViewController ()

@end

@implementation TestRankViewController

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
    self.title=@"热榜";
    appsRank=[[NSArray alloc]initWithObjects:@"", nil];
    
    [topbtn1 setTitle:@"愿望榜" forState:UIControlStateNormal];
    [topbtn2 setTitle:@"红心榜" forState:UIControlStateNormal];
    [topbtn3 setTitle:@"评价榜" forState:UIControlStateNormal];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [appsRank count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];        
            appCellView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 310, 70)];
            [cell.contentView addSubview:appCellView];
            appCellView.backgroundColor=[UIColor whiteColor];
    
        appView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 290, 40)];
        appView.backgroundColor = [UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0];
        [appCellView addSubview:appView];
                
            
            //apprank = [[UILabel alloc]initWithFrame:CGRectMake(70, 8, 42, 21)];
            //appRank.text=@"NO.1";
            //appRank.textColor=[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:0/255.0 alpha:1.0];
            //appRank.backgroundColor=[UIColor clearColor];
            //appRank.font=[UIFont systemFontOfSize:14];
            //[appCellView addSubview:appRank];
            
            appName = [[UILabel alloc]initWithFrame:CGRectMake(70, 24, 112, 21)];
            appName.text=@"Kelly Clarkson";
            appName.backgroundColor=[UIColor clearColor];
            appName.font=[UIFont systemFontOfSize:14];
            [appCellView addSubview:appName];
            
            appClass = [[UILabel alloc]initWithFrame:CGRectMake(70, 42, 42, 21)];
            appClass.text=@"游戏";
            appClass.backgroundColor=[UIColor clearColor];
            appClass.font=[UIFont systemFontOfSize:12];
            [appCellView addSubview:appClass];
            
            appRankImg = [[UIImageView alloc]initWithFrame:CGRectMake(97, 45, 72, 16)];
            appRankImg.image=[UIImage imageNamed:@"starRank"];
            [appCellView addSubview:appRankImg];
            
            appFree = [[UILabel alloc]initWithFrame:CGRectMake(225, 7, 64, 21)];
            appFree.text=@"¥12";
            appFree.font=[UIFont systemFontOfSize:14.0f];
            appFree.textAlignment=NSTextAlignmentCenter;
            appFree.backgroundColor=[UIColor clearColor];
            [appCellView addSubview:appFree];
            
            appCost = [[UILabel alloc]initWithFrame:CGRectMake(232, 22, 53,21)];
            appCost.text=@"¥6";
            appCost.font=[UIFont systemFontOfSize:14.0f];
            appCost.textAlignment=NSTextAlignmentCenter;
            appCost.textColor=[UIColor grayColor];
            appCost.backgroundColor=[UIColor clearColor];
            [appCellView addSubview:appCost];
            
            appCost = [[UILabel alloc]initWithFrame:CGRectMake(232, 42, 58, 21)];
            appCost.text=@"限时免费";
            appCost.font=[UIFont systemFontOfSize:12.0f];
            appCost.textAlignment=NSTextAlignmentCenter;
            appCost.textColor=[UIColor whiteColor];
            appCost.backgroundColor=[UIColor grayColor];
            [appCellView addSubview:appCost];
            
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    testheader.backgroundColor=[UIColor clearColor];
    return testheader;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    testheader =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,10)];
    [self.view addSubview:testheader];
    return testheader.frame.size.height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

@end
