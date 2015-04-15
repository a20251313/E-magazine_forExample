//
//  NewBannerText.m
//  E-magazine
//
//  Created by mike.sun on 6/6/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "NewBannerText.h"
#import "rects.h"
#import "picRects.h"

@implementation NewBannerText

+ (NSMutableArray *)setTextRect{
    rects *rec = [[rects alloc] init];
    rec.rect = NSStringFromCGRect(CGRectMake(83, 435, 497, 30));
    
    rects *rec1 = [[rects alloc] init];
    rec1.rect = NSStringFromCGRect(CGRectMake(83, 521, 470,166));
    
    NSMutableArray *arrTextRect = [[NSMutableArray alloc] initWithObjects:rec, rec1,nil];
    
    return arrTextRect;
    
}

+ (NSMutableArray *)setImageRect{
    picRects *picRec = [[picRects alloc] init];
    picRec.picRect = NSStringFromCGRect(CGRectMake(83, 60, 470, 353));
    
    NSMutableArray *arrImageRect = [[NSMutableArray alloc] initWithObjects:picRec, nil];
    return arrImageRect;
    
}

@end
