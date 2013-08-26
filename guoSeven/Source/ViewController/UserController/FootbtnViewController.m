//
//  FootbtnViewController.m
//  GPlay
//
//  Created by zucknet on 12/10/25.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "FootbtnViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "iChatViewController.h"

@interface FootbtnViewController ()

@end

@implementation FootbtnViewController
@synthesize footView,footbtn1,footbtn2;

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
    footView=[[UIView alloc]init];
    self.footView.frame=CGRectMake(0, 380, 320, 42);
    self.footView.backgroundColor=[UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
    footbtn1=[UIButton buttonWithType:UIButtonTypeCustom];
    self.footbtn1.frame=CGRectMake(10, 0, 150, 34);
    UIImageView *imgbtn1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"addBar.png"]];
    imgbtn1.frame=CGRectMake(35, 8, 18, 18);
    UILabel *labbtn1 = [[UILabel alloc]initWithFrame:CGRectMake(55, 0, 60, 34)];
    labbtn1.text=@"加关注";
    labbtn1.font = [UIFont systemFontOfSize:15];
    [labbtn1 setTextColor:[UIColor whiteColor]];
    labbtn1.backgroundColor=[UIColor clearColor];
    [self.footbtn1 addSubview:imgbtn1];
    [self.footbtn1 addSubview:labbtn1];

    
    footbtn2=[UIButton buttonWithType:UIButtonTypeCustom];
    self.footbtn2.frame=CGRectMake(160, 0, 150, 34);
    UIImageView *imgbtn2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iMessageBar.png"]];
    imgbtn2.frame=CGRectMake(35, 8, 18, 18);
    UILabel *labbtn2 = [[UILabel alloc]initWithFrame:CGRectMake(55, 0, 60, 34)];
    labbtn2.text=@"发私信";
    labbtn2.font = [UIFont systemFontOfSize:15];
    [labbtn2 setTextColor:[UIColor whiteColor]];
    labbtn2.backgroundColor=[UIColor clearColor];
    [self.footbtn2 addSubview:imgbtn2];
    [self.footbtn2 addSubview:labbtn2];
    [self.footbtn2 addTarget:self action:@selector(pushMessage:) forControlEvents:UIControlEventTouchUpInside];

    [self.footView addSubview:self.footbtn1];
    [self.footView addSubview:self.footbtn2];
    [self.view addSubview:self.footView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)pushMessage:(id)sender{
    iChatViewController *iChatController = [[iChatViewController alloc]init];
    [self.navigationController pushViewController:iChatController animated:YES];
    iChatController.title=@"孙语";
}

@end
