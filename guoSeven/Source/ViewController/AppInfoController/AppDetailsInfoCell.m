//
//  AppDetailsInfoCell.m
//  guoSeven
//
//  Created by RainSets on 13-1-19.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "AppDetailsInfoCell.h"

@implementation AppDetailsInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:@"AppDetailsInfoCell" owner:self options:nil] objectAtIndex:0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
