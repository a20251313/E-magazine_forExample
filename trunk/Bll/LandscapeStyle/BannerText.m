//
//  BannerText.m
//  E-magazine
//
//  Created by summer.zhu on 5/9/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "BannerText.h"

@implementation BannerText

+ (NSMutableArray *)setTextRect{
    NSString *strRect = NSStringFromCGRect(CGRectMake(83, 435, 497, 30));
    NSString *strRect1 = NSStringFromCGRect(CGRectMake(83, 521, 470,166));
    
    NSMutableArray *arrTextRect = [[NSMutableArray alloc] initWithObjects:strRect, strRect1, nil];
    return arrTextRect;
}

+ (NSMutableArray *)setImageRect{
    NSString *strPicRect_1 = NSStringFromCGRect(CGRectMake(83, 60, 470, 353));
    NSMutableArray *arrImageRect = [[NSMutableArray alloc] initWithObjects:strPicRect_1, nil];
    return arrImageRect;
}

@end
