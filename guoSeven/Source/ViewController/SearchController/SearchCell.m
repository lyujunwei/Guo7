//
//  SearchCell.m
//  guoSeven
//
//  Created by luyun on 13-1-21.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell
@synthesize name,img,info,infoPrice,price,priceImg;

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

}

@end
