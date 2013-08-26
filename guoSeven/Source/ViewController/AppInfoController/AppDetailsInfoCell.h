//
//  AppDetailsInfoCell.h
//  guoSeven
//
//  Created by RainSets on 13-1-19.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDetailsInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userAvart;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *publishTime;
@property (weak, nonatomic) IBOutlet UILabel *publishContent;
@property (weak, nonatomic) IBOutlet UIImageView *imgVLine;
@property (weak, nonatomic) IBOutlet UIButton *btnSupport;
@property (weak, nonatomic) IBOutlet UIButton *btnReply;

@end
