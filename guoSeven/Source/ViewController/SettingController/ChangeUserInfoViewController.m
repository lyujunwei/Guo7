//
//  ChangeUserInfoViewController.m
//  guoSeven
//
//  Created by luyun on 13-1-15.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "ChangeUserInfoViewController.h"
#import "ChangePasswordViewController.h"
#import "ChangeMailViewController.h"
#import "AppDelegate.h"
@interface ChangeUserInfoViewController ()

@end

@implementation ChangeUserInfoViewController
@synthesize TableView;
@synthesize tableViewList,allList;
@synthesize mailTextFiled = _mailTextFiled;
@synthesize passwordTextField = _passwordTextField;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"修改登陆账户和密码";
    
    self.tableView.backgroundColor=[UIColor colorWithRed:247.0 / 255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0];
    self.tableView.backgroundView=nil;
    
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
    
    tableViewList = [[NSArray alloc] initWithObjects:@"邮件地址",@"密码", nil];
    allList = [[NSMutableArray alloc] initWithObjects:tableViewList, nil];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    CGRect rect = CGRectMake(75, 10, 200 , 20);
    self.mailTextFiled = [APPDELEGATE showTextFieldWithPlaceholder:nil keyboardType:UIKeyboardTypeDefault returnKeyType:UIReturnKeyNext secureTextEntry:NO delegate:self];
    self.mailTextFiled.frame = rect;
    self.mailTextFiled.userInteractionEnabled = NO;
    
    self.passwordTextField = [APPDELEGATE showTextFieldWithPlaceholder:nil keyboardType:UIKeyboardTypeDefault returnKeyType:UIReturnKeyDone secureTextEntry:YES delegate:self];
    self.passwordTextField.frame = rect;
    self.passwordTextField.userInteractionEnabled = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.mailTextFiled.text = kUserDefault(kUEmail);
    self.passwordTextField.text = kUserDefault(kUPassd);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setBackView{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 16;
    }
    return YES;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
      return [[self.allList objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        
        NSUInteger row = [indexPath row];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:17.0f];
        cell.textLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        cell.textLabel.text = [[self.allList objectAtIndex:indexPath.section] objectAtIndex:row];
        [self.allList objectAtIndex:indexPath.section];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (indexPath.row == 0 && indexPath.section == 0) {
            [cell.contentView addSubview:self.mailTextFiled];
            self.mailTextFiled.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
            self.mailTextFiled.font = [UIFont fontWithName:@"Helvetica Neue" size:17.0f];
        }
        if (indexPath.row == 1 && indexPath.section == 0) {
            [cell.contentView addSubview:self.passwordTextField];
            self.passwordTextField.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
            self.passwordTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:17.0f];
        }

    }
    // Configure the cell...
    
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
//    switch (section) {
//        case 0:
//            return @"邮箱地址已验证";
//            break;
//        default:
//            return @"";
//            break;
//    }
//}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
        lb.text = @"邮箱地址已验证";
        lb.textAlignment = NSTextAlignmentCenter;
        lb.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        lb.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        lb.backgroundColor = [UIColor clearColor];
        return lb;
    }
    return nil;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
         if (IS_IPHONE5) {
             ChangeMailViewController *mailVC = [[ChangeMailViewController alloc] initWithNibName:@"ChangeMailViewController_iPhone5" bundle:nil];
             [self.navigationController pushViewController:mailVC animated:YES];

         }else{
             ChangeMailViewController *mailVC = [[ChangeMailViewController alloc] initWithNibName:@"ChangeMailViewController" bundle:nil];
             [self.navigationController pushViewController:mailVC animated:YES];
             
         }
//        ChangeMailViewController *mailVC = [[ChangeMailViewController alloc] initWithNibName:@"ChangeMailViewController" bundle:nil];
//        [self.navigationController pushViewController:mailVC animated:YES];
    }
    
    if (indexPath.row == 1 && indexPath.section == 0) {
        ChangePasswordViewController *changwPWVC = nil;
        if (IS_IPHONE5) {
            changwPWVC = [[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController_iPhone5" bundle:nil];
        }else {
            changwPWVC = [[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController" bundle:nil];
        }
        [self.navigationController pushViewController:changwPWVC animated:YES];
    }
}

@end
