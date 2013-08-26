//
//  TestFriendViewController.h
//  guoSeven
//
//  Created by zucknet on 12/12/11.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackgroundViewController.h"
#import "CustomView.h"
@class DetailViewController;

@interface TestFriendViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, CustomViewDelegate>{
//    NSMutableArray *dataSorce;
//    
//    UIView *appCellView;
//    
//    //头像
//    UIImageView *obj_imgView;
//    NSString *obj_img;
//    //名字
//    NSString *obj_name;
//    UILabel *obj_namelabel;
//    //签名
//    NSString *obj_signature;
//    UILabel *obj_signaturelabel;
//    //其他
//    NSString *obj_more;
//    UILabel *obj_morelabel;
    
}

@property(nonatomic,strong)DetailViewController *detailVewController;
//@property(nonatomic,strong)NSMutableArray *dataSorce;
@property (nonatomic, strong) UIButton *topbtn1;
@property (nonatomic, strong) UIButton *topbtn2;
-(void)getData;
@end
