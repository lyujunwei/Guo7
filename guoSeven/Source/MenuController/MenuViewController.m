//
//  MenuViewController.m
//  guoSeven
//
//  Created by zucknet on 12/12/7.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "MenuViewController.h"
#import "DDMenuController.h"
#import "AppDelegate.h"
#import "SetViewController.h"
#import "iMessageViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:64.0f/255.0f green:64.0f/255.0f blue:64.0f/255.0f alpha:1.0f];
    leftViewData=[[NSArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
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
    return [leftViewData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.textLabel.text=[leftViewData objectAtIndex:row];
    cell.textLabel.textColor=[UIColor colorWithRed:185.0/255.0 green:185.0/255.0 blue:178.0/255.0 alpha:1.0];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (row == 0) {
        UIImageView *nameimg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        nameimg.image=[UIImage imageNamed:@"touxiang"];
        [cell addSubview:nameimg];
        UILabel *namelab=[[UILabel alloc]initWithFrame:CGRectMake(50, 15, 50, 30)];
        namelab.text=@"用户名";
        namelab.backgroundColor=[UIColor clearColor];
        [cell addSubview:namelab];
    }
    
    return cell;
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
