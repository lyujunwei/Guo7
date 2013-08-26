//
//  CostViewController.m
//  guoSeven
//
//  Created by zucknet on 13/1/6.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "CostViewController.h"
#import "UIImageView+AFNetworking.h"
#import "SBJson.h"
#import "DetailViewController.h"

@interface CostViewController ()

@end

@implementation CostViewController
@synthesize cost_id;
@synthesize detailViewController = _detailViewController;
@synthesize cost_dataSorce,statistics;
@synthesize oldDownCost,oldUpCost;
@synthesize freeCost,freeDown;

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
    
    self.tableView.showsHorizontalScrollIndicator=NO;
    self.tableView.showsVerticalScrollIndicator=NO;
    
    int count = [cost_dataSorce count];
    self.tableView.contentSize= CGSizeMake(320, 60 + 44*count);
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
    return [cost_dataSorce count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    NSUInteger row = [indexPath row];
    switch (row) {
        case 0:
            oldUpCost = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, 120, 19)];
            priceMin = [statistics valueForKey:@"priceMin"];
            oldUpCost.text=[NSString stringWithFormat:@"历史最低价：%@元",priceMin];
            oldUpCost.font = [UIFont systemFontOfSize:13];
            oldUpCost.backgroundColor=[UIColor clearColor];
            [cell addSubview:oldUpCost];
            
            oldDownCost = [[UILabel alloc]initWithFrame:CGRectMake(10, 31, 120, 19)];
            priceMax = [statistics valueForKey:@"priceMax"];
            oldDownCost.text=[NSString stringWithFormat:@"历史最高价：%@元",priceMax];
            oldDownCost.font = [UIFont systemFontOfSize:13];
            oldDownCost.backgroundColor=[UIColor clearColor];
            [cell addSubview:oldDownCost];
            
            freeCost = [[UILabel alloc]initWithFrame:CGRectMake(125, 8, 150, 19)];
            free = [statistics valueForKey:@"free"];
            freeCost.text = [NSString stringWithFormat:@"限时免费：%@次",free];
            freeCost.font = [UIFont systemFontOfSize:13];
            freeCost.backgroundColor=[UIColor clearColor];
            [cell addSubview:freeCost];
            
            freeDown = [[UILabel alloc]initWithFrame:CGRectMake(125, 31, 180, 19)];
            price_drop = [statistics valueForKey:@"price_drop"];
            NSLog(@"price_drop: %@",price_drop);
            freeDown.text = [NSString stringWithFormat:@"冰点降价（6元）%@次",price_drop];
            freeDown.font=[UIFont systemFontOfSize:13];
            freeDown.backgroundColor = [UIColor clearColor];
            [cell addSubview:freeDown];
            
            cell.selectionStyle=UITableViewCellStyleDefault;
            
            break;
            
        default:
            
            tableCell = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
            tableCell.backgroundColor = [UIColor clearColor];
            [cell addSubview:tableCell];
            
            pricing_time_lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, 90, 30)];
            pricing_time = [[cost_dataSorce objectAtIndex:indexPath.row]objectForKey:@"pricing_time"];
            pricing_time_lab.text = pricing_time;
            pricing_time_lab.font = [UIFont systemFontOfSize:13.0f];
            [tableCell addSubview:pricing_time_lab];
            
            price_name_lab = [[UILabel alloc]initWithFrame:CGRectMake(280, 8, 40, 30)];
            price_name = [[cost_dataSorce objectAtIndex:indexPath.row]objectForKey:@"price_name"];
            
            if ([price_name isEqualToString:@"降价"]) {
                price_name_lab.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1.0];
            }
            if ([price_name isEqualToString:@"涨价"]) {
                price_name_lab.textColor = [UIColor colorWithRed:255.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
            }
            
            price_name_lab.text = price_name;
            
            price_name_lab.font = [UIFont systemFontOfSize:13.0f];
            [tableCell addSubview:price_name_lab];
            
            version_lab = [[UILabel alloc]initWithFrame:CGRectMake(100, 8, 130, 30)];
            version = [[cost_dataSorce objectAtIndex:indexPath.row]objectForKey:@"version"];
            retail_price = [[cost_dataSorce objectAtIndex:indexPath.row]objectForKey:@"retail_price"];
            
            if (version == NULL) {
                version_lab.text = retail_price;
            } else {
                version_lab.text = version;
            }
            version_lab.font = [UIFont systemFontOfSize:13.0f];
            [tableCell addSubview:version_lab];
            
            break;
    }
    
    cell.selectionStyle=UITableViewCellStyleDefault;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row=[indexPath row];
    switch (row) {
        case 0:
            return 60;
            break;
        default:
            return 44;
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
