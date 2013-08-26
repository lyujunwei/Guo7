//
//  NSError + Addition.m
//  guoSeven
//
//  Created by RainSets on 13-1-24.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "NSError + Addition.h"

@implementation NSError(Addition)

-(id)setCustomErrorWithDomin:(NSString *)domain andCode:(GErrorFailed)code andUserInfo:(NSDictionary *)userInfo{
    NSError *err = [NSError errorWithDomain:domain code:code userInfo:userInfo];
    return err;
}

@end
