//
//  AccountViewController.h
//  GPlay
//
//  Created by zucknet on 12/11/2.
//  Copyright (c) 2012年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UITableViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSArray *list1;
    NSArray *list2;
    NSArray *list3;
    NSArray *list4;
    NSMutableArray *listAll;
    UITableView *_tableView;
    UITextField *nickname;
    UITextField *moodname;
    UILabel *maplabel;
    NSString *mapname;
    UIImagePickerController *imagePicker;
    UIActionSheet *myActionSheet;
}

@end
