//
//  CAMapInfoPackage.h
//  IRnovationBI
//
//  Created by aplee on 12-11-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CAMapInfoPackage : NSObject

@property (nonatomic) float longitude;
@property (nonatomic) float latitude;
@property (nonatomic, assign) float scaleFactor;
@property (nonatomic, strong) NSString* cityName;
@property (nonatomic, strong) NSString* extraInfo1;
@property (nonatomic, strong) NSString* extraValue1;
@property (nonatomic, strong) NSString* extraInfo2;
@property (nonatomic, strong) NSString* extraValue2;

-(NSString*)getLongitudeStr;
-(NSString*)getLatitudeStr;

-(void)setCityName:(NSString *)thecityName longitude:(float)longi latitude:(float)lati extraInfo1:(NSString*)info1 extraValue1:(NSString*)value1 extraInfo2:(NSString*)info2 extraValue2:(NSString*)value2 scaleFactor:(float)factor;

+(id)initWithCityName:(NSString*)thecityName longitude:(float)longi latitude:(float)lati extraInfo1:(NSString*)info1 extraValue1:(NSString*)value1 extraInfo2:(NSString*)info2 extraValue2:(NSString*)value2 scaleFactor:(float)factor;

@end
