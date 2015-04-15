//
//  NewMoreTextNoAbstractPor.m
//  E-magazine
//
//  Created by mike.sun on 6/5/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "NewMoreTextNoAbstractPor.h"
#import "rectsPor.h"
#import "picRectsPor.h"

@implementation NewMoreTextNoAbstractPor

+ (NSMutableArray *)setTextRect{
    rectsPor *recPor = [[rectsPor alloc] init];
    recPor.rectPor = NSStringFromCGRect(CGRectMake(54, 470, 660, 30));
    
    rectsPor *rec1Por = [[rectsPor alloc] init];
    rec1Por.rectPor = NSStringFromCGRect(CGRectMake(54, 510, 323,398));
    
    rectsPor *rec2Por = [[rectsPor alloc] init];
    rec2Por.rectPor = NSStringFromCGRect(CGRectMake(391, 510, 323,398));
    
    NSMutableArray *arrTextRect = [[NSMutableArray alloc] initWithObjects:recPor, rec1Por, rec2Por, nil];
    return arrTextRect;
}

+ (NSMutableArray *)setImageRect{
    picRectsPor *picRecPor = [[picRectsPor alloc] init];
    picRecPor.picRectPor = NSStringFromCGRect(CGRectMake(55, 125, 659, 287));
    
    NSMutableArray *arrImageRect = [[NSMutableArray alloc] initWithObjects:picRecPor, nil];
    return arrImageRect;
}

@end
