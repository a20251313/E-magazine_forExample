//
//  BFAppReportViewController.h
//  E-magazine
//
//  Created by mike.sun on 6/6/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFAppReportView.h"
@interface BFAppReportViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (assign,nonatomic) id delegate;
@property(nonatomic, strong) NSArray *users;
@property (nonatomic ,strong) BFAppReportView *appReportView;

@end

@protocol BFAppReportDelegate <NSObject>
-(void)dismissController;
@end
