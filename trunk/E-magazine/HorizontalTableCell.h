//
//  HorizontalTableCell.h
//  HorizontalTables
//
//  Created by Felipe Laso on 8/19/11.
//  Copyright 2011 Felipe Laso. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFAppDelegate.h"
@interface HorizontalTableCell : UITableViewCell <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_horizontalTableView;
    NSArray *_articles;
    NSString *_categoryName;
    BFAppDelegate *del;
    NSMutableArray *selectedData;
}

@property (nonatomic, retain) UITableView *horizontalTableView;
@property (nonatomic, retain) NSArray *articles;
@property (nonatomic, retain) NSString *categoryName;
@property (nonatomic, retain) NSMutableArray *selectedData;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withArray:(NSArray*)data andCategory:(NSString*)category;

@end
