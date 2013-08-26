//
//  NSError + Addition.h
//  guoSeven
//
//  Created by RainSets on 13-1-24.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError(Addition)
-(id)setCustomErrorWithDomin:(NSString *)domain andCode:(GErrorFailed)code andUserInfo:(NSDictionary *)userInfo;
@end
