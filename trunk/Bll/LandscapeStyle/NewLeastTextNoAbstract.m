//
//  NewLeastTextNoAbstract.m
//  E-magazine
//
//  Created by mike.sun on 6/5/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "NewLeastTextNoAbstract.h"
#import "rects.h"
#import "picRects.h"

@implementation NewLeastTextNoAbstract

+ (NSMutableArray *)setTextRect{
    rects *rec = [[rects alloc] init];
    rec.rect = NSStringFromCGRect(CGRectMake(51, 505, 571, 30));
    
    rects *rec1 = [[rects alloc] init];
    rec1.rect = NSStringFromCGRect(CGRectMake(51, 547, 278, 140));
    
    rects *rec2 = [[rects alloc] init];
    rec2.rect = NSStringFromCGRect(CGRectMake(344, 547, 278,140));
    
    rects *rec3 = [[rects alloc] init];
    rec3.rect = NSStringFromCGRect(CGRectMake(643, 547, 318,140));
    
    NSMutableArray *arrTextRect = [[NSMutableArray alloc] initWithObjects:rec, rec1, rec2, rec3,nil];
    
    return arrTextRect;
    
}

+ (NSMutableArray *)setImageRect{
    picRects *picRec = [[picRects alloc] init];
    picRec.picRect = NSStringFromCGRect(CGRectMake(56, 85, 926, 375));
    
    NSMutableArray *arrImageRect = [[NSMutableArray alloc] initWithObjects:picRec, nil];
    return arrImageRect;
    
}

@end
