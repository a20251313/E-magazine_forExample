//
//  BannerTextPor.m
//  E-magazine
//
//  Created by summer.zhu on 5/10/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "BannerTextPor.h"

@implementation BannerTextPor

+ (NSMutableArray *)setTextRect{
    NSString *strRectPor = NSStringFromCGRect(CGRectMake(20, 466, 571, 30));
    NSString *strRect1Por = NSStringFromCGRect(CGRectMake(20, 504, 230, 439));
    NSString *strRect2Por = NSStringFromCGRect(CGRectMake(265, 504, 230, 439));
    NSString *strRect3Por = NSStringFromCGRect(CGRectMake(518, 761, 230, 182));
    
    NSMutableArray *arrTextRect = [[NSMutableArray alloc] initWithObjects:strRectPor, strRect1Por,strRect2Por,strRect3Por,nil];
    return arrTextRect;
}

+ (NSMutableArray *)setImageRect{
    NSString *strPicRect_1 = NSStringFromCGRect(CGRectMake(25, 92, 470, 353));
    NSMutableArray *arrImageRect = [[NSMutableArray alloc] initWithObjects:strPicRect_1, nil];
    return arrImageRect;
}

@end
