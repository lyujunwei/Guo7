//
//  AppInfoRWDModel.h
//  guoSeven
//
//  Created by David on 13-1-16.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "RSBaseModule.h"
#import "UserInfo.h"


@interface AppInfoRWDModel : RSBaseModule
@property (nonatomic, retain) NSDictionary *_id;
@property (nonatomic, retain) NSString *action_type;
@property (nonatomic, retain) NSString *application_id;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *create_time;
@property (nonatomic, retain) NSString *device_type;
@property (nonatomic, retain) NSString *img_path;
@property (nonatomic, retain) NSString *isMyself;
@property (nonatomic, retain) NSString *like_count;
@property (nonatomic, retain) NSString *like_count_str;
@property (nonatomic, retain) NSString *liked;
@property (nonatomic, retain) NSArray *recommend_tags;
@property (nonatomic, retain) NSString *response_count;
@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSString *response_count_str;
@property (nonatomic, retain) UserInfo *user;
@property (nonatomic, retain) NSString *event_id;
@property (nonatomic, retain) NSString *user_id;
@property (nonatomic, retain) NSString *event_uid;
@property (nonatomic, retain) NSString *event_type;
@property (nonatomic, retain) NSString *nick_name;

@end
