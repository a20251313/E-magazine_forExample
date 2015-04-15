//
//  MoreTextWithAbstract.m
//  E-magazine
//
//  Created by summer.zhu on 5/10/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "MoreTextWithAbstractPor.h"

@implementation MoreTextWithAbstractPor

+ (NSMutableArray *)setTextRect{
    NSString *strRectPor = NSStringFromCGRect(CGRectMake(67, 91, 497, 30));
    NSString *strRect1Por = NSStringFromCGRect(CGRectMake(40, 206, 609,93));
    NSString *strRect2Por = NSStringFromCGRect(CGRectMake(18, 378, 238,565));
    NSString *strRect3Por = NSStringFromCGRect(CGRectMake(265, 805, 238,138));
    NSString *strRect4Por = NSStringFromCGRect(CGRectMake(511, 805, 238,138));
    
    NSMutableArray *arrTextRect = [[NSMutableArray alloc] initWithObjects:strRectPor, strRect1Por,strRect2Por,strRect3Por,strRect4Por,nil];
    return arrTextRect;
}

+ (NSMutableArray *)setImageRect{
    NSString *strPicRect_1 = NSStringFromCGRect(CGRectMake(386, 373, 325, 483));
    NSMutableArray *arrImageRect = [[NSMutableArray alloc] initWithObjects:strPicRect_1, nil];
    return arrImageRect;
}

@end
