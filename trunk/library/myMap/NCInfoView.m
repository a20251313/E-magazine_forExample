//
//  NCInfoView.m
//  myMapDemo
//
//  Created by aplee on 12-11-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NCInfoView.h"

@implementation NCInfoView
@synthesize cityName;
//@synthesize longitude;
//@synthesize latitude;
@synthesize extraInfo1;
@synthesize extraValue1;
@synthesize extraInfo2;
@synthesize extraValue2;

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
    UIView* view = [[[NSBundle mainBundle] loadNibNamed:@"nonClusteInfoView" owner:self options:nil] lastObject];
    [self addSubview:view];
    [self sizeToFit];
    
    [self.layer setCornerRadius:10.0];
    [self setClipsToBounds:YES];
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
