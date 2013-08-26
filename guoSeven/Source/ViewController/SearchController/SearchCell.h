//
//  SearchCell.h
//  guoSeven
//
//  Created by luyun on 13-1-21.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCell : UITableViewCell
@property (nonatomic, retain) IBOutlet UIImageView *img;
@property (nonatomic, retain) IBOutlet UILabel *name;
@property (nonatomic, retain) IBOutlet UILabel *info;
@property (nonatomic, retain) IBOutlet UILabel *price;
@property (nonatomic, retain) IBOutlet UILabel *infoPrice;
@property (weak, nonatomic) IBOutlet UIImageView *priceImg;



@end
