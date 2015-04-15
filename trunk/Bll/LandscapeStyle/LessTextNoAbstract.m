//
//  LessTextNoAbstract.m
//  E-magazine
//
//  Created by summer.zhu on 5/9/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "LessTextNoAbstract.h"

@implementation LessTextNoAbstract

+ (NSMutableArray *)setTextRect{
    NSString *strRect = NSStringFromCGRect(CGRectMake(46, 428, 571, 30));
    NSString *strRect1 = NSStringFromCGRect(CGRectMake(20, 475, 318, 212));
    NSString *strRect2 = NSStringFromCGRect(CGRectMake(353, 475, 318,212));
    NSString *strRect3 = NSStringFromCGRect(CGRectMake(686, 475, 318,212));
    NSMutableArray *arrTextRect = [[NSMutableArray alloc] initWithObjects:strRect, strRect1,strRect2,strRect3,nil];
    return arrTextRect;
}

+ (NSMutableArray *)setImageRect{
    NSString *strPicRect_1 = NSStringFromCGRect(CGRectMake(49, 76, 926, 307));
    NSMutableArray *arrImageRect = [[NSMutableArray alloc] initWithObjects:strPicRect_1, nil];
    return arrImageRect;
}

@end
