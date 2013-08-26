//
//  MyLoadingView.h
//  SonyMarket
//
//  Created by 顾 鹏凌 on 12-12-6.
//  Copyright (c) 2012年 顾 鹏凌. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface MyLoadingView : UIView
@property (nonatomic, strong) UILabel *label;

+ (id)viewInSuperView:(UIView *)superview;
- (void)showAnimated:(BOOL)animated withString:(NSString *)string;
- (void)hiddenAnimated:(BOOL)animated thenRemoveup:(BOOL)removeup;
@end
