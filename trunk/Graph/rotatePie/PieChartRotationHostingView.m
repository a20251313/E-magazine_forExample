//
//  PieChartRotationHostingView.m
//  PieChartRotation
//
//  Created by zbq on 13-3-28.
//  Copyright (c) 2013年 zbq. All rights reserved.
//

#import "PieChartRotationHostingView.h"

@implementation PieChartRotationHostingView
@synthesize dataSource;
@synthesize arrRate;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initColors];
        self.opaque = YES;
        CPTXYGraph * graph = [[CPTXYGraph alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width,self.frame.size.height)];
        graph.plotAreaFrame.paddingBottom  = 0;
        graph.plotAreaFrame.paddingLeft = 0;
        graph.plotAreaFrame.paddingRight=0;
        graph.plotAreaFrame.paddingTop = 0;
        graph.paddingBottom =0 ;
        graph.paddingLeft = 0;
        graph.paddingRight = 0;
        graph.paddingTop = 0;
        graph.axisSet = nil;
        self.hostedGraph = graph;
//        [graph release];
        
        //Pie plot
        _pie= [[CPTPieChart alloc] initWithFrame:self.hostedGraph.bounds];
        _pie.pieRadius  = self.frame.size.width/2;
        _pie.paddingBottom = 0;
        _pie.paddingLeft = 0;
        _pie.paddingRight= 0;
        _pie.paddingTop = 0;
        _pie.dataSource = self;
        _pie.delegate = self;
        _pie.startAngle = 5.0;
        _pie.centerAnchor = CGPointMake(0.5, 0.5);
        _pie.sliceDirection = CPTPieDirectionCounterClockwise;//逆时针方向
        _pie.labelOffset = -50;
        [self.hostedGraph addPlot:_pie];
        self.layer.masksToBounds =YES;
        
    }
    return self;
}

- (void)initColors{
    arrColors = [[NSMutableArray alloc] init];
    UIColor *color1 = [UIColor colorWithRed:4.0/255.0 green:128.0/255.0 blue:183.0/255.0 alpha:1.0];
    UIColor *color2 = [UIColor colorWithRed:183.0/255.0 green:27.0/255.0 blue:235.0/255.0 alpha:1.0];
    UIColor *color3 = [UIColor colorWithRed:236.0/255.0 green:94.0/255.0 blue:70.0/255.0 alpha:1.0];
    UIColor *color4 = [UIColor colorWithRed:255.0/255.0 green:196.0/255.0 blue:80.0/255.0 alpha:1.0];
    UIColor *color5 = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha:1.0];
    UIColor *color6 = [UIColor colorWithRed:20.0/255.0 green:229.0/255.0 blue:40.0/255.0 alpha:1.0];
    UIColor *color7 = [UIColor colorWithRed:12.0/255.0 green:204.0/255.0 blue:243.0/255.0 alpha:1.0];
    UIColor *color8 = [UIColor colorWithRed:13.0/255.0 green:204.0/255.0 blue:243.0/255.0 alpha:1.0];
    UIColor *color9 = [UIColor colorWithRed:14.0/255.0 green:204.0/255.0 blue:243.0/255.0 alpha:1.0];
    UIColor *color10 = [UIColor colorWithRed:15.0/255.0 green:204.0/255.0 blue:243.0/255.0 alpha:1.0];
    UIColor *color11 = [UIColor colorWithRed:16.0/255.0 green:204.0/255.0 blue:243.0/255.0 alpha:1.0];
    UIColor *color12 = [UIColor colorWithRed:17.0/255.0 green:204.0/255.0 blue:243.0/255.0 alpha:1.0];
    [arrColors addObject:color1];
    [arrColors addObject:color2];
    [arrColors addObject:color3];
    [arrColors addObject:color4];
    [arrColors addObject:color5];
    [arrColors addObject:color6];
    [arrColors addObject:color7];
    [arrColors addObject:color8];
    [arrColors addObject:color9];
    [arrColors addObject:color10];
    [arrColors addObject:color11];
    [arrColors addObject:color12];
}

#pragma mark - CPTPlotDataSource
-(NSUInteger) numberOfRecordsForPlot:(CPTPlot *)plot{
    
    return [dataSource count];
    
}
//每块饼图比例
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    return [arrRate objectAtIndex:index];
}
//饼图标签
-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index
{
    static CPTMutableTextStyle *whiteText = nil;
    
    if ( !whiteText ) {
        whiteText       = [[CPTMutableTextStyle alloc] init];
        whiteText.color = [CPTColor whiteColor];
    }
    
    CPTTextLayer *newLayer = [[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@""]
                                                           style:whiteText];
//    newLayer.backgroundColor = [UIColor greenColor].CGColor;
    return newLayer;
}

-(CPTFill *)sliceFillForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)index{
    CGColorRef colorRef = ((UIColor *)[arrColors objectAtIndex:index]).CGColor;
    CPTColor *cptColor = [CPTColor colorWithCGColor:colorRef];
    CPTFill *cptFill = [CPTFill fillWithColor:cptColor];
    return cptFill;
}

//hit event
-(void)pieChart:(CPTPieChart *)plot sliceWasSelectedAtRecordIndex:(NSUInteger)index
{
    if ([self.delegate respondsToSelector:@selector(sliceWasSelected:)]) {
        [self.delegate sliceWasSelected:index];
    }
//    //指针指向的饼图中间线旋转到目标点
//    CGFloat fStartAngle = [[arrBeginAngle objectAtIndex:index] floatValue];
//    CGFloat fEndAngle = [[arrEndAngle objectAtIndex:index] floatValue];
//    CGFloat fMiddleAngle = [self calcMiddleAngleByOriginalAndDest:fStartAngle destAngle:fEndAngle];
//    CGFloat angleDest = [self angleByPoint2:destPoint center:centerPoint];
//    
//    [UIView beginAnimations:@"rotation" context:nil];
//    [UIView setAnimationDuration:0.3];
//    self.transform = CGAffineTransformRotate(self.transform, (fMiddleAngle-angleDest));
//    [UIView commitAnimations];
//    
//    [self upDateAngleByRotetionAngle:(fMiddleAngle-angleDest)];
}

@end
