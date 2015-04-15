//
//  documentMgr.h
//  yalitu
//
//  Created by aplee on 12-10-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DTDocument.h"
#import "DTReport.h"
#import "DTReportData.h"
#import "DTMetric.h"
#import "DTEntity.h"

@interface documentMgr : NSObject

+(DTDocument*)getDocumentById:(NSString*)idStr;

-(NSDictionary*)getDictionaryById:(NSString*)idStr;

@end
