//
//  NewBannerTextPor.m
//  E-magazine
//
//  Created by mike.sun on 6/6/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "NewBannerTextPor.h"
#import "rectsPor.h"
#import "picRectsPor.h"

@implementation NewBannerTextPor

+ (NSMutableArray *)setTextRect{
    rectsPor *recPor = [[rectsPor alloc] init];
    recPor.rectPor = NSStringFromCGRect(CGRectMake(20, 466, 571, 30));
    
    rectsPor *rec1Por = [[rectsPor alloc] init];
    rec1Por.rectPor = NSStringFromCGRect(CGRectMake(20, 504, 230, 439));
    
    rectsPor *rec2Por = [[rectsPor alloc] init];
    rec2Por.rectPor = NSStringFromCGRect(CGRectMake(265, 504, 230, 439));
    
    rectsPor *rec3Por = [[rectsPor alloc] init];
    rec3Por.rectPor = NSStringFromCGRect(CGRectMake(265, 504, 230, 439));
    
    NSMutableArray *arrTextRect = [[NSMutableArray alloc] initWithObjects:recPor, rec1Por, rec2Por,rec3Por, nil];
    return arrTextRect;
    
}

+ (NSMutableArray *)setImageRect{
    picRectsPor *picRecPor = [[picRectsPor alloc] init];
    picRecPor.picRectPor = NSStringFromCGRect(CGRectMake(25, 92, 470, 353));
    
    NSMutableArray *arrImageRect = [[NSMutableArray alloc] initWithObjects:picRecPor, nil];
    return arrImageRect;
    
}

@end
