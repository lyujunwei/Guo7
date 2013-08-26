//
//  iMessageViewController.m
//  GPlay
//
//  Created by zucknet on 12/11/5.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "iMessageViewController.h"
#import "iChatViewController.h"
#import "SVPullToRefresh.h"
#import "UserRootViewController.h"

#import "RSHttpManager.h"
#import "MessageModel.h"
#import "iMessageCell.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"
#import "SVPullToRefresh.h"
#import "SVProgressHUD.h"

@interface iMessageViewController ()
@property (nonatomic, retain) NSMutableArray *dataArr;
@property (nonatomic, retain) UITableView *myTableview;
@property (nonatomic, retain) NSString *currentUID;

@end

@implementation iMessageViewController
//@synthesize tableView=_tableView;
//@synthesize dataSorce;
@synthesize detailViewController=_detailViewController;
@synthesize dataArr;
@synthesize myTableview;
@synthesize currentUID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        rightBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [rightBtn setFrame:CGRectMake(10, 3, 55, 32)];
        UILabel *rightlab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 55, 32)];
        rightlab.text=@"编辑";
        rightlab.backgroundColor=[UIColor clearColor];
        rightlab.textColor=[UIColor whiteColor];
        rightlab.textAlignment=NSTextAlignmentCenter;
        rightlab.font=[UIFont systemFontOfSize:13];
        [rightBtn addSubview:rightlab];
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"icontop-normal@2x.png"] forState:UIControlStateNormal];
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"icontop-normal2@2x.png"] forState:UIControlStateHighlighted];
        [rightBtn addTarget:self action:@selector(editbtn:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        [self.navigationItem setRightBarButtonItem:rightItem];
        
        self.title=@"私信";
        self.view.backgroundColor=[UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1.0];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetImessage:) name:@"imessage" object:nil];
        
//        dataSorce = [TableDataSource MessageInformation];
    }
    return self;
    
}
-(IBAction)editbtn:(id)sender{
//    //    [_tableView setEditing:!_tableView.editing animated:YES];
    [self setEditing:!self.myTableview.editing animated:YES];
}

- (void)resetImessage:(NSNotification *)noti{
    self.myTableview.frame = CGRectMake(0, 20, 320, self.view.frame.size.height - 20);

}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[self.navigationController navigationBar] setFrame:CGRectMake(0.f, 20.f, 320.f, 44.f)];
    
    if ([self.navigationController.viewControllers count] > 1) {
        NSLog(@">>>>>>1");
    }else{
        NSLog(@"<<<<<<<");
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"YES"];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.currentUID = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUID]];

    self.myTableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    self.myTableview.dataSource=self;
    self.myTableview.delegate=self;
    self.myTableview.backgroundColor=[UIColor whiteColor];
    self.myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableview.showsHorizontalScrollIndicator=FALSE;
    self.myTableview.showsVerticalScrollIndicator=FALSE;
    [SVProgressHUD show];
    
    [self.myTableview addPullToRefreshWithActionHandler:^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cleanNum" object:@"5"];
        [RSHttpManager requestMessageListWithUID:self.currentUID WithSuccess:^(NSArray *messageList) {
            if (messageList) {
                self.dataArr = [NSMutableArray arrayWithArray:messageList];
                [self.myTableview reloadData];
                [SVProgressHUD dismiss];
            }
            [self.myTableview.pullToRefreshView stopAnimating];
        } failure:^(NSError *error) {
            NSLog(@"./...%@",error.localizedDescription);
            [self.myTableview.pullToRefreshView stopAnimating];

        }];
    }];
    
    [self.view addSubview:self.myTableview];
    
    [self getData];
    
}

-(void)getData{
        [RSHttpManager requestMessageListWithUID:self.currentUID WithSuccess:^(NSArray *messageList) {
            if (messageList) {
                self.dataArr = [NSMutableArray arrayWithArray:messageList];
                [self.myTableview reloadData];
                [SVProgressHUD dismiss];
            }
            [self.myTableview.pullToRefreshView stopAnimating];
        } failure:^(NSError *error) {
            NSLog(@"./...%@",error.localizedDescription);
            [self.myTableview.pullToRefreshView stopAnimating];
            
        }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!tableView.editing)
        return UITableViewCellEditingStyleNone;
    else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.myTableview setEditing:editing animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        MessageModel *message = [self.dataArr objectAtIndex:indexPath.row];
        [RSHTTPMANAGER requestDelALLMSGWithUID:self.currentUID WithTargetUID:message.obj_uid WithSuccess:^(BOOL isSucceed) {
            if (isSucceed) {
                [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                // Delete the row from the data source.
                [self.dataArr removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
            }else{
                [self setEditing:NO animated:YES];
                [SVProgressHUD showErrorWithStatus:@"删除失败"];
            }
 
        } failure:^(NSError *_err) {
            
        }];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr count];
}

- (CGSize)customLableSizeWithString:(NSString *)str{
    UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    CGSize size = CGSizeMake(240, 1000);
    CGSize labelsize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    return labelsize;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row];//@"Cell";
    
    MessageModel *message = [self.dataArr objectAtIndex:indexPath.row];
    
    iMessageCell *cell = (iMessageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"iMessageCell" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    if (message.uid == NULL) {
        cell.userName.text = message.obj_nick_name;
        [cell.userIcon setImageWithURL:[NSURL URLWithString:message.obj_img_path] placeholderImage:[UIImage imageNamed:@"hi"]];
        
        
    }else if (message.obj_uid == NULL){
        cell.userName.text = message.nick_name;
        [cell.userIcon setImageWithURL:[NSURL URLWithString:message.img_path] placeholderImage:[UIImage imageNamed:@"hi"]];
        
    }
    
        
    
    cell.userMessage.text = message.content;

    cell.userTime.text = [NSString stringWithFormat:@"最后: %@",[message.send_date substringWithRange:NSMakeRange(5, 11)]];
    
    
    cell.userName.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    cell.userName.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    
    CGSize sizeOfName = [cell.userName.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15]];
    cell.userName.frame = CGRectMake(cell.userName.frame.origin.x, cell.userIcon.frame.origin.y - 2, sizeOfName.width, sizeOfName.height);
    
    
    cell.userMessage.font = cell.userTime.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    cell.userMessage.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    CGSize sizeOfMSG = [self customLableSizeWithString:cell.userMessage.text];
    [cell.userMessage setNumberOfLines:0];
    cell.userMessage.frame = CGRectMake(cell.userMessage.frame.origin.x, 15 + 23, sizeOfMSG.width, sizeOfMSG.height);
    
//15 + 23 + sizeOfMSG.height + 8 + sizeOfTime.height + 15 
    
    
    cell.userTime.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    cell.userTime.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];



    CGSize sizeOfTime = [cell.userTime.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
    cell.userTime.frame = CGRectMake(cell.userTime.frame.origin.x, cell.userMessage.frame.origin.y + cell.userMessage.frame.size.height + 8,  sizeOfTime.width, sizeOfTime.height);
    
  
//    cell.userTime.backgroundColor = [UIColor greenColor];
    
    
    cell.backGroundView.frame = CGRectMake(0, 0, 320, cell.userTime.frame.origin.y + cell.userTime.frame.size.height + 15);
    
    cell.customView.frame = cell.backGroundView.frame;
    cell.bottomIV.frame = CGRectMake(0, cell.backGroundView.frame.size.height - 1, 320, 1);

    
    cell.customView.delegate = self;
    [cell.customView setIndex:indexPath.row];
    
     [cell.userBtn addTarget:self action:@selector(userBtnClick: event:) forControlEvents:UIControlEventTouchUpInside];
    
     return cell;

}

-(void)tapAction:(id)sender{
    UserRootViewController *userVC = [[UserRootViewController alloc] init];
    [self.navigationController pushViewController:userVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageModel *message = [self.dataArr objectAtIndex:indexPath.row];
    if (message.content) {
        CGSize sizeOfMSG = [self customLableSizeWithString:message.content];
        CGSize sizeOfTime = [message.send_date sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
        if (15 + 23 + sizeOfMSG.height + 8 + sizeOfTime.height + 15 > 92) {
            return 15 + 23 + sizeOfMSG.height + 8 + sizeOfTime.height + 15;
        }else{
            return 92;
        }
        
    }
    
    return 92;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
}

- (void)touchesBeganWithIndex:(int) index{
    NSLog(@"touchesBeganWithIndex");
    if (!self.myTableview.editing) {
        iMessageCell *cell = (iMessageCell *)[self.myTableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.backGroundView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
    }
}
- (void)touchesCancelWithIndex:(int) index{
    NSLog(@"touchesCancelWithIndex");
    if (!self.myTableview.editing) {
        iMessageCell *cell = (iMessageCell *)[self.myTableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.backGroundView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
    }
}
- (void)touchesEndWithIndex:(int) index{
    NSLog(@"touchesEndWithIndex");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cleanNum" object:@"5"];
    if (!self.myTableview.editing) {
        iMessageCell *cell = (iMessageCell *)[self.myTableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.backGroundView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
        iChatViewController *vContent = [[iChatViewController alloc] init];
        MessageModel *message = [self.dataArr objectAtIndex:index];
        vContent.messageModel = message;
        if (message.uid == NULL) {
            vContent.title = message.obj_nick_name;
        }else if (message.obj_uid == NULL){
            vContent.title = message.nick_name;            
        }
        [self.navigationController pushViewController:vContent animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];

    }
}
- (void)touchesMoveWithIndex:(int) index{
    NSLog(@"touchesMoveWithIndex");
    if (!self.myTableview.editing) {
        iMessageCell *cell = (iMessageCell *)[self.myTableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.backGroundView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
    }
}

- (void)userBtnClick:(id)sender event:(id)event{
    //LeftUser
    NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.myTableview];
    NSIndexPath *indexPath =[self.myTableview indexPathForRowAtPoint:currentTouchPosition];
    NSLog(@"User///,%d",indexPath.row);

    MessageModel *message = [self.dataArr objectAtIndex:indexPath.row];

    if (message.uid == NULL) {        
        UserRootViewController *vc = [[UserRootViewController alloc] init];
        vc.uuid = [NSString stringWithFormat:@"%@",message.obj_uid];
        [self.navigationController pushViewController:vc animated:YES];

    }else if (message.obj_uid == NULL){
        UserRootViewController *vc = [[UserRootViewController alloc] init];
        vc.uuid = [NSString stringWithFormat:@"%@",message.uid];
        [self.navigationController pushViewController:vc animated:YES];        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification object:@"NO"];

}


@end
