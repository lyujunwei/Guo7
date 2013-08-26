//
//  RSBaseModule.h
//  AFNetWorkingProject
//
//  Created by apple on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSBaseModule : NSObject

+ (id)instancefromJsonDic:(NSDictionary*)dic;
+ (NSArray *)instancesFromJsonArray:(NSArray *)array;


@end
