//
//  BFGraph4LeftModel.h
//  E-magazine
//
//  Created by Yann on 13-1-29.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAReport.h"
@interface BFGraph4LeftModel : NSObject
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,strong) NSMutableArray *subModels;
@property (nonatomic) BOOL isSelected;
@property (nonatomic,strong) NSString *leftColor;
@property (nonatomic,strong) NSString *rightColor;
@property (nonatomic) NSUInteger level;
@property (nonatomic) NSUInteger showLevel;
@property (nonatomic,strong) BAReport *salesReport;
@property (nonatomic,strong) BAReport *metricReport;

@property (nonatomic,strong) NSNumber *sales;
@property (nonatomic,strong) NSNumber *salesTarget;
@property (nonatomic,strong) NSNumber *salesT;
@property (nonatomic,strong) NSNumber *salesH;
@property (nonatomic,strong) NSNumber *profit;
@property (nonatomic,strong) NSNumber *profitTarget;
@property (nonatomic,strong) NSNumber *profitT;
@property (nonatomic,strong) NSNumber *profitH;
@property (nonatomic) double maxSales;
@property (nonatomic) double maxProfit;
-(id)initWithParams:(NSString*)theDesc level:(NSUInteger)theLevel salesReport:(BAReport*)salesReport metricReport:(BAReport*)metricReport entityIndex:(NSUInteger)entityIndex;
@end
