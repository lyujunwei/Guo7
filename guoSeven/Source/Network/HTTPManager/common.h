//
//  common.h
//  AFNetWoringTest
//
//  Created by David on 13-1-11.
//  Copyright (c) 2013年 David. All rights reserved.
//

#ifndef AFNetWoringTest_common_h
#define AFNetWoringTest_common_h


#define GErrorDomain @"com.guoseven.test"
typedef enum {
    GDefaultFailed = -1000,
    GRegisterFailed,
    GConnectFailed
}GErrorFailed;





//
#define kDouBanKey  @"0b6e96297217b4e5224bc27c56471eaf"
#define kDouBanPrivateKey @"3c9cafb3e6d7d2a3"
#define kDouBanRedirectUrl @"http://www.guo7.com"
//
//#define kDouBanKey  @"04e0b2ab7ca02a8a0ea2180275e07f9e"
//#define kDouBanPrivateKey @"4275ee2fa3689a2f"
//#define kDouBanRedirectUrl @"http://www.douban.com/location/mobile"




#define KEY @"17fe45bec598b510a45e0864286ef70feac7d5bb"

#define kPushNotification @"push-----notification"

#define NETREACHIBILITYISUNABLE @"网络不可用..."

#define kUID @"guo7UserID"
#define kUIcon @"guo7UIcon"
#define kUNickNamm @"guo7UNickName"
#define kUSignature @"guo7USignature"
#define kUEmail @"guo7UEmail"
#define kUPassd @"guo7Password"
#define kTokenID @"guo7TokenID"

#define kUserDefault(xx) [[NSUserDefaults standardUserDefaults] objectForKey:xx]
#define kUserDefaultSet(xx,yy) [[NSUserDefaults standardUserDefaults] setObject:xx forKey:yy];

#define KNotification @"PanEnable"


#define kHomeName @"http://www.guo7.com"
#define kAFAppDotNetAPIBaseURLString @"http://www.guo7.com/api/"
#define IS_IPHONE5 CGSizeEqualToSize([[UIScreen mainScreen] preferredMode].size,CGSizeMake(640, 1136))

#define SHOWALERT_WITHTITLE_ANDMESSAGE(TITLE,MSG) UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:(TITLE) \
message:(MSG) \
delegate:nil \
cancelButtonTitle:@"确定" \
otherButtonTitles:nil];\
[alertV show];\

#define SHOWALERT_WITHTITLE_MESSAGE_ANDCANCELBTN(TITLE,MSG,CANCEL,OTHERCANCEL) UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:(TITLE) \
message:(MSG) \
delegate:nil \
cancelButtonTitle:CANCEL \
otherButtonTitles:OTHERCANCEL];\
[alertV show];\


#define ISDEBUG 1

#define AppDetailPriceTextFont [UIFont fontWithName:@"Helvetica Neue" size:13]

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif
#endif
