//
//  CustomView.h
//  guoSeven
//
//  Created by David on 13-1-17.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomViewDelegate <NSObject>

- (void)touchesBeganWithIndex:(int) index;
- (void)touchesCancelWithIndex:(int) index;
- (void)touchesEndWithIndex:(int) index;
- (void)touchesMoveWithIndex:(int) index;
@end

@interface CustomView : UIView
@property (nonatomic, assign) int index;
@property (nonatomic, assign) id<CustomViewDelegate>delegate;

- (void)setCustomIndex:(int)indexNum;
@end
