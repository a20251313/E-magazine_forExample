//
//  BAReportService.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BAReportService.h"
#import "BAReport.h"
@implementation BAReportService
-(void)configDocument:(BADocument*)document
{
    
    for(BAReport *report in document.reports){
        if ([report.reportType isEqualToString:@"BAReportTypeBar"]) {
            
        }
    }
}
@end
