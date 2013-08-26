//
//  UserModel.h
//  guoSeven
//
//  Created by David on 13-1-14.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "RSBaseModule.h"
//关注与粉丝
@interface UserModel : RSBaseModule
@property (nonatomic, retain) NSString *details;
@property (nonatomic, retain) NSString *img_path;
@property (nonatomic, retain) NSString *nick_name;
@property (nonatomic, retain) NSString *signature;
@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSString *isFollowing;
@end
