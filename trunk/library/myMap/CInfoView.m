//
//  CInfoView.m
//  myMapDemo
//
//  Created by aplee on 12-11-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CInfoView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CInfoView
@synthesize delegate;
@synthesize titleName;
@synthesize cityName;
@synthesize extraInfo1;
@synthesize extraValue1;
@synthesize extraInfo2;
@synthesize extraValue2;
@synthesize isRespond;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self configue];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self configue];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configue];
    }
    return self;
}

-(void)configue
{
    UIView* view = [[[NSBundle mainBundle] loadNibNamed:@"clusteInfoView" owner:self options:nil] lastObject];
    [self addSubview:view];
    [self sizeToFit];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [btn setFrame:CGRectMake(181, 0, 31, 31)];
    [btn addTarget:self action:@selector(press) forControlEvents:UIControlEventTouchUpInside];

    [view addSubview:btn];
    
    [self.layer setCornerRadius:10.0];
    [self setClipsToBounds:YES];
}

-(void)press
{
    if ([delegate respondsToSelector:@selector(onRightBtnPress)]) {
        [delegate onRightBtnPress];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
