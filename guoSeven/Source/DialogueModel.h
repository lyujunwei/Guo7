//
//  DialogueModel.h
//  guoSeven
//
//  Created by David on 13-1-21.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "RSBaseModule.h"

@interface DialogueModel : RSBaseModule
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *origin_img_path;
@property (nonatomic, retain) NSString *origin_nick_name;
@property (nonatomic, retain) NSString *origin_uid;
@property (nonatomic, retain) NSString *send_date;
@property (nonatomic, retain) NSString *target_img_path;
@property (nonatomic, retain) NSString *target_nick_name;
@property (nonatomic, retain) NSString *target_uid;
@end
