//
//  AppsRootViewController.h
//  guoSeven
//
//  Created by zucknet on 13/1/6.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@class DetailViewController;
@class InfoViewController;
@class CostViewController;
@class iPhoneScreenViewController;
@class LikeViewController;
@class TalkingViewController;

@interface AppsRootViewController : UIViewController<UIScrollViewAccessibilityDelegate,UIScrollViewDelegate,SKStoreProductViewControllerDelegate,UITextFieldDelegate>{
    UIScrollView *scrollView;
    NSMutableArray *app_dataSorce;
    NSString *app_id;
    
    //AppsInfo 相关信息
    NSString *title;
    UILabel *title_lab;
    
    NSString *artist_name;
    UILabel *artist_name_lab;
    
    UIImageView *app_image;
    NSString *artwork_url_small;
    
    UIImageView *app_rank_image;
    NSString *app_rank;
    
    //按钮下的View
    UIView *topView;
    
    //按钮
    UIButton *topbtn1;
    UIButton *topbtn2;
    UIButton *topbtn3;
    UIButton *topbtn4;
    UIButton *topbtn5;
    
    UILabel *toplab1;
    UILabel *toplab2;
    UILabel *toplab3;
    UILabel *toplab4;
    UILabel *toplab5;
    
    UILabel *numlab1;
    UILabel *numlab2;
    UILabel *numlab3;
    UILabel *numlab4;
    UILabel *numlab5;
    
    UIButton *button;
    
    UIView *newView;
    
    NSString *app_url;
    NSDictionary *dict;
    
    NSMutableArray *image_size;
    NSString *iPad_img;
    NSString *iPhone_img;
    NSString *Mac_img;
    
    UITextField *alertTextField;
    
    
    //上传讨论信息;
    NSString *upuser_id; //用户uid
    UILabel *upuser_lab; //用户uid _ lab
    
    NSString *contentString; //用户评论String

    
}

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *app_dataSorce;
@property(nonatomic,strong)NSString *app_id;
@property (strong, nonatomic) DetailViewController *detailViewController;
@property(strong,nonatomic)InfoViewController *infoVc;
@property(strong,nonatomic)CostViewController *costVc;
@property(nonatomic,strong)iPhoneScreenViewController *iPhoneVc;
@property(nonatomic,strong)LikeViewController *likeVc;
@property(nonatomic,strong)TalkingViewController *talkVc;

@property(nonatomic,strong)UIView *footView;
@property(nonatomic,strong)UIButton *footbtn1;
@property(nonatomic,strong)UIButton *footbtn2;
@property(nonatomic,strong)UIButton *footbtn3;
@property(nonatomic,strong)UIButton *footbtn4;
@property(nonatomic,retain)NSDictionary *dict;
@property(nonatomic,retain)NSString *app_url;


@end
