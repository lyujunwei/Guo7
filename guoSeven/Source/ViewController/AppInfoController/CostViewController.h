//
//  CostViewController.h
//  guoSeven
//
//  Created by zucknet on 13/1/6.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface CostViewController : UITableViewController{
    NSString *cost_id;
    NSMutableArray *cost_dataSorce;
    UIView *tableCell;
    
    NSString *pricing_time; //时间
    NSString *version;  //版本
    NSString *retail_price; //价格
    NSString *price_name; //状态、更新、降价、涨价
    
    UILabel *pricing_time_lab;
    UILabel *version_lab;
    UILabel *retail_price_lab;
    UILabel *price_name_lab;
    
    NSString *free;
	NSString *price_drop;
	NSString *priceMax;
	NSString *priceMin;
    
    NSMutableArray *statistics;    
    
}

@property(nonatomic,strong)NSString *cost_id;
@property (strong, nonatomic) DetailViewController *detailViewController;
@property(nonatomic,strong)NSMutableArray *cost_dataSorce;
@property(nonatomic,strong)NSMutableArray *statistics;

@property(nonatomic,strong)UILabel *oldUpCost;
@property(nonatomic,strong)UILabel *oldDownCost;
@property(nonatomic,strong)UILabel *freeCost;
@property(nonatomic,strong)UILabel *freeDown;

@end
