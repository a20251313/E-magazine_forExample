//
//  BAData.h
//  E-magazine
//
//  Created by mike.sun on 4/16/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAImage.h"

@interface BAData : NSObject

@property (nonatomic, retain) BAImage *imagedata;
@property (nonatomic, retain) NSMutableArray *arrPageData;

@end
