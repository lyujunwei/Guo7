//
//  MessageModel.h
//  guoSeven
//
//  Created by David on 13-1-14.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "RSBaseModule.h"

@interface MessageModel : RSBaseModule
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *img_path;
@property (nonatomic, retain) NSString *message_id;
@property (nonatomic, retain) NSString *nick_name;
@property (nonatomic, retain) NSString *obj_img_path;
@property (nonatomic, retain) NSString *obj_nick_name;
@property (nonatomic, retain) NSString *send_date;
@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSString *obj_uid;
@end
