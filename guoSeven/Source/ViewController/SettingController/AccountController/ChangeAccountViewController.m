//
//  ChangeAccountViewController.m
//  GPlay
//
//  Created by zucknet on 12/10/30.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "ChangeAccountViewController.h"

@interface ChangeAccountViewController ()

@property(nonatomic,retain)NSArray *tablelist;
@property(nonatomic,retain)UITextField *passText;
@property(nonatomic,retain)UIButton *btn;

-(IBAction)clickbtn:(id)sender;

@end

@implementation ChangeAccountViewController
@synthesize tablelist,passText;
@synthesize btn;

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

    self.title=@"修改登陆密码";
    
    self.tableView.backgroundColor=[UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0];
    self.tableView.backgroundView=nil;
    
    tablelist=[[NSArray alloc]initWithObjects:@"邮箱地址",@"旧密码",@"新密码",@"验证",nil];
    
    btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(10, 250, 300, 40);
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
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

-(void)setBackView{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr{
    [self.passText resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clickbtn:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tablelist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSUInteger row=[indexPath row];
    cell.textLabel.text=[self.tablelist objectAtIndex:row];
    if (indexPath.row == 0 && indexPath.section == 0) {
        UILabel *maillabel=[[UILabel alloc]init];
        maillabel.frame=CGRectMake(40, -10, 190, 20);
        maillabel.backgroundColor=[UIColor clearColor];
        maillabel.font=[UIFont systemFontOfSize:16];
        maillabel.text=@"显示登陆用户邮箱";
        cell.accessoryView=maillabel;
    }
    if (indexPath.row==1  && indexPath.section == 0) {
        passText=[[UITextField alloc]init];
        passText.frame=CGRectMake(40, -10, 190 , 20);
        passText.backgroundColor=[UIColor clearColor];
        passText.font=[UIFont systemFontOfSize:16];
        passText.clearButtonMode=YES;
        cell.accessoryView=passText;
        passText.placeholder=@"输入旧密码";
        passText.secureTextEntry=YES;
        passText.returnKeyType=UIReturnKeyNext;
        passText.keyboardType=UIKeyboardTypeTwitter;
    }
    if (indexPath.row==2  && indexPath.section == 0) {
        passText=[[UITextField alloc]init];
        passText.frame=CGRectMake(40, -10, 190 , 20);
        passText.backgroundColor=[UIColor clearColor];
        passText.font=[UIFont systemFontOfSize:16];
        passText.clearButtonMode=YES;
        cell.accessoryView=passText;
        passText.placeholder=@"输入新密码";
        passText.secureTextEntry=YES;
        passText.returnKeyType=UIReturnKeyNext;
        passText.keyboardType=UIKeyboardTypeTwitter;
    }
    if (indexPath.row==3  && indexPath.section == 0) {
        passText=[[UITextField alloc]init];
        passText.frame=CGRectMake(40, -10, 190 , 20);
        passText.backgroundColor=[UIColor clearColor];
        passText.font=[UIFont systemFontOfSize:16];
        passText.clearButtonMode=YES;
        cell.accessoryView=passText;
        passText.placeholder=@"再次输入密码";
        passText.secureTextEntry=YES;
        passText.returnKeyType=UIReturnKeyNext;
        passText.keyboardType=UIKeyboardTypeTwitter;
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    switch (section) {
        default:
            return @"新密码不能与就密码相同，至少6个字符，区分大小写";
            break;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
