//
//  RegisterViewController.m
//  GPlay
//
//  Created by zucknet on 12/10/29.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import "SettingUserInfoViewController.h"
#import "LoginViewController.h"
#import "ReadmeViewController.h"
#import "AccountViewController.h"
#import "PasshelpViewController.h"
#import "SBJson.h"
#import <commoncrypto/CommonDigest.h>
#import "ChangeUserInfoViewController.h"
#import "LoginViewController.h"
#import "UIImageView+AFNetworking.h"
#import "RSHttpManager.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "MyLoadingView.h"
#import "UIImage+Resize.h"

@interface SettingUserInfoViewController ()
@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic, strong) MyLoadingView *load;
@property (nonatomic, assign) BOOL userImagePicker;

@property(nonatomic,retain)NSMutableArray *tablelist;
@property(nonatomic,retain)UIButton *btn1;
@property(nonatomic,retain)UIButton *btn2;
@property(nonatomic, retain) UILabel *cancleLB;
-(IBAction)clickRegister:(id)sender;
-(IBAction)clickDone:(id)sender;
-(IBAction)clickPass:(id)sender;

- (void)login:(id)sender;

@end

@implementation SettingUserInfoViewController
@synthesize tablelist;
@synthesize btn1,btn2;
@synthesize userNameField,passwordField;
@synthesize userName,password;
@synthesize userInfo;
@synthesize tablist3,tablist2,tablist1;
@synthesize nameField,iconImage,autographField;
@synthesize myTableView;
@synthesize cancleLB;

static float labx = 80.;
//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:UITableViewStyleGrouped];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    userNameField.text = kUserDefault(kUEmail);
    autographField.text = kUserDefault(kUSignature);
    nameField.text = kUserDefault(kUNickNamm);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"设置";
    self.view.backgroundColor=[UIColor colorWithRed:247.0 / 255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0];
    
    self.myTableView.delegate = (id<UITableViewDelegate>)self;
    self.myTableView.dataSource = (id<UITableViewDataSource>)self;
    self.myTableView.showsHorizontalScrollIndicator = NO;
    self.myTableView.showsVerticalScrollIndicator = NO;
    
//    self.myTableView.backgroundColor=[UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0];
//    self.myTableView.backgroundView=nil;
//    self.view.backgroundColor = [UIColor redColor];
    
//    NSLog(@"size width %f size height :%f",self.view.frame.size.width,self.view.frame.size.height);
//    [self.view setFrame:CGRectMake(0.f, 0.f, 320.f, 400)];
//    self.tableView.frame = CGRectMake(0, 0, 320, 400);
//    
//    [self.tableView setBounds:CGRectMake(0, 0, 320, 400)];
    
    CGRect rect = CGRectMake(labx, 15, 190 , 20);
    userNameField = [APPDELEGATE showTextFieldWithPlaceholder:nil keyboardType:UIKeyboardTypeEmailAddress returnKeyType:UIReturnKeyNext secureTextEntry:NO delegate:nil];
    nameField = [APPDELEGATE showTextFieldWithPlaceholder:@"你的昵称" keyboardType:UIKeyboardTypeEmailAddress returnKeyType:UIReturnKeyNext secureTextEntry:NO delegate:self];
    autographField = [APPDELEGATE showTextFieldWithPlaceholder:@"你的个性签名" keyboardType:UIKeyboardTypeEmailAddress returnKeyType:UIReturnKeyDone secureTextEntry:NO delegate:self];
    nameField.tag = 100;
    autographField.tag = 101;
    
    
    userNameField.frame = rect;
    nameField.frame = rect;
    autographField.frame = rect;
    
    userNameField.userInteractionEnabled = NO;
    
    userNameField.textAlignment = NSTextAlignmentLeft;
    nameField.textAlignment = NSTextAlignmentLeft;
    autographField.textAlignment = NSTextAlignmentLeft;    
    
    
    
    self.cancleLB = [[UILabel alloc] initWithFrame:CGRectMake(135, 0, 50, 50)];
    self.cancleLB.text = @"注销";
    self.cancleLB.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    self.cancleLB.font = [UIFont fontWithName:@"Helvetica Neue" size:17];
    self.cancleLB.textAlignment = NSTextAlignmentCenter;
    self.cancleLB.backgroundColor = [UIColor clearColor];

    
    self.tablist1 = [[NSArray alloc] initWithObjects:@"账户", nil];
    self.tablist2 = [[NSArray alloc] initWithObjects:@"头像",@"昵称", nil];
    self.tablist3 = [[NSArray alloc] initWithObjects:@"签名", nil];
    
    
    self.tablelist = [[NSMutableArray alloc] initWithObjects:tablist1,tablist2,tablist3, nil];
    
    self.userImagePicker = NO;

    [self performSelector:@selector(showAlbum) withObject:nil afterDelay:0.1];

    
    
//    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
//    tapGr.cancelsTouchesInView = NO;
//    [self.view addGestureRecognizer:tapGr];
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
//    [self.navigationItem setLeftBarButtonItem:[APPDELEGATE showBarItemWithTitle:@"返回" normalImg:[UIImage imageNamed:@"icontop-back@2x.png"] hightImg:[UIImage imageNamed:@"icontop-back2@2x.png"] viewController:self action:@selector(setBackView)]];

//    [self.navigationItem setRightBarButtonItem:[APPDELEGATE showBarItemWithTitle:@"完成" normalImg:[UIImage imageNamed:@"icontop-normal@2x.png"] hightImg:[UIImage imageNamed:@"icontop-normal2@2x.png"] viewController:self action:@selector(rightBarItemDone:)]];
    
    UIButton *Btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [Btn setFrame:CGRectMake(300, 3, 45, 28)];
    UILabel *rightlab=[[UILabel alloc]initWithFrame:CGRectMake(10, 2, 24, 20)];
    rightlab.text=@"完成";
    rightlab.backgroundColor=[UIColor clearColor];
    [rightlab setTextColor:[UIColor whiteColor]];
    rightlab.font=[UIFont fontWithName:@"Helvetica-Bold" size:12];
    [Btn addSubview:rightlab];
    [Btn setBackgroundImage:[UIImage imageNamed:@"icontop-normal@2x.png"] forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageNamed:@"icontop-normal2@2x.png"] forState:UIControlStateHighlighted];
    [Btn addTarget:self action:@selector(rightBarItemDone:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:Btn];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
}
- (void)rightBarItemDone:(id)sender {
    [SVProgressHUD show];

    NSString *currUId = kUserDefault(kUID);
    NSString *nickName = kUserDefault(kUNickNamm);
    NSString *sig = kUserDefault(kUSignature);
    if (self.userImagePicker) {
        self.userImagePicker = NO;
        //        MyLoadingView *loading = [MyLoadingView viewInSuperView:APPDELEGATE.window];
        //        [loading showAnimated:YES withString:@"上传中..."];
        [RSHTTPMANAGER requesrRestIconWithUID:currUId withIcon:UIImageJPEGRepresentation(self.iconImage.image,1.0) withSuccess:^(id response) {
            //            [loading hiddenAnimated:YES thenRemoveup:YES];
            [APPDELEGATE getNewDataForUserInfoToUserDefault:^(BOOL show) {
                [SVProgressHUD showSuccessWithStatus:@"头像修改成功"];
            } failure:^(NSError *error) {
                
            }];
        } failure:^(NSError *error) {
            //            [loading hiddenAnimated:YES thenRemoveup:YES];
            [SVProgressHUD showErrorWithStatus:@"头像修改失败"];
        }];
    }
    
    __block BOOL isNickNanme = [nameField.text isEqualToString:nickName];
    __block BOOL isSignature = [autographField.text isEqualToString:sig];
    
    
    if (!isNickNanme && isSignature) {
        [RSHTTPMANAGER requestRestNickNameWithUID:currUId WithNickName:nameField.text WithSuccess:^(BOOL isSuccess) {
            if (isSuccess) {
                [SVProgressHUD showSuccessWithStatus:@"昵称修改成功"];
                kUserDefaultSet(nameField.text, kUNickNamm);
            }else{
                [SVProgressHUD showErrorWithStatus:@"昵称修改失败"];
            }
        } failure:^(NSError *error) {
            
        }];
    }else if (isNickNanme && !isSignature){
        [RSHTTPMANAGER requestRestSigNameWithUID:currUId WithNickName:autographField.text WithSuccess:^(BOOL isSuccess) {
            if (isSuccess) {
                [SVProgressHUD showSuccessWithStatus:@"签名修改成功"];
                kUserDefaultSet(autographField.text, kUSignature);

            }else{
                [SVProgressHUD showErrorWithStatus:@"签名修改失败"];
            }
        } failure:^(NSError *error) {
            
        }];
    }else if (!isNickNanme && !isSignature){
        [RSHTTPMANAGER requestRestNickNameWithUID:currUId WithNickName:nameField.text WithSuccess:^(BOOL isSuccess) {
            if (isSuccess) {
                isNickNanme = YES;
                if (isSignature) {
                    [SVProgressHUD showSuccessWithStatus:@"昵称修改成功"];
                    kUserDefaultSet(nameField.text, kUNickNamm);

                }else{
                    [SVProgressHUD showErrorWithStatus:@"昵称修改失败"];
                }
            }else{
                
            }
        } failure:^(NSError *error) {
            
        }];
        
        [RSHTTPMANAGER requestRestSigNameWithUID:currUId WithNickName:autographField.text WithSuccess:^(BOOL isSuccess) {
            if (isSuccess) {
                isSignature = YES;
                if (isNickNanme) {
                    kUserDefaultSet(autographField.text, kUSignature);

                    [SVProgressHUD showSuccessWithStatus:@"签名修改成功"];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"签名修改失败"];
                }
            }else{
                
            }
        } failure:^(NSError *error) {
            
        }];
    }else if (isNickNanme && isSignature){
        [SVProgressHUD showErrorWithStatus:@"亲，没有做任何修改哦"];
    }

}
- (void)showAlbum {
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.delegate = (id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)self;
    self.picker.allowsEditing = YES;
}
-(void)setBackView{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)logoutBtn:(id)sender{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUIcon];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUNickNamm];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUSignature];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUEmail];

    if (IS_IPHONE5) {
        LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPhone5" bundle:nil];
        UINavigationController *navcLogin = [[UINavigationController alloc] initWithRootViewController:loginVC];
//        [self.navigationController pushViewController:loginVC animated:YES];
        APPDELEGATE.window.rootViewController = navcLogin;
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController_Normal" bundle:nil];

        UINavigationController *navcLogin = [[UINavigationController alloc] initWithRootViewController:loginVC];
//    [self.navigationController pushViewController:loginVC animated:YES];
        APPDELEGATE.window.rootViewController = navcLogin;

    }
}

-(NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

-(IBAction)clickDone:(id)sender{
    userName = userNameField.text;
    password = passwordField.text;
    
    NSString *getUserInfo=[NSString stringWithFormat:@"email=%@&passwd=%@",userName,password];  
    NSLog(@"%@",getUserInfo);
        NSData *dealPostData=[getUserInfo dataUsingEncoding:NSUTF8StringEncoding];
        NSURL *webController=[NSURL URLWithString:@"http://www.guo7.com/api/login?"];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:webController];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:dealPostData];
    NSURLConnection *sendRequest=[[NSURLConnection alloc] initWithRequest:request delegate:self];

    if(!sendRequest){
            NSLog(@"%@:::请求访问失败",request);
        }else {
            NSLog(@"%@:::请求访问成功",request);
        }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSLog(@"%@",json);
    userInfo = [json objectForKey:@"id"];
    NSLog(@"%@",userInfo);    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    if ([userName intValue]>0)
    {
        AccountViewController *accountView =[[AccountViewController alloc]init];
        [self.navigationController pushViewController:accountView animated:YES];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"账号密码有误，请检查后登陆" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
    }
    //[dongtai stopAnimating];

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:[error localizedDescription] message:[error localizedFailureReason] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    //[dongtai stopAnimating];
}

-(IBAction)clickPass:(id)sender{
    PasshelpViewController *passView =[[PasshelpViewController alloc]init];
    [self.navigationController pushViewController:passView animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr{
    [userNameField resignFirstResponder];
    [passwordField resignFirstResponder];
    [nameField resignFirstResponder];
    [autographField resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section != 3) {
        return [[self.tablelist objectAtIndex:section] count];

    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 15;
    }
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}
#pragma textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.returnKeyType == UIReturnKeyNext) {
        if (textField.tag == 100) {
            [autographField becomeFirstResponder];            
        }
    }else if (textField.returnKeyType == UIReturnKeyDone) {
        [autographField resignFirstResponder];
    }
    return YES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:17.0f];
        cell.textLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        
        if (indexPath.section != 3) {
            NSUInteger row = [indexPath row];
            
            cell.textLabel.text = [[self.tablelist objectAtIndex:indexPath.section] objectAtIndex:row];
            [self.tablelist objectAtIndex:indexPath.section];
        }
        
        if (indexPath.row == 0 && indexPath.section ==0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell.contentView addSubview:userNameField];
            userNameField.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
            userNameField.font = [UIFont fontWithName:@"Helvetica Neue" size:17.0f];
        }
        if (indexPath.row == 0 && indexPath.section == 1) {
            iconImage = [[UIImageView alloc] init];
            iconImage.frame = CGRectMake(labx, 5, 40, 40);
            [iconImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUIcon]]] placeholderImage:[UIImage imageNamed:@"hi"]];
            [cell.contentView addSubview:iconImage];
        }
        if (indexPath.row == 1 && indexPath.section == 1) {
            [cell.contentView addSubview:nameField];
            nameField.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
            nameField.font = [UIFont fontWithName:@"Helvetica Neue" size:17.0f];
        }
        if (indexPath.row == 0 && indexPath.section == 2) {
            [cell.contentView addSubview:autographField];
            autographField.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
            autographField.font = [UIFont fontWithName:@"Helvetica Neue" size:17.0f];
        }
        if (indexPath.row == 0 && indexPath.section == 3) {
            [cell addSubview:self.cancleLB];
        }

    }
    
    return cell;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"index:%d",buttonIndex);
    if (buttonIndex == 0) {
        NSLog(@"相机");
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.picker.showsCameraControls = YES;
            self.picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            self.picker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
            [self presentViewController:self.picker animated:YES completion:nil];
        }

    }else if (buttonIndex == 1){
        NSLog(@"相册");
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]) {
            self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:self.picker animated:YES completion:nil];
        }
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0) {

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    self.load = [MyLoadingView viewInSuperView:APPDELEGATE.window];
    [self.load showAnimated:YES withString:@"数据处理..."];
    [self performSelector:@selector(showImages:) withObject:info afterDelay:0.1];

    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)showImages:(id)info {
    UIImage *_image = [[info objectForKey:UIImagePickerControllerEditedImage] resizedImageToFitInSize:CGSizeMake(80., 80.) scaleIfSmaller:YES];
    iconImage.image = _image;
    [self.load hiddenAnimated:YES thenRemoveup:YES];
    self.userImagePicker = YES;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 && indexPath.section == 0) {
        ChangeUserInfoViewController *changeVC = [[ChangeUserInfoViewController alloc] init];
        [self.navigationController pushViewController:changeVC animated:YES];
    }
    if (indexPath.row == 0 && indexPath.section == 1) {
        UIActionSheet *a = [[UIActionSheet alloc] initWithTitle:@"头像"
                                                       delegate:(id<UIActionSheetDelegate>)self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"拍照",@"选择照片", nil];
        a.actionSheetStyle = UIBarStyleBlackTranslucent;
        [a showInView:self.view];

    }
    if (indexPath.row == 0 && indexPath.section == 3) {
        [self logoutBtn:nil];
        
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
        lb.text = @"修改登陆账户和密码";
        lb.textAlignment = NSTextAlignmentCenter;
        lb.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        lb.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        lb.backgroundColor = [UIColor clearColor];
        return lb;
    }if (section == 1) {
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
        lb.text = @"昵称三十天只能修改一次";
        lb.textAlignment = NSTextAlignmentCenter;
        lb.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        lb.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        lb.backgroundColor = [UIColor clearColor];
        return lb;
    }if (section == 2) {
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
        lb.text = @"签名限定最多十个字";
        lb.textAlignment = NSTextAlignmentCenter;
        lb.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        lb.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        lb.backgroundColor = [UIColor clearColor];
        return lb;
    }
    return nil;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location>=10)
    {
        return  NO;
    }
    else
    {
        return YES;
    }
}

@end
