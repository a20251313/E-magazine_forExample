//
//  BFDrawHeader.h
//  E-magazine
//
//  Created by sunjian on 13-1-29.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFHeaderViewDelegate.h"

@interface BFDrawHeader : UIView
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *weiboBtn;
@property (strong, nonatomic) IBOutlet UIButton *cleanImage;
@property (strong, nonatomic) IBOutlet UIButton *commentButton;
@property (strong, nonatomic) IBOutlet UIButton *toolButton;
@property (assign, nonatomic) id<BFHeaderViewDelegate> delegate;

@end
