//
//  NewLessTextNoAbstract.m
//  E-magazine
//
//  Created by summer.zhu on 6/5/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "NewLessTextNoAbstract.h"
#import "rects.h"
#import "picRects.h"

@implementation NewLessTextNoAbstract

+ (NSMutableArray *)setTextRect{
    rects *rec = [[rects alloc] init];
    rec.rect = NSStringFromCGRect(CGRectMake(46, 428, 571, 30));
    
    rects *rec1 = [[rects alloc] init];
    rec1.rect = NSStringFromCGRect(CGRectMake(20, 475, 318, 212));
    
    rects *rec2 = [[rects alloc] init];
    rec2.rect = NSStringFromCGRect(CGRectMake(353, 475, 318,212));
    
    rects *rec3 = [[rects alloc] init];
    rec3.rect = NSStringFromCGRect(CGRectMake(686, 475, 318,212));
    
    NSMutableArray *arrTextRect = [[NSMutableArray alloc] initWithObjects:rec, rec1, rec2, rec3,nil];
    
    return arrTextRect;
}

+ (NSMutableArray *)setImageRect{
    picRects *picRec = [[picRects alloc] init];
    picRec.picRect = NSStringFromCGRect(CGRectMake(49, 76, 926, 307));
    
    NSMutableArray *arrImageRect = [[NSMutableArray alloc] initWithObjects:picRec, nil];
    return arrImageRect;
}

@end
