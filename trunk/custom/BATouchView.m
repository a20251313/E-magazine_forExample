//
//  BATouchView.m
//  IRnovationBI
//
//  Created by Yann on 12-12-10.
//
//

#import "BATouchView.h"

@implementation BATouchView
@synthesize delegate;
@synthesize x;
@synthesize x2;
@synthesize touchCount;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    NSArray *touchArray=[[event touchesForView:self] allObjects];
    //    [delegate performSelector:@selector(removeBar1)];
    //    if (touchArray.count==1) {
    //        touchCount++;
    //        //UITouch *touch=[[touches allObjects] objectAtIndex:0];
    //        //CGPoint point=[touch locationInView:self];
    //        //NSLog(@"%@",NSStringFromCGPoint(point));
    //    }else if (touchArray.count==2)
    //    {
    //        touchCount=touchCount+2;
    //    }
    //    NSLog(@"begin count=%d",touchArray.count);
    
    NSArray *touchArray=[[event touchesForView:self] allObjects];
    [delegate performSelector:@selector(removeBar1)];
    if (touchArray.count==1) {
        UITouch *touch=[touchArray objectAtIndex:0];
        CGPoint point=[touch locationInView:self];
        if ([delegate respondsToSelector:@selector(getTouchPointX)]) {
            x=point.x;
            [delegate performSelector:@selector(getTouchPointX)];
        }
        NSLog(@"moveing 1");
    }if (touchArray.count==2) {
        UITouch *touch1=[touchArray objectAtIndex:0];
        CGPoint point1=[touch1 locationInView:self];
        
        UITouch *touch2=[touchArray objectAtIndex:1];
        CGPoint point2=[touch2 locationInView:self];
        if ([delegate respondsToSelector:@selector(getTouchPointX)]) {
            x=point1.x;
            x2=point2.x;
            [delegate performSelector:@selector(getTouchPointX)];
        }
        NSLog(@"moveing 2");
    }
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSArray *touchArray=[[event touchesForView:self] allObjects];
    NSLog(@"end count=%d",touchArray.count);
    if (touchArray.count == 1) {
        NSLog(@"单击");
    }
    if (touchArray.count == 2) {
        NSLog(@"双击");
        [delegate performSelector:@selector(removeBar2)];
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSArray *touchArray=[[event touchesForView:self] allObjects];
    if (touchArray.count==1) {
        UITouch *touch=[touchArray objectAtIndex:0];
        CGPoint point=[touch locationInView:self];
        if ([delegate respondsToSelector:@selector(getTouchPointX)]) {
            x=point.x;
            [delegate performSelector:@selector(getTouchPointX)];
        }
        NSLog(@"moveing 1");
    }if (touchArray.count==2) {
        UITouch *touch1=[touchArray objectAtIndex:0];
        CGPoint point1=[touch1 locationInView:self];
        
        UITouch *touch2=[touchArray objectAtIndex:1];
        CGPoint point2=[touch2 locationInView:self];
        if ([delegate respondsToSelector:@selector(getTouchPointX)]) {
            x=point1.x;
            x2=point2.x;
            [delegate performSelector:@selector(getTouchPointX)];
        }
        NSLog(@"moveing 2");
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"cancel");
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
