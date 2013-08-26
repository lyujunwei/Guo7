//
//  SBJsonParserT.h
//  TCWeiBoSDKDemo
//
//  Created by David on 13-1-30.
//  Copyright (c) 2013年 bysft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJsonBase.h"

@protocol SBJsonParserT
- (id)objectWithString:(NSString *)repr;

@end


@interface SBJsonParserT : SBJsonBase<SBJsonParserT>{
@private
    const char *c;
}

@end
@interface SBJsonParserT (Private)
- (id)fragmentWithString:(id)repr;
@end