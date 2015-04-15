//
//  BALineGraph.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BALineGraph.h"
#import "BAAnimationHelper.h"

@implementation BALineGraph
-(void)renderPlots
{
    for (CPTPlot *plot in plots) {
        plot.delegate=self;
        plot.dataSource=self;
        BAAnimationHelper *animation=[[BAAnimationHelper alloc]init];
        [animation plotStartAnimation:tempData sourceData:sourceData plot:plot graph:graph ];        //[graph addPlot:plot];
    }
}

-(void)renderInHostView:(CPTGraphHostingView*)hostView{
    [self renderAxisInHostView:hostView];
    
    [self renderPlots];
    [self renderLegendInHostView:hostView];
}

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{
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
