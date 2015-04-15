//
//  BFTestViewController.h
//  E-magazine
//
//  Created by Yann on 13-1-25.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFTestViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet CPTGraphHostingView *hostView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
