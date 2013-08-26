//
//  NSString_md5.m
//  guoSeven
//
//  Created by RainSets on 13-2-4.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "NSString_md5.h"
#import <commoncrypto/CommonDigest.h>

@implementation NSString(md5)
-(NSString *)md5 {
    const char *cStr = [self UTF8String];
    
    unsigned char result[16];
    
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    
    return [NSString stringWithFormat:
            
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            
            result[0], result[1], result[2], result[3],
            
            result[4], result[5], result[6], result[7],
            
            result[8], result[9], result[10], result[11],
            
            result[12], result[13], result[14], result[15]
            
            ];
}
@end
