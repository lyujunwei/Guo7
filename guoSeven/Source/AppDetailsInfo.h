//
//  AppDetailsInfo.h
//  guoSeven
//
//  Created by RainSets on 13-1-19.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "RSBaseModule.h"

/*
 "appid_encode" = 331258462;
 "application_id" = 388089858;
 "artist_id" = 388089861;
 "artist_name" = "eLong.com Inc.";
 "artwork_url_large" = "http://a1435.phobos.apple.com/us/r1000/090/Purple/v4/5b/ce/97/5bce9728-08bd-3b9d-6db1-008fad9848b0/Icon.png";
 "artwork_url_small" = "http://a369.phobos.apple.com/us/r1000/096/Purple/v4/bb/ea/bd/bbeabd2a-9b56-2cb7-30bf-1b3953d5557f/mzl.okqqnnuw.100x100-75.png";
 "average_user_rating" = "4.5";
 "average_user_rating_for_current_version" = "4.00000";
 "company_url" = "http://";
 copyright = "com.elong.app";
 description = "\U2605\U2605\";
 "device_type" = 2;
 "download_size" = "6.1MB";
 "export_date" = 1358162889;
 features = "<null>";
 "genre_ids" = "6003;6012;";
 "genre_name" = "\U65c5\U884c \U751f\U6d3b";
 "ipad_screenshot_url_1" = "<null>";
 "ipad_screenshot_url_2" = "<null>";
 "ipad_screenshot_url_3" = "<null>";
 "ipad_screenshot_url_4" = "<null>";
 "ipad_screenshot_url_5" = "<null>";
 "is_game_center_enabled" = 0;
 "is_zh" = 1;
 
 "itunes_release_date" = "2010-08-26 05:40:41";
 kind = software;
 "language_code" = "1\U79cd\U8bed\U8a00(\U542b\U4e2d\U6587)";
 limitedState = "-1";
 "old_price" = "<null>";
 powderOff = 0;
 price = "0.00000";
 "price_state" = "<null>";
 "price_state_val" = 0;
 "primary_genre_id" = 6003;
 "primary_genre_name" = "\U65c5\U884c";
 "recommended_age" = "4\U5c81\U4ee5\U4e0a";
 "release_notes" = "\U2605 \U589e\";
 "retail_price" = "0.00000";
 "screenshot_url" =     {
 iPhone =         (
 "http://a1363.phobos.apple.com/us/r1000/116/Purple/v4/15/d1/28/15d128aa-7655-44e4-4f69-762ae7ae265a/mzl.hqyypdiw.png",
 "http://a688.phobos.apple.com/us/r1000/081/Purple/v4/4d/fb/49/4dfb49db-9d99-38a3-6c8a-a9415012d413/mzl.vqbeasuf.png",
 );
 };
 "screenshot_url_1" = "http://a1363.phobos.apple.com/us/r1000/116/Purple/v4/15/d1/28/15d128aa-7655-44e4-4f69-762ae7ae265a/mzl.hqyypdiw.png";
 "screenshot_url_2" = "http://a688.phobos.apple.com/us/r1000/081/Purple/v4/4d/fb/49/4dfb49db-9d99-38a3-6c8a-a9415012d413/mzl.vqbeasuf.png";
 "screenshot_url_3" = "http://a1557.phobos.apple.com/us/r1000/098/Purple/v4/fd/16/02/fd1602b3-d17f-4e57-b8e9-b029fb8cc594/mzl.cpvugiww.png";
 "screenshot_url_4" = "http://a990.phobos.apple.com/us/r1000/082/Purple/v4/ec/68/26/ec6826b6-b044-525a-4d1e-208f5c795331/mzl.uunkgbrr.png";
 "screenshot_url_5" = "http://a1964.phobos.apple.com/us/r1000/074/Purple/v4/31/29/57/312957f8-e8af-7e02-3934-98b2f0567388/mzl.wcqaitmo.png";
 "seller_name" = "Beijing eLong Information Technology Co., Ltd.";
 "support_url" = "http://m.elong.com/?ref=appstore";
 "supported_device_name" = "iPhone\U9002\U7528";
 "supported_devices" = "iPodTouchourthGen;iPad2Wifi;iPodTouchThirdGen;iPadWifi;iPhone-3GS;iPad3G;iPad23G;iPhone4;";
 "supported_devices_ids" = "11,12,10,7,6,8,13,9";
 */


typedef enum {
    fitIphone = 0,
    fitIpad,
    fitMac
}DEVICETYPEFIT;

@interface AppDetailsInfo : RSBaseModule
@property (nonatomic, strong) NSString *appid_encode;
@property (nonatomic, strong) NSString *application_id;
@property (nonatomic, strong) NSString *artist_id;
@property (nonatomic, strong) NSString *artist_name;
@property (nonatomic, strong) NSString *artwork_url_large;
@property (nonatomic, strong) NSString *artwork_url_small;
@property (nonatomic, strong) NSString *average_user_rating;
@property (nonatomic, strong) NSString *average_user_rating_for_current_version;
@property (nonatomic, strong) NSString *company_url;
@property (nonatomic, strong) NSString *copyright;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *device_type;
@property (nonatomic, strong) NSString *download_size;
@property (nonatomic, strong) NSString *export_date;
@property (nonatomic, strong) NSString *features;
@property (nonatomic, strong) NSString *genre_ids;
@property (nonatomic, strong) NSString *genre_name;
@property (nonatomic, strong) NSString *ipad_screenshot_url_1;
@property (nonatomic, strong) NSString *ipad_screenshot_url_2;
@property (nonatomic, strong) NSString *ipad_screenshot_url_3;
@property (nonatomic, strong) NSString *ipad_screenshot_url_4;
@property (nonatomic, strong) NSString *ipad_screenshot_url_5;
@property (nonatomic, strong) NSString *is_game_center_enabled;
@property (nonatomic, strong) NSString *is_zh;
@property (nonatomic, strong) NSString *itunes_release_date;
@property (nonatomic, strong) NSString *kind;
@property (nonatomic, strong) NSString *language_code;
@property (nonatomic, strong) NSString *limitedState;
@property (nonatomic, strong) NSString *old_price;
@property (nonatomic, strong) NSString *powderOff;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *price_state;
@property (nonatomic, strong) NSString *price_state_val;
@property (nonatomic, strong) NSString *primary_genre_id;
@property (nonatomic, strong) NSString *primary_genre_name;
@property (nonatomic, strong) NSString *recommended_age;
@property (nonatomic, strong) NSString *release_notes;
@property (nonatomic, strong) NSString *retail_price;
@property (nonatomic, strong) NSString *screenshot_url;
@property (nonatomic, strong) NSString *screenshot_url_1;
@property (nonatomic, strong) NSString *screenshot_url_2;
@property (nonatomic, strong) NSString *screenshot_url_3;
@property (nonatomic, strong) NSString *screenshot_url_4;
@property (nonatomic, strong) NSString *screenshot_url_5;
@property (nonatomic, strong) NSString *seller_name;
@property (nonatomic, strong) NSString *support_url;
@property (nonatomic, strong) NSString *supported_device_name;
@property (nonatomic, strong) NSString *supported_devices;
@property (nonatomic, strong) NSString *supported_devices_ids;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, strong) NSString *tags_name;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *todayForApp;
@property (nonatomic, strong) NSString *top_rank;
@property (nonatomic, strong) NSString *totalTodayForApp;
@property (nonatomic, strong) NSString *track_content_rating;
@property (nonatomic, strong) NSString *user_rating_count;
@property (nonatomic, strong) NSString *user_rating_count_for_current_version;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *view_url;

@property (nonatomic, strong) NSArray *arrIphoneScreenshots;
@property (nonatomic, strong) NSArray *arrTags;
@property (nonatomic, strong) NSString *isRecommended;
@property (nonatomic, strong) NSString *isRemind;
@property (nonatomic, strong) NSString *limitStateName;
@property (nonatomic, strong) NSString *limitedStateName;
@property (nonatomic, assign) DEVICETYPEFIT devicetypeFit;

@end
