//
//  BFScrollViewController.h
//  BizFocus-periodical
//
//  Created by Yann on 13-1-23.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAScrollView.h"
@interface BFScrollViewController : UIViewController<BAScrollViewDataSource,UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet BAScrollView *scrollView;

@end
