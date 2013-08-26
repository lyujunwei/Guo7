//
//  AppsDetailsViewController.h
//  guoSeven
//
//  Created by zucknet on 13/1/6.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "AppsDetailTopCell.h"
#import "SquareModel.h"

typedef enum isFullScreen {
    ISFULLSCREEN,
    ISNOTFULLSCREEN
}isfullScr;


typedef enum {
    HIDEPRICELIST,
    SHOWPRICELIST
}SHOWAPPPRICELIST;

@interface AppsDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewAccessibilityDelegate,UIScrollViewDelegate,SKStoreProductViewControllerDelegate,UITextFieldDelegate,AppsDetailTopCellDelegate,UITextViewDelegate>{
    
}

- (IBAction)writeDisscussion:(id)sender;
-(void)backToPreVC:(id)sender;
- (void)sharedCurrentApp:(id)sender;
@property (nonatomic, strong) UITextField *tf;

@property (nonatomic,assign) isfullScr isfullsrc;
@property (nonatomic, strong) SquareModel *sqModel;
@property (nonatomic, strong) NSString *application_id;
@property (nonatomic, assign) SHOWAPPPRICELIST showAppPriceList;


@end
