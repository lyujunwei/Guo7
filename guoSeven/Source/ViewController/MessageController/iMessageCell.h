//
//  iMessageCell.h
//  guoSeven
//
//  Created by David on 13-1-21.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"

@interface iMessageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *userIcon;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *userMessage;
@property (strong, nonatomic) IBOutlet UILabel *userTime;
@property (strong, nonatomic) IBOutlet CustomView *customView;
@property (strong, nonatomic) IBOutlet UIView *backGroundView;
@property (strong, nonatomic) IBOutlet UIImageView *bottomIV;
@property (strong, nonatomic) IBOutlet UIButton *userBtn;


@end
