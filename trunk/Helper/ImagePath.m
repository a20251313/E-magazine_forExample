//
//  ImagePath.m
//  E-magazine
//
//  Created by summer.zhu on 5/30/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "ImagePath.h"

@implementation ImagePath

+ (NSString *)getImagePath:(NSString *)imageName{
    if (imageName.length > 0) {
        NSArray *arr = [imageName componentsSeparatedByString:@"."];
        NSString *imgName = [arr objectAtIndex:0];
        NSString *imgType = [arr objectAtIndex:1];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:imgName ofType:imgType];
        return filePath;
    }else{
        return @"";
    }
}

@end
