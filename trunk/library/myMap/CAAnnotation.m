//
//  CAAnnotation.m
//  myMapTest
//
//  Created by aplee on 12-10-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

//此类负责簇、非簇的显示annotation

#import "CAAnnotation.h"

@interface CAAnnotation ()
{
    
}
-(void)configue;
@end

@implementation CAAnnotation
@synthesize coordinate, title, isCluster, annotationsInCluster, color, infoPkg;

-(void)configue
{
    title = subtitle = [NSString stringWithFormat:@""];
    coordinate = CLLocationCoordinate2DMake(0.0, 0.0);
    self.annotationsInCluster = [[[NSMutableArray alloc] init] autorelease];
    isCluster = NO;
    color = ANNO_GREEN;
    infoPkg = [[CAMapInfoPackage alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        [self configue];
    }
    return self;
}

- (id)initWithAnnotation:(id <MKAnnotation>) annotation{
    
    self = [super init];
    if (self) {
        
        [self configue];
        
        coordinate = [annotation coordinate];
        title = [annotation title];
    }
    
    return self;
}


//
// manipulate cluster
- (void)addAnnotation:(id < MKAnnotation >)annotation{
    
    // Add annotation to the cluster
    [annotationsInCluster addObject:annotation];
    
    if ([annotationsInCluster count] > 1) {
        [self setIsCluster:YES];
    }
    else {
        [self setIsCluster:NO];
    }
    
}

- (void)addAnnotations:(NSArray *)annotations{
    for (id<MKAnnotation> annotation in annotations) {
        [self addAnnotation: annotation];
    }
}

- (void)removeAnnotation:(id < MKAnnotation >)annotation{
    
    // Remove annotation from cluster
    [annotationsInCluster removeObject:annotation];
    
    if ([annotationsInCluster count] <= 1) {
        [self setIsCluster:NO];
    }
}

- (void)removeAnnotations:(NSArray *)annotations{

    for (id<MKAnnotation> annotation in annotations) {
        [self removeAnnotation: annotation];
    }

}

-(void)removeAllAnotations
{
    // Remove annotation from cluster
    [annotationsInCluster removeAllObjects];
    [self setIsCluster:NO];
}

//
// protocoll implementation
- (NSString *)title{
    return title;
}

- (void)setTitle:(NSString *)text{
    title = text;
}

- (NSString *)subtitle{
    return subtitle;
}

- (void)setSubtitle:(NSString *)text{
    subtitle = text;
}

- (CLLocationCoordinate2D)coordinate{
    return coordinate;
}

- (void)setCoordinate:(CLLocationCoordinate2D)coord{
    coordinate = coord;
}

- (void)dealloc
{
    [annotationsInCluster removeAllObjects];
    [annotationsInCluster release];
    annotationsInCluster = nil;
    
    [infoPkg release];
    infoPkg = nil;
    
    [super dealloc];
}

@end

