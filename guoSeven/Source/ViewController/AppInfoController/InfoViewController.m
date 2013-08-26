//
//  InfoViewController.m
//  guoSeven
//
//  Created by zucknet on 13/1/6.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "InfoViewController.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize rushlab1,rushlab2,rushlab3,rushlab4,rushlab5,rushlab6,rushlab7;
@synthesize lab1,lab2;
@synthesize background;

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
    lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    rushlab1 =  [rushlab1 stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    lab1.text = rushlab1;
    UIFont *lab1font = [UIFont systemFontOfSize:13];
    lab1.font =lab1font;
    lab1.backgroundColor = [UIColor clearColor];
    [lab1 setNumberOfLines:0];
    CGSize size = CGSizeMake(320,2000);
    CGSize labelsize = [rushlab1 sizeWithFont:lab1font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    lab1.frame = CGRectMake(0, 0, 320, labelsize.height);
    [self.view addSubview:lab1];
    
    background = [[UIView alloc]initWithFrame:CGRectMake(0, lab1.frame.size.height+5, 320, 3)];
    background.backgroundColor = [UIColor blackColor];
    [self.view addSubview:background];
    
    lab2 = [[UILabel alloc]initWithFrame:CGRectMake(0,0,0,0)];
    lab2.text = [NSString stringWithFormat:@"开发商：%@ \n类型：%@ \n平台：%@ \n容量：%@ \n语言：%@",rushlab2,rushlab4,rushlab5,rushlab6,rushlab7];

    UIFont *lab2font = [UIFont systemFontOfSize:13];
    lab2.font = lab2font;
    lab2.backgroundColor = [UIColor clearColor];
    [lab2 setNumberOfLines:0];
    CGSize sizess = CGSizeMake(320,2000);
    CGSize labelsize1 = [rushlab7 sizeWithFont:lab2font constrainedToSize:sizess lineBreakMode:NSLineBreakByWordWrapping];
    lab2.frame = CGRectMake(0, lab1.frame.size.height+5 + background.frame.size.height+5 , 320, labelsize1.height * 6 );
    [self.view addSubview:lab2];
    
    self.view.frame = CGRectMake(0, 0, 320, self.lab1.frame.size.height + self.background.frame.size.height + self.lab2.frame.size.height);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
