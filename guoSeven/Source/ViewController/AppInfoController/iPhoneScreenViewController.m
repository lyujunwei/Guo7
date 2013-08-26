//
//  iPhoneScreenViewController.m
//  guoSeven
//
//  Created by zucknet on 13/1/7.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "iPhoneScreenViewController.h"
#import "UIImageView+Addition.h"
#import "UIImageView+AFNetworking.h"
#import "SBJson.h"
#import "DetailViewController.h"


@interface iPhoneScreenViewController ()

@end

@implementation iPhoneScreenViewController
@synthesize iPhone_url1,iPhone_url2,iPhone_url3,iPhone_url4,iPhone_url5;
@synthesize imgScroll;
@synthesize image1,image2,image3,image4,image5;
@synthesize detailViewController = _detailViewController;
@synthesize iPad_url1,iPad_url2,iPad_url3,iPad_url4,iPad_url5;


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
    imgScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 320)];
    imgScroll.contentSize = CGSizeMake(902, 320);
    imgScroll.showsVerticalScrollIndicator = FALSE;
    imgScroll.showsHorizontalScrollIndicator = FALSE;
    [self.view addSubview:imgScroll];
    
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 200, 150)];
    [self.view addSubview:subView];
    
    image1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 213, 320)];
    image2 = [[UIImageView alloc]initWithFrame:CGRectMake(233, 7, 213, 320)];
    image3 = [[UIImageView alloc]initWithFrame:CGRectMake(456, 7, 213, 320)];
    image4 = [[UIImageView alloc]initWithFrame:CGRectMake(679, 7, 213, 320)];
    //image5 = [[UIImageView alloc]initWithFrame:CGRectMake(902, 7, 213, 320)];

    if (iPad_url1 == [NSNull null] && iPhone_url1 != [NSNull null])
    {
        sc1 = [NSURL URLWithString:iPhone_url1];
        sc2 = [NSURL URLWithString:iPhone_url2];
        sc3 = [NSURL URLWithString:iPhone_url3];
        sc4 = [NSURL URLWithString:iPhone_url4];
       // sc5 = [NSURL URLWithString:iPhone_url5];
        
    } else if (iPad_url1 != [NSNull null])
    {
        sc1 = [NSURL URLWithString:iPad_url1];
        sc2 = [NSURL URLWithString:iPad_url2];
        sc3 = [NSURL URLWithString:iPad_url3];
        sc4 = [NSURL URLWithString:iPad_url4];
      //  sc5 = [NSURL URLWithString:iPad_url5];
    }

    [image1 setImageWithURL:sc1 placeholderImage:[UIImage imageNamed:@"hi"]];
    [subView addSubview:image1];
    image1.contentMode = UIViewContentModeScaleToFill;
    //[image1 addDetailShow];
    
    [image2 setImageWithURL:sc2 placeholderImage:[UIImage imageNamed:@"hi"]];
    [subView addSubview:image2];
    image2.contentMode = UIViewContentModeScaleToFill;
    //[image2 addDetailShow];
    
    [image3 setImageWithURL:sc3 placeholderImage:[UIImage imageNamed:@"hi"]];
    [subView addSubview:image3];
    image3.contentMode = UIViewContentModeScaleToFill;
    //[image3 addDetailShow];
    
    [image4 setImageWithURL:sc4 placeholderImage:[UIImage imageNamed:@"hi"]];
    [subView addSubview:image4];
    image4.contentMode = UIViewContentModeScaleToFill;
    //[image4 addDetailShow];
    
  //  [image5 setImageWithURL:sc5 placeholderImage:[UIImage imageNamed:@"hi"]];
  //  [subView addSubview:image5];
  //  image5.contentMode = UIViewContentModeScaleToFill;
    //[image5 addDetailShow];
    
    [self.imgScroll addSubview:image1];
    [self.imgScroll addSubview:image2];
    [self.imgScroll addSubview:image3];
    [self.imgScroll addSubview:image4];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
