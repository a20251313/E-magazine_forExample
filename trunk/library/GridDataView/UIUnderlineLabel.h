//
//  UIUnderlineLabel.h
//  gradientView
//
//  Created by aplee on 12-11-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIUnderlineLabel : UILabel
{
    BOOL isLinkable;
}

@property (nonatomic, assign) BOOL isLinkable;

@end
