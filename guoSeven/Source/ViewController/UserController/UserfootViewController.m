//
//  UserfootViewController.m
//  GPlay
//
//  Created by zucknet on 12/11/5.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "UserfootViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface UserfootViewController ()

@end

@implementation UserfootViewController
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
    self.footView.frame=CGRectMake(0, 372, 320, 50);
    self.footView.backgroundColor=[UIColor colorWithRed:64.0 / 255.0 green:64.0 / 255.0 blue:64.0 / 255.0 alpha:1.0];

    footbtn1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.footbtn1.frame=CGRectMake(45, 10, 85, 26);
    [self.footbtn1 setBackgroundImage:[[UIImage imageNamed:@"addme"]stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    self.footbtn1.backgroundColor=[UIColor colorWithRed:50.0 / 255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0];
    self.footbtn1.layer.shadowColor = [UIColor grayColor].CGColor;
    self.footbtn1.layer.shadowOpacity = 3.0f;
    self.footbtn1.layer.shadowOffset = CGSizeMake(0.0f, -1.4f);
    self.footbtn1.layer.shadowRadius = 5.5f;
    self.footbtn1.layer.masksToBounds = NO;
    
    footbtn2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.footbtn2.frame=CGRectMake(190, 10, 85, 26);
    [self.footbtn2 setBackgroundImage:[[UIImage imageNamed:@"imessage"]stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    self.footbtn2.backgroundColor=[UIColor colorWithRed:50.0 / 255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0];
    self.footbtn2.layer.shadowColor = [UIColor blackColor].CGColor;
    self.footbtn2.layer.shadowOpacity = 1.0f;
    self.footbtn2.layer.shadowOffset = CGSizeMake(0.0f, 1.4f);
    self.footbtn2.layer.shadowRadius = 1.5f;
    self.footbtn2.layer.masksToBounds = NO;
    
    [self.footView addSubview:self.footbtn1];
    [self.footView addSubview:self.footbtn2];
    [self.view addSubview:self.footView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
