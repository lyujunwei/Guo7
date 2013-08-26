//
//  UserLobbyViewController.m
//  guoSeven
//
//  Created by zucknet on 13/1/7.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "UserLobbyViewController.h"
#import "UIImageView+AFNetworking.h"
#import "DetailViewController.h"
#import "SBJson.h"
#import "AppsDetailsViewController.h"
#import "FriendRootViewController.h"

@interface UserLobbyViewController ()

@end

@implementation UserLobbyViewController
@synthesize detailViewController = _detailViewController;
@synthesize user_id;
@synthesize userfeed_dataSorce;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
            
    self.tableView.backgroundColor=[UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1.0];
    
    self.tableView.showsHorizontalScrollIndicator=NO;
    self.tableView.showsVerticalScrollIndicator=NO;
    
    int count = [userfeed_dataSorce count];
    self.tableView.contentSize= CGSizeMake(320, + 124 *count);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    allView =[[UIView alloc]initWithFrame:CGRectMake(10, 0, 300, 114)];
    allView.backgroundColor=[UIColor whiteColor];
    [cell.contentView addSubview:allView];
    
    //用户图标
    uimg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 34, 34)];
    uString = [[self.userfeed_dataSorce objectAtIndex:indexPath.row]objectForKey:@"img_path"];
    NSLog(@"ustring %@",uString);
    NSURL *usericom =[NSURL URLWithString:uString];
    [uimg setImageWithURL:usericom placeholderImage:[UIImage imageNamed:@"hi"]];
    [allView addSubview:uimg];
    
    //名字、动作
    titlename = [[UILabel alloc]initWithFrame:CGRectMake(54, 9, 220, 21)];
    titlename.font=[UIFont systemFontOfSize:13.0f];
    
    name = [[self.userfeed_dataSorce objectAtIndex:indexPath.row]objectForKey:@"nick_name"];
    
    //关注
    act_user =[[self.userfeed_dataSorce objectAtIndex:indexPath.row]objectForKey:@"obj_action_type_name"];
    //添加到愿望清单
    act_addapp = [[self.userfeed_dataSorce objectAtIndex:indexPath.row]objectForKey:@"application_action_type_name"];
    
    if ( act_appcation == nil) {
        titlename.text=[NSString stringWithFormat:@"%@ 关注了",name];
    }
    
    if (act_user == nil) {
        titlename.text = [NSString stringWithFormat:@"%@ %@",name,act_addapp];
    }
    
    [allView addSubview:titlename];
    
    //时间
    datelabel = [[UILabel alloc]initWithFrame:CGRectMake(54, 26, 157, 21)];
    date = [[self.userfeed_dataSorce objectAtIndex:indexPath.row]objectForKey:@"create_time"];
    datelabel.text=date;
    datelabel.font=[UIFont systemFontOfSize:12.0f];
    datelabel.textColor=[UIColor grayColor];
    [allView addSubview:datelabel];
    
    //内容
    seeBackView = [[UIView alloc]initWithFrame:CGRectMake(10, 50, 280, 60)];
    seeBackView.backgroundColor=[UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:243.0/255.0 alpha:1.0];
    [allView addSubview:seeBackView];
    
    seeView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 50, 50)];
    
    //应用图片加载
    appString = [[self.userfeed_dataSorce objectAtIndex:indexPath.row]objectForKey:@"application_artwork_url_small"];
    NSURL *appUrl =[NSURL URLWithString:appString];
    //用户图片加载
    userString = [[self.userfeed_dataSorce objectAtIndex:indexPath.row]objectForKey:@"obj_img_path"];
    NSURL *userUrl =[NSURL URLWithString:userString];
    
    if (userimg == NULL) {           //当用户图片为空，加载 应用图标Url
        [seeView setImageWithURL:appUrl placeholderImage:[UIImage imageNamed:@"hi"]];
    }
    if (appString == NULL)
    {                               //当应用图片为空，加载 用户图标Url
        [seeView setImageWithURL:userUrl placeholderImage:[UIImage imageNamed:@"hi"]];
    }
    [seeBackView addSubview:seeView];
    
    seenamelabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, 200, 21)];
    seenamelabel.backgroundColor=[UIColor clearColor];
    seenamelabel.font =[UIFont systemFontOfSize:13.0f];
    
    obj_signaturelabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 30, 200, 21)];
    obj_signaturelabel.backgroundColor=[UIColor clearColor];
    
    user_ratinglabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 15, 200, 21)];
    user_ratinglabel.backgroundColor=[UIColor clearColor];
    
    
    appname = [[self.userfeed_dataSorce objectAtIndex:indexPath.row]objectForKey:@"application_title"];
    
    obj_name= [[self.userfeed_dataSorce objectAtIndex:indexPath.row]objectForKey:@"obj_nick_name"];
    
    obj_signature = [[self.userfeed_dataSorce objectAtIndex:indexPath.row]objectForKey:@"obj_signature"];
    
    if (obj_signature == [NSNull null]) {
        //obj_signature = obj_details;
        obj_signature = @"该用户什么都没写!";
    }
    
    user_rating = [[self.userfeed_dataSorce objectAtIndex:indexPath.row]objectForKey:@"application_average_user_rating"];
    
    create_time = [[self.userfeed_dataSorce objectAtIndex:indexPath.row]objectForKey:@"create_time"];
    
    primary_genre_name = [[self.userfeed_dataSorce objectAtIndex:indexPath.row]objectForKey:@"primary_genre_name"];
    
    supported_device_name = [[self.userfeed_dataSorce objectAtIndex:indexPath.row]objectForKey:@"supported_device_name"];
    
    obj_details = [[self.userfeed_dataSorce objectAtIndex:indexPath.row]objectForKey:@"obj_details"];
    
    App_titleinfo = [[UILabel alloc]initWithFrame:CGRectMake(70, 28, 200, 21)];
    App_titleinfo.text = [NSString stringWithFormat:@"%@ / %@ / %@",primary_genre_name,create_time,supported_device_name];
    App_titleinfo.font = [UIFont systemFontOfSize:11.0f];
    App_titleinfo.backgroundColor = [UIColor clearColor];
    
    if (primary_genre_name == NULL) {
        App_titleinfo.text = obj_signature;
        //  if (obj_signature == [NSNull null]) {
        //      obj_signature = obj_details;
        //  }
        //  App_titleinfo.text = obj_details;
    }
    
    if (appname == nil ) {
        seenamelabel.text = obj_name;
    }
    else {
        seenamelabel.text = appname;
    }
    [seeBackView addSubview:seenamelabel];
    
    [seeBackView addSubview:user_ratinglabel];
    [seeBackView addSubview:obj_signaturelabel];
    [seeBackView addSubview:App_titleinfo];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 124;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    lobbyheader.backgroundColor=[UIColor clearColor];
    return lobbyheader;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    lobbyheader =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,10)];
    [self.view addSubview:lobbyheader];
    return lobbyheader.frame.size.height;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    application_count = [[self.userfeed_dataSorce objectAtIndex:indexPath.row]objectForKey:@"application_remind_count"];
    
    if (application_count != nil)
    {                               //如果用户名为空,显示应用页
        AppsDetailsViewController *appsVc = [[AppsDetailsViewController alloc]init];
//        appsVc.app_id = [[self.userfeed_dataSorce objectAtIndex:indexPath.row]objectForKey:@"application_id"];
        appsVc.title = @"详情";
        [self.navigationController pushViewController:appsVc animated:YES];
        
    } else {           //如果app名为空，显示应用页
        FriendRootViewController *friendInfo = [[FriendRootViewController alloc]init];
        friendInfo.friend_id = [[self.userfeed_dataSorce objectAtIndex:indexPath.row]objectForKey:@"obj_uid"];
        [self.navigationController pushViewController:friendInfo animated:YES];
    }
}

@end
