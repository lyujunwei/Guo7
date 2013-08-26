//
//  RespondCell.h
//  guoSeven
//
//  Created by David on 13-1-16.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RespondCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *userIcon;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UIImageView *bottomLine;

@end
