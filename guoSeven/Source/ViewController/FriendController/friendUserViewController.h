//
//  friendUserViewController.h
//  GPlay
//
//  Created by zucknet on 12/11/5.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FootbtnViewController.h"

@interface friendUserViewController : FootbtnViewController<UIScrollViewDelegate>{
    UIImage *_image;
}

@property(nonatomic,retain)UIScrollView *scrollView;

@property(nonatomic,retain)UIView *viewTop;
@property(nonatomic,retain)UIScrollView *viewTop1;
@property(nonatomic,retain)UIImageView *imageleft_on;
@property(nonatomic,retain)UIImageView *imageleft_off;
@property(nonatomic,retain)UIImageView *imageright_on;
@property(nonatomic,retain)UIImageView *imageright_off;
@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,retain)UIView *viewTop2;
@property(nonatomic,retain)UIView *leftRight;
@property(nonatomic,retain)UIButton *scrollbtn1;
@property(nonatomic,retain)UIButton *scrollbtn2;
@property(nonatomic,retain)UIButton *scrollbtn3;
@property(nonatomic,retain)UIButton *scrollbtn4;
@property(nonatomic,retain)UIButton *scrollbtn5;
@property(nonatomic,retain)UIButton *scrollbtn6;

@property(nonatomic,retain)UIImageView *icon4;
@property(nonatomic,retain)UIView *backView2;
@property(nonatomic,retain)UIView *backView3;

@property(nonatomic,strong)UILabel *btnLab1;
@property(nonatomic,strong)UILabel *numLab1;

@property(nonatomic,strong)UILabel *btnLab2;
@property(nonatomic,strong)UILabel *numLab2;

@property(nonatomic,strong)UILabel *btnLab3;
@property(nonatomic,strong)UILabel *numLab3;

@property(nonatomic,strong)UILabel *btnLab4;
@property(nonatomic,strong)UILabel *numLab4;

@property(nonatomic,strong)UILabel *btnLab5;
@property(nonatomic,strong)UILabel *numLab5;

@property(nonatomic,strong)UILabel *btnLab6;
@property(nonatomic,strong)UILabel *numLab6;

@property(nonatomic,retain)UILabel *userName;
@property(nonatomic,retain)UILabel *userFrom;
@property(nonatomic,retain)UILabel *userSgnature;
@property(nonatomic,retain)UIImageView *userImage;
@property(nonatomic,retain)UILabel *userTitle;
@property(nonatomic,retain)NSString *nameString;
@property(nonatomic,retain)NSString *fromString;

-(void)alertView;

- (void)pushViewController;

-(IBAction)scrollView1:(id)sender;
-(IBAction)scrollView2:(id)sender;
-(IBAction)scrollView3:(id)sender;
-(IBAction)scrollView4:(id)sender;
-(IBAction)scrollView5:(id)sender;
-(IBAction)scrollView6:(id)sender;

@end
