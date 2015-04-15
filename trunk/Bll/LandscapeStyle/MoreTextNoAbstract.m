//
//  MoreTextNoAbstract.m
//  E-magazine
//
//  Created by summer.zhu on 5/9/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "MoreTextNoAbstract.h"

@implementation MoreTextNoAbstract

+ (NSMutableArray *)setTextRect{
    NSString *strRect_1 = NSStringFromCGRect(CGRectMake(51, 475, 571, 30));
    NSString *strRect1_1 = NSStringFromCGRect(CGRectMake(51, 547, 278, 140));
    NSString *strRect2_1 = NSStringFromCGRect(CGRectMake(344, 547, 278,140));
    NSString *strRect3_1 = NSStringFromCGRect(CGRectMake(643, 117, 318,570));
    NSMutableArray *arrTextRect = [[NSMutableArray alloc] initWithObjects:strRect_1,strRect1_1,strRect2_1,strRect3_1,nil];
    return arrTextRect;
}

+ (NSMutableArray *)setImageRect{
    NSString *strPicRect_1 = NSStringFromCGRect(CGRectMake(56, 124, 551, 314));
    NSMutableArray *arrImageRect = [[NSMutableArray alloc] initWithObjects:strPicRect_1, nil];
    return arrImageRect;
}

@end
