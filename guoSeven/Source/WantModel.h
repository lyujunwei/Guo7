//
//  WantModel.h
//  guoSeven
//
//  Created by David on 13-1-14.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "RSBaseModule.h"
//愿望清单
@interface WantModel : RSBaseModule
@property (nonatomic, retain) NSString *application_artwork_url_small;
@property (nonatomic, retain) NSString *application_average_user_rating;
@property (nonatomic, retain) NSString *application_id;
@property (nonatomic, retain) NSString *application_old_price;
@property (nonatomic, retain) NSString *application_retail_price;
@property (nonatomic, retain) NSString *application_title;
@property (nonatomic, retain) NSString *create_time;
@property (nonatomic, retain) NSString *export_date;
@property (nonatomic, retain) NSString *primary_genre_name;
@property (nonatomic, retain) NSString *supported_device_name;
@property (nonatomic, retain) NSString *limitedStateName;
@property (nonatomic, retain) NSString *event_id;
@property (nonatomic, retain) NSString *response_count_str;
@property (nonatomic, retain) NSString *like_count_str;
@property (nonatomic, retain) NSString *is_like;
@property (nonatomic, retain) NSString *action_type_id;
@property (nonatomic, retain) NSString *nick_name;
@property (nonatomic, retain) NSString *img_path;
@property (nonatomic, retain) NSString *application_remind_count;
@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSString *application_action_type_name;

@end