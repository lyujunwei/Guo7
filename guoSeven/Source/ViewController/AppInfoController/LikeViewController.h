//
//  LikeViewController.h
//  guoSeven
//
//  Created by zucknet on 13/1/8.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface LikeViewController : UITableViewController{
    NSString *like_id;
    NSMutableArray *like_dataSorce;
    
    NSString *userimg;
    
    UILabel *contentlab;
    NSString *contentString;
    
    UIView *contentView;
    
    UIImageView *user_img;
    
    UILabel *userlab;
    NSString *userString;
    NSString *username;
    
    UIView *Likeheader;
}

@property (strong, nonatomic) DetailViewController *detailViewController;
@property(nonatomic,strong)NSString *like_id;
@property(nonatomic,strong)NSMutableArray *like_dataSorce;


@end
