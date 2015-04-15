//
//  BFGraph4LeftModel.m
//  E-magazine
//
//  Created by Yann on 13-1-29.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import "BFGraph4LeftModel.h"
#import "BADefinition.h"
@implementation BFGraph4LeftModel
@synthesize desc;
@synthesize subModels;
@synthesize isSelected;
@synthesize leftColor;
@synthesize rightColor;
@synthesize level;
@synthesize showLevel;
@synthesize salesReport;
@synthesize metricReport;
@synthesize sales;
@synthesize salesH;
@synthesize salesT;
@synthesize salesTarget;
@synthesize profit;
@synthesize profitH;
@synthesize profitT;
@synthesize profitTarget;
@synthesize maxProfit;
@synthesize maxSales;

-(double)getMaxDataValue:(NSMutableArray*)values targetValues:(NSMutableArray*)tragetValues
{
    double maxDataValue=0;
    for (NSNumber *dataValue in values) {
        maxDataValue=MAX([dataValue doubleValue], maxDataValue);
    }
    double maxTargetValue=0;
    for (NSNumber *dataValue in tragetValues) {
        maxTargetValue=MAX([dataValue doubleValue], maxTargetValue);
    }
    double maxValue= MAX(maxDataValue, maxTargetValue);
    return maxValue;
}

-(id)init
{
    self=[super init];
    if (self) {
        showLevel=0;
    }
    return self;
}
-(id)initWithParams:(NSString*)theDesc level:(NSUInteger)theLevel salesReport:(BAReport*)theSalesReport metricReport:(BAReport*)theMetricReport entityIndex:(NSUInteger)entityIndex
{
    self=[super init];
    if (self) {
        desc=theDesc;
        salesReport=theSalesReport;
        metricReport=theMetricReport;
        level=theLevel;
        switch (theLevel) {
            case 0:
            {
                leftColor=@"1b1d24";
                rightColor=@"2f3138";
            }
                break;
            case 1:
            {
                leftColor=@"2e303a";
                rightColor=@"42444e";
            }
                break;
            case 2:
            {
                leftColor=@"4b515f";
                rightColor=@"5f6573";
            }
                break;
            default:
            {
                leftColor=@"1b1d24";
                rightColor=@"2f3138";
            }
                break;
        }
        
        BAReportData *reportData=metricReport.reportData;
        NSMutableArray *metrics=reportData.metrics;
        
        sales=[[[metrics objectAtIndex:0]dataValues]objectAtIndex:entityIndex];
        salesTarget=[[[metrics objectAtIndex:1]dataValues]objectAtIndex:entityIndex];
        salesT=[[[metrics objectAtIndex:2]dataValues]objectAtIndex:entityIndex];
        salesH=[[[metrics objectAtIndex:3]dataValues]objectAtIndex:entityIndex];
        profit=[[[metrics objectAtIndex:4]dataValues]objectAtIndex:entityIndex];
        profitTarget=[[[metrics objectAtIndex:5]dataValues]objectAtIndex:entityIndex];
        profitT=[[[metrics objectAtIndex:6]dataValues]objectAtIndex:entityIndex];
        profitH=[[[metrics objectAtIndex:7]dataValues]objectAtIndex:entityIndex];
        
        NSMutableArray *salesValues=[[metrics objectAtIndex:0]dataValues];
        NSMutableArray *salesTargetValues=[[metrics objectAtIndex:1]dataValues];
        maxSales=[self getMaxDataValue:salesValues targetValues:salesTargetValues];
        
        NSMutableArray *profitValues=[[metrics objectAtIndex:4]dataValues];
        NSMutableArray *profitTargetValues=[[metrics objectAtIndex:5]dataValues];
        maxProfit=[self getMaxDataValue:profitValues targetValues:profitTargetValues];
    }
    return self;
}
@end
