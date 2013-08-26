//
//  MyFirendViewController.h
//  GPlay
//
//  Created by zucknet on 12/11/9.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyFirendViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UIImage *_image;
    NSMutableArray *userdata;
}

@property(nonatomic,retain)UIButton *btn1;
@property(nonatomic,retain)UIButton *btn2;
@property(nonatomic,retain)UIButton *btn3;
@property(nonatomic,retain)NSArray *tablelist;
@property(nonatomic,retain)NSMutableArray *userdata;

-(IBAction)clickbtn1:(id)sender;
-(IBAction)clickbtn2:(id)sender;
-(IBAction)clickbtn3:(id)sender;

-(void)userSectionsData;

@end
