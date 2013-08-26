//
//  FootbtnViewController.h
//  GPlay
//
//  Created by zucknet on 12/10/25.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FootbtnViewController : UIViewController

@property(nonatomic,retain)UIView *footView;
@property(nonatomic,retain)UIButton *footbtn1;
@property(nonatomic,retain)UIButton *footbtn2;

-(IBAction)pushMessage:(id)sender;

@end
