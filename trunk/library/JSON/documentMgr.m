//
//  documentMgr.m
//  yalitu
//
//  Created by aplee on 12-10-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "documentMgr.h"
#import "AES128.h"
#import "BASE64.h"

static documentMgr* mgr = nil;

@implementation documentMgr

+(DTDocument*)getDocumentById:(NSString*)idStr
{
    if (mgr != nil) {
    }else {
        mgr = [[documentMgr alloc] init];
    }
    
    //dict is the dictionary we need
    NSDictionary* dict = [mgr getDictionaryById:idStr];
    //the DTDocument to return
    DTDocument* dt = [[[DTDocument alloc] init] autorelease];
    
    //DTDocument
    dt.documentID = [dict objectForKey:@"documentID"];
    dt.documentDesc = [dict objectForKey:@"documentDesc"];
    dt.documentName = [dict objectForKey:@"documentName"];
    
    //DTReports
    NSMutableArray* reportMutableArray = [[[NSMutableArray alloc] init] autorelease];
    NSArray* reports = [dict objectForKey:@"reports"];
    
    for (NSDictionary* tempReport in reports) {
        DTReport* report = [[[DTReport alloc] init] autorelease];
        report.reportID = [tempReport objectForKey:@"reportID"];
        report.reportDesc = [tempReport objectForKey:@"reportDesc"];
        report.reportType = [tempReport objectForKey:@"reportType"];
        
        //reportData
        NSMutableArray* reportMutableDatas = [[[NSMutableArray alloc] init] autorelease];
        NSDictionary* reportDatas = [tempReport objectForKey:@"reportData"];
        DTReportData* drd = [[[DTReportData alloc] init] autorelease];
        
        
        //dtmetric
        NSArray* metrics = [reportDatas objectForKey:@"metric"];
        NSMutableArray* mutableMetrics = [[[NSMutableArray alloc] init] autorelease];
        for (NSDictionary* metric in metrics) {
            DTMetric* dm = [[[DTMetric alloc] init] autorelease];
            dm.name = [metric objectForKey:@"metricName"];
            dm.type = [metric objectForKey:@"plotType"];
            NSNumber *isKeyNum = [metric objectForKey:@"isKey"];
            dm.isKey = [isKeyNum boolValue];
            
            //datavalue
            dm.dataValue = [metric objectForKey:@"dataValue"];
            //fillColor
            dm.fillColor = [metric objectForKey:@"fillColor"];
            dm.coord = [metric objectForKey:@"coord"];
            
            [mutableMetrics addObject:dm];
        }
        drd.metrics = mutableMetrics;
        
        //entity
        NSArray* entities = [reportDatas objectForKey:@"entity"];
        
        NSMutableArray* mutableEntities = [[[NSMutableArray alloc] init] autorelease];
        for (NSDictionary* entity in entities) {
            DTEntity* de = [[[DTEntity alloc] init] autorelease];
            de.name = [entity objectForKey:@"entityName"];
            de.data = [entity objectForKey:@"entityData"];
            
            [mutableEntities addObject:de];
        }
        drd.entities = mutableEntities;
        
        [reportMutableDatas addObject:drd];
        
        report.reportDatas = reportMutableDatas;
        
        [reportMutableArray addObject:report];
    }
    
    dt.reports = reportMutableArray;
    [reportMutableArray release];
    
    [mgr release];
    
    return dt;
}

-(NSDictionary*)getDictionaryById:(NSString*)idStr
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"map" ofType:@"json"];
    NSData *jsonData = [[[NSData alloc] initWithContentsOfFile:filePath] autorelease];
    
//    NSData *keydata=[BASE64 base64Decode:@"a2V5"];
//    NSString *key=[[NSString alloc]initWithData:keydata encoding:NSUTF8StringEncoding];
//    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"document2" ofType:@"txt"];
//    NSData *jsonDataEncoded=[[NSData alloc]initWithContentsOfFile:filePath];
//    NSData *jsonData=[jsonDataEncoded AES128DecryptWithKey:key iv:@"iv"];
    

    
    
    
    NSError *error = nil;
    NSMutableArray *jsonObject = (NSMutableArray*)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    NSMutableDictionary *document=[[[NSMutableDictionary alloc]init] autorelease];
    for (NSMutableDictionary *sourceDocument in jsonObject) {
        
        if ([idStr isEqualToString:[sourceDocument objectForKey:@"documentID"]]) {
            document=sourceDocument;
            break;
        }
    }
    return document;
}

- (void)dealloc
{
    [mgr release];
    mgr = nil;
    [super dealloc];
}

@end
