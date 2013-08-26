//
//  UIImage+Extras.h
//  guoSeven
//
//  Created by RainSets on 13-1-28.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage(Extras)

/**
 * 缩放图像到指定尺寸
 */
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;

/*
 
 下面这个方法 可以改变图片大小 自适应,自己传参数吧
 
 */
- (UIImage *)rescaleImageToSize:(CGSize)size;


/*
 使用 UIKit
 此方法很简单， 但是，这种方法不是线程安全的情况
 */
-(UIImage*)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

/*
 使用 CoreGraphics
 这种方法的好处是它是线程安全，加上它负责的 （使用正确的颜色空间和位图信息，处理图像方向） 的小东西，UIKit 版本不会
 */

-(UIImage *)imageWithImage:(UIImage*)sourceImage scalesToSize:(CGSize)targetSize;

/*
 如何调整和保持长宽比 （如 AspectFill 选项）？
 它是非常类似于上述，方法，它看起来像这样：
 */

-(UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSizeWithSameAspectRatio:(CGSize)targetSize;

- (UIImage *)fixOrientation;

@end
