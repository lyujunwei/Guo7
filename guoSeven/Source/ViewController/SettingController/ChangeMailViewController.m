//
//  ChangeMailViewController.m
//  guoSeven
//
//  Created by luyun on 13-1-16.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "ChangeMailViewController.h"
#import "RSHttpManager.h"
#import "SVProgressHUD.h"

@interface ChangeMailViewController ()
//@property (nonatomic, retain) NSString *currentUID;
@property (nonatomic, retain) UILabel *completeLB;
@end

@implementation ChangeMailViewController
@synthesize mailTF,newsMailTF,PSW;
@synthesize muArray;
@synthesize btn;
@synthesize myScrollView,myTableView;
@synthesize completeLB;
//@synthesize currentUID;

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:UITableViewStyleGrouped];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.returnKeyType == UIReturnKeyNext) {
        if (textField.tag == 100) {
            [PSW becomeFirstResponder];
        }else if (textField.tag == 101) {
            [newsMailTF becomeFirstResponder];
        }
    }else {
        [textField resignFirstResponder];
        [self clickPass:nil];
    }
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.title=@"修改登陆账户";
//    self.currentUID = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUID]];
self.view.backgroundColor=[UIColor colorWithRed:247.0 / 255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0];
//    self.view.backgroundColor = [UIColor clearColor];
//    myScrollView = [[KeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
//    myScrollView.backgroundColor = [UIColor clearColor];

//    [self.view addSubview:myScrollView];
    
    
    
    self.completeLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    //    self.cancleLB.backgroundColor = [UIColor redColor];
    self.completeLB.text = @"完成";
    self.completeLB.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    self.completeLB.font = [UIFont fontWithName:@"Helvetica Neue" size:17];
    self.completeLB.textAlignment = NSTextAlignmentCenter;
    self.completeLB.backgroundColor = [UIColor clearColor];

//    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];

    
//    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [myTableView setBackgroundColor:[UIColor clearColor]];
//    [myScrollView addSubview:myTableView];
    
//    self.tableView.backgroundColor=[UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0];
//    self.tableView.backgroundView=nil;
    
    UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(20, 3, 45, 28)];
    UILabel *leftlab=[[UILabel alloc]initWithFrame:CGRectMake(14, 3, 24, 20)];
    leftlab.text=@"返回";
    leftlab.backgroundColor=[UIColor clearColor];
    [leftlab setTextColor:[UIColor whiteColor]];
    leftlab.font=[UIFont fontWithName:@"Helvetica Neue" size:12];
    [backButton addSubview:leftlab];
    [backButton setBackgroundImage:[UIImage imageNamed:@"icontop-back@2x.png"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"icontop-back2@2x.png"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(setBackView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    muArray = [[NSMutableArray alloc] initWithObjects:@"邮件地址",@"密码",@"新邮件地址", nil];
    
//    btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn.frame=CGRectMake(10, 180, 300, 40);
//    [btn setTitle:@"完成" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(clickPass:) forControlEvents:UIControlEventTouchUpInside];
////    [self.view addSubview:btn];
    
    
    
    mailTF = [[UITextField alloc] initWithFrame:CGRectMake(90, 10, 190 , 20)];
    mailTF.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    mailTF.font = [UIFont fontWithName:@"Helvetica Neue" size:17.0f];
    mailTF.backgroundColor=[UIColor clearColor];
    mailTF.font=[UIFont systemFontOfSize:16];
    mailTF.clearButtonMode=YES;
    mailTF.placeholder=@"点击输入帐号邮箱";
    mailTF.returnKeyType=UIReturnKeyNext;
    mailTF.keyboardType=UIKeyboardTypeEmailAddress;
    mailTF.delegate = self;
    mailTF.textAlignment = NSTextAlignmentRight;
    mailTF.tag = 100;
    
    PSW = [[UITextField alloc] initWithFrame:CGRectMake(90, 10, 190 , 20)];
    PSW.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    PSW.font = [UIFont fontWithName:@"Helvetica Neue" size:17.0f];
    PSW.backgroundColor = [UIColor clearColor];
    PSW.font = [UIFont systemFontOfSize:16];
    PSW.clearButtonMode = YES;
    PSW.secureTextEntry = YES;
    PSW.placeholder = @"请输入登录密码";
    PSW.returnKeyType = UIReturnKeyNext;
    PSW.keyboardType = UIKeyboardTypeDefault;
    PSW.delegate = self;
    PSW.textAlignment = NSTextAlignmentRight;
    PSW.tag = 101;
    
    newsMailTF = [[UITextField alloc] initWithFrame:CGRectMake(90, 10, 190 , 20)];
    newsMailTF.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    newsMailTF.font = [UIFont fontWithName:@"Helvetica Neue" size:17.0f];
    newsMailTF.backgroundColor = [UIColor clearColor];
    newsMailTF.font = [UIFont systemFontOfSize:16];
    newsMailTF.clearButtonMode = YES;
    newsMailTF.placeholder = @"点击输入新的邮箱帐号";
    newsMailTF.returnKeyType = UIReturnKeyDone;
    newsMailTF.keyboardType = UIKeyboardTypeEmailAddress;
    newsMailTF.delegate = self;
    newsMailTF.textAlignment = NSTextAlignmentRight;
    newsMailTF.tag = 102;
    
//	[self.myScrollView setContentSize:CGSizeMake(320, 416)];
//	[self.myScrollView setContentOffset:CGPointMake(0, -44) animated:YES];
//    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
//    tapGr.cancelsTouchesInView = NO;
//    [self.view addGestureRecognizer:tapGr];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//	[self.myScrollView setContentSize:CGSizeMake(320, 416)];
//	[self.myScrollView setContentOffset:CGPointMake(0, -44) animated:YES];
    mailTF.text = kUserDefault(kUEmail);
}
-(void)setBackView{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickPass:(id)sender{
    if (!mailTF.text.length || !PSW.text.length || !newsMailTF.text.length) {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [al show];
        return;
    }
    [SVProgressHUD show];

    NSString *tmp = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUID]];

    [RSHTTPMANAGER requestResetEmailWithUID:tmp WithOldEmail:mailTF.text WithPassword:PSW.text WithNewEmail:newsMailTF.text WithSuccess:^(BOOL isSuccess) {
        if (isSuccess) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [[NSUserDefaults standardUserDefaults] setObject:newsMailTF.text forKey:kUEmail];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"修改失败"];
        }
    } failure:^(NSError *error) {
        
    }];    
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr{
    [mailTF resignFirstResponder];
    [PSW resignFirstResponder];
    [newsMailTF resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 16;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if (section != 1) {
        return [muArray count];
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section != 1) {
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:17.0f];
            cell.textLabel.text = [muArray objectAtIndex:indexPath.row];
        }
        if (indexPath.row == 0 && indexPath.section == 0) {
            [cell.contentView addSubview:mailTF];
        }
        if (indexPath.row == 1 && indexPath.section == 0) {
            [cell.contentView addSubview:PSW];
        }
        if (indexPath.row == 2 && indexPath.section == 0) {
            [cell.contentView addSubview:newsMailTF];
        }
        if (indexPath.row == 0 && indexPath.section == 1) {
            [cell addSubview:self.completeLB];
        }

    }
    
    return cell;
}

//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    if ([newsMailTF isFirstResponder]) {
//        self.tableView.contentOffset = CGPointMake(0, 10);
//    }
//    return YES;
//}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击");
    if (indexPath.section == 1) {
        [self clickPass:nil];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
