//
//  MoreTextNoAbstractPor.m
//  E-magazine
//
//  Created by summer.zhu on 5/10/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "MoreTextNoAbstractPor.h"

@implementation MoreTextNoAbstractPor

+ (NSMutableArray *)setTextRect{
    NSString *strRectPor_1 = NSStringFromCGRect(CGRectMake(54, 470, 660, 30));
    NSString *strRect1Por_1 = NSStringFromCGRect(CGRectMake(54, 510, 323,398));
    NSString *strRect2Por_1 = NSStringFromCGRect(CGRectMake(391, 510, 323,398));
    
    NSMutableArray *arrTextRect = [[NSMutableArray alloc] initWithObjects:strRectPor_1,strRect1Por_1,strRect2Por_1,nil];
    return arrTextRect;
}

+ (NSMutableArray *)setImageRect{
    NSString *strPicRect_1 = NSStringFromCGRect(CGRectMake(55, 125, 659, 287));
    NSMutableArray *arrImageRect = [[NSMutableArray alloc] initWithObjects:strPicRect_1, nil];
    return arrImageRect;
}

@end
