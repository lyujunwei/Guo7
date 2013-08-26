//
//  friendUserViewController.m
//  GPlay
//
//  Created by zucknet on 12/11/5.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "friendUserViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface friendUserViewController ()

@end

@implementation friendUserViewController
@synthesize viewTop,viewTop1,viewTop2,scrollView;
@synthesize scrollbtn1,scrollbtn2,scrollbtn3,scrollbtn4,scrollbtn5,scrollbtn6;
@synthesize backView2,backView3;
@synthesize imageleft_on,imageleft_off,imageright_on,imageright_off;
@synthesize leftRight;
@synthesize icon4;
@synthesize imageView;
@synthesize btnLab1,btnLab2,btnLab3,btnLab4,btnLab5,btnLab6;
@synthesize numLab1,numLab2,numLab3,numLab4,numLab5,numLab6;
@synthesize userFrom,userName,userSgnature,userImage;
@synthesize userTitle;
@synthesize nameString,fromString;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    scrollView=[[UIScrollView alloc]init];
    self.scrollView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.scrollView.contentSize = CGSizeMake(320, 790);
    self.scrollView.backgroundColor=[UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1.0];
    self.scrollView.delegate=self;
    self.scrollView.showsVerticalScrollIndicator = FALSE;
    self.scrollView.showsHorizontalScrollIndicator = FALSE;
    
    viewTop=[[UIView alloc]init];
    viewTop.frame=CGRectMake(0, 0, 320, 97);
    viewTop.backgroundColor=[UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1.0];
    
    viewTop1=[[UIScrollView alloc]init];
    self.viewTop1.frame=CGRectMake(20, 97, 280, 43);
    self.viewTop1.contentSize=CGSizeMake(338, 43);
    self.viewTop1.backgroundColor=[UIColor colorWithRed:243.0 / 255.0 green:243.0 / 255.0 blue:243.0 / 255.0 alpha:1.0];
    self.viewTop1.showsVerticalScrollIndicator = FALSE;
    self.viewTop1.showsHorizontalScrollIndicator = FALSE;
    self.viewTop1.delegate=self;
    
    leftRight=[[UIView alloc]init];
    self.leftRight.frame=CGRectMake(0, 97, 320, 43);
    self.leftRight.backgroundColor=[UIColor colorWithRed:243.0 / 255.0 green:243.0 / 255.0 blue:243.0 / 255.0 alpha:1.0];
    [self.scrollView addSubview:self.leftRight];
    
    imageleft_off=[[UIImageView alloc]init];
    imageleft_off.frame=CGRectMake(5, 20, 10, 10);
    self.imageleft_off.hidden=NO;
    imageleft_off.image=[UIImage imageNamed:@"left_off.png"];
    [self.leftRight addSubview:imageleft_off];
    
    imageleft_on=[[UIImageView alloc]init];
    imageleft_on.frame=CGRectMake(5, 20, 10, 10);
    self.imageleft_on.hidden=YES;
    imageleft_on.image=[UIImage imageNamed:@"left_on.png"];
    [self.leftRight addSubview:imageleft_on];
    
    imageright_on=[[UIImageView alloc]init];
    imageright_on.frame=CGRectMake(305, 20, 10, 10);
    imageright_on.hidden=NO;
    imageright_on.image=[UIImage imageNamed:@"right_on.png"];
    [self.leftRight addSubview:imageright_on];
    
    imageright_off=[[UIImageView alloc]init];
    imageright_off.frame=CGRectMake(305, 20, 10, 10);
    imageright_off.hidden=YES;
    imageright_off.image=[UIImage imageNamed:@"right_off.png"];
    [self.leftRight addSubview:imageright_off];
    
    
    viewTop2=[[UIView alloc]init];
    viewTop2.frame=CGRectMake(0, 140, 320, 1000);
    viewTop2.backgroundColor=[UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0];
    
    userImage = [[UIImageView alloc]init];
    userImage.frame=CGRectMake(12, 12, 72, 72);
    userImage.image=[UIImage imageNamed:@"userimg"];
    
    userName=[[UILabel alloc]initWithFrame:CGRectMake(96, 12, 99, 25)];
    userName.font=[UIFont fontWithName:@"Helvetica-Bold" size:19];
    userName.backgroundColor=[UIColor clearColor];
    userName.textColor=[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];    
    
    userFrom =[[UILabel alloc]initWithFrame:CGRectMake(148, 13.5, 60, 20)];
    userFrom.font=[UIFont fontWithName:@"Helvetica-Bold" size:13];
    userFrom.backgroundColor=[UIColor clearColor];
    userFrom.textColor=[UIColor grayColor];
    
    //userTitle = [[UILabel alloc]initWithFrame:CGRectMake(96, 12, 200, 25)];
    //userTitle.text =[NSString stringWithFormat:@"%@ %@",userName.text,userFrom.text];
    //NSLog(@"%@",userTitle.text);
    
    UIImageView *friendIcon1 = [[UIImageView alloc]init];
    friendIcon1.frame=CGRectMake(96, 70, 20, 16);
    friendIcon1.image=[UIImage imageNamed:@"sinaicon"];
    
    UIImageView *friendIcon2 = [[UIImageView alloc]init];
    friendIcon2.frame=CGRectMake(125, 70, 20, 16);
    friendIcon2.image=[UIImage imageNamed:@"tweibo"];
    
    UIImageView *friendIcon3 = [[UIImageView alloc]init];
    friendIcon3.frame=CGRectMake(150, 70, 20, 16);
    friendIcon3.image=[UIImage imageNamed:@"qqlogo"];
    
    UIImageView *friendIcon4 = [[UIImageView alloc]init];
    friendIcon4.frame=CGRectMake(178, 70, 20, 16);
    friendIcon4.image=[UIImage imageNamed:@"weixinlogo"];
    
    userSgnature=[[UILabel alloc]initWithFrame:CGRectMake(96, 40, 182, 21)];
    userSgnature.font=[UIFont fontWithName:@"Helvetica-Bold" size:13];
    userSgnature.backgroundColor=[UIColor clearColor];
    userSgnature.textColor=[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    
    [self.viewTop addSubview:userImage];
    [self.viewTop addSubview:userName];
    [self.viewTop addSubview:userFrom];
    [self.viewTop addSubview:userTitle];
    [self.viewTop addSubview:friendIcon1];
    [self.viewTop addSubview:friendIcon2];
    [self.viewTop addSubview:friendIcon3];
    [self.viewTop addSubview:friendIcon4];
    [self.viewTop addSubview:userSgnature];
    
    //Scroll btn1 Setting...//*
    
    scrollbtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.scrollbtn1 setFrame:CGRectMake(0,0,48,50)];
    
    btnLab1=[[UILabel alloc]initWithFrame:CGRectMake(0, 2, 48, 25)];
    btnLab1.text=@"动态";
    btnLab1.textAlignment=NSTextAlignmentCenter;
    btnLab1.font=[UIFont systemFontOfSize:13.0];
    btnLab1.backgroundColor=[UIColor clearColor];
    [btnLab1 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [self.scrollbtn1 addSubview:btnLab1];
    
    numLab1=[[UILabel alloc]initWithFrame:CGRectMake(0, 24, 48, 15)];
    numLab1.text=@"8712";
    numLab1.textAlignment=NSTextAlignmentCenter;
    numLab1.font=[UIFont systemFontOfSize:13.0];
    numLab1.backgroundColor=[UIColor clearColor];
    [numLab1 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [self.scrollbtn1 addSubview:numLab1];
    
    [scrollbtn1 addTarget:self action:@selector(scrView1) forControlEvents:UIControlEventTouchUpInside];
    
    //Scroll btn2 Setting...

    scrollbtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.scrollbtn2 setFrame:CGRectMake(58,0,48,50)];
    
    btnLab2=[[UILabel alloc]initWithFrame:CGRectMake(0, 2, 48, 25)];
    btnLab2.text=@"愿望";
    btnLab2.textAlignment=NSTextAlignmentCenter;
    btnLab2.font=[UIFont systemFontOfSize:13.0];
    [btnLab2 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    btnLab2.backgroundColor=[UIColor clearColor];
    [self.scrollbtn2 addSubview:btnLab2];
    
    numLab2=[[UILabel alloc]initWithFrame:CGRectMake(0, 24, 48, 15)];
    numLab2.text=@"126";
    numLab2.textAlignment=NSTextAlignmentCenter;
    numLab2.font=[UIFont systemFontOfSize:13.0];
    [numLab2 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    numLab2.backgroundColor=[UIColor clearColor];
    [self.scrollbtn2 addSubview:numLab2];
    
    [scrollbtn2 addTarget:self action:@selector(scrView2) forControlEvents:UIControlEventTouchUpInside];
    
    //Scroll btn3 Setting...

    scrollbtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.scrollbtn3 setFrame:CGRectMake(116,0,48,50)];
    [scrollbtn3 setBackgroundImage:[UIImage imageNamed:@"navBar"] forState:UIControlStateSelected];

    btnLab3=[[UILabel alloc]initWithFrame:CGRectMake(0, 2, 48, 25)];
    btnLab3.text=@"喜欢";
    btnLab3.textAlignment=NSTextAlignmentCenter;
    btnLab3.font=[UIFont systemFontOfSize:13.0];
    btnLab3.backgroundColor=[UIColor clearColor];
    [btnLab3 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [self.scrollbtn3 addSubview:btnLab3];
    
    numLab3=[[UILabel alloc]initWithFrame:CGRectMake(0, 24, 48, 15)];
    numLab3.text=@"124679";
    numLab3.textAlignment=NSTextAlignmentCenter;
    numLab3.font=[UIFont systemFontOfSize:13.0];
    numLab3.backgroundColor=[UIColor clearColor];
    [numLab3 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [self.scrollbtn3 addSubview:numLab3];
    
    [scrollbtn3 addTarget:self action:@selector(scrView3) forControlEvents:UIControlEventTouchUpInside];

    //Scroll btn4 Setting...

    scrollbtn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.scrollbtn4 setFrame:CGRectMake(174,0,48,50)];
    
    btnLab4=[[UILabel alloc]initWithFrame:CGRectMake(0, 2, 48, 25)];
    btnLab4.text=@"关注";
    btnLab4.textAlignment=NSTextAlignmentCenter;
    btnLab4.font=[UIFont systemFontOfSize:13.0];
    btnLab4.backgroundColor=[UIColor clearColor];
    [btnLab4 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [self.scrollbtn4 addSubview:btnLab4];
    
    numLab4=[[UILabel alloc]initWithFrame:CGRectMake(0, 24, 48, 15)];
    numLab4.text=@"217611";
    numLab4.textAlignment=NSTextAlignmentCenter;
    numLab4.font=[UIFont systemFontOfSize:13.0];
    numLab4.backgroundColor=[UIColor clearColor];
    [numLab4 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [self.scrollbtn4 addSubview:numLab4];
    
    [scrollbtn4 addTarget:self action:@selector(scrView4) forControlEvents:UIControlEventTouchUpInside];
    
    //Scroll btn5 Setting...

    scrollbtn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.scrollbtn5 setFrame:CGRectMake(232,0,48,50)];

    btnLab5=[[UILabel alloc]initWithFrame:CGRectMake(0, 2, 48, 25)];
    btnLab5.text=@"好友";
    btnLab5.textAlignment=NSTextAlignmentCenter;
    btnLab5.font=[UIFont systemFontOfSize:13.0];
    btnLab5.backgroundColor=[UIColor clearColor];
    [btnLab5 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [self.scrollbtn5 addSubview:btnLab5];
    
    numLab5=[[UILabel alloc]initWithFrame:CGRectMake(0, 24, 48, 15)];
    numLab5.text=@"143";
    numLab5.textAlignment=NSTextAlignmentCenter;
    numLab5.font=[UIFont systemFontOfSize:13.0];
    numLab5.backgroundColor=[UIColor clearColor];
    [numLab5 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [self.scrollbtn5 addSubview:numLab5];
    
    [scrollbtn5 addTarget:self action:@selector(scrView5) forControlEvents:UIControlEventTouchUpInside];
    
    //Scroll btn6 Setting...

    scrollbtn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.scrollbtn6 setFrame:CGRectMake(290,0,48,50)];
    
    btnLab6=[[UILabel alloc]initWithFrame:CGRectMake(0, 2, 48, 25)];
    btnLab6.text=@"粉丝";
    btnLab6.textAlignment=NSTextAlignmentCenter;
    btnLab6.font=[UIFont systemFontOfSize:13.0];
    btnLab6.backgroundColor=[UIColor clearColor];
    [btnLab6 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [self.scrollbtn6 addSubview:btnLab6];
    
    numLab6=[[UILabel alloc]initWithFrame:CGRectMake(0, 24, 48, 15)];
    numLab6.text=@"138";
    numLab6.textAlignment=NSTextAlignmentCenter;
    numLab6.font=[UIFont systemFontOfSize:13.0];
    numLab6.backgroundColor=[UIColor clearColor];
    [numLab6 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [self.scrollbtn6 addSubview:numLab6];
    
    [scrollbtn6 addTarget:self action:@selector(scrView6) forControlEvents:UIControlEventTouchUpInside];
    
    UITextView *textView =[[UITextView alloc]init];
    textView.frame=CGRectMake(0, 20, 320, 200);
    textView.text=@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    textView.backgroundColor=[UIColor clearColor];
    textView.editable=NO;
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.footView];
    [self.scrollView addSubview:viewTop];
    [self.scrollView addSubview:viewTop1];
    [self.scrollView addSubview:viewTop2];
    [self.scrollView addSubview:backView2];
    [self.scrollView addSubview:backView3];
    
    [self.viewTop1 addSubview:self.scrollbtn1];
    [self.viewTop1 addSubview:self.scrollbtn2];
    [self.viewTop1 addSubview:self.scrollbtn3];
    [self.viewTop1 addSubview:self.scrollbtn4];
    [self.viewTop1 addSubview:self.scrollbtn5];
    [self.viewTop1 addSubview:self.scrollbtn6];
    
    [self.viewTop2 addSubview:textView];
}

-(void)setBackView{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)scrView1{
    [scrollbtn1 setBackgroundImage:[UIImage imageNamed:@"navBar"] forState:UIControlStateSelected];
    scrollbtn1.selected=YES;
    numLab1.highlightedTextColor=[UIColor whiteColor];
    btnLab1.highlightedTextColor=[UIColor whiteColor];
    numLab1.highlighted=YES;
    btnLab1.highlighted=YES;
    
    scrollbtn2.selected=NO;
    numLab2.highlighted=NO;
    btnLab2.highlighted=NO;
    
    scrollbtn3.selected=NO;
    numLab3.highlighted=NO;
    btnLab3.highlighted=NO;
    
    scrollbtn4.selected=NO;
    numLab4.highlighted=NO;
    btnLab4.highlighted=NO;
    
    scrollbtn5.selected=NO;
    numLab5.highlighted=NO;
    btnLab5.highlighted=NO;
    
    scrollbtn6.selected=NO;
    numLab6.highlighted=NO;
    btnLab6.highlighted=NO;
}

-(void)scrView2{
    [scrollbtn2 setBackgroundImage:[UIImage imageNamed:@"navBar"] forState:UIControlStateSelected];
    scrollbtn2.selected=YES;
    numLab2.highlightedTextColor=[UIColor whiteColor];
    btnLab2.highlightedTextColor=[UIColor whiteColor];
    numLab2.highlighted=YES;
    btnLab2.highlighted=YES;
    
    scrollbtn1.selected=NO;
    numLab1.highlighted=NO;
    btnLab1.highlighted=NO;
    
    scrollbtn3.selected=NO;
    numLab3.highlighted=NO;
    btnLab3.highlighted=NO;
    
    scrollbtn4.selected=NO;
    numLab4.highlighted=NO;
    btnLab4.highlighted=NO;
    
    scrollbtn5.selected=NO;
    numLab5.highlighted=NO;
    btnLab5.highlighted=NO;
    
    scrollbtn6.selected=NO;
    numLab6.highlighted=NO;
    btnLab6.highlighted=NO;
}

-(void)scrView3{
    [scrollbtn3 setBackgroundImage:[UIImage imageNamed:@"navBar"] forState:UIControlStateSelected];
    scrollbtn3.selected=YES;
    numLab3.highlightedTextColor=[UIColor whiteColor];
    btnLab3.highlightedTextColor=[UIColor whiteColor];
    numLab3.highlighted=YES;
    btnLab3.highlighted=YES;
    
    scrollbtn2.selected=NO;
    numLab2.highlighted=NO;
    btnLab2.highlighted=NO;
    
    scrollbtn1.selected=NO;
    numLab1.highlighted=NO;
    btnLab1.highlighted=NO;
    
    scrollbtn4.selected=NO;
    numLab4.highlighted=NO;
    btnLab4.highlighted=NO;
    
    scrollbtn5.selected=NO;
    numLab5.highlighted=NO;
    btnLab5.highlighted=NO;
    
    scrollbtn6.selected=NO;
    numLab6.highlighted=NO;
    btnLab6.highlighted=NO;
}

-(void)scrView4{
    [scrollbtn4 setBackgroundImage:[UIImage imageNamed:@"navBar"] forState:UIControlStateSelected];
    scrollbtn4.selected=YES;
    numLab4.highlightedTextColor=[UIColor whiteColor];
    btnLab4.highlightedTextColor=[UIColor whiteColor];
    numLab4.highlighted=YES;
    btnLab4.highlighted=YES;
    
    scrollbtn2.selected=NO;
    numLab2.highlighted=NO;
    btnLab2.highlighted=NO;
    
    scrollbtn3.selected=NO;
    numLab3.highlighted=NO;
    btnLab3.highlighted=NO;
    
    scrollbtn1.selected=NO;
    numLab1.highlighted=NO;
    btnLab1.highlighted=NO;
    
    scrollbtn5.selected=NO;
    numLab5.highlighted=NO;
    btnLab5.highlighted=NO;
    
    scrollbtn6.selected=NO;
    numLab6.highlighted=NO;
    btnLab6.highlighted=NO;
}

-(void)scrView5{
    [scrollbtn5 setBackgroundImage:[UIImage imageNamed:@"navBar"] forState:UIControlStateSelected];
    scrollbtn5.selected=YES;
    numLab5.highlightedTextColor=[UIColor whiteColor];
    btnLab5.highlightedTextColor=[UIColor whiteColor];
    numLab5.highlighted=YES;
    btnLab5.highlighted=YES;
    
    scrollbtn2.selected=NO;
    numLab2.highlighted=NO;
    btnLab2.highlighted=NO;
    
    scrollbtn3.selected=NO;
    numLab3.highlighted=NO;
    btnLab3.highlighted=NO;
    
    scrollbtn4.selected=NO;
    numLab4.highlighted=NO;
    btnLab4.highlighted=NO;
    
    scrollbtn1.selected=NO;
    numLab1.highlighted=NO;
    btnLab1.highlighted=NO;
    
    scrollbtn6.selected=NO;
    numLab6.highlighted=NO;
    btnLab6.highlighted=NO;
}

-(void)scrView6{
    [scrollbtn6 setBackgroundImage:[UIImage imageNamed:@"navBar"] forState:UIControlStateSelected];
    scrollbtn6.selected=YES;
    numLab6.highlightedTextColor=[UIColor whiteColor];
    btnLab6.highlightedTextColor=[UIColor whiteColor];
    numLab6.highlighted=YES;
    btnLab6.highlighted=YES;
    
    scrollbtn2.selected=NO;
    numLab2.highlighted=NO;
    btnLab2.highlighted=NO;
    
    scrollbtn3.selected=NO;
    numLab3.highlighted=NO;
    btnLab3.highlighted=NO;
    
    scrollbtn4.selected=NO;
    numLab4.highlighted=NO;
    btnLab4.highlighted=NO;
    
    scrollbtn5.selected=NO;
    numLab5.highlighted=NO;
    btnLab5.highlighted=NO;
    
    scrollbtn1.selected=NO;
    numLab1.highlighted=NO;
    btnLab1.highlighted=NO;
}

-(void)viewDidAppear:(BOOL)animated{
    [scrollbtn1 setBackgroundImage:[UIImage imageNamed:@"navBar"] forState:UIControlStateSelected];
    scrollbtn1.selected=YES;
    numLab1.highlightedTextColor=[UIColor whiteColor];
    btnLab1.highlightedTextColor=[UIColor whiteColor];
    numLab1.highlighted=YES;
    btnLab1.highlighted=YES;
}

- (void)drawRect:(CGRect)rect
{
    [_image drawInRect:rect];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UIScrollView

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollView.contentOffset.y >= 97) {
        self.viewTop1.frame=CGRectMake(20, 0, 280, 43);
        self.leftRight.frame=CGRectMake(0, 0, 320, 43);
        [self.view addSubview:self.leftRight];
        [self.view addSubview:self.viewTop1];
    }else {
        self.viewTop1.frame=CGRectMake(20, 97, 280, 43);
        self.leftRight.frame=CGRectMake(0, 97, 320, 43);
        [self.scrollView addSubview:self.leftRight];
        [self.scrollView addSubview:self.viewTop1];
    }
}

@end
