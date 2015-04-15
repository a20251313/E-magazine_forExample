//
//  BAMetricSegmentControl.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BABaseControl.h"
#import "BADefinition.h"
#import "MoSegmentedControl.h"
@interface BAMetricSegmentControl : BABaseControl
@property (nonatomic,strong) UISegmentedControl *segmentControl;
@property (nonatomic,strong) MoSegmentedControl *segment;
-(UISegmentedControl*)configureMetricSegmentControl;
-(void)renderInHostViewWithReport:(UIView*)hostView report:(BAReport*)report;
@end
