//
//  BFMenuHeaderView.m
//  E-magazine
//
//  Created by sunjian on 13-1-30.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import "BFMenuHeaderView.h"

@implementation BFMenuHeaderView
@synthesize menuBtn2;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (IBAction)hideMenuBtn:(UIButton *)sender {
    if (delegate && [delegate respondsToSelector:@selector(hideContent:)]) {
        [delegate hideContent:menuBtn2];
    }
}

@end
