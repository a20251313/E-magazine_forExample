//
//  LeastTextNoAbstractPor.m
//  E-magazine
//
//  Created by summer.zhu on 5/10/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "LeastTextNoAbstractPor.h"

@implementation LeastTextNoAbstractPor

+ (NSMutableArray *)setTextRect{
    NSString *strRectPor = NSStringFromCGRect(CGRectMake(54, 561, 660, 30));
    NSString *strRect1Por = NSStringFromCGRect(CGRectMake(54, 611, 323,197));
    NSString *strRect2Por = NSStringFromCGRect(CGRectMake(391, 611, 323,197));
    
    NSMutableArray *arrTextRect = [[NSMutableArray alloc] initWithObjects:strRectPor, strRect1Por,strRect2Por,nil];
    return arrTextRect;
}

+ (NSMutableArray *)setImageRect{
    NSString *strPicRect_1 = NSStringFromCGRect(CGRectMake(55, 125, 659, 376));
    NSMutableArray *arrImageRect = [[NSMutableArray alloc] initWithObjects:strPicRect_1, nil];
    return arrImageRect;
}

@end
