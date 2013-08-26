//
//  CustomView.m
//  guoSeven
//
//  Created by David on 13-1-17.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView
@synthesize delegate;
@synthesize index;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setCustomIndex:(int)indexNum{
    self.index = indexNum;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [delegate touchesBeganWithIndex:self.index];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
      [delegate touchesCancelWithIndex:self.index];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
      [delegate touchesEndWithIndex:self.index];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
      [delegate touchesMoveWithIndex:self.index];
}

@end
