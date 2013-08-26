//
//  AttentionCell.h
//  guoSeven
//
//  Created by David on 13-1-19.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"

@interface AttentionCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *userIcon;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *usertLocation;
@property (strong, nonatomic) IBOutlet UILabel *userSignature;
@property (strong, nonatomic) IBOutlet CustomView *customView;
@property (strong, nonatomic) IBOutlet UIView *backGroundView;
@property (strong, nonatomic) IBOutlet UIImageView *leftYinIV;
@property (strong, nonatomic) IBOutlet UIImageView *rightYinIV;

@end
