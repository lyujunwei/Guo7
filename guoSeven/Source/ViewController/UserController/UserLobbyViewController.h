//
//  UserLobbyViewController.h
//  guoSeven
//
//  Created by zucknet on 13/1/7.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface UserLobbyViewController : UITableViewController{
    NSString *user_id;
    
    NSMutableArray *userfeed_dataSorce;
    
    UIView *allView;
    
    UIImageView *uimg;
    NSString *uString;
    
    UILabel *titlename;
    NSString *name;
    
    NSString *act_user;
    NSString *act_addapp;
    NSString *act_appcation;
    
    UILabel *datelabel;
    NSString *date;
    
    UIView *seeBackView;
    
    UIImageView *seeView;
    NSString *appString;
    NSString *userString;
    
    NSString *userimg;
    
    UILabel *seenamelabel;
    UILabel *obj_signaturelabel;
    UILabel *user_ratinglabel;
    
    NSString *appname;
    NSString *obj_name;
    NSString *obj_signature;
    
    NSString *user_rating;
    NSString *create_time;
    NSString *primary_genre_name;
    NSString *supported_device_name;
    NSString *obj_details;
    
    UILabel *App_titleinfo;
    
    UIView *lobbyheader;
    
    NSString *application_count;
    
}

@property (strong, nonatomic) DetailViewController *detailViewController;

@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSMutableArray *userfeed_dataSorce;


@end
