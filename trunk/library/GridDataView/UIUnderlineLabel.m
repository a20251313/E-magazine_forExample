//
//  UIUnderlineLabel.m
//  gradientView
//
//  Created by aplee on 12-11-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIUnderlineLabel.h"

@implementation UIUnderlineLabel
@synthesize isLinkable;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        isLinkable = NO;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        isLinkable = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        isLinkable = NO;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (isLinkable) {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetRGBStrokeColor(ctx, 0.0f/255.0f, 0.0f/255.0f, 255.0f/255.0f, 1.0f); // RGBA
        CGContextSetLineWidth(ctx, 1.0f);
        
        float yPositon = self.font.lineHeight + self.font.descender + (self.bounds.size.height-self.font.lineHeight)/2.0f;
        //NSLog(@"lineheight: %f, descender: %f", self.font.lineHeight, self.font.descender);
        float textWidth = [self.text sizeWithFont:self.font].width;
        float totalWidth = self.bounds.size.width;
        if (self.textAlignment == UITextAlignmentLeft) {
            CGContextMoveToPoint(ctx, 0, yPositon);
            CGContextAddLineToPoint(ctx, textWidth, yPositon);
        }
        else if(self.textAlignment == UITextAlignmentCenter)
        {
            CGContextMoveToPoint(ctx, (totalWidth-textWidth)/2, yPositon);
            CGContextAddLineToPoint(ctx, (totalWidth+textWidth)/2, yPositon);
        }
        else {
            //UITextAlignmentRight
            CGContextMoveToPoint(ctx, (totalWidth-textWidth), yPositon);
            CGContextAddLineToPoint(ctx, totalWidth, yPositon);
        }
        
        
        CGContextStrokePath(ctx);
        
        self.textColor = [UIColor blueColor];
        
    }
    
    [super drawRect:rect];
}


@end
