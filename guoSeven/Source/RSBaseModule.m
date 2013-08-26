//
//  RSBaseModule.m
//  AFNetWorkingProject
//
//  Created by apple on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RSBaseModule.h"

@implementation RSBaseModule

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
	NSLog(@"new key found ********* %@",key);
}

+ (id)instancefromJsonDic:(NSDictionary*)dic
{
    id instance = nil;
    @try {
        instance = [[self alloc] init];
        NSArray *keys = [dic allKeys];
        for (NSString *key in keys) {
            id item = [dic objectForKey:key];
            if ([item isMemberOfClass:[NSNull class]]) {
                continue;
            } else if ([item isKindOfClass:[NSDictionary class]]) {
                //add another LC instance
            } else if ([item isKindOfClass:[NSArray class]]) {
                //add a LC instances array
            } else {
                //NSLog(@"class name: %@", [item class]);
                [instance setValue:item forKey:key];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Drat! Something wrong: %@", exception.reason);
    }
	return instance;
}

+ (NSArray *)instancesFromJsonArray:(NSArray *)array
{
    NSMutableArray *instances = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        id o = [self instancefromJsonDic:dic];
        if (o) {
            [instances addObject:o];
        }
    }
    return [NSArray arrayWithArray:instances];
}

@end