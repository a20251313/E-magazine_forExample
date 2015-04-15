//
//  BFGraphViewController4.h
//  E-magazine
//
//  Created by Yann on 13-1-28.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFGraphViewController4 : UIViewController<UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *leftTable;
@property (strong, nonatomic) IBOutlet UITableView *rightTable;
@property (strong, nonatomic) IBOutlet UIScrollView *topScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *rightScrollView;

@end
