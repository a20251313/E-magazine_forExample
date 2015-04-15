//
//  PagesInChapterViewController.h
//  E-magazine
//
//  Created by summer.zhu on 4/23/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PagesInChapterDelegate;

@interface PagesInChapterViewController : UITableViewController

@property(nonatomic, strong) NSMutableArray *arrPages;
@property(nonatomic, assign) id<PagesInChapterDelegate> delegate;

@end

@protocol PagesInChapterDelegate <NSObject>

@optional
- (void)didSelectedRow:(NSInteger)iRow;

@end