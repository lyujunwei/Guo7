//
//  SquareModel.h
//  guoSeven
//
//  Created by David on 13-1-14.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "RSBaseModule.h"
// 用户动态“广场页”
@interface SquareModel : RSBaseModule
//action_type_id ＝ 1 推荐了
//action_type_id ＝ 2 加入愿望清单
//action_type_id ＝ 3 关注了
//action_type_id  = 4  评论了
@property (nonatomic, retain) NSString *action_type_id;//用户动作
@property (nonatomic, retain) NSString *application_action_type_name; 
@property (nonatomic, retain) NSString *application_artwork_url_small; //应用程序图标
@property (nonatomic, retain) NSString *application_average_user_rating; // 应用程序评分 这个还没做 按照获取的参数去调用图片
@property (nonatomic, retain) NSString *application_id;//应用程序_id
@property (nonatomic, retain) NSString *application_old_price; // 应用程序 老价格
@property (nonatomic, retain) NSString *application_remind_count;
@property (nonatomic, retain) NSString *application_retail_price; //应用程序 当前价格
@property (nonatomic, retain) NSString *application_title;//应用程序 标题
@property (nonatomic, retain) NSString *create_time; //程序 创建时间
@property (nonatomic, retain) NSString *img_path; // 用户头像
@property (nonatomic, retain) NSString *nick_name;// 用户昵称
@property (nonatomic, retain) NSString *primary_genre_name;// 应用程序 类型
@property (nonatomic, retain) NSString *supported_device_name;// 应用程序 设备
@property (nonatomic, retain) NSString *uid; //用户 id
@property (nonatomic, retain) NSString *obj_signature; //对方用户 签名
@property (nonatomic, retain) NSString *obj_img_path;// 对方用户  头像
@property (nonatomic, retain) NSString *obj_uid;// 对方用户 uid 
@property (nonatomic, retain) NSString *obj_details;//对方用户 信息
@property (nonatomic, retain) NSString *obj_action_type_name;// 动作 “关注了”
@property (nonatomic, retain) NSString *obj_nick_name;// 对方用户 昵称
@property (nonatomic, retain) NSString *obj_signatur;// 对方用户 签名 
@property (nonatomic, retain) NSString *limited_state_name;
@property (nonatomic, retain) NSString *obj_location;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *event_id;
@property (nonatomic, retain) NSString *response_count_str;
@property (nonatomic, retain) NSString *like_count_str;
@property (nonatomic, retain) NSString *is_like;
@end
