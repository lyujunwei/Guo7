//
//  BackgroundViewController.m
//  guoSeven
//
//  Created by zucknet on 12/12/11.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "BackgroundViewController.h"

@interface BackgroundViewController ()

@end

@implementation BackgroundViewController

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
    
    self.view.backgroundColor=[UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0];
    
    [self topButton];
        
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 45.5, 310, self.view.frame.size.height - 90.0f)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundView=nil;
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = FALSE;
    _tableView.showsHorizontalScrollIndicator = FALSE;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    navBackground = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, 320, 1)];
    navBackground.image=[UIImage imageNamed:@"bg-shadowline@2x"];
    [self.view addSubview:navBackground];
    
    UITapGestureRecognizer *hiddenView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewHidden:)];
    hiddenView.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:hiddenView];

}

-(void)viewHidden:(UITapGestureRecognizer *)hiddenView{
    [testheader resignFirstResponder];
}

-(void)topButton{
    topbtn1=[UIButton buttonWithType:UIButtonTypeCustom];
    [topbtn1 setFrame:CGRectMake(0 , 0, 106, 44)];
    [topbtn1 setTitleColor:[UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [topbtn1.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    topbtn1.backgroundColor=[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1.0];
    [topbtn1 addTarget:self action:@selector(clickbtn1:)forControlEvents:UIControlEventTouchUpInside];
    
    topbtn2=[UIButton buttonWithType:UIButtonTypeCustom];
    [topbtn2 setFrame:CGRectMake(107,0,106,44)];
    [topbtn2 setTitleColor:[UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [topbtn2.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    topbtn2.backgroundColor=[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1.0];
    [topbtn2 addTarget:self action:@selector(clickbtn2:)forControlEvents:UIControlEventTouchUpInside];
    
    topbtn3=[UIButton buttonWithType:UIButtonTypeCustom];
    [topbtn3 setFrame:CGRectMake(214,0,106,44)];
    [topbtn3 setTitleColor:[UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [topbtn3.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    topbtn3.backgroundColor=[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1.0];
    [topbtn3 addTarget:self action:@selector(clickbtn3:)forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:topbtn1];
    [self.view addSubview:topbtn2];
    [self.view addSubview:topbtn3];
}

-(IBAction)clickbtn1:(id)sender{
    [topbtn1 setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [topbtn2 setTitleColor:[UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [topbtn3 setTitleColor:[UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1.0] forState:UIControlStateNormal];
}

-(IBAction)clickbtn2:(id)sender{
    [topbtn2 setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [topbtn1 setTitleColor:[UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [topbtn3 setTitleColor:[UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1.0] forState:UIControlStateNormal];
}

-(IBAction)clickbtn3:(id)sender{
    [topbtn3 setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [topbtn2 setTitleColor:[UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [topbtn1 setTitleColor:[UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1.0] forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated{
    [topbtn1 setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [topbtn2 setTitleColor:[UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [topbtn2 setTitleColor:[UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1.0] forState:UIControlStateNormal];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
