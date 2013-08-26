//
//  ChangePasswordViewController.m
//  guoSeven
//
//  Created by luyun on 13-1-15.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "RSHttpManager.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"

@interface ChangePasswordViewController ()
@property (nonatomic, strong) UILabel *completeLB;
@end

@implementation ChangePasswordViewController
@synthesize tableView,myScrollView;
@synthesize passwordF,replayPSW,newsPSW, emailF;
@synthesize titlelist1,titlelist2,allTitle;
//@synthesize btn;

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:UITableViewStyleGrouped];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    emailF.text = kUserDefault(kUEmail);
}
//- (UITextField *)showTextFieldWithPlaceholder:(NSString *)placeholder keyboardType:(UIKeyboardType)keyboardType returnKeyType:(UIReturnKeyType)returnKeyType secureTextEntry:(BOOL)entry {
//    UITextField *texF = [[UITextField alloc] initWithFrame:CGRectMake(90, 10, 190 , 20)];
//    texF.backgroundColor = [UIColor clearColor];
//    texF.font = [UIFont systemFontOfSize:16];
//    texF.clearButtonMode = YES;
//    texF.placeholder = placeholder;
//    texF.returnKeyType = returnKeyType;//UIReturnKeyNext;
//    texF.keyboardType = keyboardType;
//    texF.delegate = self;
//    texF.textAlignment = NSTextAlignmentRight;
//    texF.secureTextEntry = entry;
//    return texF;
//}
#pragma textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.returnKeyType == UIReturnKeyNext) {
        if (textField.tag == 100) {
            [passwordF becomeFirstResponder];
        }else if(textField.tag == 101) {
            [replayPSW becomeFirstResponder];
        }else if (textField.tag == 102){
            [newsPSW becomeFirstResponder];
        }
    }else if (textField.returnKeyType == UIReturnKeyDone) {
        [textField resignFirstResponder];
        [self clickPass:nil];
    }
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"修改登陆账户";
    self.view.backgroundColor=[UIColor colorWithRed:247.0 / 255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0];

    self.tableView.delegate = (id<UITableViewDelegate>)self;
    self.tableView.dataSource = (id<UITableViewDataSource>)self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];

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
    
//    titlelist1 = [[NSArray alloc] initWithObjects:@"邮箱",@"旧密码",@"新密码",@"验证", nil];
    titlelist1 = [[NSArray alloc] initWithObjects:@"旧密码",@"新密码",@"验证", nil];
    
    allTitle = [[NSMutableArray alloc] initWithObjects:titlelist1, nil];
    
    
    self.completeLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    //    self.cancleLB.backgroundColor = [UIColor redColor];
    self.completeLB.text = @"完成";
    self.completeLB.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    self.completeLB.font = [UIFont fontWithName:@"Helvetica" size:17.0f];
    self.completeLB.textAlignment = NSTextAlignmentCenter;
    self.completeLB.backgroundColor = [UIColor clearColor];

//    btn=[UIButton buttonWithType:UIButtonTypeCustom];
////    btn.frame=CGRectMake(10, 250, 300, 40);
//    btn.frame=CGRectMake(0, 0, 300, 44);
//    [btn setTitle:@"完成" forState:UIControlStateNormal];
//    btn.titleLabel.textColor = [UIColor blackColor];
//    [btn addTarget:self action:@selector(clickPass:) forControlEvents:UIControlEventTouchUpInside];
////    [self.view addSubview:btn];


    emailF = [APPDELEGATE showTextFieldWithPlaceholder:@"请输入邮箱" keyboardType:UIKeyboardTypeEmailAddress returnKeyType:UIReturnKeyNext secureTextEntry:NO delegate:self];
    emailF.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    emailF.font = [UIFont fontWithName:@"Helvetica" size:17.0f];
    passwordF = [APPDELEGATE showTextFieldWithPlaceholder:@"请输入旧密码" keyboardType:UIKeyboardTypeDefault returnKeyType:UIReturnKeyNext secureTextEntry:YES delegate:self];
    passwordF.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    passwordF.font = [UIFont fontWithName:@"Helvetica" size:17.0f];
    replayPSW = [APPDELEGATE showTextFieldWithPlaceholder:@"请输入新密码" keyboardType:UIKeyboardTypeDefault returnKeyType:UIReturnKeyNext secureTextEntry:YES delegate:self];
    replayPSW.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    replayPSW.font = [UIFont fontWithName:@"Helvetica" size:17.0f];
    newsPSW = [APPDELEGATE showTextFieldWithPlaceholder:@"再次输入新密码" keyboardType:UIKeyboardTypeDefault returnKeyType:UIReturnKeyDone secureTextEntry:YES delegate:self];
    newsPSW.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    newsPSW.font = [UIFont fontWithName:@"Helvetica" size:17.0f];
    emailF.tag = 100;
    passwordF.tag = 101;
    replayPSW.tag = 102;
    newsPSW.tag = 103;
	
//    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
//    tapGr.cancelsTouchesInView = NO;
//    [self.view addGestureRecognizer:tapGr];
    
}

-(void)setBackView{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickPass:(id)sender{
    NSLog(@"完成");
    
    if (!passwordF.text.length || !replayPSW.text.length || !newsPSW.text.length) {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [al show];
        return;
    }
    [SVProgressHUD show];

    NSString *tmp = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUID]];
//    emailF.text = @"549858687@qq.com";
//    passwordF.text = @"1qazmklp0";
//    newsPSW.text = @"123123";
    [RSHTTPMANAGER requestRestPasswdWithUID:tmp WithEmail:emailF.text WithPasswd:passwordF.text WithNPasswd:newsPSW.text WithSuccess:^(BOOL isSuccess) {
        if (isSuccess) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"修改失败"];

        }
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr{
    [newsPSW resignFirstResponder];
    [passwordF resignFirstResponder];
    [emailF resignFirstResponder];
    [replayPSW resignFirstResponder];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 16;
    }
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 80;
    }
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    if (section != 1) {
        return [[self.allTitle objectAtIndex:section] count];
    }else{
        return 1;
    }

}

- (UITableViewCell *)tableView:(UITableView *)TableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [TableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

        if (indexPath.section == 0) {
            NSUInteger row = [indexPath row];
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0f];
            cell.textLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
            cell.textLabel.text = [[self.allTitle objectAtIndex:indexPath.section] objectAtIndex:row];
            [self.allTitle objectAtIndex:indexPath.section];
            
            if (indexPath.row == 0 && indexPath.section == 0) {
                //            [cell.contentView addSubview:emailF];
                [cell.contentView addSubview:passwordF];
            }
            if (indexPath.row == 1 && indexPath.section == 0) {
                //            [cell.contentView addSubview:passwordF];
                [cell.contentView addSubview:replayPSW];
            }
            if (indexPath.row == 2 && indexPath.section == 0) {
                //            [cell.contentView addSubview:replayPSW];
                [cell.contentView addSubview:newsPSW];
            }
            //        if (indexPath.row == 3 && indexPath.section == 0) {
            //            [cell.contentView addSubview:newsPSW];
            //        }
        }else {
            if (indexPath.row == 0 && indexPath.section == 1) {
                [cell addSubview:self.completeLB];
//                [cell addSubview:btn];
            }
        }

    }
    
    // Configure the cell...
    
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
//    switch (section) {
//        case 0:
//            return @"新密码不能与当前密码相同。\n新密码至少6个字符：区分大小写。";
//            break;
//        default:
//            return @"";
//            break;
//    }
//}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
        lb.text = @"新密码不能与当前密码相同。\n新密码至少6个字符：区分大小写。";
        [lb setNumberOfLines:0];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.textColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
        lb.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        lb.backgroundColor = [UIColor clearColor];
        return lb;
    }
    return nil;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        [self clickPass:nil];
    }

}

@end
