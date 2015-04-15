//
//  klpView.m
//  king
//
//  Created by iMac-User4 on 12-5-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "klpView.h"

@implementation klpView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    [[UIColor redColor] setStroke];
    CGPathAddRect(path, nil, self.bounds);
    CGContextAddPath(context, path);
    CGContextSetLineWidth(context,3.0f);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
}


@end
