//
//  AppDelegate.h
//  guoSeven
//
//  Created by zucknet on 12/12/4.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

#import <UIKit/UIKit.h>
#import "DDMenuController.h"

//#define kAppKey             @"289978966"
//#define kAppSecret          @"e46e5aee627d41ee75478642f6f1cd98"
//#define kAppRedirectURI     @"http://w.imagchina.com"

#define kAppKey             @"1185634791"
#define kAppSecret          @"b09eeca7fe472996ebceafec7a2b4d8c"
#define kAppRedirectURI     @"http://www.guo7.com"

#ifndef kAppKey
#error
#endif

#ifndef kAppSecret
#error
#endif

#ifndef kAppRedirectURI
#error
#endif




typedef enum{
    iPhone,
    iPad,
    iPodtouch
}deviceType;

@interface AppDelegate : UIResponder <UIApplicationDelegate, DDMenuControllerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DDMenuController *menuController;
@property (nonatomic, assign) deviceType devicetype;
@property (nonatomic, assign) BOOL isEnterBackground;

- (void)setCustomRootViewController;//动态/广场


- (void)setCustomRootViewControllerWithSearch;

- (UITextField *)showTextFieldWithPlaceholder:(NSString *)placeholder
                                 keyboardType:(UIKeyboardType)keyboardType
                                returnKeyType:(UIReturnKeyType)returnKeyType
                              secureTextEntry:(BOOL)entry
                                     delegate:(id)delegate;
- (void)getNewDataForUserInfoToUserDefault:(void (^)(BOOL show))success failure:(void (^)(NSError *error))failure;
- (UIBarButtonItem *)showBarItemWithTitle:(NSString *)title normalImg:(UIImage *)norimage hightImg:(UIImage *)higimage viewController:(id)vc action:(SEL)action;
@end
