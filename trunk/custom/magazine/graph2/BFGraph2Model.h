//
//  BFGraph2Model.h
//  E-magazine
//
//  Created by Yann on 13-1-31.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAReport.h"
@interface BFGraph2Model : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSNumber *salesTarget;
@property (nonatomic,strong) NSNumber *sales;
@property (nonatomic,strong) BAReport *report;
@end
