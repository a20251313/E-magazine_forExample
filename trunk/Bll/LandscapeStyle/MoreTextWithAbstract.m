//
//  MoreTextWithAbstract.m
//  E-magazine
//
//  Created by summer.zhu on 5/9/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "MoreTextWithAbstract.h"

@implementation MoreTextWithAbstract

+ (NSMutableArray *)setTextRect{
    NSString *strRect = NSStringFromCGRect(CGRectMake(63, 87, 571, 30));
    NSString *strRect1 = NSStringFromCGRect(CGRectMake(46, 173, 796, 70));
    NSString *strRect2 = NSStringFromCGRect(CGRectMake(56, 344, 444, 343));
    NSString *strRect3 = NSStringFromCGRect(CGRectMake(533, 647, 444, 40));
    
    NSMutableArray *arrTextRect = [[NSMutableArray alloc] initWithObjects:strRect, strRect1,strRect2,strRect3,nil];
    return arrTextRect;
}

+ (NSMutableArray *)setImageRect{
    NSString *strPicRect_1 = NSStringFromCGRect(CGRectMake(533, 344, 443, 283));
    NSMutableArray *arrImageRect = [[NSMutableArray alloc] initWithObjects:strPicRect_1, nil];
    return arrImageRect;
}

@end
