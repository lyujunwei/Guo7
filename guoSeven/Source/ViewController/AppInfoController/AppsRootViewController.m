//
//  AppsRootViewController.m
//  guoSeven
//
//  Created by zucknet on 13/1/6.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "AppsRootViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+AFNetworking.h"
#import "SBJson.h"
#import "DetailViewController.h"
#import "InfoViewController.h"
#import "CostViewController.h"
#import "SGInfoAlert.h"
#import "iPhoneScreenViewController.h"
#import "LikeViewController.h"
#import "TalkingViewController.h"


#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


@interface AppsRootViewController ()

-(void)setBackView;
-(void)columnBarTitle;
-(void)footerView;

-(void)InfoView;
-(void)iPhoneScreenView;
-(void)costView;
-(void)likeView;
-(void)talkView;

@end

@implementation AppsRootViewController

@synthesize scrollView,infoVc,costVc,iPhoneVc;
@synthesize app_dataSorce,app_id;
@synthesize detailViewController = _detailViewController;
@synthesize footView,footbtn1,footbtn2,footbtn3,footbtn4;
@synthesize app_url,dict,likeVc,talkVc;


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
    
    self.title =@"详情";
    
    NSLog(@"app_id: %@",app_id);
    
    upuser_id = @"17";
            
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 376)];
    if (IS_IPHONE_5) {
        scrollView.frame = CGRectMake(0, 0, 320, 466);
    }
    scrollView.contentSize = CGSizeMake(320, 900.0f);
    scrollView.backgroundColor=[UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1.0];
    scrollView.delegate=self;
    scrollView.showsVerticalScrollIndicator = FALSE;
    scrollView.showsHorizontalScrollIndicator = FALSE;
    [self.view addSubview:scrollView];
    
    infoVc = [[InfoViewController alloc]init];
    infoVc.rushlab1 = [app_dataSorce valueForKey:@"description"];
    infoVc.rushlab2 = [app_dataSorce valueForKey:@"seller_name"];
    infoVc.rushlab3 = [app_dataSorce valueForKey:@"version"];
    infoVc.rushlab4 = [app_dataSorce valueForKey:@"primary_genre_name"];
    infoVc.rushlab5 = [app_dataSorce valueForKey:@"supported_device_name"];
    infoVc.rushlab6 = [app_dataSorce valueForKey:@"download_size"];
    infoVc.rushlab7 = [app_dataSorce valueForKey:@"language_code"];
    
    costVc = [[CostViewController alloc]init];
    costVc.cost_id = [app_dataSorce valueForKey:@"application_id"];

    [self iPhoneScreenView];
    [self costView];
    [self likeView];
    [self talkView];
    
    iPhoneVc = [[iPhoneScreenViewController alloc]init];
        iPhoneVc.iPhone_url1 = [app_dataSorce valueForKey:@"screenshot_url_1"];
        iPhoneVc.iPhone_url2 = [app_dataSorce valueForKey:@"screenshot_url_2"];
        iPhoneVc.iPhone_url3 = [app_dataSorce valueForKey:@"screenshot_url_3"];
        iPhoneVc.iPhone_url4 = [app_dataSorce valueForKey:@"screenshot_url_4"];
        iPhoneVc.iPhone_url5 = [app_dataSorce valueForKey:@"screenshot_url_5"];

        iPhoneVc.iPad_url1 = [app_dataSorce valueForKey:@"ipad_screenshot_url_1"];
        iPhoneVc.iPad_url2 = [app_dataSorce valueForKey:@"ipad_screenshot_url_2"];
        iPhoneVc.iPad_url3 = [app_dataSorce valueForKey:@"ipad_screenshot_url_3"];
        iPhoneVc.iPad_url4 = [app_dataSorce valueForKey:@"ipad_screenshot_url_4"];
        iPhoneVc.iPad_url5 = [app_dataSorce valueForKey:@"ipad_screenshot_url_5"];

    likeVc = [[LikeViewController alloc]init];
    likeVc.like_id = [app_dataSorce valueForKey:@"application_id"];
    
    talkVc = [[TalkingViewController alloc]init];
    talkVc.talk_id = [app_dataSorce valueForKey:@"application_id"];
    
    
    title_lab=[[UILabel alloc]initWithFrame:CGRectMake(80, 11, 250, 25)];
    title = [self.app_dataSorce valueForKey:@"title"];
    title_lab.text = title;
    title_lab.font=[UIFont fontWithName:@"Helvetica-Bold" size:18];
    title_lab.backgroundColor=[UIColor clearColor];
    title_lab.textColor=[UIColor colorWithRed:102.0 / 255.0 green:102.0 / 255.0 blue:102.0 / 255.0 alpha:1.0];
    
    artist_name_lab = [[UILabel alloc]initWithFrame:CGRectMake(82, 32, 250, 25)];
    artist_name= [self.app_dataSorce valueForKey:@"artist_name"];
    artist_name_lab.text = artist_name;
    artist_name_lab.font=[UIFont fontWithName:@"Helvetica-Bold" size:13];
    artist_name_lab.backgroundColor=[UIColor clearColor];
    artist_name_lab.textColor=[UIColor colorWithRed:153.0 / 255.0 green:153.0 / 255.0 blue:153.0 / 255.0 alpha:1.0];
    
    app_image = [[UIImageView alloc]init];
    app_image.frame=CGRectMake(10, 10, 57 , 57);
    artwork_url_small = [self.app_dataSorce valueForKey:@"artwork_url_small"];
    NSURL *appimageUrl =[NSURL URLWithString:artwork_url_small];
    [app_image setImageWithURL:appimageUrl placeholderImage:[UIImage imageNamed:@"hi"]];
    
    app_rank_image = [[UIImageView alloc]initWithFrame:CGRectMake(80, 55, 70, 15)];
    app_rank_image.image=[UIImage imageNamed:@"starRank"];
    
    topView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, 320, 46)];
    topView.backgroundColor = [UIColor colorWithRed:243.0 / 255.0 green:243.0 / 255.0 blue:243.0 / 255.0 alpha:1.0];
    [scrollView addSubview:topView];
    
    [self columnBarTitle];
    [self footerView];
    
    newView = [[UIView alloc]initWithFrame:CGRectMake(0, 126, 320, infoVc.lab1.frame.size.height + infoVc.background.frame.size.height + infoVc.lab2.frame.size.height)];
    newView = [[UIView alloc]initWithFrame:CGRectMake(0, 126, 320, 800)];
    newView.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:newView];
    [newView addSubview:infoVc.view];
    
    [scrollView addSubview:title_lab];
    [scrollView addSubview:artist_name_lab];
    [scrollView addSubview:app_image];
    [scrollView addSubview:app_rank_image];
    [scrollView addSubview:topView];
    
    scrollView.contentSize = CGSizeMake(320, self.infoVc.lab1.frame.size.height + self.infoVc.background.frame.size.height + self.infoVc.lab2.frame.size.height + 146.0f);

}

-(void)columnBarTitle{
    //Setting topbtn1...
    topbtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [topbtn1 setFrame:CGRectMake(15,0,50,46)];
    topbtn1.tag = 1;
    [topbtn1 addTarget:self action:@selector(InfoView) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:topbtn1];
    
    toplab1=[[UILabel alloc]initWithFrame:CGRectMake(0, 2, 48, 25)];
    toplab1.text=@"基本";
    toplab1.textAlignment=NSTextAlignmentCenter;
    toplab1.font=[UIFont systemFontOfSize:14.0];
    toplab1.backgroundColor=[UIColor clearColor];
    [toplab1 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [topbtn1 addSubview:toplab1];
    
    numlab1=[[UILabel alloc]initWithFrame:CGRectMake(0, 24, 48, 15)];
    numlab1.text=@"资料";
    numlab1.textAlignment=NSTextAlignmentCenter;
    numlab1.font=[UIFont systemFontOfSize:14.0];
    numlab1.backgroundColor=[UIColor clearColor];
    [numlab1 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [topbtn1 addSubview:numlab1];
    //[topbtn1 addTarget:self action:@selector(toDoSoming:) forControlEvents:UIControlEventTouchUpInside];
    
    [topbtn1 setBackgroundImage:[UIImage imageNamed:@"topbtn"] forState:UIControlStateSelected];
    topbtn1.selected=YES;
    toplab1.highlightedTextColor=[UIColor whiteColor];
    numlab1.highlightedTextColor=[UIColor whiteColor];
    toplab1.highlighted=YES;
    numlab1.highlighted=YES;
    
    //Setting topbtn1...
    
    topbtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [topbtn2 setFrame:CGRectMake(75,0,50,46)];
    topbtn2.tag = 2;
    [topbtn2 addTarget:self action:@selector(iPhoneScreenView) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:topbtn2];
    
    toplab2=[[UILabel alloc]initWithFrame:CGRectMake(0, 2, 48, 25)];
    toplab2.text=@"屏幕";
    toplab2.textAlignment=NSTextAlignmentCenter;
    toplab2.font=[UIFont systemFontOfSize:14.0];
    [toplab2 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    toplab2.backgroundColor=[UIColor clearColor];
    [topbtn2 addSubview:toplab2];
    
    numlab2=[[UILabel alloc]initWithFrame:CGRectMake(0, 24, 48, 15)];
    numlab2.text=@"截图";
    numlab2.textAlignment=NSTextAlignmentCenter;
    numlab2.font=[UIFont systemFontOfSize:14.0];
    [numlab2 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    numlab2.backgroundColor=[UIColor clearColor];
    [topbtn2 addSubview:numlab2];
    //[topbtn2 addTarget:self action:@selector(toDoSoming:) forControlEvents:UIControlEventTouchUpInside];
    
    //Setting topbtn1...
    
    topbtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [topbtn3 setFrame:CGRectMake(135,0,50,46)];
    topbtn3.tag = 3;
    [topbtn3 addTarget:self action:@selector(costView) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:topbtn3];
    
    toplab3=[[UILabel alloc]initWithFrame:CGRectMake(0, 2, 48, 25)];
    toplab3.text=@"价格";
    toplab3.textAlignment=NSTextAlignmentCenter;
    toplab3.font=[UIFont systemFontOfSize:14.0];
    toplab3.backgroundColor=[UIColor clearColor];
    [toplab3 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [topbtn3 addSubview:toplab3];
    
    numlab3=[[UILabel alloc]initWithFrame:CGRectMake(0, 24, 48, 15)];
    numlab3.text=@"走势";
    numlab3.textAlignment=NSTextAlignmentCenter;
    numlab3.font=[UIFont systemFontOfSize:14.0];
    numlab3.backgroundColor=[UIColor clearColor];
    [numlab3 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [topbtn3 addSubview:numlab3];
    
    //Setting topbtn1...
    
    topbtn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [topbtn4 setFrame:CGRectMake(195,0,50,46)];
    topbtn4.tag = 4;
    [topbtn4 addTarget:self action:@selector(likeView) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:topbtn4];
    
    toplab4=[[UILabel alloc]initWithFrame:CGRectMake(0, 2, 48, 25)];
    toplab4.text=@"推荐";
    toplab4.textAlignment=NSTextAlignmentCenter;
    toplab4.font=[UIFont systemFontOfSize:14.0];
    toplab4.backgroundColor=[UIColor clearColor];
    [toplab4 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [topbtn4 addSubview:toplab4];
    
    numlab4=[[UILabel alloc]initWithFrame:CGRectMake(0, 24, 48, 15)];
    numlab4.text=@"124679";
    numlab4.textAlignment=NSTextAlignmentCenter;
    numlab4.font=[UIFont systemFontOfSize:14.0];
    numlab4.backgroundColor=[UIColor clearColor];
    [numlab4 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [topbtn4 addSubview:numlab4];
    
    //Setting topbtn1...
    
    topbtn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [topbtn5 setFrame:CGRectMake(255,0,50,46)];
    topbtn5.tag = 5;
    [topbtn5 addTarget:self action:@selector(talkView) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:topbtn5];
    
    toplab5=[[UILabel alloc]initWithFrame:CGRectMake(0, 2, 48, 25)];
    toplab5.text=@"讨论";
    toplab5.textAlignment=NSTextAlignmentCenter;
    toplab5.font=[UIFont systemFontOfSize:14.0];
    toplab5.backgroundColor=[UIColor clearColor];
    [toplab5 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [topbtn5 addSubview:toplab5];
    
    numlab5=[[UILabel alloc]initWithFrame:CGRectMake(0, 24, 48, 15)];
    numlab5.text=@"276211";
    numlab5.textAlignment=NSTextAlignmentCenter;
    numlab5.font=[UIFont systemFontOfSize:14.0];
    numlab5.backgroundColor=[UIColor clearColor];
    [numlab5 setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [topbtn5 addSubview:numlab5];
    
}

-(void)costView{
    [infoVc.view removeFromSuperview];
    [iPhoneVc.view removeFromSuperview];
    [likeVc.view removeFromSuperview];
    [talkVc.view removeFromSuperview];

    
    costVc.view.frame = CGRectMake(0, 0, 320, costVc.tableView.contentSize.height + 44.0f + 150.0f);
    
    [newView addSubview:costVc.view];
    scrollView.contentSize = CGSizeMake(320, costVc.tableView.frame.size.height + 90);
    
    [topbtn3 setBackgroundImage:[UIImage imageNamed:@"topbtn"] forState:UIControlStateSelected];
    topbtn3.selected=YES;
    toplab3.highlightedTextColor=[UIColor whiteColor];
    numlab3.highlightedTextColor=[UIColor whiteColor];
    toplab3.highlighted=YES;
    numlab3.highlighted=YES;
    
    topbtn2.selected=NO;
    numlab2.highlighted=NO;
    toplab2.highlighted=NO;
    
    topbtn1.selected=NO;
    numlab1.highlighted=NO;
    toplab1.highlighted=NO;
    
    topbtn4.selected=NO;
    numlab4.highlighted=NO;
    toplab4.highlighted=NO;
    
    topbtn5.selected=NO;
    toplab5.highlighted=NO;
    numlab5.highlighted=NO;
}

-(void)likeView{
    [infoVc.view removeFromSuperview];
    [costVc.view removeFromSuperview];
    [iPhoneVc.view removeFromSuperview];
    [talkVc.view removeFromSuperview];

    
    likeVc.view.frame = CGRectMake(0, 0, 320, likeVc.tableView.contentSize.height + 44.0f + 550.0f);
    [newView addSubview:likeVc.view];
    scrollView.contentSize = CGSizeMake(320, likeVc.tableView.frame.size.height + 90);
    
    [topbtn4 setBackgroundImage:[UIImage imageNamed:@"topbtn"] forState:UIControlStateSelected];
    topbtn4.selected=YES;
    toplab4.highlightedTextColor=[UIColor whiteColor];
    numlab4.highlightedTextColor=[UIColor whiteColor];
    toplab4.highlighted=YES;
    numlab4.highlighted=YES;
    
    topbtn2.selected=NO;
    numlab2.highlighted=NO;
    toplab2.highlighted=NO;
    
    topbtn3.selected=NO;
    numlab3.highlighted=NO;
    toplab3.highlighted=NO;
    
    topbtn1.selected=NO;
    numlab1.highlighted=NO;
    toplab1.highlighted=NO;
    
    topbtn5.selected=NO;
    toplab5.highlighted=NO;
    numlab5.highlighted=NO;
}

-(void)InfoView{
    [iPhoneVc.view removeFromSuperview];
    [costVc.view removeFromSuperview];
    [likeVc.view removeFromSuperview];
    [talkVc.view removeFromSuperview];
    
    [newView addSubview:infoVc.view];
    scrollView.contentSize = CGSizeMake(320, self.infoVc.lab1.frame.size.height + self.infoVc.background.frame.size.height + self.infoVc.lab2.frame.size.height + 146.0f);
    

    [topbtn1 setBackgroundImage:[UIImage imageNamed:@"topbtn"] forState:UIControlStateSelected];
    topbtn1.selected=YES;
    toplab1.highlightedTextColor=[UIColor whiteColor];
    numlab1.highlightedTextColor=[UIColor whiteColor];
    toplab1.highlighted=YES;
    numlab1.highlighted=YES;
    
    topbtn2.selected=NO;
    numlab2.highlighted=NO;
    toplab2.highlighted=NO;
    
    topbtn3.selected=NO;
    numlab3.highlighted=NO;
    toplab3.highlighted=NO;
    
    topbtn4.selected=NO;
    numlab4.highlighted=NO;
    toplab4.highlighted=NO;
    
    topbtn5.selected=NO;
    toplab5.highlighted=NO;
    numlab5.highlighted=NO;
}


-(void)iPhoneScreenView{
    
    [infoVc.view removeFromSuperview];
    [costVc.view removeFromSuperview];
    [likeVc.view removeFromSuperview];
    [talkVc.view removeFromSuperview];
    
    [newView addSubview:iPhoneVc.view];
    iPhoneVc.view.frame = CGRectMake(0, 0, 320, iPhoneVc.imgScroll.frame.size.height);
    scrollView.contentSize = CGSizeMake(320, iPhoneVc.imgScroll.frame.size.height + 136.0f);
    
    [topbtn2 setBackgroundImage:[UIImage imageNamed:@"topbtn"] forState:UIControlStateSelected];
    topbtn2.selected=YES;
    toplab2.highlightedTextColor=[UIColor whiteColor];
    numlab2.highlightedTextColor=[UIColor whiteColor];
    toplab2.highlighted=YES;
    numlab2.highlighted=YES;
    
    topbtn1.selected=NO;
    numlab1.highlighted=NO;
    toplab1.highlighted=NO;
    
    topbtn3.selected=NO;
    numlab3.highlighted=NO;
    toplab3.highlighted=NO;
    
    topbtn4.selected=NO;
    numlab4.highlighted=NO;
    toplab4.highlighted=NO;
    
    topbtn5.selected=NO;
    toplab5.highlighted=NO;
    numlab5.highlighted=NO;
}

-(void)talkView{
    [infoVc.view removeFromSuperview];
    [costVc.view removeFromSuperview];
    [likeVc.view removeFromSuperview];
    [iPhoneVc.view removeFromSuperview];
    
    talkVc.view.frame = CGRectMake(0, 0, 320, talkVc.tableView.contentSize.height + 44.0f + 550.0f);
    [newView addSubview:talkVc.view];
    scrollView.contentSize = CGSizeMake(320, talkVc.tableView.frame.size.height + 90);
    
    [topbtn5 setBackgroundImage:[UIImage imageNamed:@"topbtn"] forState:UIControlStateSelected];
    topbtn5.selected=YES;
    toplab5.highlightedTextColor=[UIColor whiteColor];
    numlab5.highlightedTextColor=[UIColor whiteColor];
    toplab5.highlighted=YES;
    numlab5.highlighted=YES;
    
    topbtn2.selected=NO;
    numlab2.highlighted=NO;
    toplab2.highlighted=NO;
    
    topbtn3.selected=NO;
    numlab3.highlighted=NO;
    toplab3.highlighted=NO;
    
    topbtn4.selected=NO;
    numlab4.highlighted=NO;
    toplab4.highlighted=NO;
    
    topbtn1.selected=NO;
    toplab1.highlighted=NO;
    numlab1.highlighted=NO;
}


-(void)setBackView{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)footerView{
    footView=[[UIView alloc]init];
    self.footView.frame=CGRectMake(0, 376, 320, 50);
    self.footView.backgroundColor=[UIColor colorWithRed:64.0 / 255.0 green:64.0 / 255.0 blue:64.0 / 255.0 alpha:1.0];
    if (IS_IPHONE_5) {
        self.footView.frame = CGRectMake(0, 464, 320, 50);
    }
    [self.view addSubview:footView];
    
    footbtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    footbtn1.frame=CGRectMake(4,8, 76, 26);
    [self.footbtn1.titleLabel setTextColor:[UIColor colorWithRed:219 green:217 blue:203 alpha:1]];
    [self.footbtn1.layer setCornerRadius:3.0f];
    [self.footbtn1.layer setMasksToBounds:YES];
    [self.footbtn1.layer setBorderWidth:1.0f];
    [self.footbtn1.layer setBorderColor:(__bridge CGColorRef)([UIColor clearColor])];
    
    UIImageView *imgbtn1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rmbBar.png"]];
    imgbtn1.frame=CGRectMake(5, 5.5, 14, 14);
    
    UILabel *labbtn1 = [[UILabel alloc]initWithFrame:CGRectMake(22, 6, 56, 14)];
    labbtn1.text=@"付费购买";
    labbtn1.backgroundColor=[UIColor clearColor];
    [labbtn1 setTextColor:[UIColor colorWithRed:219 green:217 blue:203 alpha:1]];
    labbtn1.font=[UIFont fontWithName:@"Helvetica-Bold" size:14.0];
    
    [self.footbtn1 addSubview:labbtn1];
    [self.footbtn1 addSubview:imgbtn1];
    
    footbtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    footbtn2.frame = CGRectMake(88,8.5,76,26);
    [self.footbtn2.layer setCornerRadius:3.0f];
    [self.footbtn2.layer setMasksToBounds:YES];
    [self.footbtn2.layer setBorderWidth:1.0f];
    [self.footbtn2.layer setBorderColor:(__bridge CGColorRef)([UIColor clearColor])];
    
    UIImageView *imgbtn2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fileplusBar.png"]];
    imgbtn2.frame=CGRectMake(4, 5.5, 16, 16);
    
    UILabel *labbtn2 = [[UILabel alloc]initWithFrame:CGRectMake(22, 6, 56, 14)];
    labbtn2.text=@"愿望清单";
    labbtn2.backgroundColor=[UIColor clearColor];
    [labbtn2 setTextColor:[UIColor colorWithRed:219 green:217 blue:203 alpha:1]];
    labbtn2.font=[UIFont fontWithName:@"Helvetica-Bold" size:14.0];
    
    [self.footbtn2 addSubview:labbtn2];
    [self.footbtn2 addSubview:imgbtn2];
    
    footbtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    footbtn3.frame = CGRectMake(172,8.5,76,26);
    [self.footbtn3.layer setCornerRadius:3.0f];
    [self.footbtn3.layer setMasksToBounds:YES];
    [self.footbtn3.layer setBorderWidth:1.0f];
    [self.footbtn3.layer setBorderColor:(__bridge CGColorRef)([UIColor clearColor])];
    
    UIImageView *imgbtn3 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"commentBar.png"]];
    imgbtn3.frame=CGRectMake(4, 5.5, 16, 16);
    
    UILabel *labbtn3 = [[UILabel alloc]initWithFrame:CGRectMake(22, 6, 56, 14)];
    labbtn3.text=@"撰写评论";
    labbtn3.backgroundColor=[UIColor clearColor];
    [labbtn3 setTextColor:[UIColor colorWithRed:219 green:217 blue:203 alpha:1]];
    labbtn3.font=[UIFont fontWithName:@"Helvetica-Bold" size:14.0];
    
    [self.footbtn3 addSubview:labbtn3];
    [self.footbtn3 addSubview:imgbtn3];
    
    
    footbtn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    footbtn4.frame = CGRectMake(256,8.5,56,26);
    
    [self.footbtn4.layer setCornerRadius:3.0];
    [self.footbtn4.layer setMasksToBounds:YES];
    [self.footbtn4.layer setBorderWidth:1.0f];
    [self.footbtn4.layer setBorderColor:(__bridge CGColorRef)([UIColor clearColor])];
    
    UIImageView *imgbtn4 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"heartBar.png"]];
    imgbtn4.frame=CGRectMake(6, 6, 13, 13);
    
    UILabel *labbtn4 = [[UILabel alloc]initWithFrame:CGRectMake(24, 6, 30, 14)];
    labbtn4.text=@"推荐";
    labbtn4.backgroundColor=[UIColor clearColor];
    [labbtn4 setTextColor:[UIColor colorWithRed:219 green:217 blue:203 alpha:1]];
    labbtn4.font=[UIFont fontWithName:@"Helvetica-Bold" size:14.0];
    
    [self.footbtn4 addSubview:labbtn4];
    [self.footbtn4 addSubview:imgbtn4];
    
    [footbtn1 addTarget:self action:@selector(appLink:)forControlEvents:UIControlEventTouchUpInside];
    [footbtn2 addTarget:self action:@selector(addApp:)forControlEvents:UIControlEventTouchUpInside];
    [footbtn4 addTarget:self action:@selector(alert:)forControlEvents:UIControlEventTouchUpInside];
    
    [self.footView addSubview:footbtn1];
    [self.footView addSubview:footbtn2];
    [self.footView addSubview:footbtn3];
    [self.footView addSubview:footbtn4];
}

-(IBAction)addApp:(id)sender{
    NSString *info=[NSString stringWithFormat:@"已添加到愿望清单"];
    [SGInfoAlert showInfo:info
                  bgColor:[[UIColor darkGrayColor] CGColor]
                   inView:self.view
                 vertical:0.7];
}

-(IBAction)alert:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"我来推荐" message:nil
                                                  delegate:self
                                         cancelButtonTitle:@"取消" otherButtonTitles:@"发送", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alertTextField = [alert textFieldAtIndex:0];
    alertTextField.placeholder = @"写出您的推荐语";
    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
        
    contentString = [[alertView textFieldAtIndex:0]text];
    
    NSString *result = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                    (CFStringRef)contentString,
                                                                                    NULL,
                                                                                    CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                    kCFStringEncodingUTF8);
    
    NSLog(@"%@",result);
    
    NSString *postLikeTitle=[NSString stringWithFormat:@"uid=%@&aid=%@&content=%@",upuser_id,app_id,result];
    NSLog(@"%@",postLikeTitle);
    NSData *dealPostData=[postLikeTitle dataUsingEncoding:NSUTF8StringEncoding];
    NSURL *webController=[NSURL URLWithString:@"http://www.guo7.com/api/post_recommend?"];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:webController];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:dealPostData];
    NSURLConnection *sendRequest=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(!sendRequest){
        NSLog(@"%@:::请求访问失败",request);
    }else {
        NSLog(@"%@:::请求访问成功",request);
    }
}

-(IBAction)appLink:(id)sender{
    SKStoreProductViewController *skVC=[SKStoreProductViewController new];
    
    skVC.delegate=self;
    app_url = [app_dataSorce valueForKey:@"application_id"];
    
    dict = [NSDictionary dictionaryWithObject:app_url forKey:SKStoreProductParameterITunesItemIdentifier];
    [skVC loadProductWithParameters:dict completionBlock:nil];
    [self presentViewController:skVC animated:YES completion:nil];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location>=10)
    {
        return  NO;
    }
    else
    {
        return YES;
    }
}

-(void) productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"取消返回");
    }];
}

#pragma ScrollView

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollView.contentOffset.y >= 80) {
        topView.frame=CGRectMake(0, 0, 320, 46);
        [self.view addSubview:topView];
    }else {
        topView.frame=CGRectMake(0, 80, 320, 46);
        [self.scrollView addSubview:topView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
