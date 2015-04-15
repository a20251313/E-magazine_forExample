//
//  BFRootViewController.h
//  E-magazine
//
//  Created by zhonghao zhang on 1/29/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLView.h"
#import "PLJSONLoader.h"
#import "BFScrollViewController.h"
#import "BFGraphViewController1.h"
#import "BFGraphViewController2.h"
#import "BFGraphViewController3.h"
#import "BFTestViewController.h"
#import "BFRootViewController.h"

@interface BFRootViewController : UIViewController <PLViewDelegate>
{
@private
    PLView *plView;
}

@end
