//
//  iMessageCell.m
//  guoSeven
//
//  Created by David on 13-1-21.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "iMessageCell.h"

@implementation iMessageCell
@synthesize userIcon, userMessage, userName, userTime, customView, backGroundView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    
    userTime.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    
    if (editing) {
        [UIView animateWithDuration:0.3 animations:^{
            self.userIcon.frame = CGRectMake(10 + 30, self.userIcon.frame.origin.y, self.userIcon.frame.size.width, self.userIcon.frame.size.height);
            self.userName.frame = CGRectMake(70 + 30, self.userName.frame.origin.y, self.userName.frame.size.width, self.userName.frame.size.height);
            self.userMessage.frame = CGRectMake(70 + 30, self.userMessage.frame.origin.y, self.userMessage.frame.size.width, self.userMessage.frame.size.height);
            self.userTime.frame = CGRectMake(70 + 30, self.userTime.frame.origin.y, self.userTime.frame.size.width, self.userTime.frame.size.height);
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.userIcon.frame = CGRectMake(10, self.userIcon.frame.origin.y, self.userIcon.frame.size.width, self.userIcon.frame.size.height);
            self.userName.frame = CGRectMake(70, self.userName.frame.origin.y, self.userName.frame.size.width, self.userName.frame.size.height);
            self.userName.frame = CGRectMake(70, self.userName.frame.origin.y, self.userName.frame.size.width, self.userName.frame.size.height);
            self.userMessage.frame = CGRectMake(70, self.userMessage.frame.origin.y, self.userMessage.frame.size.width, self.userMessage.frame.size.height);
            self.userTime.frame = CGRectMake(70, self.userTime.frame.origin.y, self.userTime.frame.size.width, self.userTime.frame.size.height);
        }];
    }
    
}

@end
