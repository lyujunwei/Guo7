//
//  AppsDetailTopCell.h
//  guoSeven
//
//  Created by RainSets on 13-1-17.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AppsDetailTopCellDelegate <NSObject>

-(void)appDetailsInfo:(id)sender;
-(void)appWithWishesList:(id)sender;
-(void)appLinkToAppStore:(id)sender;
-(void)appRecommend:(id)sender;
-(void)appPriceChangeList:(id)sender;

@end

@interface AppsDetailTopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgVAppIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblAppPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblAppType;
@property (weak, nonatomic) IBOutlet UILabel *lblAppName;
@property (weak, nonatomic) IBOutlet UILabel *rmbLB;
@property (weak, nonatomic) IBOutlet UILabel *lblAppDiscussionCount;
@property (weak, nonatomic) IBOutlet UIButton *btnWishList;
@property (weak, nonatomic) IBOutlet UIButton *btnRecommend;
@property (weak, nonatomic) IBOutlet UIImageView *imgAppState;
@property (weak, nonatomic) IBOutlet UILabel *appRecommend;
@property (weak, nonatomic) IBOutlet UILabel *lblAppWishList;
@property (weak, nonatomic) IBOutlet UIButton *btnAppStore;
@property (strong, nonatomic) IBOutlet UILabel *limitStateName;
- (IBAction)currentAppDetails:(id)sender;
- (IBAction)currentAppPriceChangeList:(id)sender;
- (IBAction)wishList:(id)sender;
- (IBAction)appRecomment:(id)sender;
- (IBAction)viewInAPPStore:(id)sender;

@property (nonatomic, assign) id<AppsDetailTopCellDelegate>delegate;

@end
