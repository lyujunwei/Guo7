//
//  SocialMessageViewController.m
//  GPlay
//
//  Created by zucknet on 12/10/31.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "SocialMessageViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface SocialMessageViewController ()

@property(nonatomic,retain)NSArray *tablelist;
@property(nonatomic,retain)NSArray *zishulist;
@property(nonatomic,retain)NSMutableArray *tableAll;
@property (nonatomic, retain) IBOutlet TPKeyboardAvoidingScrollView *scrollView;


@end

@implementation SocialMessageViewController
@synthesize tablelist,zishulist,tableAll;
@synthesize scrollView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"社交信息";
    
    self.tableView.backgroundColor=[UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0];
    self.tableView.backgroundView=nil;
    
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"警告" message:@"补充中，暂不能点击" delegate:nil
                                        cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
    tablelist=[[NSArray alloc]initWithObjects:@"性别",@"年龄",@"星座",@"感情状况",@"兴趣爱好",@"自述", nil];
    tableAll=[[NSMutableArray alloc]initWithObjects:tablelist,zishulist, nil];
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
}

-(void)setBackView{
    [self.navigationController popViewControllerAnimated:YES];
}

//-(void)viewTapped:(UITapGestureRecognizer*)tapGr{
//    [self.textField resignFirstResponder];
//}


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
    return [self.tablelist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSInteger row=[indexPath row];
    cell.textLabel.text=[self.tablelist objectAtIndex:row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - Text field delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [scrollView adjustOffsetToIdealIfNeeded];
}

@end
