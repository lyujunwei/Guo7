//
//  RespondViewController.h
//  guoSeven
//
//  Created by David on 13-1-15.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SquareModel.h"
#import "CustomView.h"

@protocol RespondViewControllerDelegate <NSObject>

- (void)refreshData;

@end
@interface RespondViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, CustomViewDelegate, UITextFieldDelegate>
@property (nonatomic, retain) SquareModel *squareModle;
@property (nonatomic, assign) id<RespondViewControllerDelegate>delegate;
@end
