//
//  CAAlgorithms.m
//  myMapTest
//
//  Created by aplee on 12-10-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CAAlgorithms.h"
#import <math.h>
#import "CAAnnotation.h"
#import "CADistance.h"

@implementation CAAlgorithms

+(NSArray*) clusterWithAnnotations:(NSArray *)annotationsToCluster andClusterRadius:(CLLocationDistance)radius
{
    NSLog(@"radius, %f", radius);
    for (CAAnnotation* annotation in annotationsToCluster) {
        
        [annotation removeAllAnotations];
        
    }
    
    for (CAAnnotation* annotation in annotationsToCluster)
    {
        for (int i = 0; i < [annotationsToCluster count]; i++) {
            
            CAAnnotation* secdAnno = (CAAnnotation*)[annotationsToCluster objectAtIndex:i];
            
            if (isLocationNearToOtherLocation([annotation coordinate], [secdAnno coordinate], radius)) {
                [annotation addAnnotation:secdAnno];
            }
            
        }
    }
    
    
    return annotationsToCluster;
    
    
}

@end
