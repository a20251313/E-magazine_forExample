//
//  BATestViewController.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-11-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BATouchView.h"
@interface BFGraphViewController3 : UIViewController<UITableViewDataSource,UITableViewDelegate,BATouchViewDelegate>
{
    float tempX;
    float tempX2;
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet CPTGraphHostingView *hostView;
@property (strong, nonatomic) IBOutlet UIView *host;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UILabel *metricName;
@property (strong, nonatomic) IBOutlet UILabel *entityName;
@property (strong, nonatomic) IBOutlet UILabel *metricValue;
@property (strong, nonatomic) IBOutlet UISlider *mySlider;
@property (strong, nonatomic) IBOutlet UIImageView *bar;
@property (strong, nonatomic) IBOutlet UIImageView *bar1;
@property (strong, nonatomic) IBOutlet UIImageView *bar2;
@property (strong, nonatomic) IBOutlet BATouchView *touchView;
@property (strong, nonatomic) UILabel *floatingView;
@end
