//
//  BAPieGraph.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BABaseGraph.h"
#import "BAReport.h"
@interface BAPieGraph : BABaseGraph<CPTPieChartDelegate,CPTPieChartDataSource,CPTPlotDataSource>
-(void)renderLegendInHostView:(CPTGraphHostingView *)hostView;
-(void)renderInHostView:(CPTGraphHostingView*)hostView;
-(void)configurePlots:(BAReport*)report hostView:(CPTGraphHostingView*)hostView;
@end
