//
//  WishCell.h
//  guoSeven
//
//  Created by David on 13-1-18.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"

@interface WishCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *backGroundView;
@property (strong, nonatomic) IBOutlet UIImageView *appIcon;
@property (strong, nonatomic) IBOutlet UILabel *appName;
@property (strong, nonatomic) IBOutlet UILabel *appType;
@property (strong, nonatomic) IBOutlet UILabel *appPrice;
@property (strong, nonatomic) IBOutlet UIImageView *appPriveIV;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UILabel *zanLabel;
@property (strong, nonatomic) IBOutlet UILabel *respondeLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet CustomView *customView;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIButton *appBtn;
@property (strong, nonatomic) IBOutlet UIButton *zanBtn;
@property (strong, nonatomic) IBOutlet UIView *zanBackIV;
@property (strong, nonatomic) IBOutlet UIView *responserBackIV;

@end
