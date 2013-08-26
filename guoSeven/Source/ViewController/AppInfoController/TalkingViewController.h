//
//  TalkingViewController.h
//  guoSeven
//
//  Created by zucknet on 13/1/9.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface TalkingViewController : UITableViewController{
    
    NSMutableArray *talk_dataSorce;
    NSString *talk_id;
    
    NSString *userimg;
    
    UILabel *contentlab;
    NSString *contentString;
    
    UIView *contentView;
    
    UIImageView *user_img;
    
    UILabel *userlab;
    NSString *userString;
    NSString *username;
    
    UIView *talkheader;
    
}

@property (strong, nonatomic) DetailViewController *detailViewController;
@property(nonatomic,strong)NSString *talk_id;
@property(nonatomic,strong)NSMutableArray *talk_dataSorce;

@end
