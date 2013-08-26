//
//  WantViewController.h
//  guoSeven
//
//  Created by zucknet on 13/1/5.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrikeThroughLabel.h"
#import "CustomView.h"
@class DetailViewController;
#import "RespondViewController.h"

@interface WantViewController : UIViewController<CustomViewDelegate, UITableViewDataSource, UITableViewDelegate,RespondViewControllerDelegate>{
    NSMutableArray *want_dataSorce;
    UIView *appView;
    UIView *wantheader;
        
    UIImageView *app_img;
    NSString *link_img;
    
    UILabel *app_name;
    NSString *link_name;
    
    UIImageView *app_rank;
    NSString *link_rank;
    
    NSString *link_primary_genre_name;
    NSString *link_export_date;
    NSString *link_supported_device_name;
    UILabel *app_title;
    
    NSString *link_application_old_price;
    NSString *link_application_retail_price;
   // UILabel *app_old_price;
    StrikeThroughLabel *app_old_price;

    UILabel *app_retail_price;
    
    UILabel *app_limitedStateName;
    NSString *link_limitedStateName;
    
}

//@property(nonatomic,strong)NSMutableArray *want_dataSorce;
@property (strong, nonatomic) DetailViewController *detailViewController;
- (void)getdata;
@end
