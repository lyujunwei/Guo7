//
//  iChatViewCell.h
//  guoSeven
//
//  Created by David on 13-1-21.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iChatViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *userLeftIcon;
@property (strong, nonatomic) IBOutlet UIImageView *leftBubbleIV;
@property (strong, nonatomic) IBOutlet UIImageView *userRightIcon;
@property (strong, nonatomic) IBOutlet UIImageView *rightBubbleIV;
@property (strong, nonatomic) IBOutlet UILabel *conentLB;
@property (strong, nonatomic) IBOutlet UILabel *timeLB;

@end
