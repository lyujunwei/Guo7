//
//  iPhoneScreenViewController.h
//  guoSeven
//
//  Created by zucknet on 13/1/7.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface iPhoneScreenViewController : UIViewController<UIScrollViewDelegate>{
    NSString *iPhone_url1;
    NSString *iPhone_url2;
    NSString *iPhone_url3;
    NSString *iPhone_url4;
    NSString *iPhone_url5;
    UIScrollView *imgScroll;
    
    NSString *iPad_url1;
    NSString *iPad_url2;
    NSString *iPad_url3;
    NSString *iPad_url4;
    NSString *iPad_url5;
    
    UIImageView *image1;
    UIImageView *image2;
    UIImageView *image3;
    UIImageView *image4;
    UIImageView *image5;

    NSURL *sc1;
    NSURL *sc2;
    NSURL *sc3;
    NSURL *sc4;
    NSURL *sc5;
    
    NSString *img_size;
    
}

@property(nonatomic,strong)NSString *iPhone_url1;
@property(nonatomic,strong)NSString *iPhone_url2;
@property(nonatomic,strong)NSString *iPhone_url3;
@property(nonatomic,strong)NSString *iPhone_url4;
@property(nonatomic,strong)NSString *iPhone_url5;
@property(nonatomic,strong)UIScrollView *imgScroll;

@property(nonatomic,strong)NSString *iPad_url1;
@property(nonatomic,strong)NSString *iPad_url2;
@property(nonatomic,strong)NSString *iPad_url3;
@property(nonatomic,strong)NSString *iPad_url4;
@property(nonatomic,strong)NSString *iPad_url5;


@property(nonatomic,retain)UIImageView *image1;
@property(nonatomic,retain)UIImageView *image2;
@property(nonatomic,retain)UIImageView *image3;
@property(nonatomic,retain)UIImageView *image4;
@property(nonatomic,retain)UIImageView *image5;

@property (strong, nonatomic) DetailViewController *detailViewController;


@end
