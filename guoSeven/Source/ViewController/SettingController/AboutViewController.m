//
//  AboutViewController.m
//  guoSeven
//
//  Created by luyun on 13-1-25.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
@synthesize aboutWeb;

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
    
    self.title=@"关于果7";
    
    NSString *mainBundleDirectory=[[NSBundle mainBundle] bundlePath];
    NSString *path=[mainBundleDirectory stringByAppendingPathComponent:@"AboutGuoSeven.htm"];
    
    NSURL *url=[NSURL fileURLWithPath:path];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [aboutWeb setScalesPageToFit:YES];
    [aboutWeb loadRequest:request];
    
    self.view.backgroundColor = [UIColor clearColor];
    
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
    
    // Do any additional setup after loading the view from its nib.
}

-(void)setBackView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
