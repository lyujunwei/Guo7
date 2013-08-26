//
//  MyLoadingView.m
//  SonyMarket
//
//  Created by 顾 鹏凌 on 12-12-6.
//  Copyright (c) 2012年 顾 鹏凌. All rights reserved.
//

#import "MyLoadingView.h"

@implementation MyLoadingView
@synthesize label;

- (id)initWithSuperview:(UIView *)superview {
    self = [super initWithFrame:CGRectMake(0, 0, superview.frame.size.width, superview.frame.size.height)];
    if (self) {
        self.exclusiveTouch = YES;
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(90, 180, 140, 80)];
        bg.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.85];
		self.label = [[UILabel alloc] initWithFrame:CGRectMake(12, 40, 120, 30)];
		self.label.text = @"loading...";
		self.label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
        //        label.textAlignment = UITextAlignmentCenter;
        self.label.textAlignment = NSTextAlignmentCenter;
		self.label.textColor = [UIColor whiteColor];
		self.label.backgroundColor = [UIColor clearColor];
		[bg addSubview:self.label];
		UIActivityIndicatorView *spin = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		spin.center = CGPointMake(70, 25);
		[spin startAnimating];
		[bg addSubview:spin];
		bg.layer.cornerRadius = 8;
        bg.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.85].CGColor;
        bg.layer.borderWidth = 2.0;
        [self addSubview:bg];
        self.hidden = YES;
        [superview addSubview:self];
    }
    return self;
}
+ (id)viewInSuperView:(UIView *)superview {
    return [[MyLoadingView alloc] initWithSuperview:superview];
}
#pragma loadingview 控制
- (void)showAnimated:(BOOL)animated withString:(NSString *)string {
    if (!string) {
        string = @"loading...";
    }
    self.label.text = string;
    if (animated) {
        self.alpha = 0;
        self.hidden = NO;
        [UIView	animateWithDuration:0.2
                         animations:^{
                             self.alpha = 1.;
                         }];
    } else {
        self.hidden = NO;
        self.alpha = 1.;
    }

}
- (void)hiddenAnimated:(BOOL)animated thenRemoveup:(BOOL)removeup {
    if (animated) {
        [UIView	animateWithDuration:0.2
                         animations:^{
                             self.alpha = 0;
                         }
                         completion:^(BOOL finished){
                             self.hidden = YES;
                             if (removeup) {
                                 [self removeFromSuperview];
                             }
                         }];
    } else {
        self.hidden = YES;
        if (removeup) {
            [self removeFromSuperview];
        }
    }

}
@end
