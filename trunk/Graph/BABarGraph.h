//
//  BABarGraph.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BAAxisGraph.h"

@protocol BABarGraphDelegate;
@interface BABarGraph : BAAxisGraph<CPTPlotDataSource,CPTBarPlotDelegate,CPTPlotSpaceDelegate>
{
    //CPTGraph *graph;
}
@property (nonatomic,weak) id<BABarGraphDelegate> delegate;

-(void)renderInHostView:(CPTGraphHostingView*)hostView;
@end

@protocol BABarGraphDelegate <NSObject>

@optional
-(void)test;

@end