//
//  TestRelikeCell.h
//  guoSeven
//
//  Created by David on 13-1-19.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"
@interface TestRelikeCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *appIcon;
@property (strong, nonatomic) IBOutlet UILabel *appName;
@property (strong, nonatomic) IBOutlet UILabel *appPrice;
@property (strong, nonatomic) IBOutlet UILabel *appType;
@property (strong, nonatomic) IBOutlet UILabel *appContent;
@property (strong, nonatomic) IBOutlet UIImageView *appPriceType;
@property (strong, nonatomic) IBOutlet CustomView *customView;
@property (strong, nonatomic) IBOutlet UIView *backGroundView;
@property (strong, nonatomic) IBOutlet UIImageView *bottomIV;
@property (strong, nonatomic) IBOutlet UIImageView *leftYinIV;
@property (strong, nonatomic) IBOutlet UIImageView *rightYinIV;

@end
