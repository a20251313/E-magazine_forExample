//
//  BAListControl.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-11-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BABaseControl.h"
#import "BADefinition.h"
@interface BAListControl : BABaseControl<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) CPTGraphHostingView *hostView;
@property (nonatomic,strong) UIPopoverController *popover;
@property (nonatomic,strong) UIButton *button;
-(void)showPopover;
@end
