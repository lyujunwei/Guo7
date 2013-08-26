//
//  BackgroundViewController.h
//  guoSeven
//
//  Created by zucknet on 12/12/11.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackgroundViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    //Top button
    UIButton *topbtn1;
    UIButton *topbtn2;
    UIButton *topbtn3;
    
    UITableView *_tableView;
    
    UIView *testheader;//头部View
    UIImageView *navBackground;
    
}

-(void)topButton;


@end
