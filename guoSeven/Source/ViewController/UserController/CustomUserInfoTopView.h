//
//  CustomUserInfoTopView.h
//  guoSeven
//
//  Created by David on 13-1-17.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomUserInfoTopView : UIView
@property (nonatomic, retain) IBOutlet UILabel *dynamicLabel;//动态
@property (strong, nonatomic) IBOutlet UIButton *dynamicBtn;
@property (nonatomic, retain) IBOutlet UILabel *dynamicCountLabel;//动态数量
@property (nonatomic, retain) IBOutlet UILabel *desireLabel;//愿望
@property (nonatomic, retain) IBOutlet UILabel *desireCountLabel;//愿望数量
@property (strong, nonatomic) IBOutlet UIButton *desireBt;
@property (nonatomic, retain) IBOutlet UILabel *recommendLabel;//推荐
@property (nonatomic, retain) IBOutlet UILabel *recommendCountLabel;//推荐数量
@property (strong, nonatomic) IBOutlet UIButton *recommendBt;
@property (nonatomic, retain) IBOutlet UILabel *attentionLabel;//关注
@property (nonatomic, retain) IBOutlet UILabel *attentionCountLabel;//关注数量
@property (strong, nonatomic) IBOutlet UIButton *attentionBtn;
@property (nonatomic, retain) IBOutlet UILabel *commentLabel;//评论
@property (nonatomic, retain) IBOutlet UILabel *commentCountLabel;//评论数量
@property (strong, nonatomic) IBOutlet UIButton *commentBtn;

@end
