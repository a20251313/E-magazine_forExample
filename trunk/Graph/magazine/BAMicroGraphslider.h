//
//  BAMicroGraph.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-10-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BABaseGraph.h"
#import "BAReport.h"
@interface BAMicroGraphslider: BABaseGraph<CPTPlotDataSource>
@property (nonatomic,strong) NSString *city;
-(UIImage*)microImage;
-(void)configure:(BAReport*)report;
@end
