//
//  BFRootViewController.h
//  E-magazine
//
//  Created by zhonghao zhang on 1/29/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import "PLView.h"
#import "PLJSONLoader.h"
#import "UIGridViewRow.h"
#import "BFGraphViewController1.h"
#import "BFGraphViewController2.h"
#import "BFGraphViewController3.h"
#import "BFTestViewController.h"
#import "BFPageViewController.h"

@interface BFRootViewController : UIViewController<PLViewDelegate,UITableViewDataSource,UITableViewDelegate,GridViewRowDelegate>
{
    IBOutlet UITableView *tableviewBook;
    NSMutableArray *arrDataBook;
    @private
    PLView *plView;
}

@property (nonatomic, strong) IBOutlet UIView *BackGroundView;
@property (nonatomic, strong) NSMutableArray *arrBookMarksStr;
@property (nonatomic, strong) NSMutableArray *arrMsgKey;
@property (nonatomic, strong) NSMutableArray *arrViewsIndex;
@property (nonatomic, strong) NSMutableArray *arrViewsAtIndex;
@property (nonatomic, strong) NSMutableArray *arrTitles;

@end
