//
//  AppReplyInfo.h
//  guoSeven
//
//  Created by RainSets on 13-1-28.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "RSBaseModule.h"
/*
 {
 "action_type" = 1;
 "application_id" = 517850153;
 content = "\U652f\U6301E-Pub ,\U5f88\U4e0d\U9519\U7684\U4e00\U4e2a\U9605\U8bfb\U8f6f\U4ef6,\U5f88\U597d \U6536\U4e86 !";
 "create_time" = "2013-01-28 17:04";
 "device_type" = 1;
 "event_id" = 51063f0465e112f056000000;
 "img_path" = "http://icon.guo7.com/000480.144x144.jpg?rand=754";
 isMyself = 0;
 "like_count" = 1;
 liked = 0;
 "nick_name" = RainSets;
 "recommend_tags" =         (
 );
 "response_count" = 0;
 uid = 480;
 }
 */

@interface AppReplyInfo : RSBaseModule
@property (nonatomic, strong) NSString *action_type;
@property (nonatomic, strong) NSString *application_id;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *device_type;
@property (nonatomic, strong) NSString *event_id;
@property (nonatomic, strong) NSString *img_path;
@property (nonatomic, strong) NSString *isMyself;
@property (nonatomic, strong) NSString *like_count;
@property (nonatomic, strong) NSString *is_like;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, strong) NSArray *recommend_tags;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *response_count_str;
@property (nonatomic, strong) NSString *response_count;
@property (nonatomic, strong) NSString *liked;
@end
