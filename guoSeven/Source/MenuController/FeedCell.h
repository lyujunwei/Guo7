//
//  FeedCell.h
//  guoSeven
//
//  Created by David on 13-2-1.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"
@interface FeedCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconImg;
@property (strong, nonatomic) IBOutlet UILabel *leftLB;
@property (strong, nonatomic) IBOutlet UIView *bGView;
@property (strong, nonatomic) IBOutlet UIView *backGoundView;
@property (strong, nonatomic) IBOutlet CustomView *cutomView;
@property (strong, nonatomic) IBOutlet UIImageView *bottomLine;

@end
