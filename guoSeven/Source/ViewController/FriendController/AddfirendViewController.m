//
//  AddfirendViewController.m
//  guoSeven
//
//  Created by zucknet on 12/12/5.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "AddfirendViewController.h"
#import "RSHttpManager.h"
#import "UserModel.h"
#import "UIImageView+AFNetworking.h"
#import "AttentionCell.h"
#import "FriendRootViewController.h"
#import "UserRootViewController.h"
#import "SVProgressHUD.h"


@interface AddfirendViewController ()
@property (nonatomic, retain) NSMutableArray *friendArr;
@property(nonatomic, retain) UITableView *myTableView;
@property(nonatomic, retain) UIImageView* noSearchImg;
@property(nonatomic, retain) UIImageView* errorImg;

@end

@implementation AddfirendViewController
@synthesize searchFriend,friendArr,myTableView,noSearchImg,errorImg;

- (void)hidekeyBoard:(NSNotification *)noti{
    if ([searchFriend isFirstResponder]) {
    }
    [searchFriend resignFirstResponder];
    
}

-(void)showKeyboard:(NSNotification *)noti{
    [searchFriend becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidekeyBoard:) name:@"biedianle" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard:) name:@"showRightToLeft" object:nil];
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.myTableView];
    NSLog(@"...%d",[self.friendArr count]);
    
    [self.navigationItem setHidesBackButton:YES];
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
    [backButton addTarget:self action:@selector(setBackView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    

    
    
    
    UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 250, 44)];
    titleV.backgroundColor = [UIColor clearColor];
    searchFriend = [[UISearchBar alloc]initWithFrame:CGRectMake(-3, 0, 250, 44)];
    searchFriend.delegate=self;
//    searchFriend.clearsContextBeforeDrawing=YES;

    searchFriend.placeholder = @"输入邮箱地址查找好友";
    [[searchFriend.subviews objectAtIndex:1] setBackgroundColor:[UIColor clearColor]];
    
    [[searchFriend.subviews objectAtIndex:0] removeFromSuperview];
    searchFriend.backgroundColor=[UIColor clearColor];
    
    UITextField *searchField0 = nil;
    UIImageView *tmp = [[UIImageView alloc] initWithFrame:CGRectMake(4, 7, 240, 30)];
    tmp.image = [UIImage imageNamed:@"search@2x.png"];
    
    [titleV addSubview:tmp];
    for (UIView* subview  in searchFriend.subviews) {
        // 删除searchBar输入框的背景
        if ([subview isKindOfClass:[UITextField class]]) {
            searchField0 = (UITextField*)subview;
            [searchField0 setBackground:nil];
            [searchField0 setBackgroundColor:[UIColor clearColor]];
            [searchField0 setBorderStyle:UITextBorderStyleNone];
            break;
        }
    }
    
    [titleV addSubview:searchFriend];
    //    [_searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"search@2x.png"] forState:UIControlStateNormal];
    
    self.navigationItem.titleView = titleV;
    
    
    noSearchImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 174)];
    noSearchImg.image = [UIImage imageNamed:@"noSearchFriend.png"];
    noSearchImg.hidden = YES;
    [self.view addSubview:noSearchImg];
    
    errorImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 174)];
    errorImg.image = [UIImage imageNamed:@"error.png"];
    errorImg.hidden = YES;
    [self.view addSubview:errorImg];
    
    [searchFriend becomeFirstResponder];
    
//    self.tableView.backgroundColor=[UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0];
//    self.tableView.backgroundView=nil;
//    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [searchFriend resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchFriend resignFirstResponder];
    [RSHTTPMANAGER requestSearchFriendWithString:searchFriend.text WithPage:@"0" WithSuccess:^(NSArray *friendList) {
        [SVProgressHUD show];
        
        if ([friendList count]) {
            myTableView.hidden = NO;
            noSearchImg.hidden = YES;
            errorImg.hidden = YES;
            self.friendArr = [NSMutableArray arrayWithArray:friendList];
            [self.myTableView reloadData];
            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD dismiss];
            myTableView.hidden = YES;
            noSearchImg.hidden = NO;
            errorImg.hidden = YES;
       }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        myTableView.hidden = YES;
        noSearchImg.hidden = YES;
        errorImg.hidden = NO;
        
    }];
}

-(void)setBackView{
    [SVProgressHUD dismiss];
    [searchFriend resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.friendArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row];//@"Cell";
    
    UserModel *user = [self.friendArr objectAtIndex:indexPath.row];
    AttentionCell *cell = (AttentionCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"AttentionCell" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSLog(@".......user.nick_name:%@",user.nick_name);
    cell.userName.text = user.nick_name;
    cell.userName.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    cell.userName.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    
    CGSize userNameSize = [user.nick_name sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15]];
    cell.userName.frame = CGRectMake(cell.userName.frame.origin.x, cell.userName.frame.origin.y, userNameSize.width, userNameSize.height);
    cell.usertLocation.text = user.details;
    cell.usertLocation.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    cell.usertLocation.textColor = [UIColor colorWithRed:187.0/255 green:187.0/255 blue:187.0/255 alpha:1.0];
    
    CGSize userLocationSize = [user.details sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15]];
    cell.usertLocation.frame = CGRectMake(cell.userName.frame.origin.x + cell.userName.frame.size.width + 10.0f, cell.userName.frame.origin.y, userLocationSize.width, userLocationSize.height);
    
    if (user.signature.length) {
        //        cell.userSignature.text = [NSString stringWithFormat:@"\"%@\"",user.signature];
        cell.userSignature.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        cell.userSignature.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        
        CGSize userSigSize = [user.signature sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
        cell.leftYinIV.hidden = NO;
        cell.userSignature.text = [NSString stringWithFormat:@"%@",user.signature];
        
        if (userSigSize.width > 190.0) {
            cell.userSignature.frame = CGRectMake(cell.leftYinIV.frame.origin.x + cell.leftYinIV.frame.size.width, cell.userSignature.frame.origin.y, 190.0, userSigSize.height);
        }else{
            cell.userSignature.frame = CGRectMake(cell.leftYinIV.frame.origin.x + cell.leftYinIV.frame.size.width, cell.userSignature.frame.origin.y, userSigSize.width, userSigSize.height);
        }
        cell.rightYinIV.hidden = NO;
        cell.rightYinIV.frame = CGRectMake(cell.userSignature.frame.origin.x + cell.userSignature.frame.size.width, cell.rightYinIV.frame.origin.y, 14, 14);
        
        
        
    }else{
        cell.userSignature.text = @"";
    }
    //    CGSize userSignatureSize = [user.signature sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
    //    cell.userSignature.frame = CGRectMake(cell.userSignature.frame.origin.x, cell.userSignature.frame.origin.y, userSignatureSize.width, userSignatureSize.height);
    cell.userName.center = CGPointMake(cell.userName.center.x, 22);
    cell.usertLocation.center = CGPointMake(cell.usertLocation.center.x, 22);
    
    
    [cell.userIcon setImageWithURL:[NSURL URLWithString:user.img_path] placeholderImage:[UIImage imageNamed:@"hi"]];
    [cell.customView setIndex:indexPath.row];
    cell.customView.delegate = self;
    return cell;
}

- (void)touchesBeganWithIndex:(int) index{
    AttentionCell *cell = (AttentionCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    cell.backGroundView.backgroundColor = [UIColor lightGrayColor];
}
- (void)touchesCancelWithIndex:(int) index{
    
}
- (void)touchesEndWithIndex:(int) index{
    AttentionCell *cell = (AttentionCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    cell.backGroundView.backgroundColor = [UIColor whiteColor];
    
    
    //    FriendRootViewController *friendRootVc = [[FriendRootViewController alloc]init];
    //
    ////    friendRootVc.friend_id = [[self.dataArr objectAtIndex:index]objectForKey:@"uid"];
    //
    //    [self.navigationController pushViewController:friendRootVc animated:YES];
    UserModel *user = [self.friendArr objectAtIndex:index];
    
    UserRootViewController *userRootVc = [[UserRootViewController alloc]init];
    userRootVc.uuid = user.uid;
    //    friendRootVc.friend_id = [[self.dataArr objectAtIndex:index]objectForKey:@"uid"];
    
    [self.navigationController pushViewController:userRootVc animated:YES];
}
- (void)touchesMoveWithIndex:(int) index{
    
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendRootViewController *friendRootVc = [[FriendRootViewController alloc]init];
    
    //    friendRootVc.friend_id = [[self.dataSorce objectAtIndex:indexPath.row]objectForKey:@"uid"];
    
    [self.navigationController pushViewController:friendRootVc animated:YES];
}

@end
