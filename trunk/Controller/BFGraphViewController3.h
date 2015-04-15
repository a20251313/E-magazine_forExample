//
//  BFGraphViewController3ViewController.h
//  E-magazine
//
//  Created by yann.cai on 5/9/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BATouchView.h"
@interface BFGraphViewController3 : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
}
@property (nonatomic,weak) IBOutlet CPTGraphHostingView *hostView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@end
