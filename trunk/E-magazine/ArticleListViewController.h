//
//  ArticleListViewController.h
//  HorizontalTables
//
//  Created by Felipe Laso on 8/6/11.
//  Copyright 2011 Felipe Laso. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFAppDelegate.h"

@interface ArticleListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary *articleDictionary;
    NSArray* sortedCategories;
    UITableView *customTable;
    
    UIBarButtonItem *backButton;
    UIBarButtonItem *editButton;
    UIBarButtonItem *cancelButton;
    UIBarButtonItem *deleteButton;
    BFAppDelegate *del;

}

@property (nonatomic, retain) UITableView *customTable;
@property (nonatomic, retain) NSDictionary *articleDictionary;
@property (nonatomic, retain) NSArray *sortedCategories;
@end
