//
//  AppsDetailTopCell.m
//  guoSeven
//
//  Created by RainSets on 13-1-17.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "AppsDetailTopCell.h"

@implementation AppsDetailTopCell
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:@"AppsDetailTopCell" owner:self options:nil] objectAtIndex:0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)currentAppDetails:(id)sender {
    if ([self.delegate respondsToSelector:@selector(appDetailsInfo:)]) {
        [self.delegate appDetailsInfo:sender];
    }
}

- (IBAction)currentAppPriceChangeList:(id)sender {
    if ([self.delegate respondsToSelector:@selector(appPriceChangeList:)]) {
        [self.delegate appPriceChangeList:sender];
    }
}

- (IBAction)wishList:(id)sender {
    if ([self.delegate respondsToSelector:@selector(appWithWishesList:)]) {
        [self.delegate appWithWishesList:sender];
    }
}

- (IBAction)appRecomment:(id)sender {
    if ([self.delegate respondsToSelector:@selector(appRecommend:)]) {
        [self.delegate appRecommend:sender];
    }
}

- (IBAction)viewInAPPStore:(id)sender {
    if ([self.delegate respondsToSelector:@selector(appLinkToAppStore:)]) {
        [self.delegate appLinkToAppStore:sender];
    }
}
@end
