//
//  AboutViewController.h
//  guoSeven
//
//  Created by luyun on 13-1-25.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController<UITextViewDelegate>

//@property (nonatomic, retain) IBOutlet UITextView *myTextView;
@property (nonatomic, retain) IBOutlet UIWebView *aboutWeb;

@end
