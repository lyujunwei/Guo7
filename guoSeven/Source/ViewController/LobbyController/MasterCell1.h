//
//  MasterCell1.h
//  guoSeven
//
//  Created by David on 13-1-15.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"

@interface MasterCell1 : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *leftUIcon;
@property (strong, nonatomic) IBOutlet UIImageView *appIcon;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *appName;
@property (strong, nonatomic) IBOutlet UILabel *appType;
@property (strong, nonatomic) IBOutlet UILabel *zanLabel;
@property (strong, nonatomic) IBOutlet UILabel *respondLabel;
@property (strong, nonatomic) IBOutlet UIButton *userBtn;
@property (strong, nonatomic) IBOutlet UIButton *appBtn;
@property (strong, nonatomic) IBOutlet UIButton *zanBtn;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *appPric;
@property (strong, nonatomic) IBOutlet UIImageView *appPriceIV;
@property (strong, nonatomic) IBOutlet UILabel *actionTypeNameLable;
@property (strong, nonatomic) IBOutlet UILabel *contentLable;

@property (strong, nonatomic) IBOutlet UIView *bottomIV;
@property (strong, nonatomic) IBOutlet UILabel *objUserLocation;

@property (strong, nonatomic) IBOutlet UIView *backGroundView;
@property (strong, nonatomic) IBOutlet CustomView *customView;
@property (strong, nonatomic) IBOutlet UIView *centerView;
@property (strong, nonatomic) IBOutlet UIView *zanBackView;
@property (strong, nonatomic) IBOutlet UIView *respondBackView;
@property (strong, nonatomic) IBOutlet UIImageView *leftYinIV;
@property (strong, nonatomic) IBOutlet UIImageView *rightYinIV;
@end
