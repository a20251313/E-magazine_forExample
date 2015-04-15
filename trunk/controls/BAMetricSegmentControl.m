//
//  BAMetricSegmentControl.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BAMetricSegmentControl.h"
#import "BAAnimationHelper.h"


@implementation BAMetricSegmentControl
{
    MoSegmentedControl *segment;
}
@synthesize segmentControl;
@synthesize segment;

-(UISegmentedControl*)configureMetricSegmentControl
{
    NSMutableArray *items=[[NSMutableArray alloc]init];
    for (NSString *key in baseGraph.sourceData) {
        [items addObject:key];
    }
    segmentControl=[[UISegmentedControl alloc]initWithItems:items];
    segmentControl.frame=CGRectMake(0, 0, 300, 200);
    segmentControl.momentary=YES;
    //[segmentControl addTarget:self action:@selector(changeSegement:) forControlEvents:UIControlEventValueChanged];
    return segmentControl;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(changeSegement:)
                   name:@"metricSegmentNotification"
                 object:nil];
        NSNotificationCenter *nc2 = [NSNotificationCenter defaultCenter];
        [nc2 addObserver:self
                selector:@selector(changeSegment:)
                   name:@"metricSegmentNotification2"
                 object:nil];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)renderInHostViewWithReport:(UIView*)hostView report:(BAReport*)report
{
    NSMutableArray *keys=[[NSMutableArray alloc]init];
    for(int i=0;i<report.reportData.metrics.count;i++)
    {
        BAMetric *metric=[report.reportData.metrics objectAtIndex:i];
        [keys addObject:metric.metricName];
    }
    segment=[[MoSegmentedControl alloc]initWithItems:keys ];
    [segment setFrame:hostView.bounds];
    for (int i=0; i<keys.count; i++) {
        [segment makeSegment:i selected:YES];
    }

    //[segment addTarget:self action:@selector(test) forControlEvents:UIControlEventValueChanged];
    [hostView addSubview:segment];
}

-(void)changeSegment:(NSNotification*)note
{
    NSMutableArray *selectedIndexs=[[note userInfo]objectForKey:@"selectedIndexs"];
    for (int i=0; i<baseGraph.plots.count; i++) {
        CPTPlot *plot=[baseGraph.plots objectAtIndex:i];
        if ([selectedIndexs containsObject:[NSString stringWithFormat:@"%d",i]]) {

            if (![baseGraph.graph plotWithIdentifier:plot.identifier]) {
                [baseGraph.graph addPlot:plot];
            }
            
        }else {
            if ([baseGraph.graph plotWithIdentifier:plot.identifier]) {
                [baseGraph.graph removePlot:plot];
            }
        }
    }
    [baseGraph.graph reloadData];
    BAAnimationHelper *animation=[[BAAnimationHelper alloc]init];
    for(CPTPlot *plot in baseGraph.graph.allPlots)
    {
        [animation plotScaleAnimation:plot];
    }

}
-(void)changeSegement:(NSNotification*)note
{
    NSUInteger index=[[[note userInfo]objectForKey:@"selectedSegmentIndex"] intValue];
    CPTPlot *plot=[baseGraph.plots objectAtIndex:index];
    if([baseGraph.graph plotWithIdentifier:plot.identifier])
    {
        [baseGraph.graph removePlot:plot];
    }else {
        [baseGraph.graph addPlot:plot];
    }
    [baseGraph.graph reloadData];
    BAAnimationHelper *animation=[[BAAnimationHelper alloc]init];
    for(CPTPlot *plot in baseGraph.graph.allPlots)
    {
        [animation plotScaleAnimation:plot];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
