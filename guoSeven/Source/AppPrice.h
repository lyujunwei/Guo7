//
//  AppPrice.h
//  guoSeven
//
//  Created by RainSets on 13-1-19.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "RSBaseModule.h"
/*
 {"pricing_time":"2013-01-14","price_name":"\u6da8\u4ef7","retail_price":"12\u5143"}
 */
@interface AppPrice : RSBaseModule
@property (nonatomic, strong) NSString *pricing_time;
@property (nonatomic, strong) NSString *price_name;
@property (nonatomic, strong) NSString *retail_price;

@property (nonatomic, strong) NSString *version;
@end


/*
 {"priceMin":0,"priceMax":18,"free":0,"price_drop":0}
 */
@interface AppPriceStatistic : RSBaseModule
@property (nonatomic, strong) NSString *priceMin;
@property (nonatomic, strong) NSString *priceMax;
@property (nonatomic, strong) NSString *free;
@property (nonatomic, strong) NSString *price_drop;

@end