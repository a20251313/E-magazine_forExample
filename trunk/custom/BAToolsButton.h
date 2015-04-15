//
//  BAToolsButton.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-11-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAToolsButton : NSObject<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UIViewController *controller;
-(UIBarButtonItem*)generateButtonWithController:(UIViewController*)controller;
-(UIBarButtonItem*)generateButtonWithControllerIphone:(UIViewController *)viewController;
@end
