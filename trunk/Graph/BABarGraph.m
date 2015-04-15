//
//  BABarGraph.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BABarGraph.h"
#import "BAMetric.h"
#import "BAAnimationHelper.h"

@implementation BABarGraph
@synthesize delegate;



-(void)renderPlots
{
    for (CPTPlot *plot in plots) {
        plot.delegate=self;
        plot.dataSource=self;
        BAAnimationHelper *animation=[[BAAnimationHelper alloc]init];
        [animation plotStartAnimation:tempData sourceData:sourceData plot:plot graph:graph ]; 

        //[graph addPlot:plot];
    }
}

-(void)renderInHostView:(CPTGraphHostingView*)hostView{
    [self renderAxisInHostView:hostView];
    
    [self renderPlots];
    [self renderLegendInHostView:hostView];
}
-(BOOL)plotSpace:(CPTPlotSpace *)space shouldHandlePointingDeviceDownEvent:(id)event atPoint:(CGPoint)point{
    return YES;
}
-(BOOL)plotSpace:(CPTPlotSpace *)space shouldHandlePointingDeviceCancelledEvent:(id)event{
    return YES;
}
-(BOOL)plotSpace:(CPTPlotSpace *)space shouldHandlePointingDeviceDraggedEvent:(id)event atPoint:(CGPoint)point{
    return YES;
}
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{
    NSMutableArray *dataValues=[tempData objectForKey:(NSString*)plot.identifier];
    return [dataValues count];
}
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index{
    NSMutableArray *dataValues=[tempData objectForKey:(NSString*)plot.identifier];
    NSNumber *number=nil;
    switch (fieldEnum) {
        case CPTBarPlotFieldBarLocation:
            number=[NSNumber numberWithInt:index];
            break;
            
        case CPTBarPlotFieldBarTip:
            number=[dataValues objectAtIndex:index];
            break;
    }
    return number;
}
@end
