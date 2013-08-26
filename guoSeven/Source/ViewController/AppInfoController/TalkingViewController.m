//
//  TalkingViewController.m
//  guoSeven
//
//  Created by zucknet on 13/1/9.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "TalkingViewController.h"
#import "UIImageView+AFNetworking.h"
#import "SBJson.h"
#import "DetailViewController.h"

@interface TalkingViewController ()

@end

@implementation TalkingViewController
@synthesize talk_id,talk_dataSorce;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.tableView.showsHorizontalScrollIndicator=FALSE;
    self.tableView.showsVerticalScrollIndicator=FALSE;
    self.tableView.separatorColor = [UIColor clearColor];
    
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
    return [talk_dataSorce count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    contentView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 300, 60)];
    contentView.backgroundColor =[UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:243.0/255.0 alpha:1.0];
    [cell.contentView addSubview:contentView];
    
    user_img = [[UIImageView alloc]initWithFrame:CGRectMake( 10, 5, 50, 50)];
    userimg = [[self.talk_dataSorce objectAtIndex:indexPath.row]valueForKey:@"img_path"];
    NSURL *imgurl = [NSURL URLWithString:userimg];
    [user_img setImageWithURL:imgurl placeholderImage:[UIImage imageNamed:@"hi"]];
    [contentView addSubview:user_img];
    
    userlab = [[UILabel alloc]initWithFrame:CGRectMake(70, 7, 90, 30)];
    userString = [[self.talk_dataSorce objectAtIndex:indexPath.row]objectForKey:@"user"];
    username = [userString valueForKey:@"nick_name"];
    userlab.text = username;
    userlab.font = [UIFont systemFontOfSize:13.0f];
    userlab.backgroundColor = [UIColor clearColor];
    [contentView addSubview:userlab];
    
    contentlab = [[UILabel alloc]initWithFrame:CGRectMake(70, 26, 230, 30)];
    contentString = [[self.talk_dataSorce objectAtIndex:indexPath.row]objectForKey:@"content"];
    contentlab.text = contentString;
    contentlab.font = [UIFont systemFontOfSize:12.0f];
    contentlab.backgroundColor = [UIColor clearColor];
    [contentView addSubview:contentlab];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    talkheader.backgroundColor=[UIColor clearColor];
    return talkheader;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    talkheader =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,10)];
    [self.view addSubview:talkheader];
    return talkheader.frame.size.height;
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
