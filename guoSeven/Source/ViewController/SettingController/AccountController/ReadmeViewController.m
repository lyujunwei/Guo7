//
//  ReadmeViewController.m
//  GPlay
//
//  Created by zucknet on 12/10/30.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "ReadmeViewController.h"
#import "LoginViewController.h"

@interface ReadmeViewController ()

@property(nonatomic,retain)UITextView *alertText;

-(IBAction)nextView:(id)sender;

@end

@implementation ReadmeViewController
@synthesize alertText;

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
    self.title=@"阅读事项";
    
    UIBarButtonItem *nextbtn =[[UIBarButtonItem alloc]initWithTitle:@"同意" style:UIBarButtonItemStylePlain target:self action:@selector(nextView:)];
    self.navigationItem.rightBarButtonItem=nextbtn;
    
    
    self.tableView.backgroundColor=[UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0];
    self.tableView.backgroundView=nil;
    

    alertText=[[UITextView alloc]init];
    alertText.frame=CGRectMake(10, 0, 300, self.view.frame.size.height);
    alertText.backgroundColor=[UIColor clearColor];
    alertText.editable=NO;
    alertText.textColor=[UIColor grayColor];
    alertText.text=@"CUPERTINO, California—October 29, 2012—Apple® today announced executive management changes that will encourage even more collaboration between the Company’s world-class hardware, software and services teams. As part of these changes, Jony Ive, Bob Mansfield, Eddy Cue and Craig Federighi will add more responsibilities to their roles. Apple also announced that Scott Forstall will be leaving Apple next year and will serve as an advisor to CEO Tim Cook in the interim.CUPERTINO, California—October 29, 2012—Apple® today announced executive management changes that will encourage even more collaboration between the Company’s world-class hardware, software and services teams. As part of these changes, Jony Ive, Bob Mansfield, Eddy Cue and Craig Federighi will add more responsibilities to their roles. Apple also announced that Scott Forstall will be leaving Apple next year and will serve as an advisor to CEO Tim Cook in the interim.CUPERTINO, California—October 29, 2012—Apple® today announced executive management changes that will encourage even more collaboration between the Company’s world-class hardware. ";
    
    [self.view addSubview:alertText];
    
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
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [rightBtn setFrame:CGRectMake(10, 3, 55, 32)];
    UILabel *rightlab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 55, 32)];
    rightlab.text=@"同意";
    rightlab.backgroundColor=[UIColor clearColor];
    rightlab.textColor=[UIColor whiteColor];
    rightlab.textAlignment=NSTextAlignmentCenter;
    rightlab.font=[UIFont fontWithName:@"Helvetica-Bold" size:12];
    [rightBtn addSubview:rightlab];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"icontop-normal@2x.png"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"icontop-normal2@2x.png"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(nextView:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self.navigationItem setRightBarButtonItem:rightItem];

}

-(void)setBackView{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)nextView:(id)sender{
    LoginViewController *loginView =[[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginView animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
    //
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


@end
