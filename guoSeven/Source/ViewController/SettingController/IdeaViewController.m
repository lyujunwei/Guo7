//
//  IdeaViewController.m
//  GPlay
//
//  Created by zucknet on 12/10/29.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "IdeaViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RSHttpManager.h"
#import "SVProgressHUD.h"

@interface IdeaViewController ()

@property(nonatomic,retain)UITextView *textView;
@property(nonatomic,retain)UITextField *textfield;
@property(nonatomic,retain)UIButton *clickbtn;

-(IBAction)showAlert:(id)sender;

@end

@implementation IdeaViewController
@synthesize textfield,textView,clickbtn;

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:UITableViewStyleGrouped];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"意见反馈";

    self.labTitle.text = @"欢迎提出宝贵的建议和意见！我们会用心倾听并持续改进产品，把更好的体验带给你！";
    self.labTitle.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.labTitle.textAlignment = NSTextAlignmentLeft;
    
    self.tableView.delegate = (id<UITableViewDelegate>)self;
    self.tableView.dataSource = (id<UITableViewDataSource>)self;
//    self.tableView.backgroundColor = [UIColor redColor];
    self.view.backgroundColor=[UIColor colorWithRed:247.0 / 255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0];

    
    textView=[[UITextView alloc]initWithFrame:CGRectMake(5, 0, 310, 140)];
//    textView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    textView.backgroundColor = [UIColor clearColor];
    textView.showsHorizontalScrollIndicator = NO;
    textView.showsVerticalScrollIndicator = NO;
    [[textView layer] setCornerRadius:12.f];
    self.textView.font=[UIFont fontWithName:@"Helvetica Neue" size:17];
//    [[self.textView layer] setBorderColor:[[UIColor grayColor] CGColor]];
//    [[self.textView layer] setBorderWidth:2.3];
//    [[self.textView layer] setCornerRadius:15];
    
    
    clickbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    clickbtn.frame=CGRectMake(0, 0, 300, 44);
    [clickbtn setTitle:@"完成" forState:UIControlStateNormal];
    [clickbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clickbtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];

    [clickbtn addTarget:self action:@selector(showAlert:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
//    [self.view addSubview:clickbtn];
//    [self.view addSubview:textView];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr{
    [self.textView resignFirstResponder];
}

-(IBAction)showAlert:(id)sender{
    
    if (!self.textView.text.length) {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [al show];
        return;
    }
    [SVProgressHUD show];
    
    [RSHTTPMANAGER requestQuestWithUID:kUserDefault(kUID) WithContent:self.textView.text WithSuccess:^(BOOL isSuccess) {
        if (isSuccess) {
            [SVProgressHUD showSuccessWithStatus:@"感谢您的宝贵意见"];
            [self setBackView];
        }else {
            [SVProgressHUD showErrorWithStatus:@"意见反馈失败"];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"意见反馈失败"];
    }];
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"感谢您的宝贵意见" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//    [alert show];
}

-(void)setBackView{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if(section == 1) {
        return 1;    
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 140.;
    }
    return 44.;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            [cell addSubview:self.textView];
        }
        if (indexPath.section == 1 && indexPath.row == 0) {
            [cell addSubview:clickbtn];
        }
        cell.backgroundColor = [UIColor whiteColor];
    }
    // Configure the cell...
    
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

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    switch (section) {
//        default:
//            return @"欢迎提出宝贵的建议和意见！我们会用心倾听并持续改进产品，把更好的体验带给你！";
//            break;
//    }
//}

-(void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textfield resignFirstResponder];
    
    UITouch*touch =[touches anyObject];
    if(touch.phase==UITouchPhaseBegan){
        for(UIView*view in[self.view subviews]){
            if([view isFirstResponder]){
                [view resignFirstResponder];
                break;
            }
        }
    }
}


@end
