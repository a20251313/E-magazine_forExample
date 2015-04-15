//
//  BAMicroGraph.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-10-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BAMicroGraph4.h"
#import "BADefinition.h"
@implementation BAMicroGraph4
@synthesize city;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)configure:(BAReport*)report
{

    //获取报表数据
    sourceData=[[NSMutableDictionary alloc]init];
    for(BAMetric *metric in report.reportData.metrics){
        [sourceData setObject:metric.dataValues forKey:metric.metricName];
    }
    
    
    //临时数据用于显示
    tempData=[NSMutableDictionary dictionaryWithDictionary:sourceData];

    self.sourceData=sourceData;
    self.tempData=tempData;
    self.plots=[[NSMutableArray alloc]init];
    BAMetric *metric=[report.reportData.metrics objectAtIndex:0];
    
    CPTBarPlot *barPlot=[[CPTBarPlot alloc]init];
    barPlot.identifier=metric.metricName;
    CPTGradient *gradient=[CPTGradient gradientWithBeginningColor:[BAColorHelper stringToCPTColor:@"c04100" alpha:@"1"] endingColor:[BAColorHelper stringToCPTColor:@"fd8f00" alpha:@"1"] ];
    gradient.angle=90;
    barPlot.fill=[CPTFill fillWithGradient:gradient];
    barPlot.barWidth=CPTDecimalFromFloat(0.8) ;
    [self.plots addObject:barPlot];
    
//    CPTScatterPlot *linePlot=[[CPTScatterPlot alloc]init];
//    linePlot.identifier=metric.metricName;
//    CPTMutableLineStyle *lineStyle=[CPTMutableLineStyle lineStyle];
//    //lineStyle.lineColor=[BAColorHelper stringToCPTColor:@"4482bb" alpha:@"1"];
//    lineStyle.lineColor=[CPTColor grayColor];
//    lineStyle.lineWidth=1.5;
//    linePlot.dataLineStyle=lineStyle;
//    //linePlot.areaFill=[CPTFill fillWithColor:[CPTColor yellowColor]];
//    linePlot.areaBaseValue=[[NSDecimalNumber zero]decimalValue];
//    [self.plots addObject:linePlot];
}
-(void)renderInHostView:(CPTGraphHostingView*)hostView{
    graph=[[CPTXYGraph alloc]initWithFrame:hostView.bounds];
    graph.fill=[CPTFill fillWithColor:[CPTColor clearColor]];
    hostView.hostedGraph=graph;
    graph.paddingBottom=0;
    graph.paddingTop=0;
    [graph removePlotSpace:graph.defaultPlotSpace];
    CPTXYPlotSpace *plotSpace=[[CPTXYPlotSpace alloc] init];
    //plotSpace.allowsUserInteraction=YES;
    [graph addPlotSpace:plotSpace];
    
    NSMutableArray *plotsInSpace1=[[NSMutableArray alloc]init];
    
    for (int i = 0; i<plots.count; i++) {
        CPTPlot *plot=[plots objectAtIndex:i];
        plot.delegate=self;
        plot.dataSource=self;
        [plotsInSpace1 addObject:plot];
        plot.plotSpace=plotSpace;
        [graph addPlot:plot toPlotSpace:plotSpace];
        
        BAAnimationHelper *animation=[[BAAnimationHelper alloc]init];
        [animation plotScaleAnimation:plot];
    }
    [plotSpace scaleToFitPlots:[NSArray arrayWithArray:plotsInSpace1]];
    
    //手动调整y轴显示范围，增加顶端范围
    CPTPlotRange *yRange=plotSpace.yRange;
    NSDecimal length=yRange.length;
    NSDecimal locatoin=yRange.location;
    NSDecimalNumber *a=[[NSDecimalNumber alloc]initWithDecimal:length];
    NSDecimalNumber *b=[[[NSDecimalNumber alloc]initWithDecimal:length] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"0.1"]];
    ;
    NSDecimal newLength=[[a decimalNumberByAdding:b] decimalValue];
    plotSpace.yRange=[[CPTPlotRange alloc]initWithLocation:locatoin length:newLength];
    
    plotSpace.xRange=[CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat([self getMaxRange])];
    
    graph.plotAreaFrame.paddingBottom=10;
    graph.plotAreaFrame.paddingLeft=0;
    graph.plotAreaFrame.paddingTop=10;
    graph.plotAreaFrame.paddingRight=0;
    
}
-(UIImage*)microImage
{
    graph=[[CPTXYGraph alloc]initWithFrame:CGRectMake(0, 0, 595, 60)];

    //hostView.hostedGraph=graph;
    graph.paddingBottom=0;
    graph.paddingTop=0;
    graph.paddingLeft=0;
    graph.paddingRight=0;
    [graph removePlotSpace:graph.defaultPlotSpace];
    CPTXYPlotSpace *plotSpace=[[CPTXYPlotSpace alloc] init];
    //plotSpace.allowsUserInteraction=YES;
    [graph addPlotSpace:plotSpace];
    
    NSMutableArray *plotsInSpace1=[[NSMutableArray alloc]init];
    
    for (int i = 0; i<plots.count; i++) {
        CPTPlot *plot=[plots objectAtIndex:i];
        plot.delegate=self;
        plot.dataSource=self;
        [plotsInSpace1 addObject:plot];
        plot.plotSpace=plotSpace;
        [graph addPlot:plot toPlotSpace:plotSpace];
        
        BAAnimationHelper *animation=[[BAAnimationHelper alloc]init];
        [animation plotScaleAnimation:plot];
    }
    [plotSpace scaleToFitPlots:[NSArray arrayWithArray:plotsInSpace1]];
    
    //手动调整y轴显示范围，增加顶端范围
    CPTPlotRange *yRange=plotSpace.yRange;
    NSDecimal length=yRange.length;
    NSDecimal locatoin=yRange.location;
    NSDecimalNumber *a=[[NSDecimalNumber alloc]initWithDecimal:length];
    NSDecimalNumber *b=[[[NSDecimalNumber alloc]initWithDecimal:length] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"0.1"]];
    ;
    NSDecimal newLength=[[a decimalNumberByAdding:b] decimalValue];
    plotSpace.yRange=[[CPTPlotRange alloc]initWithLocation:locatoin length:newLength];
    
    plotSpace.xRange=[CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat([self getMaxRange])];
    
    graph.plotAreaFrame.paddingBottom=10;
    graph.plotAreaFrame.paddingLeft=0;
    graph.plotAreaFrame.paddingTop=10;
    graph.plotAreaFrame.paddingRight=0;
    [graph setTransform:CATransform3DMakeRotation(M_PI, 1, 0, 1)];
    UIGraphicsBeginImageContext(graph.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [graph renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{
    //NSLog(plot.identifier);
    NSMutableArray *dataValues=[tempData objectForKey:(NSString*)plot.identifier];
    return [dataValues count];
}
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index{
    NSMutableArray *dataValues=[tempData objectForKey:(NSString*)plot.identifier];
    NSNumber *number=nil;
    
    switch (fieldEnum) {
        case CPTScatterPlotFieldX:
            number=[NSNumber numberWithFloat:index+0.5];
            break;
            
        case CPTScatterPlotFieldY:
            number=[dataValues objectAtIndex:index];
            break;
    }
    return number;
}

@end
