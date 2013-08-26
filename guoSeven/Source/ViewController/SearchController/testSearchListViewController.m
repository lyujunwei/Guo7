//
//  testSearchListViewController.m
//  guoSeven
//
//  Created by zucknet on 13/1/6.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "testSearchListViewController.h"
#import "SBJson.h"
#import "DetailViewController.h"
#import "AppsDetailsViewController.h"
#import "UIImageView+AFNetworking.h"


@interface testSearchListViewController ()

@end

@implementation testSearchListViewController

@synthesize detailViewController = _detailViewController;
@synthesize push_app_name;
@synthesize search_dataSorce;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self.navigationItem setHidesBackButton:YES];
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
        [backButton addTarget:self action:@selector(setBackView) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
        [self.navigationItem setLeftBarButtonItem:leftItem];
    }
    return self;
}

-(void)setBackView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"App_name:%@",push_app_name);
    
    NSString *result = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)push_app_name,
                                                                           NULL,
                                                                           CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                           kCFStringEncodingUTF8);
    
    NSLog(@"%@",result);
        
    NSLog(@"%@",search_dataSorce);
    
    self.view.backgroundColor=[UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1.0];
    self.tableView.showsHorizontalScrollIndicator=FALSE;
    self.tableView.showsVerticalScrollIndicator=FALSE;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [search_dataSorce count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    appView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 300, 80)];
    appView.backgroundColor=[UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:243.0/255.0 alpha:1.0];
    [cell addSubview:appView];
    
    app_img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    link_img =[[self.search_dataSorce objectAtIndex:indexPath.row]objectForKey:@"artwork_url_small"];
    NSURL *linkimg = [NSURL URLWithString:link_img];
    [app_img setImageWithURL:linkimg placeholderImage:[UIImage imageNamed:@"hi"]];
    
    app_name = [[UILabel alloc]initWithFrame:CGRectMake(80, 12, 150, 20)];
    app_name.backgroundColor = [UIColor clearColor];
    app_name.font = [UIFont systemFontOfSize:13.0f];
    link_name = [[self.search_dataSorce objectAtIndex:indexPath.row]objectForKey:@"title"];
    app_name.text = link_name;
    
    app_title = [[UILabel alloc]initWithFrame:CGRectMake(80, 32, 175, 20)];
    link_primary_genre_name = [[self.search_dataSorce objectAtIndex:indexPath.row]objectForKey:@"primary_genre_name"];
    //link_export_date = [[list objectAtIndex:indexPath.row]objectForKey:@"export_date"];
    link_supported_device_name = [[self.search_dataSorce objectAtIndex:indexPath.row]objectForKey:@"supported_device_name"];
    app_title.backgroundColor = [UIColor clearColor];
    app_title.font = [UIFont systemFontOfSize:11.0f];
    app_title.text = [NSString stringWithFormat:@"%@ / %@ ",link_primary_genre_name,link_supported_device_name];
    
    
    //app评分用图片比例代替 稍后
    app_rank = [[UIImageView alloc]initWithFrame:CGRectMake(80, 55, 54, 11)];
    //link_rank = [[self.want_dataSorce objectAtIndex:indexPath.row]objectForKey:@""];
    //NSURL *linkrank = [NSURL URLWithString:link_rank];
    //[app_rank setImageWithURL:linkrank placeholderImage:[UIImage imageNamed:@"hi"]];
    app_rank.image =[UIImage imageNamed:@"starRank"];
    
    app_retail_price = [[UILabel alloc]initWithFrame:CGRectMake(245, 12, 50, 20)];
    app_retail_price.backgroundColor = [UIColor clearColor];
    app_retail_price.font = [UIFont systemFontOfSize:12.0f];
    app_retail_price.textAlignment=NSTextAlignmentCenter;
    link_application_retail_price = [[self.search_dataSorce objectAtIndex:indexPath.row]objectForKey:@"retail_price"];
//    link_application_retail_price = [link_application_retail_price stringByReplacingOccurrencesOfString:@".00000" withString:@"元"];
    app_retail_price.text = [NSString stringWithFormat:@"￥%d",[link_application_retail_price integerValue]];
    
    app_old_price = [[StrikeThroughLabel alloc]initWithFrame:CGRectMake(245, 32, 50, 20)];
    app_old_price.backgroundColor = [UIColor clearColor];
    app_old_price.font = [UIFont systemFontOfSize:12.0f];
    app_old_price.textAlignment=NSTextAlignmentCenter;
    app_old_price.strikeThroughEnabled = YES;
    //link_application_old_price = [[list objectAtIndex:indexPath.row]objectForKey:@"old_price"];

//    link_application_old_price = [link_application_old_price stringByReplacingOccurrencesOfString:@".00000" withString:@"元"];
    
//    app_old_price.text = link_application_old_price;
    app_old_price.text = [NSString stringWithFormat:@"￥%d",[link_application_old_price integerValue]];
    
    app_limitedStateName = [[UILabel alloc]initWithFrame:CGRectMake(245, 50, 50, 20)];
    app_limitedStateName.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
    app_limitedStateName.font = [UIFont systemFontOfSize:12.0f];
    app_limitedStateName.textAlignment=NSTextAlignmentCenter;
    link_limitedStateName = [[self.search_dataSorce objectAtIndex:indexPath.row]objectForKey:@"limitedStateName"];
    if (link_limitedStateName == nil) {
        app_limitedStateName.backgroundColor = [UIColor clearColor];
    } else{
        app_limitedStateName.textColor=[UIColor whiteColor];
        app_limitedStateName.text = link_limitedStateName;
    }
    
    [appView addSubview:app_img];
    [appView addSubview:app_name];
    [appView addSubview:app_rank];
    [appView addSubview:app_title];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
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
    
    AppsDetailsViewController *rootVc = [[AppsDetailsViewController alloc]init];
    
//    rootVc.app_id = [[self.search_dataSorce objectAtIndex:indexPath.row]objectForKey:@"_id"];
    
    [self.navigationController pushViewController:rootVc animated:YES];
    
}

@end
