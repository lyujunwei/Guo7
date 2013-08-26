//
//  MyFirendViewController.m
//  GPlay
//
//  Created by zucknet on 12/11/9.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "MyFirendViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MyFirendViewController ()

@end

@implementation MyFirendViewController
@synthesize btn1,btn2,btn3;

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
    self.title=@"好友和粉丝";
    
    self.view.backgroundColor=[UIColor colorWithRed:50.0 / 255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0];
    
    btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btn1.frame=CGRectMake(15,8,90,30);
    [self.btn1 setTitle:@"我的好友" forState:UIControlStateNormal];
    self.btn1.backgroundColor=[UIColor colorWithRed:219.0 / 255.0 green:217.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    [self.btn1 setTitleColor:[UIColor colorWithRed:50.0 / 255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [btn1.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [self.btn1 addTarget:self action:@selector(clickbtn1:)forControlEvents:UIControlEventTouchUpInside];
    [self.btn1.layer setCornerRadius:6.0];
    
    btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btn2.frame=CGRectMake(120,8,90,30);
    [self.btn2 setTitle:@"我的关注" forState:UIControlStateNormal];
    [self.btn2 setTitleColor:[UIColor colorWithRed:172.0 / 255.0 green:172.0 / 255.0 blue:157.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [btn2.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [self.btn2 addTarget:self action:@selector(clickbtn2:)forControlEvents:UIControlEventTouchUpInside];
    [self.btn2.layer setCornerRadius:6.0];
    
    btn3=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btn3.frame=CGRectMake(220,8,90,30);
    [self.btn3 setTitle:@"我的粉丝" forState:UIControlStateNormal];
    [self.btn3 setTitleColor:[UIColor colorWithRed:172.0 / 255.0 green:172.0 / 255.0 blue:157.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [btn3.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [self.btn3 addTarget:self action:@selector(clickbtn3:)forControlEvents:UIControlEventTouchUpInside];
    [self.btn3.layer setCornerRadius:6.0];
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
        
    
}

-(IBAction)clickbtn1:(id)sender{
    self.btn1.backgroundColor=[UIColor colorWithRed:219.0 / 255.0 green:217.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    [self.btn1 setTitleColor:[UIColor colorWithRed:50.0 / 255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    self.btn2.backgroundColor=[UIColor colorWithRed:50.0 / 255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0];
    [self.btn2 setTitleColor:[UIColor colorWithRed:172.0 / 255.0 green:172.0 / 255.0 blue:157.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    self.btn3.backgroundColor=[UIColor colorWithRed:50.0 / 255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0];
    [self.btn3 setTitleColor:[UIColor colorWithRed:172.0 / 255.0 green:172.0 / 255.0 blue:157.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    
}

-(IBAction)clickbtn2:(id)sender{
    self.btn2.backgroundColor=[UIColor colorWithRed:219.0 / 255.0 green:217.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    [self.btn2 setTitleColor:[UIColor colorWithRed:50.0 / 255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    self.btn1.backgroundColor=[UIColor colorWithRed:50.0 / 255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0];
    [self.btn1 setTitleColor:[UIColor colorWithRed:172.0 / 255.0 green:172.0 / 255.0 blue:157.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    self.btn3.backgroundColor=[UIColor colorWithRed:50.0 / 255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0];
    [self.btn3 setTitleColor:[UIColor colorWithRed:172.0 / 255.0 green:172.0 / 255.0 blue:157.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
}

-(IBAction)clickbtn3:(id)sender{
    self.btn3.backgroundColor=[UIColor colorWithRed:219.0 / 255.0 green:217.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    [self.btn3 setTitleColor:[UIColor colorWithRed:50.0 / 255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    self.btn1.backgroundColor=[UIColor colorWithRed:50.0 / 255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0];
    [self.btn1 setTitleColor:[UIColor colorWithRed:172.0 / 255.0 green:172.0 / 255.0 blue:157.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    self.btn2.backgroundColor=[UIColor colorWithRed:50.0 / 255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0];
    [self.btn2 setTitleColor:[UIColor colorWithRed:172.0 / 255.0 green:172.0 / 255.0 blue:157.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated{
    self.btn1.backgroundColor=[UIColor colorWithRed:219.0 / 255.0 green:217.0 / 255.0 blue:203.0 / 255.0 alpha:1.0];
    [self.btn1 setTitleColor:[UIColor colorWithRed:50.0 / 255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    self.btn2.backgroundColor=[UIColor colorWithRed:50.0 / 255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0];
    [self.btn2 setTitleColor:[UIColor colorWithRed:172.0 / 255.0 green:172.0 / 255.0 blue:157.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    self.btn3.backgroundColor=[UIColor colorWithRed:50.0 / 255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0];
    [self.btn3 setTitleColor:[UIColor colorWithRed:172.0 / 255.0 green:172.0 / 255.0 blue:157.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


@end
