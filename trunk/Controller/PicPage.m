//
//  PicPage.m
//  E-magazine
//
//  Created by mike.sun on 6/28/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "PicPage.h"

@implementation PicPage
@synthesize image;
@synthesize imageName;
@synthesize imageNamePor;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        image = [[UIImageView alloc] init];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        self.image.frame = CGRectMake(0, 0, 768, 1004);
        image.image=[UIImage imageWithContentsOfFile:imageNamePor];
    }
    else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        self.image.frame = CGRectMake(0, 0, 1024, 748);
        image.image=[UIImage imageWithContentsOfFile:imageName];
    }
    [self addSubview:image];
}
-(void)changeFramesWhenRotate{
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        self.image.frame = CGRectMake(0, 0, 768, 1004);
        image.image=[UIImage imageWithContentsOfFile:imageNamePor];
    }
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        self.image.frame = CGRectMake(0, 0, 1024, 748);
        image.image=[UIImage imageWithContentsOfFile:imageName];
    }
}

@end
