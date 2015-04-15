//
//  BFMenuHeaderView.h
//  E-magazine
//
//  Created by sunjian on 13-1-30.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFHeaderViewDelegate.h"

@interface BFMenuHeaderView : UIView

@property (strong, nonatomic) IBOutlet UIButton *menuBtn2;
@property (assign, nonatomic) id<BFHeaderViewDelegate> delegate;

@end
