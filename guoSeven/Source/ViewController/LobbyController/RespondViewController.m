//
//  RespondViewController.m
//  guoSeven
//
//  Created by David on 13-1-15.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "RespondViewController.h"
#import "UIImageView+AFNetworking.h"
#import "DAKeyboardControl.h"
#import "RSHttpManager.h"
#import "AppInfoRWDModel.h"
#import "RespondCell.h"
#import "UIImageView+AFNetworking.h"
#import "RSHttpManager.h"
#import "SVPullToRefresh.h"
#import "SVProgressHUD.h"
#import "AppsDetailsViewController.h"

@interface RespondViewController ()
@property (nonatomic, retain) UILabel *zanLabel;
@property (nonatomic, retain) UILabel *respondLabel;
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray *dataArr;
@property (nonatomic, retain) UIImageView *chatView;
@property (nonatomic, retain) UITextField *tf;
@property (nonatomic, assign) BOOL isPop;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, retain) NSString *currentUID;
@property (nonatomic, assign) int page;
@property (nonatomic, retain) UIView *backView;
@end

@implementation RespondViewController
@synthesize squareModle;
@synthesize zanLabel, respondLabel;
@synthesize myTableView;
@synthesize dataArr;
@synthesize chatView;
@synthesize tf;
@synthesize isPop;
@synthesize animationDuration;
@synthesize currentUID;
@synthesize page;
@synthesize backView;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[self.navigationController navigationBar] setFrame:CGRectMake(0.f, 20.f, 320.f, 44.f)];

}

- (void)hideKeyboardTTT:(NSNotification *)noti{
//    if ([self.tf isFirstResponder]) {
//        [self.tf resignFirstResponder];
//    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboardTTT:) name:@"showRightToLeft" object:nil];
    
    
    self.page = 2;
    self.currentUID = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUID]];

    UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(20, 3, 45, 28)];
    UILabel *leftlab=[[UILabel alloc]initWithFrame:CGRectMake(14, 3, 24, 20)];
    leftlab.text=@"返回";
    leftlab.backgroundColor=[UIColor clearColor];
    [leftlab setTextColor:[UIColor whiteColor]];
    leftlab.font=[UIFont fontWithName:@"Helvetica-Bold" size:12];
    [backButton addSubview:leftlab];
    [backButton setBackgroundImage:[UIImage imageNamed:@"icontop-back@2x.png"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"icontop-back2@2x.png"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(backToPreVC:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    self.title =@"回应";
    
//    if ([self.squareModle.action_type_id intValue] == 3) {
//        self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 45)];
//
//    }else{
        self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 88)];
//        [self setChatView];
//    }
    [self setCustomTopIMV];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsHorizontalScrollIndicator=FALSE;
    self.myTableView.showsVerticalScrollIndicator=FALSE;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.myTableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.myTableView];
//
    [self.myTableView addPullToRefreshWithActionHandler:^{
        NSLog(@"开始加载");    
        [RSHTTPMANAGER requestResponseListWithEvent_id:self.squareModle.event_id WithPage:@"1" WithSuccess:^(NSArray *appInfoRWDList) {
            if ([appInfoRWDList count]) {
                self.respondLabel.text = [NSString stringWithFormat:@"%d回应",[appInfoRWDList count]];
                
                CGSize sizeOfResp = [self.respondLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                
                self.respondLabel.frame = CGRectMake(self.zanLabel.frame.origin.x + self.zanLabel.frame.size.width + 5, 17, sizeOfResp.width, sizeOfResp.height);
                self.zanLabel.center = CGPointMake(self.zanLabel.center.x, self.respondLabel.center.y - 1);

                self.dataArr = [NSMutableArray arrayWithArray:appInfoRWDList];
                [self.myTableView reloadData];
                self.page = 2;
            }
            [self.myTableView.pullToRefreshView stopAnimating];
            if ([appInfoRWDList count] < 10) {
                self.myTableView.infiniteScrollingView.enabled = NO;
            }else{
                self.myTableView.infiniteScrollingView.enabled = YES;
            }
        } failure:^(NSError *error) {
            [self.myTableView.pullToRefreshView stopAnimating];
            self.myTableView.infiniteScrollingView.enabled = YES;
        }];
    }];
   
    [self.myTableView addInfiniteScrollingWithActionHandler:^{
        NSLog(@"加载更多");        
        UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        la.text = @"正在加载更多";
        la.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        
        la.textAlignment = NSTextAlignmentCenter;
        
        self.myTableView.tableFooterView = la;

        [RSHTTPMANAGER requestResponseListWithEvent_id:self.squareModle.event_id WithPage:[NSString stringWithFormat:@"%d",self.page] WithSuccess:^(NSArray *appInfoRWDList) {
            if ([appInfoRWDList count]) {
                [self.dataArr addObjectsFromArray:appInfoRWDList];
                self.respondLabel.text = [NSString stringWithFormat:@"%d回应",[self.dataArr count]];
                
                CGSize sizeOfResp = [self.respondLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                
                self.respondLabel.frame = CGRectMake(self.zanLabel.frame.origin.x + self.zanLabel.frame.size.width + 5, 17, sizeOfResp.width, sizeOfResp.height);
                self.zanLabel.center = CGPointMake(self.zanLabel.center.x, self.respondLabel.center.y);

                [self.myTableView reloadData];
                self.page ++;
                if ([appInfoRWDList count] < 10) {
                    self.myTableView.infiniteScrollingView.enabled = NO;
                }else{
                    self.myTableView.infiniteScrollingView.enabled = YES;
                }
            }else{
                UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
                la.text = @"已没有更多内容";
                la.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
                
                la.textAlignment = NSTextAlignmentCenter;
                
                self.myTableView.tableFooterView = la;

                self.myTableView.infiniteScrollingView.enabled = NO;
            }
            [self performSelector:@selector(hideFootView) withObject:nil afterDelay:1];

            [self.myTableView.infiniteScrollingView stopAnimating];
        } failure:^(NSError *error) {
            [self performSelector:@selector(hideFootView) withObject:nil afterDelay:1];
            [self.myTableView.infiniteScrollingView stopAnimating];
        }];
        
    }];
//    [self.myTableView triggerPullToRefresh];
    [self getData];

    
    
    UIImageView *toolBar = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,
                                                                     self.view.bounds.size.height - 45.0f,
                                                                     self.view.bounds.size.width,
                                                                     45.0f)];
    toolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;

    toolBar.image = [UIImage imageNamed:@"chatTalk.png"];
    toolBar.userInteractionEnabled = YES;
    [self.view addSubview:toolBar];
    
    self.tf= [[UITextField alloc] initWithFrame:CGRectMake(15.0f,
                                                                           12.0f,
                                                                           toolBar.bounds.size.width - 20.0f - 75.0f,
                                                                           30.0f)];
    self.tf.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.tf.backgroundColor = [UIColor clearColor];
    self.tf.placeholder = @"随便说点什么吧...";
    [self.tf setFont:[UIFont systemFontOfSize:14.f]];
    [toolBar addSubview:self.tf];
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [sendButton setImage:[UIImage imageNamed:@"submitBtn"] forState:UIControlStateNormal];
    sendButton.frame = CGRectMake(toolBar.bounds.size.width - 68.0f,
                                  8.0f,
                                  62.0f,
                                  28.0f);
    [sendButton addTarget:self action:@selector(subMitClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [toolBar addSubview:sendButton];
    
    
    self.view.keyboardTriggerOffset = toolBar.bounds.size.height;
    
    [self.view addKeyboardPanningWithActionHandler:^(CGRect keyboardFrameInView) {
        
        CGRect toolBarFrame = toolBar.frame;
        toolBarFrame.origin.y = keyboardFrameInView.origin.y - toolBarFrame.size.height;
        toolBar.frame = toolBarFrame;
        
        CGRect tableViewFrame = self.myTableView.frame;
        tableViewFrame.size.height = toolBarFrame.origin.y;
        self.myTableView.frame = tableViewFrame;
    }];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];

}
- (void)keyboardWillShow:(NSNotification *)notification{
    self.myTableView.infiniteScrollingView.enabled = NO;
    [UIView animateWithDuration:animationDuration animations:^{
        if (self.myTableView.contentSize.height > self.myTableView.frame.size.height) {
            if ([self.dataArr count]) {
                [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(self.dataArr.count - 1) inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
        }else{
            
        }
    }];
}

- (void)keyboardDidHide:(NSNotification *)notification{
//    self.myTableView.infiniteScrollingView.enabled = YES;

}

- (void)keyboardChangeFrame:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
    //    CGSize keyboard = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSValue *animationDurationValue = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    [animationDurationValue getValue:&animationDuration];

}

- (void)hideFootView{
//    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
//    la.text = @"";
//    la.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
//    
//    la.textAlignment = NSTextAlignmentCenter;
    
    self.myTableView.tableFooterView = nil;
//    if (self.myTableView.contentSize.height > self.myTableView.frame.size.height) {
//        [self.myTableView setContentOffset:CGPointMake(0, self.myTableView.contentOffset.y - 60) animated:YES];
//    }
    
}



-(void)getData{
    [SVProgressHUD show];
    [RSHTTPMANAGER requestResponseListWithEvent_id:self.squareModle.event_id WithPage:@"1" WithSuccess:^(NSArray *appInfoRWDList) {
        if ([appInfoRWDList count]) {
            self.respondLabel.text = [NSString stringWithFormat:@"%d回应",[appInfoRWDList count]];
            
            CGSize sizeOfResp = [self.respondLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
            
            self.respondLabel.frame = CGRectMake(self.zanLabel.frame.origin.x + self.zanLabel.frame.size.width + 5, 17, sizeOfResp.width, sizeOfResp.height);
            self.zanLabel.center = CGPointMake(self.zanLabel.center.x, self.respondLabel.center.y);
            
            self.dataArr = [NSMutableArray arrayWithArray:appInfoRWDList];
            [self.myTableView reloadData];
            self.page = 2;
        }
        if ([appInfoRWDList count] < 10) {
            self.myTableView.infiniteScrollingView.enabled = NO;
        }else{
            self.myTableView.infiniteScrollingView.enabled = YES;
        }
        [SVProgressHUD dismiss];
        [self.myTableView.pullToRefreshView stopAnimating];
    } failure:^(NSError *error) {
        [self.myTableView.pullToRefreshView stopAnimating];
        self.myTableView.infiniteScrollingView.enabled = NO;
        [SVProgressHUD dismiss];
    }];
}



-(void)backToPreVC:(id)sender{
    self.isPop = YES;
    [self.tf resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (CGSize)customLableSizeWithString:(NSString *)str{
    UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    CGSize size = CGSizeMake(220, 1000);
    CGSize labelsize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    return labelsize;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppInfoRWDModel *app = [self.dataArr objectAtIndex:indexPath.row];
    NSString *tmp = [NSString stringWithFormat:@"%@",app.content];
    if (tmp.length) {
        CGSize s = [self customLableSizeWithString:app.content];
        if ((25 + s.height + 10) > 55) {
            return 25 + s.height + 10 ;
        }
        return 55 ;
    }
    return 55;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row];//@"Cell";
    
    AppInfoRWDModel *app = [self.dataArr objectAtIndex:indexPath.row];
//    NSLog(@"/////////%@",app.event_id);
    RespondCell *cell = (RespondCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"RespondCell" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
//    NSLog(@"app.user.nick_name:%@",app.user.nick_name);
//    NSLog(@"app.img_path：%@",app.img_path);
    [cell.userIcon setImageWithURL:[NSURL URLWithString:app.img_path] placeholderImage:[UIImage imageNamed:@"hi"]];
    cell.userIcon.frame = CGRectMake(cell.userIcon.frame.origin.x, cell.userIcon.frame.origin.y, 35, 35);
    
    cell.userIcon.center = CGPointMake(cell.userIcon.center.x - 12, cell.userIcon.center.y);
//    cell.userName.text = app.user.nick_name;
    cell.userName.text = app.nick_name;
    cell.userName.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    cell.userName.backgroundColor = [UIColor clearColor];
    cell.userName.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    
    
    cell.userName.center = CGPointMake(cell.userName.center.x - 11, cell.userName.center.y);
    
    
    cell.timeLabel.backgroundColor = [UIColor clearColor];
//    NSLog(@"app.user.create_datetime:%@",app.user.create_datetime);
    cell.timeLabel.text = [[NSString stringWithFormat:@"%@",app.create_time] substringWithRange:NSMakeRange(5, 11)];

    cell.contentLabel.backgroundColor = [UIColor clearColor];
    NSString *tmp = [NSString stringWithFormat:@"%@", app.content];
    if (tmp.length) {
        cell.contentLabel.text = app.content;
        [cell.contentLabel setNumberOfLines:0];
        cell.contentLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        CGSize s = [self customLableSizeWithString:app.content];
        cell.contentLabel.frame = CGRectMake(cell.contentLabel.frame.origin.x, cell.contentLabel.frame.origin.y, cell.contentLabel.frame.size.width, s.height);
        cell.contentLabel.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        
        if (25 + s.height + 10 > 55) {
//            cell.backView.frame = CGRectMake(cell.backView.frame.origin.x, cell.backView.frame.origin.y, cell.backView.frame.size.width, 25 + s.height + 5);
            cell.bottomLine.frame = CGRectMake(0, cell.bottomLine.frame.origin.y + 10 + 25 + s.height - 55 - 1, 320, 1);
        }
    }
    cell.contentLabel.center = CGPointMake(cell.contentLabel.center.x - 11, cell.contentLabel.center.y);

    cell.userName.textColor = cell.contentLabel.textColor = cell.timeLabel.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    

    return cell;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (CGSize)customLableSizeWithTop:(NSString *)str{
    UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    CGSize size = CGSizeMake(250, 1000);
    CGSize labelsize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    return labelsize;
}

- (void)setCustomTopIMV{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 115)];
    iv.image = [UIImage imageNamed:@"MasterUP.png"];
    //   110 78 510 142
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(55, 39, 510/2, 142/2)];
    self.backView.backgroundColor = [UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1.0];

    [iv addSubview:self.backView];
    
    UIImageView *userIconLeft = [[UIImageView alloc] initWithFrame:CGRectMake(11, 13, 35, 35)];
    [userIconLeft setImageWithURL:[NSURL URLWithString:self.squareModle.img_path] placeholderImage:[UIImage imageNamed:@"hi"]];
    
    [iv addSubview:userIconLeft];

    
    
    UILabel *userName = [[UILabel alloc] init];
    userName.text = self.squareModle.nick_name;
    userName.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    userName.backgroundColor = [UIColor clearColor];
    userName.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    
    CGSize userNameSize = [self.squareModle.nick_name sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    userName.frame = CGRectMake(56, 10, userNameSize.width, userNameSize.height);
    [iv addSubview:userName];
    
    UILabel *actionTypeNameLable = [[UILabel alloc] init];
    actionTypeNameLable.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    actionTypeNameLable.backgroundColor = [UIColor clearColor];
    actionTypeNameLable.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
    
    UIImageView *appIcon = [[UIImageView alloc] initWithFrame:CGRectMake(65, 50, 50, 50)];
    UILabel *appName = [[UILabel alloc] init];
    appName.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    appName.backgroundColor = [UIColor clearColor];
    appName.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    UILabel *appType = [[UILabel alloc] init];
    appType.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    appType.backgroundColor = [UIColor clearColor];
    appType.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
    
//    if ([self.squareModle.action_type_id intValue] == 3) {
//    NSLog(@"self.squareModle.obj_action_type_name:%@",self.squareModle.obj_action_type_name);
//        actionTypeNameLable.text = self.squareModle.obj_action_type_name;
//        CGSize obj_action_type_nameSize = [self.squareModle.obj_action_type_name sizeWithFont:[UIFont fontWithName:@"Helvetica" size:15]];
//        actionTypeNameLable.frame = CGRectMake(userName.frame.origin.x + userName.frame.size.width + 5, 10, obj_action_type_nameSize.width,obj_action_type_nameSize.height);
//         [appIcon setImageWithURL:[NSURL URLWithString:self.squareModle.obj_img_path] placeholderImage:[UIImage imageNamed:@"hi"]];
//        
//        appName.text = [NSString stringWithFormat:@"%@",self.squareModle.obj_nick_name];
//        UILabel *objUserLocation = [[UILabel alloc] init];
//        objUserLocation.backgroundColor = [UIColor clearColor];
//        objUserLocation.font =  [UIFont fontWithName:@"Helvetica" size:13];
//        objUserLocation.text = [NSString stringWithFormat:@"%@",self.squareModle.obj_location];
//        
//        CGSize sizeOfobjUserName = [self.squareModle.obj_nick_name sizeWithFont:[UIFont fontWithName:@"Helvetica" size:15]];
//        appName.frame = CGRectMake(134, 48, sizeOfobjUserName.width, sizeOfobjUserName.height);
//        
//        CGSize sizeOfobjUserLocation = [self.squareModle.obj_location sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
//        objUserLocation.frame = CGRectMake(appName.frame.origin.x + appName.frame.size.width + 5, appName.frame.origin.y, sizeOfobjUserLocation.width, sizeOfobjUserLocation.height);
//        [iv addSubview:objUserLocation];
//        if (!self.squareModle.obj_signature.length) {
//            appType.text = @"";
//        }else{
//            appType.text = [NSString stringWithFormat:@"\"%@\"",self.squareModle.obj_signature];
//            CGSize appTypeSize = [appType.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
//            appType.frame = CGRectMake(138, 72, appTypeSize.width, appTypeSize.height);
//        }
//        
//    }else{
        NSLog(@"self.squareModle.application_action_type_name:%@",self.squareModle.application_action_type_name);
        actionTypeNameLable.text = self.squareModle.application_action_type_name;
        
        CGSize application_action_type_nameSize = [self.squareModle.application_action_type_name sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15]];
        actionTypeNameLable.frame = CGRectMake(userName.frame.origin.x + userName.frame.size.width + 5, 10, application_action_type_nameSize.width,application_action_type_nameSize.height);
     [appIcon setImageWithURL:[NSURL URLWithString:self.squareModle.application_artwork_url_small] placeholderImage:[UIImage imageNamed:@"hi"]];
        
        
        CGSize appNameSize = [self.squareModle.application_title sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15]];
        appName.text = self.squareModle.application_title;
        if (appNameSize.width > 120) {
            appName.frame = CGRectMake(127, 48, 120, appNameSize.height);
        }else{
            appName.frame = CGRectMake(127, 48, appNameSize.width, appNameSize.height);
        }
        
        CGSize appTypeSize = [[NSString stringWithFormat:@"%@ / %@", self.squareModle.primary_genre_name, self.squareModle.supported_device_name] sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
        appType.text = [NSString stringWithFormat:@"%@ / %@", self.squareModle.primary_genre_name, self.squareModle.supported_device_name];
        appType.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        appType.frame = CGRectMake(127, 72, appTypeSize.width, appTypeSize.height);
       
        
        UILabel *appPrice = [[UILabel alloc] initWithFrame:CGRectMake(263, 48, 42, 21)];
        appPrice.textAlignment = NSTextAlignmentRight;
        appPrice.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
        appPrice.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        
        appPrice.backgroundColor = [UIColor clearColor];
        UIImageView *appPriceIV = [[UIImageView alloc] initWithFrame:CGRectMake(245, 73, 58, 19)];
        
//        if ([[NSString stringWithFormat:@"%@",self.squareModle.application_retail_price] isEqualToString:@"免费"]) {
//            appPrice.text = [NSString stringWithFormat:@"%@",self.squareModle.application_retail_price];
//            [appPriceIV setImage:[UIImage imageNamed:@"appForFree.png"]];
//        }else{
//            appPrice.text = [NSString stringWithFormat:@"￥%@",self.squareModle.application_retail_price];
//            if ([self.squareModle.application_retail_price floatValue] > [self.squareModle.application_old_price floatValue]) {
//                [appPriceIV setImage:[UIImage imageNamed:@"appForUPrice.png"]];
//            }else if ([self.squareModle.application_retail_price floatValue] < [self.squareModle.application_old_price floatValue]){
//                [appPriceIV setImage:[UIImage imageNamed:@"appForDPrice.png"]];
//            }else{
//                
//            }
//        }
        
        if ([[NSString stringWithFormat:@"%@",self.squareModle.application_retail_price] isEqualToString:@"免费"]) {
            appPrice.text = [NSString stringWithFormat:@"%@",self.squareModle.application_retail_price];
//            [appPriceIV setImage:[UIImage imageNamed:@"apptip1.png.png"]];
        }else{
            appPrice.text = [NSString stringWithFormat:@"￥%d",[self.squareModle.application_retail_price intValue]];
//            if ([self.squareModle.application_retail_price floatValue] > [self.squareModle.application_old_price floatValue]) {
//                [appPriceIV setImage:[UIImage imageNamed:@"apptip5"]];
//            }else if ([self.squareModle.application_retail_price floatValue] < [self.squareModle.application_old_price floatValue]){
//                [appPriceIV setImage:[UIImage imageNamed:@"apptip3.png"]];
//            }else{
//                
//            }
        }
        
        if ([self.squareModle.limited_state_name isEqualToString:@"首次限免"]) {
            [appPriceIV setImage:[UIImage imageNamed:@"apptip1.png"]];
        }else if ([self.squareModle.limited_state_name isEqualToString:@"多次限免"]){
            [appPriceIV setImage:[UIImage imageNamed:@"apptip2.png"]];
        }else if ([self.squareModle.limited_state_name isEqualToString:@"首次冰点"]){
            [appPriceIV setImage:[UIImage imageNamed:@"apptip3.png"]];
        }else if ([self.squareModle.limited_state_name isEqualToString:@"再次冰点"]){
            [appPriceIV setImage:[UIImage imageNamed:@"apptip4.png"]];
        }else if ([self.squareModle.limited_state_name isEqualToString:@"涨价"]){
            [appPriceIV setImage:[UIImage imageNamed:@"apptip5.png"]];
        }
        CGSize priceSize = [appPrice.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15]];

        appPrice.frame = CGRectMake(appPrice.frame.origin.x, 59, priceSize.width, priceSize.height);
    
        appPrice.center = CGPointMake(appPriceIV.center.x, appName.center.y);

        [iv addSubview:appPrice];
        [iv addSubview:appPriceIV];
//    }

    [iv addSubview:appType];
    [iv addSubview:actionTypeNameLable];
    [iv addSubview:appName];
    [iv addSubview:appIcon];
    
    [topView addSubview:iv];
    
   
    
    CGSize ss = [self customLableSizeWithTop:self.squareModle.content];

     UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.backView.frame.origin.x, self.backView.frame.origin.y + self.backView.frame.size.height + 15, ss.width, ss.height)];
    countLabel.text = self.squareModle.content;
    [countLabel setNumberOfLines:0];
    countLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    countLabel.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    [topView addSubview:countLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 35)];
    timeLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    timeLabel.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
    
    timeLabel.textAlignment = NSTextAlignmentRight;
    NSLog(@"self.squareModle.create_time:%@",self.squareModle.create_time);
    timeLabel.text= [self.squareModle.create_time substringWithRange:NSMakeRange(5, 11)];
    CGSize timeSize = [timeLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
    timeLabel.frame = CGRectMake(310 - timeSize.width, countLabel.frame.origin.y + countLabel.frame.size.height + 15 , timeSize.width, timeSize.height);
    
    [topView addSubview:timeLabel];
    
    UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, timeLabel.frame.origin.y + timeLabel.frame.size.height + 15, 320, 50)];
//    iv2.image = [UIImage imageNamed:@"respondCell"];
    iv2.backgroundColor = [UIColor whiteColor];
    
    iv2.userInteractionEnabled = YES;
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, 320, 1)];
    line.image = [UIImage imageNamed:@"respondBottomLine.png"];
    [iv2 addSubview:line];
    
    self.zanLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 15, 30)];
    self.zanLabel.textColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
    self.zanLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    
    NSString *tmp = [NSString stringWithFormat:@"%@",self.squareModle.like_count_str];
    if (tmp.length) {
        if ([self.squareModle.like_count_str intValue] == 0) {
            self.zanLabel.text = @"0赞";
        }else{
            self.zanLabel.text = [NSString stringWithFormat:@"%@赞",self.squareModle.like_count_str];
        }
    }else{
        self.zanLabel.text = @"0赞";
    }
    
    
    
    
    
    
//    self.zanLabel.text = @"赞";
    CGSize sizeOfZan = [self.zanLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];

    self.zanLabel.frame = CGRectMake(10, 17, sizeOfZan.width, sizeOfZan.height);
    
    self.zanLabel.backgroundColor = [UIColor clearColor];
    
    self.respondLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.zanLabel.frame.origin.x + self.zanLabel.frame.size.width + 5, 10, 30, 30)];
    self.respondLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
//    self.respondLabel.text = @"回应";
    NSString *countResponse = [NSString stringWithFormat:@"%@",self.squareModle.response_count_str];
    if (countResponse.length) {
        if ([countResponse intValue] == 0) {
            self.respondLabel.text = @"0回应";
        }else{
            self.respondLabel.text = [NSString stringWithFormat:@"%d回应",[countResponse intValue]];
        }
    }else{
        self.respondLabel.text = @"0回应";
    }
    
    
    self.respondLabel.backgroundColor = [UIColor clearColor];
    self.respondLabel.textColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
    [iv2 addSubview:self.zanLabel];
    [iv2 addSubview:self.respondLabel];
    
//    CGSize sizeOfZan = [self.zanLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
    CGSize sizeOfResp = [self.respondLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
    
    self.respondLabel.frame = CGRectMake(self.zanLabel.frame.origin.x + self.zanLabel.frame.size.width + 5, 17, sizeOfResp.width, sizeOfResp.height);
//    UIImageView *zanIV =[[UIImageView alloc] initWithFrame:CGRectMake(260, 10, 51, 26)];
//    zanIV.image = [UIImage imageNamed:@"zan.png"];
    
    UIButton *zanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zanBtn setImage:[UIImage imageNamed:@"zan.png"] forState:UIControlStateNormal];
    [zanBtn setImage:[UIImage imageNamed:@"zan.png"] forState:UIControlStateHighlighted];
    
    [zanBtn setFrame:CGRectMake(260, 12, 51, 26)];
    [zanBtn addTarget:self action:@selector(zanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    

//    [iv2 addSubview:zanIV];
    [iv2 addSubview:zanBtn];
    
    self.respondLabel.center = CGPointMake(self.respondLabel.center.x, zanBtn.center.y);
    
    self.zanLabel.center = CGPointMake(self.zanLabel.center.x, self.respondLabel.center.y);

    
    
    [topView addSubview:iv2];
    
    topView.frame = CGRectMake(0, 0, 320, iv2.frame.origin.y + iv2.frame.size.height);
    
    CustomView *customView = [[CustomView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
    customView.delegate = self;
    customView.backgroundColor = [UIColor clearColor];
    [topView addSubview:customView];
    [self.myTableView setTableHeaderView:topView];
    
    self.isPop = NO;
}


- (void)touchesBeganWithIndex:(int)index{
    NSLog(@"begin");
    self.backView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
    
}

- (void)touchesCancelWithIndex:(int)index{
    self.backView.backgroundColor = [UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1.0];

}

- (void)touchesEndWithIndex:(int)index{
    self.backView.backgroundColor = [UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1.0];
    AppsDetailsViewController *appsVc = [[AppsDetailsViewController alloc] init];
    appsVc.sqModel = self.squareModle;
    [appsVc.sqModel setApplication_retail_price:[NSString stringWithFormat:@"%d",[self.squareModle.application_retail_price integerValue]]];
    //    if (IS_IPHONE5) {
    //        appsVc = [appsVc initWithNibName:@"AppsDetailsViewController_iPhone5" bundle:nil];
    //    }else{
    //        appsVc = [appsVc initWithNibName:@"AppsDetailsViewController_Normal" bundle:nil];
    //    }
    //    DLog(@"self.squarArr==%@  sqModel==%@",self.squarArr,sqModel.application_id);
    [appsVc setApplication_id:self.squareModle.application_id];
    [self.navigationController pushViewController:appsVc animated:YES];
}


- (void)touchesMoveWithIndex:(int)index{
    self.backView.backgroundColor = [UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1.0];

}

- (void)zanBtnClick:(id)sender{
    NSLog(@"......");
    
    NSString *tmp = [NSString stringWithFormat:@"%@",self.squareModle.is_like];

    if ([tmp intValue]) {
        [RSHTTPMANAGER showActivityView:YES];
        [RSHTTPMANAGER requestUnZanWithEvent_id:self.squareModle.event_id WithUid:self.currentUID WithSuccess:^(BOOL isSuccess) {
            if (isSuccess) {
                [delegate refreshData];
                self.squareModle.is_like = @"0";
                int amount = [[NSString stringWithFormat:@"%@",self.squareModle.like_count_str] integerValue] ;
                NSLog(@"////////%d",amount);
                amount --;
                if (amount < 0) {
                    amount = 0;
                }
                self.squareModle.like_count_str = [NSString stringWithFormat:@"%d", amount];

                self.zanLabel.text = [NSString stringWithFormat:@"%d赞",amount];;
                CGSize sizeOfZan = [self.zanLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                
                self.zanLabel.frame = CGRectMake(10, 17, sizeOfZan.width, sizeOfZan.height);
                CGSize sizeOfResp = [self.respondLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                
                self.respondLabel.frame = CGRectMake(self.zanLabel.frame.origin.x + self.zanLabel.frame.size.width + 5, 17, sizeOfResp.width, sizeOfResp.height);
                self.zanLabel.center = CGPointMake(self.zanLabel.center.x, self.respondLabel.center.y);
//                [SVProgressHUD showSuccessWithStatus:@"取消赞成功"];
                
            }else{
//                [SVProgressHUD showErrorWithStatus:@"取消赞失败"];
                
            }
            
        } failure:^(NSError *error) {
            
        }];
    }else{
        
        [RSHTTPMANAGER requestZanWithEvent_id:self.squareModle.event_id WithUid:self.currentUID WithSuccess:^(BOOL isSuccess) {
            if (isSuccess) {
                [delegate refreshData];

                self.squareModle.is_like = @"1";
                int amount = [[NSString stringWithFormat:@"%@",self.squareModle.like_count_str] integerValue] ;
                NSLog(@"////////%d",amount);
                amount ++;
                self.squareModle.like_count_str = [NSString stringWithFormat:@"%d", amount];
                self.zanLabel.text = [NSString stringWithFormat:@"%d赞",amount];;
                CGSize sizeOfZan = [self.zanLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                
                self.zanLabel.frame = CGRectMake(10, 17, sizeOfZan.width, sizeOfZan.height);
                CGSize sizeOfResp = [self.respondLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                
                self.respondLabel.frame = CGRectMake(self.zanLabel.frame.origin.x + self.zanLabel.frame.size.width + 5, 17, sizeOfResp.width, sizeOfResp.height);
                self.zanLabel.center = CGPointMake(self.zanLabel.center.x, self.respondLabel.center.y);
                
                [SVProgressHUD showSuccessWithStatus:@"赞成功"];
            }else{
                [SVProgressHUD showErrorWithStatus:@"赞失败"];
            }
        } failure:^(NSError *error) {
            NSLog(@"..222222222.....%@",error.localizedDescription);
        }];
    }
    
   
}





- (void)subMitClick:(id)sender{
    NSLog(@"submit");
//    if ([self.tf isFirstResponder]) {
//        [self.tf resignFirstResponder];
//    }
    NSLog(@"event_id:%@",self.squareModle.event_id);
    UIButton *tmp = (UIButton *)sender;
    //有问题啊。
    
    if (self.tf.text.length) {
        [SVProgressHUD show];
        tmp.userInteractionEnabled = NO;
        [RSHttpManager requestResponseWithUId:self.currentUID WithEvent_id:self.squareModle.event_id WithContent:self.tf.text WithSuccess:^(BOOL isSuccess) {
            if (isSuccess) {
                self.tf.text = @"";
//                [RSHTTPMANAGER requestAppInfoRWDWithAppID:self.squareModle.application_id WithType:self.squareModle.action_type_id WithPage:@"1" WithSuccess:^(NSArray *appInfoRWDList) {
//                    if ([appInfoRWDList count]) {
//                        self.dataArr = [NSMutableArray arrayWithArray:appInfoRWDList];
//                        [self.myTableView reloadData];
//                    }
//                    
//                    //        self.zanLabel.text =  self.squareModle.
//                    //        self.respondLabel.text =
//                    tmp.userInteractionEnabled = YES;
//
//                } failure:^(NSError *error) {
//                    NSLog(@".....%@",error.localizedDescription);
//                    tmp.userInteractionEnabled = YES;
//
//                }];
                [delegate refreshData];

                [RSHTTPMANAGER requestResponseListWithEvent_id:self.squareModle.event_id WithPage:@"1" WithSuccess:^(NSArray *appInfoRWDList) {
                    [SVProgressHUD showSuccessWithStatus:@"回应成功"];
                    [self.tf resignFirstResponder];
                    [self.tf setText:@""];
                    if ([appInfoRWDList count]) {
                        self.respondLabel.text = [NSString stringWithFormat:@"%d回应",[appInfoRWDList count]];
                        
                        CGSize sizeOfResp = [self.respondLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
                        
                        self.respondLabel.frame = CGRectMake(self.zanLabel.frame.origin.x + self.zanLabel.frame.size.width + 5, 17, sizeOfResp.width, sizeOfResp.height);
                        
                        self.dataArr = [NSMutableArray arrayWithArray:appInfoRWDList];
                        [self.myTableView reloadData];
                        self.page = 2;
                        if ([appInfoRWDList count] < 10) {
                            self.myTableView.infiniteScrollingView.enabled = NO;
                        }else{
                            self.myTableView.infiniteScrollingView.enabled = YES;
                        }
                    }else{
                        self.myTableView.infiniteScrollingView.enabled = NO;
                    }
                    [self.myTableView.pullToRefreshView stopAnimating];
                } failure:^(NSError *error) {
                    [self.myTableView.pullToRefreshView stopAnimating];
                    self.myTableView.infiniteScrollingView.enabled = NO;
                    
                }];

                
            }else{
                [SVProgressHUD showErrorWithStatus:@"回应失败"];
            }
            tmp.userInteractionEnabled = YES;

        } failure:^(NSError *error) {
            NSLog(@"......%@",error);
             tmp.userInteractionEnabled = YES;
        }];    
    }
}



@end
