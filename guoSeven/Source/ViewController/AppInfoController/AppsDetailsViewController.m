//
//  AppsDetailsViewController.m
//  guoSeven
//
//  Created by zucknet on 13/1/6. Modified by RainSets on 2013-01-15 12:40
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "AppsDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "RSHttpManager.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDetailsInfo.h"
#import "UIImageView+AFNetworking.h"
#import "AppPrice.h"
#import "AppDetailsInfoCell.h"
#import "AppInfoRWDModel.h"
#import "AppShareModel.h"
#import "AppShareViewController.h"
#import "DAKeyboardControl.h"
#import "UIImage+CSExtensions.h"
#import "UIImage+Extras.h"
#import "AppReplyInfo.h"
#import "RespondViewController.h"
#import "SVProgressHUD.h"
#define KEYBOARD_STATUS_ALL_HIDDEN 1
#define KEYBOARD_STATUS_EXP_HIDDEN 2

@interface AppsDetailsViewController ()<RespondViewControllerDelegate>{
    NSMutableArray         *_imageViews;
    UIScrollView    *_imageScroller;
    UIScrollView    *_transparentScroller;
    UITableView     *_tableView;
    BOOL hasScrollToMaxOffset;
    
    UIView *viewTop;
    CGRect rectInitialTableView;
    CGRect rectInitialImageScrollView;
    UISwipeGestureRecognizer *recognizer;
    UITapGestureRecognizer *tapScrollGes;
    UITapGestureRecognizer *tapGes;
    UIView *viewRight;
    UIScrollView *scrollV;
    UILabel *lblDescription;

    UILabel *lblDescriptionType;
    UILabel *lblDescriptionLanguage;
    UILabel *lblDescriptionLanguageDesc;

    UILabel *lblDescriptionVersion;
    UILabel *lblDescriptionSize;
    UILabel *lblDescriptionAge;
    UILabel *lblDescriptionDeveloper;
    UILabel *lblDescriptionDeveloperDesc;

    UIView *viewPriceTop;
    UILabel *lblAppPriceDes1;
    UILabel *lblAppPriceDes2;
    UILabel *lblAppPriceDes3;
    UILabel *lblAppPriceDes4;

    UITapGestureRecognizer *viewRightTapGes;
    
    UITableView *_tableVPrice;
    AppDetailsInfo *appDetailsInfo;
    
    NSMutableArray *arrPriceChangeList;
    
    NSMutableArray *arrAppDetailsCW;
    
    NSArray *arrShareList;
    
    UIScrollView *scrollVRecommend;
    
    UITextView *txtVRecommendInput;
    UILabel *lblPlaceHolder;
    
    UIButton *btnSubmitRec;
    
    NSMutableDictionary *dictParam;
    
    UIImageView *toolBar;
    
//    CGRect toolBarFrame;
    
    AppsDetailTopCell *topCell;
    
    NSString *userId;
    
    UIPageControl *pageCtr;
    
    UIActivityIndicatorView *activityV;
    UIImageView *imgVLine;
    CGFloat cellHeight0;
    BOOL tapScreenFull;
    
    CGSize keyboardSize;
    NSInteger keyboardStatus;
    UIView *touchView;
}
@property (nonatomic, strong) UIImage *firstImage;
@end

@implementation AppsDetailsViewController
@synthesize isfullsrc;
@synthesize showAppPriceList;
@synthesize application_id;
@synthesize sqModel;
static CGFloat WindowHeight = 200.0;
static CGFloat ImageHeight  = 300.0;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {        
        
    }
    return self;
}

-(void)initialTopViewWith:(NSArray *)images{
    _imageScroller  = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [_imageScroller setDelegate:self];
    _imageScroller.backgroundColor                  = [UIColor blackColor];
    _imageScroller.pagingEnabled                    = YES;
    _imageScroller.showsHorizontalScrollIndicator   = NO;
    _imageScroller.showsVerticalScrollIndicator     = NO;
    
    
        
    _transparentScroller = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _transparentScroller.backgroundColor                = [UIColor clearColor];
    _transparentScroller.delegate                       = self;
    _transparentScroller.bounces                        = NO;
    _transparentScroller.pagingEnabled                  = YES;
    _transparentScroller.showsVerticalScrollIndicator   = NO;
    _transparentScroller.showsHorizontalScrollIndicator = NO;
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor              = [UIColor clearColor];
    _tableView.dataSource                   = self;
    _tableView.delegate                     = self;
    _tableView.separatorStyle               = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_imageScroller];
    [self.view addSubview:_tableView];
}

-(void)initialTopScrollViewWith:(NSArray *)images{
    _imageViews = [NSMutableArray array];

    for (int i = 0; i < [images count]; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 130, newW, newH)];
        
        UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(320 *i , 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        [view addSubview:imageView];
        UIActivityIndicatorView *activ = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [activ setCenter:view.center];
        [view addSubview:activ];
        
        [activ startAnimating];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[[appDetailsInfo arrIphoneScreenshots] objectAtIndex:i]]];
        [imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            [activ stopAnimating];
            imageView.image = image;
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            
        }];
        [_imageViews addObject:imageView];
        [_imageScroller addSubview:view];
    }
    [self layoutImages];
    [[self view] bringSubviewToFront:toolBar];
    
    for (int i = 0; i <[_imageViews count]; i++) {
        UIImageView *img = [_imageViews objectAtIndex:i];
        [img setContentMode:UIViewContentModeCenter];
        [img setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    }
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    DLog(@"toolbar frame x=%f y=%f width=%f height=%f",toolBar.frame.origin.x,toolBar.frame.origin.y,toolBar.frame.size.width,toolBar.frame.size.height);
    if (toolBar) {
        [toolBar setFrame:CGRectMake(0.0f,
                                      self.view.bounds.size.height - 45.0f,
                                      self.view.bounds.size.width,
                                      45.0f)];
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    [self setWantsFullScreenLayout:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    CGRect bounds = self.view.bounds;
    DLog(@"bounds.height = %f",bounds.size.height);
    _imageScroller.frame        = CGRectMake(0.0, -60.0, bounds.size.width, bounds.size.height + 64.f);
    rectInitialImageScrollView = _imageScroller.frame;
    cellHeight0 = IS_IPHONE5 ? WindowHeight + 40.f + 88.f : WindowHeight + 40.f;
    _transparentScroller.frame  = CGRectMake(0.0, 0.0, bounds.size.width, cellHeight0);
    if (!tapGes) {
        tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesHandeler:)];
        [_transparentScroller addGestureRecognizer:tapGes];
    }
    tapScreenFull = NO;
    
    _tableView.backgroundView   = nil;
    _tableView.frame            = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height + 22.f);
    rectInitialTableView = _tableView.frame;
    [self layoutImages];
    [self updateOffsets];
}

-(void)tapGesHandeler:(UITapGestureRecognizer *)tapG{
    if (tapScreenFull == NO) {
        tapScreenFull = YES;
        [self dragDownWithAnimation:_imageViews];
    }else if (tapScreenFull){
        tapScreenFull = NO;
        [self swipHandelGesture:nil];
    }
}

#pragma mark - Parallax effect

- (void)updateOffsets {
    CGFloat yOffset   = _tableView.contentOffset.y;
    
    CGFloat xOffset   = _transparentScroller.contentOffset.x;

    CGFloat threshold = ImageHeight - WindowHeight;
    if (hasScrollToMaxOffset && isfullsrc == ISFULLSCREEN) {
        DLog(@"=============================");

        [self dragDownWithAnimation:_imageViews];
    }
    if (hasScrollToMaxOffset == NO) {
        if (yOffset > -threshold && yOffset < 0) {
            _imageScroller.contentOffset = CGPointMake(xOffset, floorf(yOffset / 2.0));
        }else if (tapScreenFull){
            return;
        }
        else {
            [_imageScroller setFrame:CGRectMake(_imageScroller.frame.origin.x, -yOffset - 60.f, _imageScroller.frame.size.width, _imageScroller.frame.size.height)];
        }
    }
}

#pragma mark - View Layout

- (void)layoutImages {
    CGFloat imageWidth   = _imageScroller.frame.size.width;
    
    _imageScroller.contentSize = CGSizeMake([_imageViews count]*imageWidth, _imageScroller.frame.size.height);
    _imageScroller.contentOffset = CGPointMake(0.0, 0.0);
    [_imageScroller setFrame:rectInitialImageScrollView];
    _transparentScroller.contentSize = CGSizeMake([_imageViews count]*imageWidth, cellHeight0);
    _transparentScroller.contentOffset = CGPointMake(0.0, 0.0);
}

-(void)dragDownWithAnimation:(NSArray *)arrImages{
    DLog(@"pageCtr.currentPage==%d",pageCtr.currentPage);
    tapScreenFull = YES;
    keyboardStatus = KEYBOARD_STATUS_EXP_HIDDEN;

    if (!recognizer) {
        recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(swipHandelGesture:)];
        
        [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
        [_imageScroller addGestureRecognizer:recognizer];
    }
    if (!tapScrollGes) {
        tapScrollGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesHandeler:)];
        [_imageScroller addGestureRecognizer:tapScrollGes];
        
    }

    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
    [self setNewFrameForImageViews];
    
    [UIView animateWithDuration:.3 animations:^{
        [pageCtr setFrame:CGRectMake(pageCtr.frame.origin.x, 0.f, pageCtr.frame.size.width, pageCtr.frame.size.height)];
        [viewTop setFrame:CGRectMake(0.f, -38.f, viewTop.frame.size.width, viewTop.frame.size.height)];
        [_imageScroller setFrame:CGRectMake(_imageScroller.frame.origin.x, 0.f, _imageScroller.frame.size.width, _imageScroller.frame.size.height)];
        [_tableView setFrame:CGRectMake(_tableView.frame.origin.x, self.view.frame.size.height, _tableView.frame.size.width, _tableView.frame.size.height)];
        
        [toolBar setFrame:CGRectMake(0.f, self.view.bounds.size.height, toolBar.frame.size.width, toolBar.frame.size.height)];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)swipHandelGesture:(UISwipeGestureRecognizer *)ges{
    tapScreenFull = NO;

    [_imageScroller removeGestureRecognizer:recognizer];
    recognizer = nil;
    hasScrollToMaxOffset = NO;
    isfullsrc = ISNOTFULLSCREEN;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    
    [self backToOldFrameForImageViews];
    
    [UIView animateWithDuration:.3 animations:^{
        [pageCtr setFrame:CGRectMake(pageCtr.frame.origin.x, 20.f, pageCtr.frame.size.width, pageCtr.frame.size.height)];
        [viewTop setFrame:CGRectMake(0.f, 20.f, viewTop.frame.size.width, viewTop.frame.size.height)];
        [_imageScroller setFrame:rectInitialImageScrollView];
        [_tableView setFrame:rectInitialTableView];
        [_tableView setContentOffset:CGPointZero];
        [toolBar setFrame:CGRectMake(0.f, self.view.bounds.size.height - 45.f, self.view.bounds.size.width, 45.f)];
        
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)createSubmitBottomView{
    if (!toolBar) {
        toolBar = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,
                                                                self.view.bounds.size.height - 45.0f,
                                                                self.view.bounds.size.width,
                                                                45.0f)];
        
        toolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        toolBar.image = [UIImage imageNamed:@"chatTalk.png"];
        [self.view addSubview:toolBar];
    }
    toolBar.userInteractionEnabled = NO;
    
    if(!self.tf){
        self.tf= [[UITextField alloc] initWithFrame:CGRectMake(15.0f,
                                                               12.0f,
                                                               toolBar.bounds.size.width - 20.0f - 75.0f,
                                                               30.0f)];
        //    self.tf.borderStyle = UITextBorderStyleRoundedRect;
        [self.tf setDelegate:self];
        
        [self.tf setPlaceholder:@"随便说点儿什么吧..."];
        [self.tf setFont:[UIFont systemFontOfSize:14.f]];
        //        [self.tf setTextColor:[UIColor grayColor]];
        self.tf.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.tf.backgroundColor = [UIColor clearColor];
        [toolBar addSubview:self.tf];
        
        UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sendButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        //    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [sendButton setImage:[UIImage imageNamed:@"submitBtn"] forState:UIControlStateNormal];
        sendButton.frame = CGRectMake(toolBar.bounds.size.width - 68.0f,
                                      8.0f,
                                      62.0f,
                                      28.0f);
        [sendButton addTarget:self action:@selector(subMitClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [toolBar addSubview:sendButton];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.tf resignFirstResponder];
}



- (void) keyboardWillShow:(NSNotification *)notification {
    
    keyboardStatus = KEYBOARD_STATUS_EXP_HIDDEN;
    
    NSDictionary *info = [notification userInfo];
    keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGSize size = self.view.bounds.size;
    
    if (!touchView && [self.tf isFirstResponder]) {
        touchView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, size.width, size.height - keyboardSize.height - toolBar.frame.size.height)];
        [touchView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:touchView];
        [UIView animateWithDuration:.4f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            toolBar.frame = CGRectMake(0, size.height - keyboardSize.height - toolBar.frame.size.height, toolBar.frame.size.width,toolBar.frame.size.height);
            [self.view bringSubviewToFront:toolBar];
            DLog(@"toolbar.frame  x:%f   Y:%f  width:%f   height:%f",toolBar.frame.origin.x,toolBar.frame.origin.y,toolBar.frame.size.width,toolBar.frame.size.height);
            
            [_imageScroller setFrame:CGRectMake(0.f, -keyboardSize.height, _imageScroller.frame.size.width, _imageScroller.frame.size.height)];
            
            [_tableView setFrame:CGRectMake(0, -keyboardSize.height, _tableView.frame.size.width, size.height - toolBar.frame.size.height)];
            NSIndexPath* ipath = [NSIndexPath indexPathForRow: [arrAppDetailsCW count] > 0 ? [arrAppDetailsCW count]-1 :0 inSection: 2];
            DLog(@"[arrAppDetailsCW count]==%d",[arrAppDetailsCW count]);
            if ([arrAppDetailsCW count]) {
                [_tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionBottom animated: NO];
            }
            
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
    
}

- (void) keyboardWillHide:(NSNotification *)notification {
    if (touchView) {
        [touchView removeFromSuperview];
        touchView = nil;
    }
    keyboardStatus = KEYBOARD_STATUS_ALL_HIDDEN;
    [UIView animateWithDuration:0.25 animations:^{
        
        [toolBar setFrame:CGRectMake(0.0f,
                                     self.view.bounds.size.height - 45.0f,
                                     self.view.bounds.size.width,
                                     45.0f)];
        [_imageScroller setFrame:rectInitialImageScrollView];

        DLog(@"imageScroll frame x:%f  y:%f  width:%f  height:%f",_imageScroller.frame.origin.x
             ,_imageScroller.frame.origin.y,_imageScroller.frame.size.width,_imageScroller.frame.size.height);
        [_tableView setFrame:rectInitialTableView];
        [_tableView setContentOffset:CGPointZero];
        
        
    } completion:^(BOOL finished) {
        
    }];
}

//发表回复
-(void)subMitClick:(id)sender{
    
    if ([self.tf.text length] > 0) {
        NSDictionary *dictP = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"uid",appDetailsInfo.application_id,@"application_id",self.tf.text,@"content", nil];
        
        NSLog(@"DDDDDDDD: %@",dictP);
        
        [RSHTTPMANAGER addDiscussionToAppWithParameters:dictP WithSuccess:^(AppDiscussion *discussion) {
            
            [self requestAppWithListAndRecommendListWith:@"4"];
            
            [self.tf resignFirstResponder];
            [self.tf setText:@""];
        } failure:^(NSError *_err) {
            
        }];
    }else{
        SHOWALERT_WITHTITLE_ANDMESSAGE(@"", @"输入想要说的话 才能进行评论哦 !");
    }
    
    DLog(@"submit...");
}
static float newW,newH;
- (void)backToOldFrameForImageViews {
    if (self.firstImage.size.width > 320) {
        for (int i = 0; i <[_imageViews count]; i++) {
            UIImageView *img = [_imageViews objectAtIndex:i];
            [img setContentMode:UIViewContentModeCenter];
            [UIView animateWithDuration:.3 animations:^{
                [img setFrame:CGRectMake(0, 130, newW, newH)];
                [img setTransform:CGAffineTransformMakeRotation(0)];
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}
- (void)setNewFrameForImageViews {
    if (self.firstImage.size.width > 320) {
        for (int i = 0; i <[_imageViews count]; i++) {
            UIImageView *img = [_imageViews objectAtIndex:i];
            [img setContentMode:UIViewContentModeCenter];
            [UIView animateWithDuration:.3 animations:^{
                [img setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
                [img setTransform:CGAffineTransformMakeRotation(-M_PI_2)];
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

- (void)showVerticalWithImages:(NSArray *)images image:(UIImage *)image {
    float oldW = image.size.width;
    float oldH = image.size.height;
    
    float bl = 320/oldW;
    newW = oldW *bl;
    newH = oldH *bl;
    _imageViews = [NSMutableArray array];
    
    for (int i = 0; i < [images count]; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 130, newW, newH)];

        UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(320 *i , 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        [view addSubview:imageView];
        UIActivityIndicatorView *activ = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [activ setCenter:view.center];
        [view addSubview:activ];
        
        [activ startAnimating];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[[appDetailsInfo arrIphoneScreenshots] objectAtIndex:i]]];
        [imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            [activ stopAnimating];
            imageView.image = image;
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            
        }];
        [_imageViews addObject:imageView];
        [_imageScroller addSubview:view];
    }
    
    [self layoutImages];
    [[self view] bringSubviewToFront:toolBar];
    
    if (self.firstImage.size.width > 320) {
        for (int i = 0; i <[_imageViews count]; i++) {
            UIImageView *img = [_imageViews objectAtIndex:i];
            [img setContentMode:UIViewContentModeCenter];
            [img setFrame:CGRectMake(0, 130, newW, newH)];
            [img setTransform:CGAffineTransformMakeRotation(0)];
        }
    }
}
-(void)requestAppResponseData{    
    [RSHTTPMANAGER showActivityView:YES];
    [RSHTTPMANAGER requestAppDetailsWitiAppId:self.application_id andUid:userId WithSuccess:^(AppDetailsInfo *appDetails) {
//        DLog(@"appdetailsInfo==%@",[appDetails.arrIphoneScreenshots description]);
        appDetailsInfo = appDetails;

        UIImageView *imageView = [[UIImageView alloc] init];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[[appDetailsInfo arrIphoneScreenshots] objectAtIndex:0]]];
        [imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            self.firstImage = [[UIImage alloc] init];
            self.firstImage = image;
            DLog(@"image width =%f image height=%f",image.size.width,image.size.height);
            if (image.size.width > 320) {
                [self showVerticalWithImages:[appDetailsInfo arrIphoneScreenshots] image:image];
            }else {
                [self initialTopScrollViewWith:[appDetailsInfo arrIphoneScreenshots]];
            }

        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {

        }];
        
        [pageCtr setNumberOfPages:[[appDetailsInfo arrIphoneScreenshots] count]];
        [self requestAppWithListAndRecommendListWith:@"4"];

    }failure:^(NSError *errorMSG) {
    }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SVProgressHUD *tmp = [SVProgressHUD sharedView];
    [tmp setCenter:CGPointMake(tmp.center.x, tmp.center.y - 20)];
    
    DLog(@"frame= width:%f  height:%f",self.view.frame.size.width,self.view.frame.size.height);
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"详情";
    dictParam = [[NSMutableDictionary alloc] init];
//    DLog(@"sqModel==%@",self.sqModel.application_id);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    userId = [defaults objectForKey:kUID];
    DLog(@"userId==%@",userId);
    self.showAppPriceList = HIDEPRICELIST;
    
    [self createSubmitBottomView];

    
    [self requestAppResponseData];
    
    [self initialTopViewWith:nil];
    
    viewTop = [[UIView alloc] initWithFrame:CGRectMake(0.f, 20.f, 320.f, 38.f)];
    [viewTop setBackgroundColor:[UIColor clearColor]];
    
    
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setFrame:CGRectMake(6.f, 4.f, 30.f, 30.f)];
    [btnBack setImage:[UIImage imageNamed:@"detail-back.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(backToPreVC:) forControlEvents:UIControlEventTouchUpInside];
    [viewTop addSubview:btnBack];
    
    UIButton *btnShare = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnShare setFrame:CGRectMake(282.f, 4.f, 30.f, 30.f)];
    [btnShare setImage:[UIImage imageNamed:@"detail-share.png"] forState:UIControlStateNormal];
    [btnShare addTarget:self action:@selector(sharedCurrentApp:) forControlEvents:UIControlEventTouchUpInside];

    [viewTop addSubview:btnShare];
    
    [self.view addSubview:viewTop];
    
    pageCtr = [[UIPageControl alloc] initWithFrame:CGRectMake(40.f, 20.f, 240.f, 36.f)];
    [pageCtr addTarget:self action:@selector(pageCtrValueChange:) forControlEvents:UIControlEventValueChanged];
    [pageCtr setBackgroundColor:[UIColor clearColor]];
    
    [pageCtr setCurrentPage:0];
    [self.view addSubview:pageCtr];
}

-(void)pageCtrValueChange:(id)sender{
    int page = pageCtr.currentPage;
    
    [_imageScroller setContentOffset:CGPointMake(self.view.bounds.size.width * page, _imageScroller.frame.origin.y) animated:YES];
}

-(void)layRightViewContetnWithAppDescriopion:(NSDictionary *)description{
    
    if (!viewRight) {
        viewRight = [[UIView alloc] initWithFrame:self.view.bounds];
        [viewRight setBackgroundColor:[UIColor blackColor]];
        [viewRight setAlpha:.1f];
    }
    
    viewRightTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handelTapGesture:)];
    [viewRight addGestureRecognizer:viewRightTapGes];
    
    if (!scrollV) {
        scrollV = [[UIScrollView alloc] init];
        [scrollV setBackgroundColor:[UIColor colorWithRed:247.f/ 255.f green:247.f/ 255.f blue:247.f/ 255.f alpha:1.f]];
        [scrollV setShowsVerticalScrollIndicator:NO];
    }
    [scrollV setFrame:CGRectMake(320.f, 20.f, 265.f, self.view.bounds.size.height - 20.f)];
    [self.view addSubview:viewRight];
    
    NSString *strDescription = [[NSMutableString stringWithString:appDetailsInfo.description] stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    
    NSString *strReleaseNotes = [[NSMutableString stringWithString:appDetailsInfo.release_notes] stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    
    
    if (!lblDescriptionType) {
        lblDescriptionType = [[UILabel alloc]initWithFrame:CGRectMake(10.f, 15.f, 255.f, 15.f)];
        [lblDescriptionType setBackgroundColor:[UIColor clearColor]];
        
        [lblDescriptionType setFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
        
        [lblDescriptionType setTextColor:[UIColor colorWithRed:51.f / 255.f green:51.f / 255.f blue:51.f / 255.f alpha:1.f]];
        [lblDescriptionType setNumberOfLines:0];
        [lblDescriptionType setText:[NSString stringWithFormat:@"所属分类:  %@",appDetailsInfo.primary_genre_name]];
        [scrollV addSubview:lblDescriptionType];
    }
    if (!lblDescriptionLanguage) {
        lblDescriptionLanguage = [[UILabel alloc]initWithFrame:CGRectMake(10.f, 35.f, 40.f, 15.f)];
        [lblDescriptionLanguage setBackgroundColor:[UIColor clearColor]];
        
        [lblDescriptionLanguage setFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
        
        [lblDescriptionLanguage setTextColor:[UIColor colorWithRed:51.f / 255.f green:51.f / 255.f blue:51.f / 255.f alpha:1.f]];
        [lblDescriptionLanguage setNumberOfLines:0];
        [lblDescriptionLanguage setText:@"语言:"];
        [scrollV addSubview:lblDescriptionLanguage];
    }
    
    if (!lblDescriptionLanguageDesc) {
        lblDescriptionLanguageDesc = [[UILabel alloc]init];
        [lblDescriptionLanguageDesc setBackgroundColor:[UIColor clearColor]];
        
        [lblDescriptionLanguageDesc setFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
        CGFloat ldHeight = [self getSizeWithText:appDetailsInfo.language_code andWidth:183.f].height;
        [lblDescriptionLanguageDesc setFrame:CGRectMake(72.f, 35.f, 183.f, ldHeight)];
        
        [lblDescriptionLanguageDesc setTextColor:[UIColor colorWithRed:51.f / 255.f green:51.f / 255.f blue:51.f / 255.f alpha:1.f]];
        [lblDescriptionLanguageDesc setNumberOfLines:0];
        [lblDescriptionLanguageDesc setText:[NSString stringWithFormat:@"%@",appDetailsInfo.language_code]];
        //
        [scrollV addSubview:lblDescriptionLanguageDesc];
    }
    
    
    if (!lblDescriptionVersion) {
        lblDescriptionVersion = [[UILabel alloc]initWithFrame:CGRectMake(10.f, lblDescriptionLanguageDesc.frame.size.height + lblDescriptionLanguageDesc.frame.origin.y + 5.f, 255.f, 15.f)];
        [lblDescriptionVersion setBackgroundColor:[UIColor clearColor]];
        
        [lblDescriptionVersion setFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
        
        [lblDescriptionVersion setTextColor:[UIColor colorWithRed:51.f / 255.f green:51.f / 255.f blue:51.f / 255.f alpha:1.f]];
        [lblDescriptionVersion setNumberOfLines:0];
        [lblDescriptionVersion setText:[NSString stringWithFormat:@"当前版本:  %@",appDetailsInfo.version]];
        [scrollV addSubview:lblDescriptionVersion];
    }
    if (!lblDescriptionSize) {
        lblDescriptionSize = [[UILabel alloc]initWithFrame:CGRectMake(10.f, lblDescriptionVersion.frame.size.height + lblDescriptionVersion.frame.origin.y + 5.f, 255.f, 15.f)];
        [lblDescriptionSize setBackgroundColor:[UIColor clearColor]];
        
        [lblDescriptionSize setFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
        
        [lblDescriptionSize setTextColor:[UIColor colorWithRed:51.f / 255.f green:51.f / 255.f blue:51.f / 255.f alpha:1.f]];
        [lblDescriptionSize setNumberOfLines:0];
        [lblDescriptionSize setText:[NSString stringWithFormat:@"文件大小:  %@",appDetailsInfo.download_size]];
        [scrollV addSubview:lblDescriptionSize];
    }
    if (!lblDescriptionAge) {
        lblDescriptionAge = [[UILabel alloc]initWithFrame:CGRectMake(10.f, lblDescriptionSize.frame.size.height + lblDescriptionSize.frame.origin.y + 5.f, 255.f, 15.f)];
        [lblDescriptionAge setBackgroundColor:[UIColor clearColor]];
        
        [lblDescriptionAge setFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
        
        [lblDescriptionAge setTextColor:[UIColor colorWithRed:51.f / 255.f green:51.f / 255.f blue:51.f / 255.f alpha:1.f]];
        [lblDescriptionAge setNumberOfLines:0];
        [lblDescriptionAge setText:[NSString stringWithFormat:@"适合年龄:  %@",appDetailsInfo.recommended_age]];
        [scrollV addSubview:lblDescriptionAge];
    }
    if (!lblDescriptionDeveloper) {
        lblDescriptionDeveloper = [[UILabel alloc]initWithFrame:CGRectMake(10.f, lblDescriptionAge.frame.size.height + lblDescriptionAge.frame.origin.y + 5.f, 50.f, 15.f)];
        [lblDescriptionDeveloper setBackgroundColor:[UIColor clearColor]];
        
        [lblDescriptionDeveloper setFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
        
        [lblDescriptionDeveloper setTextColor:[UIColor colorWithRed:51.f / 255.f green:51.f / 255.f blue:51.f / 255.f alpha:1.f]];
        [lblDescriptionDeveloper setNumberOfLines:0];
        [lblDescriptionDeveloper setText:@"开发者:"];
        [scrollV addSubview:lblDescriptionDeveloper];
    }
    
    if (!lblDescriptionDeveloperDesc) {
        lblDescriptionDeveloperDesc = [[UILabel alloc]init];
        
        CGFloat ldHeight = [self getSizeWithText:appDetailsInfo.seller_name andWidth:183.f].height;
        [lblDescriptionDeveloperDesc setFrame:CGRectMake(72.f, lblDescriptionDeveloper.frame.origin.y , 183.f, ldHeight)];
        [lblDescriptionDeveloperDesc setBackgroundColor:[UIColor clearColor]];
        
        [lblDescriptionDeveloperDesc setFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
        
        [lblDescriptionDeveloperDesc setTextColor:[UIColor colorWithRed:51.f / 255.f green:51.f / 255.f blue:51.f / 255.f alpha:1.f]];
        [lblDescriptionDeveloperDesc setNumberOfLines:0];
        [lblDescriptionDeveloperDesc setText:[NSString stringWithFormat:@"%@",appDetailsInfo.seller_name]];
        //
        [scrollV addSubview:lblDescriptionDeveloperDesc];
    }
    
    //
    
    if (!imgVLine) {
        imgVLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"appDetailsLine.png"]];
        [imgVLine setFrame:CGRectMake(0.f, lblDescriptionDeveloperDesc.frame.size.height + lblDescriptionDeveloperDesc.frame.origin.y + 5.f, scrollV.frame.size.width, 1.f)];
        [scrollV addSubview:imgVLine];
    }
    
    CGFloat height = [self getSizeWithText:[NSString stringWithFormat:@"%@%@",strDescription,strReleaseNotes] andWidth:255.f].height;
    
    if (!lblDescription) {
        lblDescription = [[UILabel alloc]initWithFrame:CGRectMake(10.f, imgVLine.frame.origin.y + imgVLine.frame.size.height + 5.f, 255.f, height)];
        [lblDescription setBackgroundColor:[UIColor clearColor]];
        
        [lblDescription setFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
        
        [lblDescription setTextColor:[UIColor colorWithRed:51.f / 255.f green:51.f / 255.f blue:51.f / 255.f alpha:1.f]];
        [lblDescription setNumberOfLines:0];
        [lblDescription setText:[NSString stringWithFormat:@"%@%@",strDescription,strReleaseNotes]];
        [scrollV addSubview:lblDescription];
    }
        
    [scrollV setContentSize:CGSizeMake(scrollV.frame.size.width, height + imgVLine.frame.origin.y + imgVLine.frame.size.height + 15.f)];

    
    [self.view addSubview:scrollV];
    
    [UIView animateWithDuration:.3 animations:^{
        [viewRight setAlpha:.7f];
        [scrollV setFrame:CGRectMake(55.f, 20.f, 265.f, self.view.bounds.size.height - 20.f)];
    } completion:^(BOOL finished) {
        
    }];

}

-(void)layRightViewContetnWithAppPriceChangeList:(NSArray *)arrPrice{
    
    if (!viewRight) {
        viewRight = [[UIView alloc] initWithFrame:self.view.bounds];
        [viewRight setBackgroundColor:[UIColor blackColor]];
        [viewRight setAlpha:.1f];
    }
    [self.view addSubview:viewRight];

    viewRightTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handelTapGesture:)];
    [viewRight addGestureRecognizer:viewRightTapGes];
    
    if (!_tableVPrice) {
        _tableVPrice = [[UITableView alloc] initWithFrame:CGRectMake(320.f, 20.f, 265.f, self.view.bounds.size.height - 20.f)];
        [_tableVPrice setDelegate:self];
        [_tableVPrice setDataSource:self];
        //[_tableVPrice setBackgroundColor:[UIColor colorWithRed:247.f/ 255.f green:247.f/ 255.f blue:247.f/ 255.f alpha:1.f]];
        [_tableVPrice setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]];
    }
    
    if (!viewPriceTop) {
        viewPriceTop = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 265.f, 50.f)];
        [viewPriceTop setBackgroundColor:[UIColor clearColor]];
        [_tableVPrice setTableHeaderView:viewPriceTop];
    }
    
    if (!lblAppPriceDes1) {
        lblAppPriceDes1 = [[UILabel alloc]initWithFrame:CGRectMake(5.f, 10.f, 125.f, 15.0f)];
        UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:13];

        [lblAppPriceDes1 setFont:font];
        [lblAppPriceDes1 setBackgroundColor:[UIColor clearColor]];
        [lblAppPriceDes1 setNumberOfLines:0];
//        [_tableVPrice setTableHeaderView:lblAppPriceDes1];
        [viewPriceTop addSubview:lblAppPriceDes1];
    }
    
    if (!lblAppPriceDes2) {
        lblAppPriceDes2 = [[UILabel alloc]initWithFrame:CGRectMake(5.f, 30.f, 125.f, 15.0f)];
        UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        
        [lblAppPriceDes2 setFont:font];
        [lblAppPriceDes2 setBackgroundColor:[UIColor clearColor]];
        [lblAppPriceDes2 setNumberOfLines:0];
        [viewPriceTop addSubview:lblAppPriceDes2];
//        [_tableVPrice setTableHeaderView:lblAppPriceDes2];
    }
    if (!lblAppPriceDes3) {
        lblAppPriceDes3 = [[UILabel alloc]initWithFrame:CGRectMake(130.f, 10.f, 125.f, 15.0f)];
        UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        
        [lblAppPriceDes3 setFont:font];
        [lblAppPriceDes3 setBackgroundColor:[UIColor clearColor]];
        [lblAppPriceDes3 setNumberOfLines:0];
        [viewPriceTop addSubview:lblAppPriceDes3];
//        [_tableVPrice setTableHeaderView:lblAppPriceDes3];
    }
    if (!lblAppPriceDes4) {
        lblAppPriceDes4 = [[UILabel alloc]initWithFrame:CGRectMake(130.f, 30.f, 125.f, 15.0f)];
        UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        
        [lblAppPriceDes4 setFont:font];
        [lblAppPriceDes4 setBackgroundColor:[UIColor clearColor]];
        [lblAppPriceDes4 setNumberOfLines:0];
        [viewPriceTop addSubview:lblAppPriceDes4];
//        [_tableVPrice setTableHeaderView:lblAppPriceDes4];
    }
    
    
    [self.view addSubview:_tableVPrice];
    
    [UIView animateWithDuration:.3 animations:^{
        [viewRight setAlpha:.7f];
        [_tableVPrice setFrame:CGRectMake(55.f, 20.f, 265.f, self.view.bounds.size.height - 20.f)];
    } completion:^(BOOL finished) {
        
    }];

}
-(void)layRightViewContetnAppRecommendInput{
    if (!viewRight) {
        viewRight = [[UIView alloc] initWithFrame:self.view.bounds];
        [viewRight setBackgroundColor:[UIColor blackColor]];
        [viewRight setAlpha:.1f];
    }
    
    viewRightTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handelTapGesture:)];
    [viewRight addGestureRecognizer:viewRightTapGes];
    
    if (!scrollVRecommend) {
        scrollVRecommend = [[UIScrollView alloc] init];
        [scrollVRecommend setBackgroundColor:[UIColor colorWithRed:247.f/255.f green:247.f/255.f blue:247.f/255.f alpha:1.f]];
    }
    [scrollVRecommend setFrame:CGRectMake(320.f, 20.f, 265.f, self.view.bounds.size.height - 20.f)];
    
    if (!txtVRecommendInput) {
        txtVRecommendInput = [[UITextView alloc]initWithFrame:CGRectMake(10.f, 13.f, 245.f, 145.f)];
        [txtVRecommendInput setDelegate:self];
        [txtVRecommendInput setFont:[UIFont systemFontOfSize:14.0f]];
        [[txtVRecommendInput layer] setCornerRadius:12.f];
        
        [[txtVRecommendInput layer] setBorderColor:[[UIColor colorWithRed:221.f / 255.f green:221.f / 255.f blue:221.f / 255.f alpha:1.f] CGColor]];
        [[txtVRecommendInput layer] setBorderWidth:1.f];
        [txtVRecommendInput setClipsToBounds:YES];
        
        [scrollVRecommend setContentSize:CGSizeMake(scrollVRecommend.frame.size.width, scrollVRecommend.frame.size.height + 5.f)];
        
        [scrollVRecommend addSubview:txtVRecommendInput];
        
    }
    if (!lblPlaceHolder) {
        lblPlaceHolder = [[UILabel alloc] initWithFrame:CGRectMake(16.f, 22.f, 240.f, 15.f)];
        UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:15];
        [lblPlaceHolder setBackgroundColor:[UIColor clearColor]];
        [lblPlaceHolder setFont:font];
        [lblPlaceHolder setTextColor:[UIColor colorWithRed:127.f/255.f green:127.f/255.f blue:127.f/255.f alpha:1.f]];
        [scrollVRecommend addSubview:lblPlaceHolder];
    }
    [lblPlaceHolder setText:@"推荐理由（必填）"];

    if (!btnSubmitRec) {
        btnSubmitRec = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnSubmitRec setFrame:CGRectMake(10.f, 182.f, 245.f, 44.f)];
        [btnSubmitRec setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnSubmitRec setBackgroundColor:[UIColor whiteColor]];
        [[btnSubmitRec layer] setCornerRadius:12.f];
        [[btnSubmitRec layer] setBorderColor:[[UIColor colorWithRed:221.f / 255.f green:221.f / 255.f blue:221.f / 255.f alpha:1.f] CGColor]];
        [[btnSubmitRec layer] setBorderWidth:1.f];
        [btnSubmitRec setTitle:@"完成" forState:UIControlStateNormal];
        [btnSubmitRec addTarget:self action:@selector(submitAppRecommend) forControlEvents:UIControlEventTouchUpInside];
        [scrollVRecommend addSubview:btnSubmitRec];
    }
    
    [self.view addSubview:viewRight];
    
    [self.view addSubview:scrollVRecommend];
    [self.view bringSubviewToFront:scrollVRecommend];
    
    [UIView animateWithDuration:.3 animations:^{
        [viewRight setAlpha:.7f];
        [scrollVRecommend setFrame:CGRectMake(55.f, 20.f, 265.f, self.view.bounds.size.height - 20.f)];
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma uitext view delegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (textView == txtVRecommendInput) {
        DLog(@"------------------------");
    }else{
        DLog(@"+++++++++++++++++++++++++");
    }
//    if ([textView.text length] == 0) {
//        [lblPlaceHolder setText:@"推荐理由（必填）"];
//    }else{
        [lblPlaceHolder setText:@""];
//    }
//    [scrollVRecommend setContentOffset:CGPointMake(0.f, 20.f) animated:YES];
    
    [toolBar setHidden:YES];
}

-(void)recommendAppWithContent:(NSString *)reContent{
    
    [dictParam setObject:userId forKey:@"uid"];
    [dictParam setObject:appDetailsInfo.application_id forKey:@"aid"];
    [dictParam setObject:reContent forKey:@"content"];

    [RSHTTPMANAGER shareBlogWithParameters:dictParam WithSuccess:^(BOOL isSucceed) {
        
        if (isSucceed) {
                        
            [topCell.appRecommend setText:@"已推荐"];
            [topCell.btnRecommend setEnabled:NO];
            [txtVRecommendInput setText:@""];
            SHOWALERT_WITHTITLE_ANDMESSAGE(@"提示", @"推荐成功");
            [toolBar setHidden:NO];
            [self handelTapGesture:viewRightTapGes];
        }else{
            SHOWALERT_WITHTITLE_ANDMESSAGE(@"提示", @"推荐失败");
            [toolBar setHidden:NO];
        }
    } failure:^(NSError *_err) {
        
    }];
}


-(void)submitAppRecommend{
    if ([[txtVRecommendInput text] length] > 0) {
        [self recommendAppWithContent:[txtVRecommendInput text]];
    }else{
        SHOWALERT_WITHTITLE_ANDMESSAGE(@"", @"输入推荐文字才能进行App推荐哦");
    }
    
    DLog(@"推荐");
}


-(void)handelTapGesture:(UITapGestureRecognizer *)ges{
    self.showAppPriceList = HIDEPRICELIST;
    [UIView animateWithDuration:.3 animations:^{
        [txtVRecommendInput resignFirstResponder];
        [viewRight setAlpha:.1f];

        [scrollV setFrame:CGRectMake(320.f, 20.f, 265.f, self.view.bounds.size.height - 20.f)];
        [scrollVRecommend setFrame:CGRectMake(320.f, 20.f, 265.f, self.view.bounds.size.height - 20.f)];
        [_tableVPrice setFrame:CGRectMake(320.f, 20.f, 265.f, self.view.bounds.size.height - 20.f)];

    } completion:^(BOOL finished) {
        [toolBar setHidden:NO];
        [viewRight removeGestureRecognizer:viewRightTapGes];
        [viewRight removeFromSuperview];
        viewRight = nil;
    }];
    
}

-(CGSize)getSizeWithText:(NSString *)strMsg andWidth:(CGFloat)width{
    CGSize size = [strMsg sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13] constrainedToSize:CGSizeMake(width, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return size;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.showAppPriceList == SHOWPRICELIST) {
        return 1;
    }else if (self.showAppPriceList == HIDEPRICELIST){
        return 3;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.showAppPriceList == SHOWPRICELIST) {
        return [arrPriceChangeList count];
    }else if (self.showAppPriceList == HIDEPRICELIST){
        if (section == 0 || section == 1) { return 1;  }
        else              { return [arrAppDetailsCW count]; }
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.showAppPriceList == SHOWPRICELIST) {
        return 44.f;
    }else if (self.showAppPriceList == HIDEPRICELIST){
        if (indexPath.section == 0) {
            return  cellHeight0;
            //return 240.f;
        }
        else if (indexPath.section == 1){return 197.0;}
        else{
            if (arrAppDetailsCW) {
                NSString *strTemp = [(AppInfoRWDModel *)[arrAppDetailsCW objectAtIndex:indexPath.row] content];
                CGFloat cellHeight = [self getSizeWithText:strTemp andWidth:265.f].height;
                return  cellHeight + 85.f > 100.f ? cellHeight + 85.f : 100.f;
            }
            return 110.0;
        }
    }
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellReuseIdentifier0   = @"TableViewCellSection0";
    static NSString *cellReuseIdentifier1 = @"TableViewCellSection1";
    static NSString *cellReuseIdentifier2 = @"TableViewCellSection2";
    NSString *cellPriceReuseIdentifier = [NSString stringWithFormat:@"%d-%d",indexPath.row,indexPath.section];

    if (self.showAppPriceList == SHOWPRICELIST) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellPriceReuseIdentifier];
        UILabel *lblPricing_time;
        UILabel *lblRetail_price;
        UILabel *lblPrice_name;
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellPriceReuseIdentifier];
            cell.backgroundColor             = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.selectionStyle              = UITableViewCellSelectionStyleNone;
            
            UIColor *textColor = [UIColor colorWithRed:51.f / 255.f green:51.f / 255.f blue:51.f / 255.f alpha:1.f];
            UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:13];
            
            lblPricing_time = [[UILabel alloc] initWithFrame:CGRectMake(7.f, 11.f, 85.f, 20.f)];
            [lblPricing_time setFont:font];
            [lblPricing_time setTextAlignment:NSTextAlignmentLeft];
            [lblPricing_time setBackgroundColor:[UIColor clearColor]];
            [lblPricing_time setFont:[UIFont systemFontOfSize:13.f]];
            [lblPricing_time setTextColor:textColor];
            [cell.contentView addSubview:lblPricing_time];
            
            lblRetail_price = [[UILabel alloc] initWithFrame:CGRectMake(96.f, 11.f, 95.f, 20.f)];
            [lblRetail_price setFont:font];
            [lblRetail_price setBackgroundColor:[UIColor clearColor]];
            [lblRetail_price setFont:[UIFont systemFontOfSize:13.f]];
            [lblRetail_price setTextColor:textColor];
            [lblRetail_price setTextAlignment:NSTextAlignmentLeft];
            [cell.contentView addSubview:lblRetail_price];

            lblPrice_name = [[UILabel alloc] initWithFrame:CGRectMake(195.f, 11.f, 58.f, 20.f)];
            [[lblPrice_name layer] setCornerRadius:4.f];
            [lblPrice_name setFont:font];
            [lblPrice_name setTextColor:[UIColor whiteColor]];
            [lblPrice_name setTextAlignment:NSTextAlignmentCenter];

            [cell.contentView addSubview:lblPrice_name];

        }
        if (arrPriceChangeList) {
            AppPrice *price = (AppPrice *)[arrPriceChangeList objectAtIndex:indexPath.row];
//            DLog(@"row:%d    name:%@  time:%@  price:%@  version:%@",indexPath.row,price.price_name,price.pricing_time,price.retail_price,price.version);
            [lblPricing_time setText:[price.pricing_time stringByReplacingOccurrencesOfString:@"-" withString:@"/"]];
            [lblRetail_price setText:price.retail_price ? [NSString stringWithFormat:@"%@  %@",price.version ? price.version : @"",price.retail_price] : price.version];
            if ([price.price_name isEqualToString:@"涨价"]) {
                [lblPrice_name setBackgroundColor:[UIColor colorWithRed:255.f/255.f green:102.f/255.f blue:102.f/255.f alpha:1.f]];
            }else{
                [lblPrice_name setBackgroundColor:[UIColor colorWithRed:63.f / 255.f green:165.f / 255.f blue:81.f / 255.f alpha:1.f]];
            }
            [lblPrice_name setText:price.price_name];
        }
        return cell;
        
    }else if (self.showAppPriceList == HIDEPRICELIST){
        if (indexPath.section == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier0];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier0];
                cell.backgroundColor             = [UIColor clearColor];
                cell.contentView.backgroundColor = [UIColor clearColor];
                cell.selectionStyle              = UITableViewCellSelectionStyleNone;
                
                [cell.contentView addSubview:_transparentScroller];
            }
            return cell;
        }else if (indexPath.section == 1){
            
            topCell = (AppsDetailTopCell*)[tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier1];
            if (topCell == nil) {
                topCell = [[AppsDetailTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier1];
                [topCell setSelectionStyle:UITableViewCellSelectionStyleNone];
                topCell.delegate = self;
            }
//            [topCell.btnAppStore setEnabled:NO];
            UIFont *fontTitle = [UIFont fontWithName:@"Helvetica Neue" size:20.f];
            
            UIFont *fontType = [UIFont fontWithName:@"Helvetica Neue" size:15.f];
            
            DLog(@"self.sqModel.limited_state_name:%@",self.sqModel.limited_state_name);
            if ([self.sqModel.limited_state_name isEqualToString:@"首次限免"]) {
                [topCell.imgAppState setImage:[UIImage imageNamed:@"apptip1.png"]];
            }else if ([self.sqModel.limited_state_name isEqualToString:@"多次限免"]){
                [topCell.imgAppState setImage:[UIImage imageNamed:@"apptip2.png"]];
            }else if ([self.sqModel.limited_state_name isEqualToString:@"首次冰点"]){
                [topCell.imgAppState setImage:[UIImage imageNamed:@"apptip3.png"]];
            }else if ([self.sqModel.limited_state_name isEqualToString:@"再次冰点"]){
                [topCell.imgAppState setImage:[UIImage imageNamed:@"apptip4.png"]];
            }else if ([self.sqModel.limited_state_name isEqualToString:@"涨价"]){
                [topCell.imgAppState setImage:[UIImage imageNamed:@"apptip5.png"]];
            }
            
            NSLog(@"........%f",topCell.rmbLB.center.x);
//            topCell.rmbLB.center = CGPointMake(110.5, topCell.rmbLB.center.y);
            NSLog(@"........%f",topCell.lblAppPrice.center.x);
//            topCell.lblAppPrice.center = CGPointMake(128, topCell.lblAppPrice.center.y);

            
            
            
            
            NSLog(@"limited_state_name==%@, price===%@",self.sqModel.limited_state_name,self.sqModel.application_retail_price);
//            topCell.lblAppPrice.text = [NSString stringWithFormat:@"%@",self.sqModel.application_retail_price];
            topCell.lblAppPrice.text = [NSString stringWithFormat:@"%@",[self.sqModel.application_retail_price intValue] > 0 ? [NSString stringWithFormat:@"%d",[self.sqModel.application_retail_price intValue]] : @"免费"];
            
            [topCell.lblAppDiscussionCount setText:[NSString stringWithFormat:@"谈论%@   ",self.sqModel.application_title]];

            
            
            if ([topCell.lblAppPrice.text isEqualToString:@"免费"]) {
                topCell.rmbLB.hidden = YES;
                topCell.lblAppPrice.center = CGPointMake(138.0 - 9, topCell.lblAppPrice.center.y);
                topCell.lblAppPrice.font = [UIFont fontWithName:@"Helvetica Neue" size:16.f];
                
            }else{
                topCell.rmbLB.hidden = NO;
                NSLog(@"........%f",topCell.rmbLB.center.x);
//                topCell.rmbLB.center = CGPointMake(110.5, topCell.rmbLB.center.y);
                NSLog(@"........%f",topCell.lblAppPrice.center.x);
//                topCell.lblAppPrice.center = CGPointMake(128, topCell.lblAppPrice.center.y);

                if (topCell.lblAppPrice.text.length == 1) {
                    topCell.rmbLB.center = CGPointMake(110.5 + 5, topCell.rmbLB.center.y);
                    topCell.lblAppPrice.center = CGPointMake(138.0 + 5, topCell.lblAppPrice.center.y);
                }else if (topCell.lblAppPrice.text.length == 2) {
                    topCell.rmbLB.center = CGPointMake(110.5 + 6, topCell.rmbLB.center.y);
                    topCell.lblAppPrice.center = CGPointMake(138.0 + 6, topCell.lblAppPrice.center.y);
                }else if (topCell.lblAppPrice.text.length == 3){
                    topCell.rmbLB.center = CGPointMake(110.5 + 7, topCell.rmbLB.center.y);
                    topCell.lblAppPrice.center = CGPointMake(138.0+ 7, topCell.lblAppPrice.center.y);
                }
            }

            
            
            if (appDetailsInfo) {
                if ([[appDetailsInfo isRecommended] boolValue]) {
                    [topCell.appRecommend setText:@"已推荐"];
                    [topCell.btnRecommend setEnabled:NO];
                }
                if ([[appDetailsInfo isRemind] boolValue]) {
                    [topCell.lblAppWishList setText:@"已添加"];
                    [topCell.btnWishList setEnabled:NO];
                }
//                if (appDetailsInfo.devicetypeFit == fitIphone) {
//                    [topCell.btnAppStore setEnabled:YES];
//                }
//                DLog(@"----------------------------:  %@",[appDetailsInfo limitStateName]);

//                NSLog(@"appDetailsInfo.limitStateName......:%@",appDetailsInfo.limitedStateName);
                if (appDetailsInfo.limitedState != nil && ![[NSString stringWithFormat:@"%@",appDetailsInfo.limitedState] isEqualToString:@""]) {
//                    DLog(@"++++++++++++++++++++++++:  %@",[appDetailsInfo limitStateName]);
                    switch ([[appDetailsInfo limitedState] intValue]) {
                        case 0:
                        {
                            [topCell.imgAppState setImage:[UIImage imageNamed:@"apptip1.png"]];
                        }
                            break;
                        case 1:
                        {
                            [topCell.imgAppState setImage:[UIImage imageNamed:@"apptip2.png"]];
                        }
                            break;
                        case 2:
                        {
                            [topCell.imgAppState setImage:[UIImage imageNamed:@"apptip3.png"]];
                        }
                            break;
                        case 3:
                        {
                            [topCell.imgAppState setImage:[UIImage imageNamed:@"apptip4.png"]];
                        }
                            break;
                        case 4:
                        {
                            [topCell.imgAppState setImage:[UIImage imageNamed:@"apptip5.png"]];
                        }
                            break;
                        default:
                            //                    {
                            ////                        [topCell.imgAppState setImage:[UIImage imageNamed:@"apptip1.png"]];
                            //                    }
                            break;
                    }
                }
                else if (appDetailsInfo.limitedStateName != nil && ![[NSString stringWithFormat:@"%@",appDetailsInfo.limitedStateName] isEqualToString:@""]){
                    topCell.limitStateName.text = appDetailsInfo.limitedStateName;
                }
                
                
                
                topCell.lblAppPrice.text = [NSString stringWithFormat:@"%@",[appDetailsInfo.price intValue] > 0 ? [NSString stringWithFormat:@"%d",[appDetailsInfo.price intValue]] : @"免费"];
                if ([topCell.lblAppPrice.text isEqualToString:@"免费"]) {
                    topCell.rmbLB.hidden = YES;
                    topCell.lblAppPrice.center = CGPointMake(138.0 - 9, topCell.lblAppPrice.center.y);
                    topCell.lblAppPrice.font = [UIFont fontWithName:@"Helvetica Neue" size:16.f];
                    
                }else{
                    topCell.rmbLB.hidden = NO;
                    if (topCell.lblAppPrice.text.length == 1) {
                        topCell.rmbLB.center = CGPointMake(110.5 + 5, topCell.rmbLB.center.y);
                        topCell.lblAppPrice.center = CGPointMake(138.0 + 5, topCell.lblAppPrice.center.y);
                    }else if (topCell.lblAppPrice.text.length == 2) {
                        topCell.rmbLB.center = CGPointMake(110.5 + 6, topCell.rmbLB.center.y);
                        topCell.lblAppPrice.center = CGPointMake(138.0 + 6, topCell.lblAppPrice.center.y);
                    }else if (topCell.lblAppPrice.text.length == 3){
                        topCell.rmbLB.center = CGPointMake(110.5 + 7, topCell.rmbLB.center.y);
                        topCell.lblAppPrice.center = CGPointMake(138.0 + 7, topCell.lblAppPrice.center.y);
                    }
                }
                [topCell.imgVAppIcon setImageWithURL:[NSURL URLWithString:appDetailsInfo.artwork_url_small]];
                [topCell.lblAppDiscussionCount setText:[NSString stringWithFormat:@"谈论%@   %d 人",[appDetailsInfo title],[arrAppDetailsCW count]]];
            }
         
            
            [topCell.imgVAppIcon setImageWithURL:[NSURL URLWithString:[self.sqModel application_artwork_url_small]]];
            topCell.lblAppName.text = [self.sqModel application_title];
            [topCell.lblAppName setFont:fontTitle];
            
            topCell.lblAppType.text = [NSString stringWithFormat:@"%@/%@",self.sqModel.primary_genre_name,self.sqModel.supported_device_name];
            [topCell.lblAppType setFont:fontType];
            
            return topCell;
        }else {
            
            AppDetailsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier2];
            if (!cell) {
                cell = [[AppDetailsInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier2];
                cell.contentView.backgroundColor = [UIColor whiteColor];
                cell.selectionStyle              = UITableViewCellSelectionStyleNone;
                [cell.btnSupport setBackgroundColor:[UIColor colorWithRed:247.f / 255.f green:247.f / 255.f blue:247.f / 255.f alpha:1.f]];
                [cell.btnReply setBackgroundColor:[UIColor colorWithRed:247.f / 255.f green:247.f / 255.f blue:247.f / 255.f alpha:1.f]];
                [cell.btnSupport addTarget:self action:@selector(appSupportAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.btnSupport showsTouchWhenHighlighted];
                [cell.btnReply addTarget:self action:@selector(appReplyAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.btnReply showsTouchWhenHighlighted];
                [cell.btnSupport setTag:indexPath.row];
                [cell.btnReply setTag:indexPath.row];
            }
            
            if (arrAppDetailsCW) {
                AppReplyInfo *app = [arrAppDetailsCW objectAtIndex:indexPath.row];
                [cell.userAvart setImageWithURL:[NSURL URLWithString:app.img_path] placeholderImage:[UIImage imageNamed:@"hi"]];
                cell.userName.text = app.nick_name;
//                DLog(@"app.user.create_datetime===%@",app.user.create_datetime);
                cell.publishTime.text = [[NSString stringWithFormat:@"%@",app.create_time] substringWithRange:NSMakeRange(5, 11)];
                cell.publishContent.text = app.content;
                CGFloat height= [self getSizeWithText:app.content andWidth:265.f].height;
                [cell.publishContent setFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                cell.publishContent.frame = CGRectMake(cell.publishContent.frame.origin.x, cell.publishContent.frame.origin.y, cell.publishContent.frame.size.width, height);
                
                NSString *strResponse = nil;
                NSString *strSupport = nil;
                
//                if ([app.response_count_str length] > 0) {
                strResponse = [NSString stringWithFormat:@"%@回应",[app.response_count intValue]> 0 ? app.response_count : @""];
                strSupport = [NSString stringWithFormat:@"%@ 赞",[app.like_count intValue] > 0 ? app.like_count : @""];

                [[cell.btnReply layer] setCornerRadius:3.f];
                [[cell.btnSupport layer] setCornerRadius:3.f];
                
                [cell.btnReply setTitle:strResponse forState:UIControlStateNormal];
                [cell.btnSupport setTitle:strSupport forState:UIControlStateNormal];
                
                [cell.btnSupport setFrame:CGRectMake(cell.btnSupport.frame.origin.x, cell.publishContent.frame.origin.y + cell.publishContent.frame.size.height + 5.f, cell.btnSupport.frame.size.width, cell.btnSupport.frame.size.height)];
                [cell.btnReply setFrame:CGRectMake(cell.btnReply.frame.origin.x, cell.publishContent.frame.origin.y + cell.publishContent.frame.size.height + 5.f, cell.btnReply.frame.size.width, cell.btnReply.frame.size.height)];
                [cell.publishTime setFrame:CGRectMake(cell.publishTime.frame.origin.x, cell.btnSupport.frame.origin.y + cell.btnSupport.frame.size.height - cell.publishTime.frame.size.height - 15.f, cell.publishTime.frame.size.width, cell.publishTime.frame.size.height)];
                [cell.imgVLine setFrame:CGRectMake(cell.imgVLine.frame.origin.x, cell.btnSupport.frame.origin.y + cell.btnSupport.frame.size.height + 9.f, cell.imgVLine.frame.size.width, cell.imgVLine.frame.size.height)];
            }
            return cell;
        }
    }
    return nil;
}

#pragma App support and reply
//赞
-(void)appSupportAction:(id)sender{
    UIButton *btnTemp = (UIButton *)sender;
    DLog(@"btnTemp.tag==%d",btnTemp.tag);
    AppReplyInfo *replyInfo = [arrAppDetailsCW objectAtIndex:btnTemp.tag];
    DLog(@"replyinfo is_like==%@",replyInfo.is_like);
    if ([[replyInfo is_like] intValue] == 0) {
        [RSHTTPMANAGER showActivityView:YES];

        [RSHTTPMANAGER requestZanWithEvent_id:replyInfo.event_id WithUid:userId WithSuccess:^(BOOL isSuccess) {
            if (isSuccess) {
                [replyInfo setIs_like:@"1"];
                [replyInfo setLike_count:[NSString stringWithFormat:@"%d",[replyInfo.like_count intValue] + 1]];
                [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:btnTemp.tag inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
            }
            
        } failure:^(NSError *error) {
            
        }];
    }else{
        [RSHTTPMANAGER showActivityView:YES];
        [RSHTTPMANAGER requestUnZanWithEvent_id:replyInfo.event_id WithUid:userId WithSuccess:^(BOOL isSuccess) {
            if (isSuccess) {
                [replyInfo setIs_like:@"0"];
                [replyInfo setLike_count:[NSString stringWithFormat:@"%d",[replyInfo.like_count intValue] - 1]];
                [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:btnTemp.tag inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
            }
        } failure:^(NSError *error) {
            
        }];
    }
    
}
//回应
-(void)appReplyAction:(id)sender{
    UIButton *btnTemp = (UIButton *)sender;
    AppReplyInfo *replyInfo = [arrAppDetailsCW objectAtIndex:btnTemp.tag];
    
    RespondViewController *respondVC = [[RespondViewController alloc] init];
    [respondVC setDelegate:self];
    [self.sqModel setEvent_id:replyInfo.event_id];
    respondVC.squareModle = self.sqModel;
    [self.navigationController pushViewController:respondVC animated:YES];
}

#pragma respondviewcontroller delegate
-(void)refreshData{
    DLog(@"toolbar frame x=%f y=%f width=%f height=%f",toolBar.frame.origin.x,toolBar.frame.origin.y,toolBar.frame.size.width,toolBar.frame.size.height);
//    [self createSubmitBottomView];
//    [toolBar setHidden:NO];
//    [self.tf resignFirstResponder];
    [self requestAppResponseData];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self.tf resignFirstResponder];    
}


#pragma mark - Scroll view delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"scrollViewWillBeginDragging:%@",[scrollView class]);
    self.tf.userInteractionEnabled = NO;    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSLog(@"scrollViewWillEndDragging:%@",[scrollView class]);
    
    if ([scrollView isKindOfClass:[UITableView class]]) {
//        self.tf.userInteractionEnabled = YES;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //    self.tf.userInteractionEnabled = YES;
    NSLog(@"scrollViewDidEndDecelerating:%@",[scrollView class]);
    if ([scrollView isKindOfClass:[UITableView class]]) {
        self.tf.userInteractionEnabled = YES;
    }
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndScrollingAnimation:%@",[scrollView class]);
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll:%@",[scrollView class]);
    if ([scrollView isKindOfClass:[UITableView class]]) {
//        self.tf.userInteractionEnabled = NO;
    }
    if (scrollView == _imageScroller) {
        [_transparentScroller setContentOffset:_imageScroller.contentOffset];
        CGFloat pageWidth = self.view.bounds.size.width;
        float fractionalPage = scrollView.contentOffset.x / pageWidth;
        NSInteger page = lround(fractionalPage);
        pageCtr.currentPage = page;
    }else{
        
        CGFloat yOffset   = _tableView.contentOffset.y;
        if (yOffset <= -60.f) {
            if (hasScrollToMaxOffset == NO) {
                hasScrollToMaxOffset = YES;
                isfullsrc = ISFULLSCREEN;
                DLog(@"yOffset <= -60.f");
                [self updateOffsets];
                return;
            }
        }else if (yOffset > -60.f && yOffset < 0 ){
            isfullsrc = ISNOTFULLSCREEN;
//            DLog(@"1");
            [self updateOffsets];
            
        }else if (yOffset > 0.f){
//            DLog(@"2");
            
            [_imageScroller setFrame:rectInitialImageScrollView];

            [self updateOffsets];

        }else{
//            DLog(@"3");
            if(yOffset == 0) {
                CGFloat yOffset   = _tableView.contentOffset.y;
                
                CGFloat xOffset   = _transparentScroller.contentOffset.x;
                _imageScroller.contentOffset = CGPointMake(xOffset, yOffset);
                if (keyboardStatus == KEYBOARD_STATUS_ALL_HIDDEN) {
                    [_imageScroller setFrame:rectInitialImageScrollView];
                }
            }
        }
    }
}


-(void)backToPreVC:(id)sender{
    SVProgressHUD *tmp = [SVProgressHUD sharedView];
    [tmp setCenter:CGPointMake(tmp.center.x, tmp.center.y + 20)];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sharedCurrentApp:(id)sender{
    [SVProgressHUD dismiss];
    [viewRight setHidden:YES];
    [scrollVRecommend setHidden:YES];
    [scrollV setHidden:YES];
    [_tableVPrice setHidden:YES];
    
    AppShareViewController *appShareVC = [[AppShareViewController alloc] init];
    appShareVC.appDetailsInfo = appDetailsInfo;
    [self.navigationController pushViewController:appShareVC animated:YES];
    DLog(@"shared...");
}

-(void)appDetailsInfo:(id)sender{
    if (appDetailsInfo) {
        [viewRight setHidden:NO];
        [scrollV setHidden:NO];
        [self layRightViewContetnWithAppDescriopion:nil];
    }
    DLog(@"----描述");
}

-(void)appLinkToAppStore:(id)sender{
    DLog(@"AppStore");
    DLog(@"------:%f  %f  %f %f",_tableView.frame.origin.x,_tableView.frame.origin.y,_tableView.frame.size.width,_tableView.frame.size.height);
        if (appDetailsInfo) {
            
            if (appDetailsInfo.devicetypeFit == fitIphone) {
                if (!activityV) {
                    activityV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                    [activityV setFrame:CGRectMake(0.f, 0.f, 50.f, 50.f)];
                    [activityV setCenter:self.view.center];
                    [activityV setBackgroundColor:[UIColor blackColor]];
                    [activityV setAlpha:.7f];
                    [[activityV layer] setCornerRadius:8.f];
                    [self.view addSubview:activityV];
                }
            }else{
                SHOWALERT_WITHTITLE_ANDMESSAGE(@"提示", @"该App不适用于iPhone设备,您可以添加到愿望清单后 在其他客户端进行下载体验");
                return;
            }
            [activityV startAnimating];
            
            if([SKStoreProductViewController class]) {
//                //show the SKStoreProductViewController
//                SKStoreProductViewController *storeController=[SKStoreProductViewController new];
//                storeController.delegate=self;
//                NSDictionary *productParameters = [NSDictionary dictionaryWithObject:appDetailsInfo.application_id forKey:SKStoreProductParameterITunesItemIdentifier];//  @{SKStoreProductParameterITunesItemIdentifier : appDetailsInfo.application_id};
//                [storeController loadProductWithParameters:productParameters completionBlock:^(BOOL result, NSError *error) {
//                    if (result) {
//                        [activityV stopAnimating];
//                        [self presentModalViewController:storeController animated:YES];
//                    } else {
//                        [activityV stopAnimating];
//                        [[[UIAlertView alloc] initWithTitle:@"Uh oh!" message:@"There was a problem displaying the App" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
//                    }
//                }];
            
                DLog("view url==%@",appDetailsInfo.view_url);
            [activityV stopAnimating];
            //恢复5.0之前老方法，点击跳转到App Store应用
            NSString *helloMessage = appDetailsInfo.application_id;
            NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/id%@", helloMessage];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
            else {
                //use UIApplication's openURL:
                DLog("view url==%@",appDetailsInfo.view_url);

//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appDetailsInfo.view_url]];
                NSString *helloMessage = appDetailsInfo.application_id;
                NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/id%@", helloMessage];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                [activityV stopAnimating];
            }
            
        }
}

-(void) productViewControllerDidFinish:(SKStoreProductViewController *)viewController{

    [viewController dismissViewControllerAnimated:YES completion:^{
        [_tableView setFrame:CGRectMake(_tableView.frame.origin.x,_tableView.frame.origin.y,_tableView.frame.size.width,rectInitialTableView.size.height - 66.f)];
        rectInitialTableView = _tableView.frame;
        NSLog(@"dismiss");
    }];
    
}

-(void)appWithWishesList:(id)sender{
    NSDictionary *dictParamW = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"uid",appDetailsInfo.application_id,@"aid", nil];
    [RSHTTPMANAGER showActivityView:YES];
    [RSHTTPMANAGER addAppToWishlistWithParameters:dictParamW WithSuccess:^(BOOL isSucceed) {
        if (isSucceed) {
            [topCell.lblAppWishList setText:@"已添加"];
            [topCell.btnWishList setEnabled:NO];
            NSString *wishStore = [NSString stringWithFormat:@"已经添加%@到愿望清单",appDetailsInfo.title];
            SHOWALERT_WITHTITLE_ANDMESSAGE(@"提示", wishStore);
        }
    } failure:^(NSError *_err) {
        
    }];
    DLog(@"愿望清单");
}
-(void)appRecommend:(id)sender{
    DLog(@"推荐");
    if (appDetailsInfo) {
        [viewRight setHidden:NO];
        [scrollVRecommend setHidden:NO];
        
        [self layRightViewContetnAppRecommendInput];
    }
}

-(void)requestAppWithListAndRecommendListWith:(NSString *)strType{
    arrAppDetailsCW = nil;
    [RSHTTPMANAGER showActivityView:YES];
    
    [RSHTTPMANAGER requestAppInfoRWDWithAppID:appDetailsInfo.application_id userId:userId WithType:strType WithPage:@"0" WithSuccess:^(NSArray *appInfoRWDList) {
        
        NSLog(@"appleId_: %@",appDetailsInfo.application_id);
        
        if ([appInfoRWDList count] > 0) {
            arrAppDetailsCW = [NSMutableArray arrayWithArray:appInfoRWDList];
        }
        toolBar.userInteractionEnabled = YES;
        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@".....%@",error.localizedDescription);
    }];
}
-(void)appPriceChangeList:(id)sender{
    if (appDetailsInfo) {
        [viewRight setHidden:NO];
        [_tableVPrice setHidden:NO];
        [self layRightViewContetnWithAppPriceChangeList:nil];
        self.showAppPriceList = SHOWPRICELIST;
        [arrPriceChangeList removeAllObjects];
        [RSHTTPMANAGER showActivityView:YES];
        [RSHTTPMANAGER requestAppPriceChangeWitiAppId:appDetailsInfo.application_id WithSuccess:^(NSArray *arrPriceList) {
//            DLog(@"appPriceList=%@",[(AppPrice *)[arrPriceList objectAtIndex:0] pricing_time]);
            arrPriceChangeList = [NSMutableArray arrayWithArray:arrPriceList];
            
            [_tableVPrice reloadData];
        } failure:^(NSError *_err) {
            
        }];
        
        [RSHTTPMANAGER requestAppPriceStatisticWitiAppId:appDetailsInfo.application_id WithSuccess:^(AppPriceStatistic *appPriceStatistic) {
            [lblAppPriceDes1 setText:[NSString stringWithFormat:@"历史最低价: %@",[[appPriceStatistic priceMin] intValue] > 0 ? [appPriceStatistic priceMin] : @"免费"]];
            [lblAppPriceDes2 setText:[NSString stringWithFormat:@"历史最高价: %@元",[appPriceStatistic priceMax] ? [appPriceStatistic priceMax] : @"0"]];
            [lblAppPriceDes3 setText:[NSString stringWithFormat:@"限时免费次数: %@次",[appPriceStatistic free] ? [appPriceStatistic free] : @"0"]];
            [lblAppPriceDes4 setText:[NSString stringWithFormat:@"冰点降价(6元): %@次",[appPriceStatistic price_drop] ? [appPriceStatistic price_drop] : @"0"]];
        } failure:^(NSError *_err) {
            
        }];
    }
    
    DLog(@"价格变动");
}

- (IBAction)writeDisscussion:(id)sender {
    DLog(@"转写评论");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
//    [self setScrollBackG:nil];
    _imageScroller = nil;
    _transparentScroller = nil;
    _tableView = nil;
        
    [super viewDidUnload];
}
@end
