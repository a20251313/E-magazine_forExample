//
//  BFFootView.m
//  BizFocus-periodical
//
//  Created by Yann on 13-1-23.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import "BFFootView.h"

@implementation BFFootView
@synthesize pageLabel;

#pragma mark -
#pragma mark scroll delegate method
-(void)didScrollToPage:(BAScrollView *)scrollView page:(NSInteger)page
{
    pageLabel.text=[NSString stringWithFormat:@"%d",page+1];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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
