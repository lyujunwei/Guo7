//
//  SetViewController.m
//  GPlay
//
//  Created by zucknet on 12/11/5.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "SetViewController.h"
#import "AccountViewController.h"
#import "SetoffViewController.h"
#import "FindfirendViewController.h"
#import "AboutViewController.h"
#import "IdeausViewController.h"
#import "SocalNetworkViewController.h"
#import "IdeaViewController.h"
#import "AlertmeViewController.h"
#import "SettingUserInfoViewController.h"
#import "RSHttpManager.h"
#import "UserInfo.h"

#import "FFViewController.h"

@interface SetViewController ()
//@property (nonatomic, retain) NSString *currentUID;
@end

@implementation SetViewController
@synthesize tablist1,tablist2,tablist3,tablist4,listAll;
@synthesize number;
@synthesize tableView=_tableView;
//@synthesize currentUID;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"设置";

    self.tablist1=[[NSArray alloc]initWithObjects:@"帐号设置", nil];
//    self.tablist2=[[NSArray alloc]initWithObjects:@"降价提醒",nil];
    self.tablist3=[[NSArray alloc]initWithObjects:@"同步分享",@"寻找好友", nil];
    self.tablist4=[[NSArray alloc]initWithObjects:@"意见反馈",@"版本",@"关于果7", nil];
    //self.listAll=[[NSMutableArray alloc]initWithObjects:tablist1,tablist2,tablist3,tablist4, nil];
    self.listAll=[[NSMutableArray alloc]initWithObjects:tablist1,tablist3,tablist4, nil];

    self.view.backgroundColor=[UIColor colorWithRed:247.0 / 255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 640) style:UITableViewStyleGrouped];
    _tableView.backgroundView=nil;
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.scrollEnabled = YES;
    [self.view addSubview:_tableView];

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.listAll objectAtIndex:section] count]; //设定每一类的资料笔数
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [@"set" stringByAppendingFormat:@"%@", indexPath];
    UITableViewCell *set1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (set1 == nil)
    {
        set1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:CellIdentifier];
        set1.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSUInteger row = [indexPath row];
    set1.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:17.0f];
    set1.textLabel.textColor = [UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0];
    set1.textLabel.text = [[self.listAll objectAtIndex:indexPath.section] objectAtIndex:row];
    [self.listAll objectAtIndex:indexPath.section];//显示所有数据列表
    
    if (indexPath.row == 1 && indexPath.section == 2) {
        number=[[UILabel alloc]init];
        self.number.frame=CGRectMake(0, 0, 20, 20);
        self.number.text=@"1.0";
        self.number.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        self.number.font = [UIFont fontWithName:@"Helvetica Neue" size:17.0f];
        self.number.backgroundColor=[UIColor clearColor];
        self.number.font = [UIFont systemFontOfSize:14];
        set1.accessoryView = self.number;
        set1.selectionStyle=UITableViewCellStyleDefault;
    }else {
        set1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return set1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //帐号设置
    if(indexPath.row == 0 && indexPath.section == 0) {
        SettingUserInfoViewController *appsVc = [SettingUserInfoViewController alloc];
        if (IS_IPHONE5) {
            appsVc = [appsVc initWithNibName:@"SettingUserInfoViewController_iPhone5" bundle:nil];
        }else{
            appsVc = [appsVc initWithNibName:@"SettingUserInfoViewController_Normal" bundle:nil];
        }
        //        appsVc.app_id = [[self.dataSorce objectAtIndex:indexPath.row]objectForKey:@"application_id"];
        //        appsVc.title = @"详情";
        [self.navigationController pushViewController:appsVc animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];

//        RegisterViewController *accountView =[[RegisterViewController alloc]init];
//        [self.navigationController pushViewController:accountView animated:YES];
    }
    
    //降价提醒
//    if(indexPath.row == 0 && indexPath.section == 1) {
//        AlertmeViewController *alertView =[[AlertmeViewController alloc]init];
//        [self.navigationController pushViewController:alertView animated:YES];
//    }
    //同步分享、寻找好友
    if(indexPath.row == 0 && indexPath.section == 1) {
//        SocialViewController *socialView = [[SocialViewController alloc]init];
//        [self.navigationController pushViewController:socialView animated:YES];
        SocalNetworkViewController *socialView =[[SocalNetworkViewController alloc]init];
        [self.navigationController pushViewController:socialView animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];

    }
    else if (indexPath.row == 1 && indexPath.section == 1){
//        FindfirendViewController *findView = [[FindfirendViewController alloc]init];
//        [self.navigationController pushViewController:findView animated:YES];
        FFViewController *appsVc = [FFViewController alloc];
        if (IS_IPHONE5) {
            appsVc = [appsVc initWithNibName:@"FFViewController_iPhone5" bundle:nil];
        }else{
            appsVc = [appsVc initWithNibName:@"FFViewController" bundle:nil];
        }
        [self.navigationController pushViewController:appsVc animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];


    }
    //意见反馈
    else if(indexPath.row == 0 && indexPath.section == 2) {
        IdeaViewController *ideaView =[[IdeaViewController alloc]init];
        [self.navigationController pushViewController:ideaView animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];

    }
    else if(indexPath.row == 2 && indexPath.section == 2) {
        AboutViewController *aboutView =[[AboutViewController alloc]init];
        [self.navigationController pushViewController:aboutView animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];

    }
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow]animated:YES];
}


//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
//    switch (section) {
//        case 2:
//            return @"@2012 Guo7.com, All rights reserved.";
//            break;
//            
//        default:
//            return @"";
//            break;
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 120;
    }
    return YES;
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (section == 2) {
//        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
//        lb.text = @"@2012 Guo7.com, All rights reserved.";
//        lb.textAlignment = NSTextAlignmentCenter;
//        lb.textColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
//        lb.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
//        lb.backgroundColor = [UIColor clearColor];
//        return lb;
//    }
//    return nil;
//}

@end
