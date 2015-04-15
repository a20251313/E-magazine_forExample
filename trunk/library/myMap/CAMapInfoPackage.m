//
//  CAMapInfoPackage.m
//  IRnovationBI
//
//  Created by aplee on 12-11-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CAMapInfoPackage.h"

@implementation CAMapInfoPackage
@synthesize longitude, latitude, cityName, extraInfo1, extraValue1, scaleFactor, extraInfo2, extraValue2;

-(NSString*)getLongitudeStr
{
    return [NSString stringWithFormat:@"%.2f", self.longitude];
}

-(NSString*)getLatitudeStr
{
    return [NSString stringWithFormat:@"%.2f", self.latitude];
}

-(void)setCityName:(NSString *)thecityName longitude:(float)longi latitude:(float)lati extraInfo1:(NSString*)info1 extraValue1:(NSString*)value1 extraInfo2:(NSString*)info2 extraValue2:(NSString*)value2 scaleFactor:(float)factor
{
    self.cityName = thecityName;
    self.longitude = longi;
    self.latitude = lati;
    self.extraInfo1 = info1;
    self.extraValue1 = value1;
    self.scaleFactor = factor;
    self.extraInfo2 = info2;
    self.extraValue2 = value2;
}

+(id)initWithCityName:(NSString*)thecityName longitude:(float)longi latitude:(float)lati extraInfo1:(NSString*)info1 extraValue1:(NSString*)value1 extraInfo2:(NSString*)info2 extraValue2:(NSString*)value2 scaleFactor:(float)factor
{
    CAMapInfoPackage* instance = [[CAMapInfoPackage alloc] init];
    [instance setCityName:thecityName longitude:longi latitude:lati extraInfo1:info1 extraValue1:value1 extraInfo2:info2 extraValue2:value2 scaleFactor:factor];
    return instance;
}

@end
