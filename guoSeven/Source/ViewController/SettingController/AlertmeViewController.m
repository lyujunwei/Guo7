//
//  AlertmeViewController.m
//  GPlay
//
//  Created by zucknet on 12/10/29.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "AlertmeViewController.h"

@interface AlertmeViewController ()

@property(nonatomic,retain)UIButton *startbtn;
@property(nonatomic,retain)UIButton *endbtn;
@property(nonatomic,retain)UIDatePicker *dataPicker;
@property(nonatomic,retain)UILabel *starttext;
@property(nonatomic,retain)UILabel *endtext;
@property(nonatomic,retain)NSString *timestamp;

@end

@implementation AlertmeViewController
@synthesize tablelist;
@synthesize switchView;
@synthesize startbtn,endbtn;
@synthesize dataPicker;
@synthesize starttext,endtext;
@synthesize timestamp=_timestamp;

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
	self.title=@"降价提醒";
    self.view.backgroundColor=[UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0];
    self.tableView.backgroundView=nil;
    self.tableView.backgroundColor=[UIColor clearColor];

    tablelist=[[NSArray alloc]initWithObjects:@"推送提醒",@"开始时间",@"结束时间",nil];
    self.tableView.backgroundColor=[UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0];
    
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
    NSUInteger row = [indexPath row];
    cell.textLabel.text=[self.tablelist objectAtIndex:row];
    
    
    if (indexPath.row == 0) {
        switchView=[[UISwitch alloc]initWithFrame:CGRectZero];
        cell.accessoryView=self.switchView;
        [self.switchView addTarget:self action:@selector(updateSwitchAtIndexPath) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (indexPath.row == 1) {
        startbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        startbtn.frame=CGRectMake(0, 0, 86, 34);
        [startbtn addTarget:self action:@selector(callDP:) forControlEvents:UIControlEventTouchUpInside];
        
        starttext=[[UILabel alloc]init];
        starttext.frame=CGRectMake(0, 0, 86, 34);
        starttext.backgroundColor=[UIColor clearColor];
        starttext.font=[UIFont systemFontOfSize:14];
        starttext.textAlignment=NSTextAlignmentCenter;
        [self.startbtn addSubview:starttext];

        cell.accessoryView=startbtn;
    }
    if (indexPath.row == 2) {
        endbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        endbtn.frame=CGRectMake(0, 0, 86, 34);
        endbtn.backgroundColor=[UIColor clearColor];
       [endbtn addTarget:self action:@selector(callDP:) forControlEvents:UIControlEventTouchUpInside];
        
        endtext=[[UILabel alloc]init];
        endtext.frame=CGRectMake(0, 0, 86, 34);
        endtext.backgroundColor=[UIColor clearColor];
        endtext.font=[UIFont systemFontOfSize:14];
        endtext.textAlignment=NSTextAlignmentCenter;
        [self.endbtn addSubview:endtext];
        
        cell.accessoryView=endbtn;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow]animated:YES];
}

- (void)updateSwitchAtIndexPath {
    if ([self.switchView isOn]) {
        NSLog(@")>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ON");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"已打开推送服务" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else{
        NSLog(@")>>>>>>>>>>>>>>>>>>>>>>>>>>>>> OFF");
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	dataPicker = (UIDatePicker *)[actionSheet viewWithTag:101];
    dataPicker=[[UIDatePicker alloc]init];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
			formatter.dateFormat = @"a h:mm";
	_timestamp = [formatter stringFromDate:dataPicker.date];
        
    [(UILabel *)[self.view viewWithTag:103] setText:_timestamp];
}

- (void) action: (id) sender
{
	NSString *title = UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ? @"\n\n\n\n\n\n\n\n\n" : @"\n\n\n\n\n\n\n\n\n\n\n\n" ;
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"确定", nil];
	[actionSheet showInView:self.view];
	dataPicker = [[UIDatePicker alloc] init];
	dataPicker.tag = 101;
	dataPicker.datePickerMode = [(UISegmentedControl *)self.navigationItem.titleView selectedSegmentIndex];
	[actionSheet addSubview:dataPicker];
}

- (void)changeDate:(UIDatePicker *)sender {
    NSLog(@"New Date: %@", sender.date);
}

- (void)removeViews:(id)object {
    [[self.view viewWithTag:9] removeFromSuperview];
    [[self.view viewWithTag:10] removeFromSuperview];
    [[self.view viewWithTag:11] removeFromSuperview];
}

- (void)dismissDatePicker:(id)sender {
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height+44, 320, 216);
    [UIView beginAnimations:@"MoveOut" context:nil];
    [self.view viewWithTag:9].alpha = 0;
    [self.view viewWithTag:10].frame = datePickerTargetFrame;
    [self.view viewWithTag:11].frame = toolbarTargetFrame;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeViews:)];
    [UIView commitAnimations];
}

- (IBAction)callDP:(id)sender {
    if ([self.view viewWithTag:9]) {
        return;
    }
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height-216-44, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height-216, 320, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:self.view.bounds];
    darkView.alpha = 0;
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+44, 320, 216)];
    datePicker.tag = 10;
    datePicker.datePickerMode=UIDatePickerModeTime;
    [datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)];
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissDatePicker:)];
    
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    [self.view addSubview:toolBar];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolbarTargetFrame;
    datePicker.frame = datePickerTargetFrame;
    darkView.alpha = 0.5;
    [UIView commitAnimations];
}




@end
