//
//  AccountViewController.m
//  GPlay
//
//  Created by zucknet on 12/11/2.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "AccountViewController.h"
#import "TSLocateView.h"
#import "SettingUserInfoViewController.h"
#import "ChangeAccountViewController.h"
#import "SocialMessageViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface AccountViewController ()

@property (nonatomic, retain) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

@end

@implementation AccountViewController
@synthesize scrollView;

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

    self.title=@"帐号设置";
    
    self.tableView.backgroundColor=[UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0];
    self.tableView.backgroundView=nil;
    self.tableView.frame=CGRectMake(0, 0, 320, 500);
    
    list1=[[NSArray alloc]initWithObjects:@"帐户", nil];
    list2=[[NSArray alloc]initWithObjects:@"头像",@"昵称",@"地区", nil];
    list3=[[NSArray alloc]initWithObjects:@"签名", nil];
    listAll=[[NSMutableArray alloc]initWithObjects:list1,list2,list3,nil];
    
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
    
//    UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"camera" ofType:@"png"]];
}

-(void)clickSelectPhoto{
    //下方的图片按钮 点击后呼出菜单 打开摄像机 查找本地相册
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"camera" ofType:@"png"]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 120, image.size.width, image.size.height);
    
    [button setImage:image forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    
    //把它也加在视图当中
    [self.view addSubview:button];
}

-(void)openMenu
{
    //在这里呼出下方菜单按钮项
    myActionSheet = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    
    [myActionSheet showInView:self.view];
}

//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentModalViewController:picker animated:YES];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

//打开本地相册
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentModalViewController:picker animated:YES];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中x
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        //filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        
        //关闭相册界面
        [picker dismissModalViewControllerAnimated:YES];
        
        //创建一个选择后图片的小图标放在下方
        //类似微薄选择图后的效果
        UIImageView *smallimage = [[UIImageView alloc] initWithFrame:
                                    CGRectMake(73, 112.5, 35, 35)];
        
        smallimage.image = image;
        //加在视图中
        [self.view addSubview:smallimage];
        
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissModalViewControllerAnimated:YES];
}

-(void)sendInfo
{
  //  NSLog(@"图片的路径是：%@", filePath);
    
  //  NSLog(@"您输入框中的内容是：%@", _textEditor.text);
}

- (void)pickImageFromAlbum
{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//圖片來源
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;
    
    [self presentModalViewController:imagePicker animated:YES];
}

-(void)setBackView{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr{
    [nickname resignFirstResponder];
    [moodname resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[listAll objectAtIndex:section] count]; //设定每一类的资料笔数
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [[listAll objectAtIndex:indexPath.section] objectAtIndex:row];
    [listAll objectAtIndex:indexPath.section];//显示所有数据列表
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.row == 1 && indexPath.section == 1) {
        nickname=[[UITextField alloc]init];
        nickname.frame=CGRectMake(0, -10, 230, 20);
        nickname.backgroundColor=[UIColor clearColor];
        nickname.font=[UIFont systemFontOfSize:18];
        nickname.clearButtonMode=YES;
        nickname.delegate=self;
        nickname.returnKeyType = UIReturnKeyDone;
        nickname.placeholder=@"点击修改昵称";
        
        cell.accessoryView=nickname;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row==2 && indexPath.section==1) {
        maplabel=[[UILabel alloc]init];
        maplabel.frame=CGRectMake(0, -10, 230, 20);
        maplabel.backgroundColor=[UIColor clearColor];
        cell.accessoryView=maplabel;
    }
    
    if (indexPath.row==0 && indexPath.section==2) {
        moodname=[[UITextField alloc]init];
        moodname.frame=CGRectMake(0, 10, 230, 20);
        moodname.backgroundColor=[UIColor clearColor];
        moodname.font=[UIFont systemFontOfSize:18];
        moodname.clearButtonMode=YES;
        moodname.delegate=self;
        moodname.returnKeyType = UIReturnKeyDone;
        moodname.placeholder=@"点击修改签名档";
        
        cell.accessoryView=moodname;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == 0 && indexPath.section == 0) {
        ChangeAccountViewController *changeView = [[ChangeAccountViewController alloc]init];
        [self.navigationController pushViewController:changeView animated:YES];
    }
    
    if (indexPath.row == 0 && indexPath.section ==1 ) {
       [self pickImageFromAlbum];
        //[self openMenu];
    }
    
    if(indexPath.row == 2 && indexPath.section == 1) {
        TSLocateView *locateView = [[TSLocateView alloc] initWithTitle:@"选择城市" delegate:self];
        [locateView showInView:self.view];
    }
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow]animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"修改帐号密码";
            break;
        case 1:
            return @"昵称30天内只能修改1次";
            break;
        case 2:
            return @"签名最大限制10个字";
            break;
        case 3:
            return @" ";
            break;
        default:
            return @" ";
            break;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    TSLocateView *locateView = (TSLocateView *)actionSheet;
    TSLocation *location = locateView.locate;
    mapname = [[NSString alloc] initWithFormat:@"%@", location.city];
    maplabel.text=mapname;
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        NSLog(@"Select");
    }
    
    
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == myActionSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
   
        switch (buttonIndex)
        {
            case 0:  //打开照相机拍照
                [self takePhoto];
                break;
                
            case 1:  //打开本地相册
                [self pickImageFromAlbum];
                break;
        }
    }
    

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
