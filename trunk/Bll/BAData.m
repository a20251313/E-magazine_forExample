//
//  BAData.m
//  E-magazine
//
//  Created by mike.sun on 4/16/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "BAData.h"

@implementation BAData
@synthesize imagedata;
@synthesize arrPageData;
- (id)init{
    self = [super init];
    if (self) {
        imagedata = [[BAImage alloc] init];
    }
    return self;
}

@end
