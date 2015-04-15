//
//  PieChartRotationHostingView.h
//  PieChartRotation
//
//  Created by zbq on 13-3-28.
//  Copyright (c) 2013年 zbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@protocol PieChartRotationHostDelegate;

@interface PieChartRotationHostingView : CPTGraphHostingView
<
CPTPlotDataSource,
CPTPieChartDelegate
>{
    CPTPieChart *_pie;
    NSMutableArray *arrColors;
}
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *arrRate;//各模块所占的比例数组
@property (nonatomic, assign) id<PieChartRotationHostDelegate> delegate;

- (void)initColors;

@end

@protocol PieChartRotationHostDelegate <NSObject>

@optional
- (void)sliceWasSelected:(NSInteger)iSelected;

@end
