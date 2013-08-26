//
//  FriendRootViewController.m
//  guoSeven
//
//  Created by zucknet on 13/1/8.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "FriendRootViewController.h"
#import "UIImageView+AFNetworking.h"
#import "DetailViewController.h"
#import "SBJson.h"
#import "UserLobbyViewController.h"

@interface FriendRootViewController ()

-(void)LobbyVc;

@end

@implementation FriendRootViewController
@synthesize scrollView,topView,topScroll;
@synthesize namelabel,signaturelabel,touxiangImg,formlab,nameForm;
@synthesize leftRight,imageleft_on,imageleft_off,imageright_on,imageright_off;
@synthesize btnLab1,btnLab2,btnLab3,btnLab4,btnLab5,btnLab6,btnLab7;
@synthesize numLab1,numLab2,numLab3,numLab4,numLab5,numLab6,numLab7;
@synthesize review1;
@synthesize detailViewController = _detailViewController;
@synthesize frienduser_info;
@synthesize userLobby;
@synthesize pushVc;
@synthesize friend_id;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.title=@"个人首页";
        
    nick_name = [frienduser_info valueForKey:@"nick_name"];
    
    self.title = [NSString stringWithFormat:@"%@的首页",nick_name];
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    scrollView.contentSize = CGSizeMake(320, 640);
    scrollView.backgroundColor=[UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1.0];
    scrollView.delegate=self;
    scrollView.showsVerticalScrollIndicator = FALSE;
    scrollView.showsHorizontalScrollIndicator = FALSE;
    [self.view addSubview:scrollView];
    
    leftRight=[[UIView alloc]init];
    self.leftRight.frame=CGRectMake(0, 97, 320, 43);
    self.leftRight.backgroundColor=[UIColor colorWithRed:243.0 / 255.0 green:243.0 / 255.0 blue:243.0 / 255.0 alpha:1.0];
    [scrollView addSubview:leftRight];
    
    topScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(20, 97, 280, 43)];
    topScroll .backgroundColor = [UIColor colorWithRed:243.0 / 255.0 green:243.0 / 255.0 blue:243.0 / 255.0 alpha:1.0];
    topScroll.contentSize=CGSizeMake(340, 43);
    topScroll.showsVerticalScrollIndicator = FALSE;
    topScroll.showsHorizontalScrollIndicator = FALSE;
    [scrollView addSubview:topScroll];
    
    userLobby = [[UserLobbyViewController alloc]init];
    userLobby.user_id = [frienduser_info valueForKey:@"id"];
    
    pushVc = [[UIView alloc]initWithFrame:CGRectMake(0, 140, 320, self.view.frame.size.height)];
    pushVc.backgroundColor = [UIColor blueColor];
    [scrollView addSubview:pushVc];
    
    userLobby.view.frame = CGRectMake(0, 0, 320, 640);
    [pushVc addSubview:userLobby.view];
    
    [self topTitle];
    [self topbutton];
    [self LobbyVc];
    
    userLobby.view.frame = CGRectMake(0, 0, 320, userLobby.tableView.contentSize.height + 110);
    scrollView.contentSize = CGSizeMake(320, userLobby.tableView.frame.size.height + 90);
}

-(void)setBackView{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)topTitle{
    touxiangImg = [[UIImageView alloc]init];
    touxiangImg.frame=CGRectMake(12, 12, 72, 72);
    touxiang = [frienduser_info valueForKey:@"img_path"];
    NSURL *imageUrl =[NSURL URLWithString:touxiang];
    touxiangImg.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    
    namelabel=[[UILabel alloc]initWithFrame:CGRectMake(96, 12, 99, 25)];
    namelabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:19];
    name = [frienduser_info valueForKey:@"nick_name"];
    namelabel.text=name;
    namelabel.backgroundColor=[UIColor clearColor];
    namelabel.textColor=[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
    
    formlab =[[UILabel alloc]initWithFrame:CGRectMake(170, 13.5, 60, 20)];
    formlab.font=[UIFont fontWithName:@"Helvetica-Bold" size:13];
    form = [frienduser_info valueForKey:@"location_name"];
    formlab.text=form;
    formlab.backgroundColor=[UIColor clearColor];
    formlab.textColor=[UIColor grayColor];
    
    nameForm = [[UILabel alloc]initWithFrame:CGRectMake(96, 13.5, 200, 25)];
    nameForm.text = [NSString stringWithFormat:@"%@ %@",namelabel.text,formlab.text];
    
    UIImageView *icon1 = [[UIImageView alloc]init];
    icon1.frame=CGRectMake(96, 70, 20, 16);
    icon1.image=[UIImage imageNamed:@"sinaicon"];
    
    UIImageView *icon2 = [[UIImageView alloc]init];
    icon2.frame=CGRectMake(125, 70, 20, 16);
    icon2.image=[UIImage imageNamed:@"tweibo"];
    
    UIImageView *icon3 = [[UIImageView alloc]init];
    icon3.frame=CGRectMake(150, 70, 20, 16);
    icon3.image=[UIImage imageNamed:@"qqlogo"];
    
    UIImageView *icon4 = [[UIImageView alloc]init];
    icon4.frame=CGRectMake(178, 70, 20, 16);
    icon4.image=[UIImage imageNamed:@"weixinlogo"];
    
    signaturelabel=[[UILabel alloc]initWithFrame:CGRectMake(96, 40, 182, 21)];
    signaturelabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:13];
    signature = [frienduser_info valueForKey:@"signature"];
    signaturelabel.text=signature;
    signaturelabel.backgroundColor=[UIColor clearColor];
    signaturelabel.textColor=[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    
    [scrollView addSubview:touxiangImg];
    [scrollView addSubview:namelabel];
    [scrollView addSubview:formlab];
    [scrollView addSubview:signaturelabel];
    [scrollView addSubview:icon1];
    [scrollView addSubview:icon2];
    [scrollView addSubview:icon3];
    [scrollView addSubview:icon4];
    
}

-(void)topbutton{
    //Scroll btn1 Setting...
    
    topbtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    topbtn1.tag = 1;
    [topbtn1 setFrame:CGRectMake(0,0,48,50)];
    
    btnLab1=[[UILabel alloc]initWithFrame:CGRectMake(0, 2, 48, 25)];
    btnLab1.text=@"动态";
    btnLab1.textAlignment=NSTextAlignmentCenter;
    btnLab1.font=[UIFont systemFontOfSize:13.0];
    btnLab1.backgroundColor=[UIColor clearColor];
    [btnLab1 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [topbtn1 addSubview:btnLab1];
    
    numLab1=[[UILabel alloc]initWithFrame:CGRectMake(0, 24, 48, 15)];
    feed_count = [[NSString alloc] initWithFormat:@"%@\n",[frienduser_info valueForKey:@"feed_count"]];
    numLab1.text=feed_count;
    numLab1.textAlignment=NSTextAlignmentCenter;
    numLab1.font=[UIFont systemFontOfSize:13.0];
    numLab1.backgroundColor=[UIColor clearColor];
    [numLab1 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [topbtn1 addSubview:numLab1];
    
    [topbtn1 addTarget:self action:@selector(LobbyVc) forControlEvents:UIControlEventTouchUpInside];
    
    [topbtn1 setBackgroundImage:[UIImage imageNamed:@"navBar"] forState:UIControlStateSelected];
    topbtn1.selected=YES;
    numLab1.highlightedTextColor=[UIColor whiteColor];
    btnLab1.highlightedTextColor=[UIColor whiteColor];
    numLab1.highlighted=YES;
    btnLab1.highlighted=YES;
    
    //Scroll btn2 Setting...
    
    topbtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    topbtn2.tag = 2;
    [topbtn2 setFrame:CGRectMake(58,0,48,50)];
    
    btnLab2=[[UILabel alloc]initWithFrame:CGRectMake(0, 2, 48, 25)];
    btnLab2.text=@"推荐";
    btnLab2.textAlignment=NSTextAlignmentCenter;
    btnLab2.font=[UIFont systemFontOfSize:13.0];
    [btnLab2 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    btnLab2.backgroundColor=[UIColor clearColor];
    [topbtn2 addSubview:btnLab2];
    
    numLab2=[[UILabel alloc]initWithFrame:CGRectMake(0, 24, 48, 15)];
    recommend_count = [[NSString alloc] initWithFormat:@"%@\n",[frienduser_info valueForKey:@"recommend_count"]];
    numLab2.text=recommend_count;
    numLab2.textAlignment=NSTextAlignmentCenter;
    numLab2.font=[UIFont systemFontOfSize:13.0];
    [numLab2 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    numLab2.backgroundColor=[UIColor clearColor];
    [topbtn2 addSubview:numLab2];
    
    //[topbtn2 addTarget:self action:@selector(toDoSoming:) forControlEvents:UIControlEventTouchUpInside];
    
    //Scroll btn3 Setting...
    
    topbtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    topbtn3.tag = 3;
    [topbtn3 setFrame:CGRectMake(116,0,48,50)];
    
    [topbtn3 setBackgroundImage:[UIImage imageNamed:@"navBar"] forState:UIControlStateSelected];
    
    btnLab3=[[UILabel alloc]initWithFrame:CGRectMake(0, 2, 48, 25)];
    btnLab3.text=@"愿望";
    btnLab3.textAlignment=NSTextAlignmentCenter;
    btnLab3.font=[UIFont systemFontOfSize:13.0];
    btnLab3.backgroundColor=[UIColor clearColor];
    [btnLab3 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [topbtn3 addSubview:btnLab3];
    
    numLab3=[[UILabel alloc]initWithFrame:CGRectMake(0, 24, 48, 15)];
    want_count = [[NSString alloc] initWithFormat:@"%@\n",[frienduser_info valueForKey:@"want_count"]];
    numLab3.text=want_count;
    numLab3.textAlignment=NSTextAlignmentCenter;
    numLab3.font=[UIFont systemFontOfSize:13.0];
    numLab3.backgroundColor=[UIColor clearColor];
    [numLab3 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [topbtn3 addSubview:numLab3];
    
    //[topbtn3 addTarget:self action:@selector(toDoSoming:) forControlEvents:UIControlEventTouchUpInside];
    
    //Scroll btn4 Setting...
    
    topbtn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    topbtn4.tag = 4;
    [topbtn4 setFrame:CGRectMake(174,0,48,50)];
    
    btnLab4=[[UILabel alloc]initWithFrame:CGRectMake(0, 2, 48, 25)];
    btnLab4.text=@"评论";
    btnLab4.textAlignment=NSTextAlignmentCenter;
    btnLab4.font=[UIFont systemFontOfSize:13.0];
    btnLab4.backgroundColor=[UIColor clearColor];
    [btnLab4 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [topbtn4 addSubview:btnLab4];
    
    numLab4=[[UILabel alloc]initWithFrame:CGRectMake(0, 24, 48, 15)];
    discuss_count = [[NSString alloc] initWithFormat:@"%@\n",[frienduser_info valueForKey:@"discuss_count"]];
    numLab4.text=discuss_count;
    numLab4.textAlignment=NSTextAlignmentCenter;
    numLab4.font=[UIFont systemFontOfSize:13.0];
    numLab4.backgroundColor=[UIColor clearColor];
    [numLab4 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [topbtn4 addSubview:numLab4];
    
    //[topbtn4 addTarget:self action:@selector(toDoSoming:) forControlEvents:UIControlEventTouchUpInside];
    
    //Scroll btn5 Setting...
    
    topbtn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    topbtn5.tag = 5;
    [topbtn5 setFrame:CGRectMake(232,0,48,50)];
    
    btnLab5=[[UILabel alloc]initWithFrame:CGRectMake(0, 2, 48, 25)];
    btnLab5.text=@"关注";
    btnLab5.textAlignment=NSTextAlignmentCenter;
    btnLab5.font=[UIFont systemFontOfSize:13.0];
    btnLab5.backgroundColor=[UIColor clearColor];
    [btnLab5 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [topbtn5 addSubview:btnLab5];
    
    numLab5=[[UILabel alloc]initWithFrame:CGRectMake(0, 24, 48, 15)];
    discuss_count = [[NSString alloc] initWithFormat:@"%@\n",[frienduser_info valueForKey:@"feed_count"]];
    numLab5.text=discuss_count;
    numLab5.textAlignment=NSTextAlignmentCenter;
    numLab5.font=[UIFont systemFontOfSize:13.0];
    numLab5.backgroundColor=[UIColor clearColor];
    [numLab5 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [topbtn5 addSubview:numLab5];
    
    //[topbtn5 addTarget:self action:@selector(toDoSoming:) forControlEvents:UIControlEventTouchUpInside];
    
    //Scroll btn6 Setting...
    
    topbtn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    topbtn6.tag = 6;
    [topbtn6 setFrame:CGRectMake(290,0,48,50)];
    
    btnLab6=[[UILabel alloc]initWithFrame:CGRectMake(0, 2, 48, 25)];
    btnLab6.text=@"粉丝";
    btnLab6.textAlignment=NSTextAlignmentCenter;
    btnLab6.font=[UIFont systemFontOfSize:13.0];
    btnLab6.backgroundColor=[UIColor clearColor];
    [btnLab6 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [topbtn6 addSubview:btnLab6];
    
    numLab6=[[UILabel alloc]initWithFrame:CGRectMake(0, 24, 48, 15)];
    follower_count = [[NSString alloc] initWithFormat:@"%@\n",[frienduser_info valueForKey:@"follower_count"]];
    numLab6.text=[NSString stringWithFormat:@"%@",follower_count];
    numLab6.textAlignment=NSTextAlignmentCenter;
    numLab6.font=[UIFont systemFontOfSize:13.0];
    numLab6.backgroundColor=[UIColor clearColor];
    [numLab6 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [topbtn6 addSubview:numLab6];
    
    //[topbtn6 addTarget:self action:@selector(toDoSoming:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [topScroll addSubview:topbtn1];
    [topScroll addSubview:topbtn2];
    [topScroll addSubview:topbtn3];
    [topScroll addSubview:topbtn4];
    [topScroll addSubview:topbtn5];
    [topScroll addSubview:topbtn6];
    
}

-(void)LobbyVc{
    
}

#pragma ScrollView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollView.contentOffset.y >= 97) {
        topScroll.frame=CGRectMake(20, 0, 280, 43);
        self.leftRight.frame=CGRectMake(0, 0, 320, 43);
        [self.view addSubview:self.leftRight];
        [self.view addSubview:topScroll];
    }else {
        topScroll.frame=CGRectMake(20, 97, 280, 43);
        self.leftRight.frame=CGRectMake(0, 97, 320, 43);
        [self.scrollView addSubview:self.leftRight];
        [self.scrollView addSubview:topScroll];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
