//
//  BAEntitySliderControl.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BAEntitySliderControl.h"
#import "BAAnimationHelper.h"

@implementation BAEntitySliderControl

@synthesize slider;

-(NMRangeSlider*)configureEntitySliderControl
{
    slider=[[NMRangeSlider alloc]initWithFrame:CGRectMake(0,0, 300, 50)];
    UIImage* image = nil;
    
    
    image = [UIImage imageNamed:@"slider-metal-trackBackground"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)];
    slider.trackBackgroundImage = image;
    
    image = [UIImage imageNamed:@"slider-metal-track"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 7.0)];
    slider.trackImage = image;
    
    image = [UIImage imageNamed:@"slider-metal-handle"];
    slider.lowerHandleImageNormal = image;
    slider.upperHandleImageNormal = image;
    
    image = [UIImage imageNamed:@"slider-metal-handle-highlighted"];
    slider.lowerHandleImageHighlighted = image;
    slider.upperHandleImageHighlighted = image;
    
    CPTPlot *plot=[[[baseGraph graph] allPlots]objectAtIndex:0];
    
    NSUInteger count=plot.cachedDataCount;
    
    
    slider.maximumValue=count-1;
    slider.minimumValue=0;
    slider.upperValue=count-1;
    slider.stepValue=1;
    slider.stepValueContinuously=YES;
    
    //[slider addTarget:self action:@selector(changeEntity:) forControlEvents:UIControlEventValueChanged];
    return slider;
}
-(NMRangeSlider*)configureWithBounds:(CGRect)bounds
{
    slider=[[NMRangeSlider alloc]initWithFrame:bounds];
    UIImage* image = nil;
    
    image = [UIImage imageNamed:@"graph2-track2"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)];
    slider.trackBackgroundImage = image;
    
    image = [UIImage imageNamed:@"graph2-track1-80"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 7.0)];
    slider.trackImage = image;
    
    image = [UIImage imageNamed:@"graph2thumb"];
    slider.lowerHandleImageNormal = image;
    slider.upperHandleImageNormal = image;
    
    image = [UIImage imageNamed:@"graph2thumb"];
    slider.lowerHandleImageHighlighted = image;
    slider.upperHandleImageHighlighted = image;
    
    
    CPTPlot *plot=[[[baseGraph graph] allPlots]objectAtIndex:0];
    
    NSUInteger count=plot.cachedDataCount;
    
    
    slider.maximumValue=count-1;
    slider.minimumValue=0;
    slider.upperValue=count-1;
    slider.stepValue=1;
    slider.stepValueContinuously=NO;
    
    //[slider addTarget:self action:@selector(changeEntity:) forControlEvents:UIControlEventValueChanged];
    return slider;
}
-(void)changeEntity:(float)lowerValue upperValue:(float)upperValue
{
    
    NSRange range=NSMakeRange((int)lowerValue,(int)upperValue+1-(int)lowerValue);
    //改变显示范围
    //CPTXYPlotSpace *plotSpace=(CPTXYPlotSpace*) baseGraph.graph.defaultPlotSpace;
    CPTXYPlotSpace *plotSpace1=(CPTXYPlotSpace*)[baseGraph.graph plotSpaceAtIndex:0];
    CPTXYPlotSpace *plotSpace2=(CPTXYPlotSpace*)[baseGraph.graph plotSpaceAtIndex:1];
    plotSpace1.xRange=[CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat(range.length)];
    plotSpace2.xRange=[CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat(range.length)];
    //改变值
    NSMutableDictionary *tempData=[[NSMutableDictionary alloc]init];
    for (NSString *key in baseGraph.sourceData) {
        NSMutableArray *dataValues=[baseGraph.sourceData objectForKey:key];
        //NSMutableArray *tempDataValues=[baseGraph.tempData objectForKey:key];
        NSMutableArray * tempDataValues=[NSMutableArray arrayWithArray:[dataValues objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range]]];
        [tempData setValue:tempDataValues forKey:key];
    }
    baseGraph.tempData=tempData;
    //改变label
    NSMutableArray *tempLabel=[NSMutableArray arrayWithArray:[baseGraph.sourceLabel objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range]]];
    baseGraph.tempLabel=[NSMutableArray arrayWithArray:[baseGraph.sourceLabel objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range]]];
    CPTMutableTextStyle *textStyle=[CPTMutableTextStyle textStyle];
    textStyle.color=[CPTColor whiteColor];
    textStyle.fontSize=12;
    NSMutableArray *xlabels=[[NSMutableArray alloc]init ];
    for (int i=0; i<tempLabel.count; i++) {
        CPTAxisLabel *xlabel;
        if (i%5==0) {
            xlabel=[[CPTAxisLabel alloc]initWithText:[tempLabel objectAtIndex:i] textStyle:textStyle];
        }else
        {
            xlabel=[[CPTAxisLabel alloc]initWithText:@"" textStyle:textStyle];
        }
        xlabel.tickLocation=[[NSDecimalNumber numberWithFloat:i+0.5] decimalValue];
        xlabel.offset=5;
        [xlabels addObject:xlabel];
    }
    CPTXYAxisSet *axisSet=(CPTXYAxisSet*)baseGraph.graph.axisSet;
    CPTXYAxis *x=axisSet.xAxis;
    x.axisLabels=[NSSet setWithArray:xlabels];
    
    //重定义Y2轴位置
    if(axisSet.axes.count>2){
        CPTXYAxis *y2=[axisSet.axes objectAtIndex:2];
        y2.orthogonalCoordinateDecimal=CPTDecimalFromFloat(range.length);
    }
    
    
    [baseGraph.graph reloadData];
    
    //动画
    BAAnimationHelper *animation=[[BAAnimationHelper alloc]init];
    for(CPTPlot *plot in baseGraph.graph.allPlots)
    {
        [animation plotScaleAnimation:plot];
    }

}
- (void)changeEntity:(NSNotification *)note {
    float lowerValue=[[[note userInfo]objectForKey:@"lowerValue"] intValue];
    float upperValue=[[[note userInfo]objectForKey:@"upperValue"] intValue];
    NSRange range=NSMakeRange(lowerValue,upperValue+1-lowerValue);
    //改变显示范围
    //CPTXYPlotSpace *plotSpace=(CPTXYPlotSpace*) baseGraph.graph.defaultPlotSpace;
    CPTXYPlotSpace *plotSpace1=(CPTXYPlotSpace*)[baseGraph.graph plotSpaceAtIndex:0];
    CPTXYPlotSpace *plotSpace2=(CPTXYPlotSpace*)[baseGraph.graph plotSpaceAtIndex:1];
    plotSpace1.xRange=[CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat(range.length)];
    plotSpace2.xRange=[CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat(range.length)];
    //改变值
    NSMutableDictionary *tempData=[[NSMutableDictionary alloc]init];
    for (NSString *key in baseGraph.sourceData) {
        NSMutableArray *dataValues=[baseGraph.sourceData objectForKey:key];
        //NSMutableArray *tempDataValues=[baseGraph.tempData objectForKey:key];
         NSMutableArray *tempDataValues=[NSMutableArray arrayWithArray:[dataValues objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range]]];
        [tempData setValue:tempDataValues forKey:key];
    }
    baseGraph.tempData=tempData;
    //改变label
    NSMutableArray *tempLabel=[NSMutableArray arrayWithArray:[baseGraph.sourceLabel objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range]]];
    baseGraph.tempLabel=[NSMutableArray arrayWithArray:[baseGraph.sourceLabel objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range]]];
    CPTMutableTextStyle *textStyle=[CPTMutableTextStyle textStyle];
    textStyle.color=[CPTColor grayColor];
    textStyle.fontSize=12;
    NSMutableArray *xlabels=[[NSMutableArray alloc]init ];
    for (int i=0; i<tempLabel.count; i++) {
        CPTAxisLabel *xlabel=[[CPTAxisLabel alloc]initWithText:[tempLabel objectAtIndex:i] textStyle:textStyle];
        xlabel.tickLocation=[[NSDecimalNumber numberWithFloat:i+0.5] decimalValue];
        xlabel.offset=5;
        [xlabels addObject:xlabel];
    }
    CPTXYAxisSet *axisSet=(CPTXYAxisSet*)baseGraph.graph.axisSet;
    CPTXYAxis *x=axisSet.xAxis;
    x.axisLabels=[NSSet setWithArray:xlabels];
    
    //重定义Y2轴位置
    if(axisSet.axes.count>2){
        CPTXYAxis *y2=[axisSet.axes objectAtIndex:2];
        y2.orthogonalCoordinateDecimal=CPTDecimalFromFloat(range.length);
    }


    [baseGraph.graph reloadData];

    //动画
    BAAnimationHelper *animation=[[BAAnimationHelper alloc]init];
    for(CPTPlot *plot in baseGraph.graph.allPlots)
    {
        [animation plotScaleAnimation:plot];
    }
    
    
}
- (id)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc removeObserver:self];
        [nc addObserver:self
               selector:@selector(changeEntity:)
                   name:@"entitySliderNotification"
                 object:nil];
    }
    return self;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
