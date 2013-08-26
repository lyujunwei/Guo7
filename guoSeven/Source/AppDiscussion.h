//
//  AppDiscussion.h
//  guoSeven
//
//  Created by RainSets on 13-1-23.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "RSBaseModule.h"

/*
 responseData==++++++++{
 "_id" =     {
 "$id" = 50ffa40c65e1129373000000;
 };
 "action_type" = 4;
 "application_id" = 493136154;
 content = "\U9875\U9762\U6548\U679c\U5f88\U4e0d\U9519,\U4e0b\U62c9\U6dfb\U52a0,\U6ed1\U52a8\U5220\U9664,\U5f88\U559c\U6b22";
 "create_time" = 1358930956;
 "device_type" = 2;
 "event_id" = 50ffa40c65e1129373000000;
 "img_path" = "http://icon.guo7.com/000017.48x48.jpg?rand=902";
 "nick_name" = zucknet;
 signature = "\U03a3(\Uffe3\U3002\Uffe3\Uff89)\Uff89";
 uid = 17;
 "uid_encoded" = 2890530;
 }
 */

@interface AppDiscussion : RSBaseModule

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *action_type;
@property (nonatomic, strong) NSString *application_id;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *device_type;
@property (nonatomic, strong) NSString *event_id;
@property (nonatomic, strong) NSString *img_path;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, strong) NSString *signature;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *uid_encoded;

@end
