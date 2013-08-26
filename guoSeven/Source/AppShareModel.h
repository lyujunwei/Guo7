//
//  AppShareModel.h
//  guoSeven
//
//  Created by RainSets on 13-1-19.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "RSBaseModule.h"
/*
 [{"weibo_type":"douban","status":"1","is_share":"1"},{"weibo_type":"qq","status":"2","is_share":"0"},{"weibo_type":"sina","status":"2","is_share":"0"}]
 */
@interface AppShareModel : RSBaseModule
@property (nonatomic, strong) NSString *weibo_type;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *is_share;
@end
