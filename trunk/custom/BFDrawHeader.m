//
//  BFDrawHeader.m
//  E-magazine
//
//  Created by sunjian on 13-1-29.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import "BFDrawHeader.h"

@implementation BFDrawHeader
@synthesize backButton;
@synthesize cleanImage;
@synthesize commentButton;
@synthesize toolButton;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (IBAction)backAction:(UIButton *)sender {
    [delegate backAction];
}
- (IBAction)weiboAction:(UIButton *)sender {
    if (delegate && [delegate respondsToSelector:@selector(showLogin)]) {
        [delegate showLogin];
    }
}
- (IBAction)cleanImage:(UIButton *)sender {
    [delegate cleanImage];
}
- (IBAction)generateComment:(UIButton *)sender {
    [delegate generateComment];
}
- (IBAction)showTools:(UIButton *)sender {
    [delegate showTools:toolButton];
}

@end
