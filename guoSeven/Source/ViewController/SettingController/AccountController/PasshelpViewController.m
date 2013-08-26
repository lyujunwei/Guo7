//
//  PasshelpViewController.m
//  GPlay
//
//  Created by zucknet on 12/10/30.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "PasshelpViewController.h"

@interface PasshelpViewController ()

@property(nonatomic,retain)UIButton *sendbtn;
@property(nonatomic,retain)NSArray *tablelist;

-(IBAction)sendMessage:(id)sender;

@end

@implementation PasshelpViewController
@synthesize sendbtn,tablelist;

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

    self.title=@"忘记密码";
    tablelist=[[NSArray alloc]initWithObjects:@"邮件地址", nil];

    self.tableView.backgroundColor=[UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0];
    self.tableView.backgroundView=nil;
    
    sendbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    sendbtn.frame=CGRectMake(10, 120, 300, 40);
    [sendbtn setTitle:@"发送邮件密码" forState:UIControlStateNormal];
    [self.view addSubview:sendbtn];
    [sendbtn addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    
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

-(IBAction)sendMessage:(id)sender{
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Message" message:@"邮件已发送" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    [self.navigationController popViewControllerAnimated:YES];
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
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSUInteger row=[indexPath row];
    cell.textLabel.text=[self.tablelist objectAtIndex:row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    if (indexPath.row ==0 && indexPath.section ==0) {        
        UITextField *mailtext=[[UITextField alloc]init];
        mailtext.frame=CGRectMake(40, -10, 190 , 20);
        mailtext.backgroundColor=[UIColor clearColor];
        mailtext.font=[UIFont systemFontOfSize:16];
        mailtext.clearButtonMode=YES;
        cell.accessoryView=mailtext;
        mailtext.placeholder=@"输入帐号邮箱";
        mailtext.returnKeyType=UIReturnKeyNext;
        mailtext.keyboardType=UIKeyboardTypeEmailAddress;
    }
    
    return cell;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        default:
            return @"请输入邮箱地址";
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

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
