//
//  WBFriendModel.h
//  guoSeven
//
//  Created by David on 13-1-31.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "RSBaseModule.h"
#import "CountModle.h"
//#import "FriendsModel.h"

@interface WBFriendModel : RSBaseModule

@property (nonatomic, strong) CountModle *countModel;
//@property (nonatomic, strong) FriendsModel *friendModel;
@property (nonatomic, strong) NSArray *arrFriendsAll;

@end
