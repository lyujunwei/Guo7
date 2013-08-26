//
//  PopularViewController.h
//  Apper
//
//  Created by ZuckBot on 12/9/29.
//  Copyright (c) 2012年 Zack3tt. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AppsCell.h"

@interface SearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITextFieldDelegate>{
    NSArray *tablelist;
    BOOL showDevice;
    BOOL showSort;
    UIButton *tabbtn1;
    UIButton *tabbtn3;
    
    UISearchBar *_searchBar;
    UITextField *searchField;
    
    UIView *hiddenmyTableView;
}

@property(nonatomic,retain) UITableView *myTableView;
@property (nonatomic, retain) UITableView *selectTableView;
@property(nonatomic,retain)NSArray *tablelist;
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UIView *backView;
@property (nonatomic, retain) NSArray *sortArr;
@property (nonatomic, retain) UIButton *tabbtn1;
@property (nonatomic, retain) UIButton *tabbtn3;



@end
