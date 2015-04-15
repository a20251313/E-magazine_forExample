//
//  BFAppAddInfoView.m
//  E-magazine
//
//  Created by mike.sun on 6/6/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "BFAppAddInfoView.h"

@implementation BFAppAddInfoView
@synthesize suggestLabel;
@synthesize suggestTextView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        suggestLabel = [[UILabel alloc]  initWithFrame:CGRectMake(540/2-400/2, 0, 400, 40)];
        suggestLabel.text = @"有什么需要补充的， 请在下方说明";
        suggestLabel.backgroundColor = [UIColor clearColor];
        suggestLabel.textAlignment = NSTextAlignmentCenter;
        suggestLabel.textColor = [UIColor brownColor];
        suggestLabel.font = [UIFont fontWithName:@"helvetica" size:20];
        [self addSubview:suggestLabel];
        
        suggestTextView = [[UITextView alloc] initWithFrame:CGRectMake(30, 60, 540-30*2, 576-60*2)];
        suggestTextView.layer.borderWidth = 1.1;
        suggestTextView.layer.cornerRadius = 10.0;
        suggestTextView.layer.borderColor = [[UIColor grayColor] CGColor];
        suggestTextView.layer.masksToBounds = YES;
        suggestTextView.font = [UIFont fontWithName:@"helvetica" size:15];
        suggestTextView.returnKeyType = UIReturnKeyDone;
        [self addSubview:suggestTextView];
    }
    return self;
}


@end
