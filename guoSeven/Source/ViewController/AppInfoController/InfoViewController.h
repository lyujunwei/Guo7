//
//  InfoViewController.h
//  guoSeven
//
//  Created by zucknet on 13/1/6.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController{
    NSString *rushlab1;
    UILabel *lab1;
    
    UIView *background;
    
    NSString *rushlab2;
    UILabel *lab2;
    
    NSString *rushlab3;
    NSString *rushlab4;
    NSString *rushlab5;
    NSString *rushlab6;
    NSString *rushlab7;
}

@property(nonatomic,strong)NSString *rushlab1;
@property(nonatomic,strong)NSString *rushlab2;
@property(nonatomic,strong)NSString *rushlab3;
@property(nonatomic,strong)NSString *rushlab4;
@property(nonatomic,strong)NSString *rushlab5;
@property(nonatomic,strong)NSString *rushlab6;
@property(nonatomic,strong)NSString *rushlab7;
@property(nonatomic,strong)UIView *background;

@property(nonatomic,strong)UILabel *lab1;
@property(nonatomic,strong)UILabel *lab2;

@end
