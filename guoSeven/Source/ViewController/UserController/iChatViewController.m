//
//  iChatViewController.m
//  GPlay
//
//  Created by zucknet on 12/11/6.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "iChatViewController.h"
#import "DAKeyboardControl.h"
#import "SBJson.h"
#import "UIImageView+AFNetworking.h"
#import "RSHttpManager.h"
#import "iChatViewCell.h"
#import "DialogueModel.h"

@interface iChatViewController ()
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray *dataArr;
@property (nonatomic, retain) UITextField *tf;
@property (nonatomic, retain) NSString *currentUID;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@end

@implementation iChatViewController
//@synthesize user_id;
//@synthesize iChat_dataSorce;
@synthesize detailViewController = _detailViewController;
@synthesize messageModel;
@synthesize myTableView, dataArr;
@synthesize tf;
@synthesize currentUID;
@synthesize animationDuration;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
        
    }
    return self;
}

-(void)setBackView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapHiddenKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tapHiddenKeyboard];
    
    self.currentUID = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUID]];
    
    self.view.backgroundColor=[UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0];
    
    self.myTableView= [[UITableView alloc] initWithFrame:CGRectMake(0.0f,
                                                                    0.0f,
                                                                    self.view.bounds.size.width,
                                                                    self.view.bounds.size.height - 40.0f)];
    self.myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.myTableView.backgroundColor=[UIColor whiteColor];
    //    self.myTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    //    self.myTableView.separatorColor = UITableViewCellSeparatorStyleNone;
    //    self.myTableView.separatorColor = [UIColor clearColor];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsHorizontalScrollIndicator=FALSE;
    self.myTableView.showsVerticalScrollIndicator=FALSE;
    [self.view addSubview:self.myTableView];
    
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
    //    self.tf.borderStyle = UITextBorderStyleRoundedRect;
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
    
    
    
    
    self.view.keyboardTriggerOffset = toolBar.bounds.size.height;
    
    [self.view addKeyboardPanningWithActionHandler:^(CGRect keyboardFrameInView) {
        
        CGRect toolBarFrame = toolBar.frame;
        toolBarFrame.origin.y = keyboardFrameInView.origin.y - toolBarFrame.size.height;
        toolBar.frame = toolBarFrame;
        
        CGRect tableViewFrame = self.myTableView.frame;
        tableViewFrame.size.height = toolBarFrame.origin.y;
        self.myTableView.frame = tableViewFrame;
        //        if (self.myTableView.contentSize.height > self.myTableView.frame.size.height) {
        //            if ([self.dataArr count]) {
        //                [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(self.dataArr.count - 1) inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        //            }
        //        }else{
        //
        //        }
        
        
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    
    NSLog(@"........messageModel.obj_uid.........%@",messageModel.obj_uid);
    NSString *tmpStr;
    if (messageModel.uid == NULL) {
        tmpStr = messageModel.obj_uid;
    }else{
        tmpStr = messageModel.uid;
    }
    
    [RSHttpManager requestDialoguesWithUID:self.currentUID WithUser:tmpStr WithPage:@"0" WithSuccess:^(NSArray *dialogueList) {
        if ([dialogueList count]) {
            NSEnumerator *enumerator = [dialogueList reverseObjectEnumerator];
            self.dataArr = [[NSMutableArray alloc] initWithArray:[enumerator allObjects]];
            
            [self.myTableView reloadData];
            
            [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:([self.dataArr count] - 1) inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)tapAction:(id)sender{
//    [UIView animateWithDuration:animationDuration animations:^{
//        self.myTableView.frame = CGRectMake(0, 0, self.view.bounds.size.width,
//                                            self.view.bounds.size.height - 40.0f);
//        [tf resignFirstResponder];
//    [self.view hideKeyboard];
//
//    } completion:^(BOOL finished) {
//    }];
//    [self.view hideKeyboard];
    
    
}
- (void) keyboardWillHide:(NSNotification *)notification{
//    [UIView animateWithDuration:animationDuration animations:^{
//       self.myTableView.frame = CGRectMake(0, 0, self.view.bounds.size.width,
//                               self.view.bounds.size.height - 40.0f);
//
//    }];
}


- (void) keyboardWillShow:(NSNotification *)notification{
    [UIView animateWithDuration:animationDuration animations:^{
        if (self.myTableView.contentSize.height > self.myTableView.frame.size.height) {
            if ([self.dataArr count]) {
                [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(self.dataArr.count - 1) inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
        }else{
            
        }
    }];
}

- (void)keyboardChangeFrame:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
    //    CGSize keyboard = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSValue *animationDurationValue = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    [animationDurationValue getValue:&animationDuration];
 
}

- (void)subMitClick:(id)sender{
    UIButton *tmpBtn = (UIButton *)sender;
    tmpBtn.userInteractionEnabled = NO;
    NSString *tmpStr;
    if (messageModel.uid == NULL) {
        tmpStr = messageModel.obj_uid;
    }else{
        tmpStr = messageModel.uid;
    }
    [RSHttpManager requestSendDialogueWithUID:self.currentUID WithTargetUID:tmpStr WithContent:self.tf.text WithSuccess:^(BOOL isSucceed) {
        if (isSucceed) {
            self.tf.text = @"";
            [RSHttpManager requestDialoguesWithUID:self.currentUID WithUser:tmpStr WithPage:@"0" WithSuccess:^(NSArray *dialogueList) {
                if ([dialogueList count]) {
                    NSEnumerator *enumerator = [dialogueList reverseObjectEnumerator];
                    self.dataArr = [[NSMutableArray alloc] initWithArray:[enumerator allObjects]];
                    
                    [self.myTableView reloadData];
                    [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(self.dataArr.count - 1) inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                    
                }
                tmpBtn.userInteractionEnabled = YES;
                
            } failure:^(NSError *error) {
                tmpBtn.userInteractionEnabled = YES;
                
            }];
        }else{
            tmpBtn.userInteractionEnabled = YES;
        }
        
    } failure:^(NSError *error) {
        tmpBtn.userInteractionEnabled = YES;
    }];
}


- (CGSize)customConentSizeWithString:(NSString *)str{
    UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    CGSize size = CGSizeMake(190, 1000);
    CGSize labelsize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    return labelsize;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //15 origin.y
    DialogueModel *dialogue = [self.dataArr objectAtIndex:indexPath.row];
    
    CGSize contentSize = [self customConentSizeWithString:dialogue.content];
    
    CGSize timeSize = [dialogue.send_date sizeWithFont:[UIFont systemFontOfSize:13.0]];
    
    if (15 +contentSize.height + 5 + timeSize.height + 10 > 80) {
        return 15 + contentSize.height + 5 + timeSize.height + 10;
    }
    return 90;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row];//@"Cell";
    
    DialogueModel *dialogue = [self.dataArr objectAtIndex:indexPath.row];
    
    iChatViewCell *cell = (iChatViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"iChatViewCell" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if ([dialogue.origin_uid isEqualToString:self.currentUID]) {//右边
        [cell.userRightIcon setImageWithURL:[NSURL URLWithString:dialogue.origin_img_path] placeholderImage:[UIImage imageNamed:@"hi"]];
        cell.userLeftIcon.hidden = YES;
        //67 o.y 190 s.w
        cell.conentLB.text = dialogue.content;
        [cell.conentLB setNumberOfLines:0];
        cell.conentLB.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        cell.conentLB.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        CGSize contentSize = [self customConentSizeWithString:dialogue.content];
        cell.conentLB.frame = CGRectMake( 57 + 190 - contentSize.width, cell.conentLB.frame .origin.y, contentSize.width, contentSize.height);
        
        //        cell.timeLB.text = dialogue.send_date;
        cell.timeLB.text = [dialogue.send_date substringWithRange:NSMakeRange(5, 11)];
        cell.timeLB.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        CGSize timeSize = [cell.timeLB.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];

        cell.timeLB.textColor =[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
        cell.timeLB.frame = CGRectMake( 57 + 190 - timeSize.width, cell.conentLB.frame.origin.y + cell.conentLB.frame.size.height + 5, timeSize.width, timeSize.height);
        UIImage *image = [UIImage imageNamed:@"dialog-right-mini.png"];
        [cell.rightBubbleIV setImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(20.f, 14.f, 28.f, 12)]];
        
        if (cell.conentLB.frame.size.width > cell.timeLB.frame.size.width) {
            [cell.rightBubbleIV setFrame:CGRectMake(250 - (cell.conentLB.frame.size.width + 10), cell.conentLB.frame.origin.y - 8, cell.conentLB.frame.size.width + 10 + 5, cell.conentLB.frame.size.height + 5 + cell.timeLB.frame.size.height + 13)];
        }else{
            [cell.rightBubbleIV setFrame:CGRectMake(255 - (cell.timeLB.frame.size.width + 15), cell.conentLB.frame.origin.y - 8, cell.timeLB.frame.size.width + 15, cell.conentLB.frame.size.height + 5 + cell.timeLB.frame.size.height + 13)];
        }
        
        
    }else{//左边
        [cell.userLeftIcon setImageWithURL:[NSURL URLWithString:dialogue.origin_img_path] placeholderImage:[UIImage imageNamed:@"hi"]];
        cell.userRightIcon.hidden = YES;
        cell.conentLB.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        cell.conentLB.text = dialogue.content;
        cell.conentLB.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        [cell.conentLB setNumberOfLines:0];
        CGSize contentSize = [self customConentSizeWithString:dialogue.content];
        cell.conentLB.frame = CGRectMake(cell.conentLB.frame.origin.x , cell.conentLB.frame .origin.y, contentSize.width, contentSize.height);
        
        cell.timeLB.text = [dialogue.send_date substringWithRange:NSMakeRange(5, 11)];
        cell.timeLB.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        cell.timeLB.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
        
        CGSize timeSize = [cell.timeLB.text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
        cell.timeLB.frame = CGRectMake(cell.conentLB.frame.origin.x , cell.conentLB.frame.origin.y + cell.conentLB.frame.size.height + 5, timeSize.width, timeSize.height);
        UIImage *image = [UIImage imageNamed:@"dialog-left-mini.png"];
        [cell.leftBubbleIV setImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(20.f, 14.f, 28.f, 12)]];
        if (cell.conentLB.frame.size.width > cell.timeLB.frame.size.width) {
            [cell.leftBubbleIV setFrame:CGRectMake(cell.conentLB.frame.origin.x - 10, cell.conentLB.frame.origin.y - 8 , cell.conentLB.frame.size.width + 10 + 5 , cell.conentLB.frame.size.height + 5 + cell.timeLB.frame.size.height + 13)];
        }else{
            [cell.leftBubbleIV setFrame:CGRectMake(cell.conentLB.frame.origin.x - 10, cell.conentLB.frame.origin.y - 8, cell.timeLB.frame.size.width + 15 + 5, cell.conentLB.frame.size.height + 5 + cell.timeLB.frame.size.height + 13)];
        }
        
    }
    
    
    return cell;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    else
        return YES;
}

@end
