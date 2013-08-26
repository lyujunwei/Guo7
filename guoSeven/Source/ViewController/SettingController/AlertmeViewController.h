//
//  AlertmeViewController.h
//  GPlay
//
//  Created by zucknet on 12/10/29.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface AlertmeViewController : UITableViewController<UIActionSheetDelegate>

@property(nonatomic,retain)NSArray *tablelist;
@property(nonatomic,retain)UISwitch *switchView;

- (void)updateSwitchAtIndexPath;

@end
