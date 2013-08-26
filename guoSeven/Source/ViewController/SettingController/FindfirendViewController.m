//
//  FindfirendViewController.m
//  GPlay
//
//  Created by zucknet on 12/10/27.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "FindfirendViewController.h"

@interface FindfirendViewController ()
@property(nonatomic,retain)UISearchBar *searchBar;
@property(nonatomic,retain)NSArray *tablelist;
@property(nonatomic,retain)NSMutableArray *searchData;
@property(nonatomic,retain)UISearchDisplayController *searchDisplayController;
@property(nonatomic,retain)UIButton *addbtn;

@end

@implementation FindfirendViewController
@synthesize searchBar,tablelist;
@synthesize searchDisplayController;
@synthesize searchData;
@synthesize addbtn;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"寻找好友";
    tablelist=[[NSArray alloc]initWithObjects:@"新浪微博",@"腾讯微博",@"人人网",@"豆瓣", nil];
    
    searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    self.searchBar.clearsContextBeforeDrawing=YES;
    [self.searchBar sizeToFit];
    [[searchBar.subviews objectAtIndex:0] removeFromSuperview];
    searchBar.placeholder = @"寻找其他社交网站的好友";
    self.tableView.tableHeaderView=self.searchBar;
    
    addbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    addbtn.frame=CGRectMake(10, 280, 300, 40);
    [addbtn setTitle:@"全部加为好友" forState:UIControlStateNormal];
    
    [self.view addSubview:addbtn];
    
    self.tableView.backgroundColor=[UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0];
    self.tableView.backgroundView=nil;
    
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
    [self.searchBar resignFirstResponder];
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
    return [self.tablelist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSInteger row=[indexPath row];
    cell.textLabel.text=[self.tablelist objectAtIndex:row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0 ) {
        return @"发现你其他社交网站也在用果7的人";
    }
    else
        return nil;
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
