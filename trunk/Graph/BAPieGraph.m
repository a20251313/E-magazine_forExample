//
//  BAPieGraph.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BAPieGraph.h"
#import "BAColorHelper.h"
#import "BAAnimationHelper.h"
#import "BAReport.h"
#import "BAMetric.h"

@implementation BAPieGraph
{
    bool isLongPress;
}

-(void)configurePlots:(BAReport*)report hostView:(CPTGraphHostingView*)hostView
{
    
    NSMutableDictionary *sourceDataD=[[NSMutableDictionary alloc]init];
    BAMetric *metric=[report.reportData.metrics objectAtIndex:0];
    NSMutableArray* tempArrayD = [NSMutableArray arrayWithArray:metric.dataValues];
    //for(BAMetric *metric in report.reportData.metrics){
    //    [tempArrayD addObject:metric.dataValues];
    //}
    [sourceDataD setObject:tempArrayD forKey:report.reportName];
    
    //临时数据用于显示
    NSMutableDictionary *tempDataD=[NSMutableDictionary dictionaryWithDictionary:sourceDataD];
    
    //获取报表label
    NSMutableArray *sourceLabelD=[[NSMutableArray alloc] init];
    for(NSString *entity in report.reportData.entity.entityValues){
        [sourceLabelD addObject:entity];
    }
    NSMutableArray *tempLabelD=[NSMutableArray arrayWithArray:sourceLabelD];
    
    self.sourceData=sourceDataD;
    self.tempData=tempDataD;
    self.sourceLabel=sourceLabelD;
    self.tempLabel=tempLabelD;
    self.plots=[[NSMutableArray alloc]init];
    
    for (int i=0; i<report.reportData.metrics.count; i++) {
        BAMetric *metric=[report.reportData.metrics objectAtIndex:i];
        CPTPieChart *piePlot=[[CPTPieChart alloc]init];
        piePlot.identifier=report.reportName;
        CPTGradient *overlayGradient = [[CPTGradient alloc] init];
        overlayGradient.gradientType = CPTGradientTypeRadial;
        overlayGradient				 = [overlayGradient addColorStop:[[BAColorHelper stringToCPTColor:metric.fillColor.color1 alpha:@"0.5"] colorWithAlphaComponent:0.01] atPosition:0.6];
        overlayGradient				 = [overlayGradient addColorStop:[[BAColorHelper stringToCPTColor:metric.fillColor.color2 alpha:@"0.5"] colorWithAlphaComponent:0.1] atPosition:0.9];
        
        piePlot.pieRadius  = 0.75 * hostView.frame.size.height/2 ;
        piePlot.startAngle	   = M_PI_2;
        piePlot.sliceDirection = CPTPieDirectionCounterClockwise;
        piePlot.overlayFill	   = [CPTFill fillWithGradient:overlayGradient];
        //CPTMutableLineStyle *lineStyle=[CPTMutableLineStyle lineStyle];
        //lineStyle.lineColor=[BAColorHelper stringToCPTColor:metric.fillColor.color1 alpha:metric.fillColor.alpha];
        //linePlot.dataLineStyle=lineStyle;
        
        [self.plots addObject:piePlot];
    }

	

}
-(void)registeGuesture:(CPTGraphHostingView*)hostView
{
    
    UISwipeGestureRecognizer *swipeToRight = 
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToRight:)];
    [swipeToRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [hostView addGestureRecognizer:swipeToRight];
    
    //向左滑动
    UISwipeGestureRecognizer *swipeToLeft = 
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToLeft:)];
    [swipeToLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [hostView addGestureRecognizer:swipeToLeft];
    
    //向下滑动
    UISwipeGestureRecognizer *swipToDown=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeToDown:)];
    [swipToDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [hostView addGestureRecognizer:swipToDown];
    
    //向上滑动
    UISwipeGestureRecognizer *swipToUp=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeToUp:)];
    [swipToUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [hostView addGestureRecognizer:swipToUp];
    
}

-(void)renderPlots
{
    for (CPTPlot *plot in plots) {
        plot.delegate=self;
        plot.dataSource=self;
        
    }
    BAAnimationHelper *animation=[[BAAnimationHelper alloc]init];
    [animation plotRatationAnimation:[plots objectAtIndex:0] graph:graph];
    //[graph addPlot:[plots objectAtIndex:0]];

}
-(void)renderLegendInHostView:(CPTGraphHostingView *)hostView
{
    CPTLegend *theLegend=[CPTLegend legendWithGraph:graph];
    //theLegend.numberOfRows	  = 12;
	//theLegend.borderLineStyle = axisLineStyle;
	theLegend.cornerRadius	  = 10.0;
	theLegend.swatchSize	  = CGSizeMake(20.0, 20.0);
	theLegend.columnMargin=10;
	theLegend.paddingRight	  = 0.0;
    theLegend.numberOfColumns=1;
    graph.legendAnchor		 = CPTRectAnchorRight;
    graph.legend=theLegend;
}
-(void)renderInHostView:(CPTGraphHostingView*)hostView{
    graph=[[CPTXYGraph alloc]initWithFrame:hostView.bounds];
    hostView.hostedGraph=graph;
    //graph.fill=[CPTFill fillWithColor:[CPTColor redColor]]
    
    
    graph.axisSet = nil;

    graph.paddingBottom=20;
    myHostView=hostView;
    [self renderPlots];
    [self renderLegendInHostView:hostView];
    [self registeGuesture:myHostView];
}

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{

    NSMutableArray *dataValues=[tempData objectForKey:(NSString*)plot.identifier];
    return [dataValues count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index{
    NSMutableArray *dataValues=[tempData objectForKey:(NSString*)plot.identifier];
    NSNumber *number=nil;
    if (fieldEnum==CPTPieChartFieldSliceWidth) {
        number=[dataValues objectAtIndex:index];
    }else {
        number=[NSNumber numberWithInt:index];
    }
    return number;
}
-(NSString *)legendTitleForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)index{
    return [tempLabel objectAtIndex:index];
}
-(CPTFill *)sliceFillForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)index
{
    
    CPTFill *fill=[CPTFill fillWithColor:[BAColorHelper stringToCPTColor:[defaultColors objectAtIndex:index%defaultColors.count] alpha:@"1"]] ;
    return fill;
}
-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index{
    NSMutableArray *dataValues=[tempData objectForKey:(NSString*)plot.identifier];
    float dataValue=[[dataValues objectAtIndex:index] floatValue];
    if(index==selectedIndex){
        CPTMutableTextStyle *textStyle=[CPTMutableTextStyle textStyle];
        textStyle.fontSize=14;
        textStyle.color=[CPTColor blueColor];
        CPTTextLayer *textLayer=[[CPTTextLayer alloc]initWithText:[NSString stringWithFormat:@"%.2f",dataValue] style:textStyle];
        plot.labelOffset=-50;
        return textLayer;
    }
    return nil;
}
-(void)longPress:(NSMutableDictionary*)params
{
    if (isLongPress) {
        NSLog(@"longPress");
    }
}
-(void)pieChart:(CPTPieChart *)plot sliceWasSelectedAtRecordIndex:(NSUInteger)index{
    /*
    CPTMutableTextStyle *hitAnnotationTextStyle = [CPTMutableTextStyle textStyle];
    hitAnnotationTextStyle.color	= [CPTColor blueColor];
    hitAnnotationTextStyle.fontSize = 16.0f;
    hitAnnotationTextStyle.fontName = @"Helvetica-Bold";
    NSArray *plotPoint = [NSArray arrayWithObjects:[NSNumber numberWithInteger:200], [NSNumber numberWithInteger:30], nil];
    
	CPTPlotSpaceAnnotation *legendAnnotation = [[CPTPlotSpaceAnnotation alloc] initWithPlotSpace:plot.plotSpace anchorPlotPoint:plotPoint];
    CPTTextLayer *textLayer = [[CPTTextLayer alloc] initWithText:@"hahaha" style:hitAnnotationTextStyle];
	legendAnnotation.contentLayer = textLayer;    
    
	legendAnnotation.contentAnchorPoint = CGPointMake(0, 0);
    legendAnnotation.displacement=CGPointMake(0, 0);
	[graph.plotAreaFrame.plotArea addAnnotation:legendAnnotation];
    */
    isLongPress=YES;
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObjectsAndKeys:plot,@"plot",[NSString stringWithFormat:@"%d", index],@"index", nil];
    [self performSelector:@selector(longPress:) withObject:params afterDelay:1];
    
    //[plot reloadData];
    selectedIndex=index;
    [graph reloadData];
}

-(BOOL)plotSpace:(CPTPlotSpace *)space shouldHandlePointingDeviceUpEvent:(id)event atPoint:(CGPoint)point
{
    isLongPress=NO;
    selectedIndex=-1;
    return YES;
}
- (void)swipeToRight:(UISwipeGestureRecognizer *)recognizer
{   
    CGPoint point = [recognizer locationInView:myHostView.superview];
    CGPoint plotAreaPoint=[myHostView.superview.layer convertPoint:point toLayer:graph];
    CGPoint center=[myHostView.superview.layer convertPoint:myHostView.center toLayer:graph];
    if(plotAreaPoint.y>center.y){
        [BAAnimationHelper plotRatationAnimation:[[graph allPlots]objectAtIndex:0] direction:0];
    }else {
        [BAAnimationHelper plotRatationAnimation:[[graph allPlots]objectAtIndex:0] direction:1];
    }
}

- (void)swipeToLeft:(UISwipeGestureRecognizer *)recognizer 
{ 
    CGPoint point = [recognizer locationInView:myHostView.superview];
    CGPoint plotAreaPoint=[myHostView.superview.layer convertPoint:point toLayer:graph];
    CGPoint center=[myHostView.superview.layer convertPoint:myHostView.center toLayer:graph];
    if(plotAreaPoint.y>center.y){
        [BAAnimationHelper plotRatationAnimation:[[graph allPlots]objectAtIndex:0] direction:1];
    }else {
        [BAAnimationHelper plotRatationAnimation:[[graph allPlots]objectAtIndex:0] direction:0];
    }
}

- (void)swipeToDown:(UISwipeGestureRecognizer *)recognizer 
{   
    CGPoint point = [recognizer locationInView:myHostView.superview];
    CGPoint plotAreaPoint=[myHostView.superview.layer convertPoint:point toLayer:graph];
    CGPoint center=[myHostView.superview.layer convertPoint:myHostView.center toLayer:graph];
    if(plotAreaPoint.x>center.x){
        [BAAnimationHelper plotRatationAnimation:[[graph allPlots]objectAtIndex:0] direction:0];
    }else {
        [BAAnimationHelper plotRatationAnimation:[[graph allPlots]objectAtIndex:0] direction:1];
    }
}

- (void)swipeToUp:(UISwipeGestureRecognizer *)recognizer 
{   
    CGPoint point = [recognizer locationInView:myHostView.superview];
    CGPoint plotAreaPoint=[myHostView.superview.layer convertPoint:point toLayer:graph];
    CGPoint center=[myHostView.superview.layer convertPoint:myHostView.center toLayer:graph];
    if(plotAreaPoint.x<center.x){
        [BAAnimationHelper plotRatationAnimation:[[graph allPlots]objectAtIndex:0] direction:0];
    }else {
        [BAAnimationHelper plotRatationAnimation:[[graph allPlots]objectAtIndex:0] direction:1];
    }
}
- (id)init
{
    self = [super init];
    if (self) {
        selectedIndex=-1;
    }
    return self;
}
@end
