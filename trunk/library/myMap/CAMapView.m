//
//  CAMapView.m
//  myMapTest
//
//  Created by aplee on 12-10-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CAMapView.h"
#define DEFAULT_DISTANCE1 0.018;

@interface CAMapView (private)
- (void)initSetUp;
@end

@implementation CAMapView
@synthesize annotationsToIgnore;
@synthesize clusterSize;
@synthesize minLongitudeDeltaToCluster;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initSetUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];    
    if (self) {
        // call actual initializer
        [self initSetUp];
    }
    return self;
}

- (void)initSetUp{
    allAnnotations = [[NSMutableSet alloc] init];
    annotationsToIgnore = [[NSMutableSet alloc] init];
    clusterSize = DEFAULT_DISTANCE1;
    minLongitudeDeltaToCluster = 0.0;

}



// ======================================
#pragma mark MKMapView implementation

- (void)addAnnotation:(id < MKAnnotation >)annotation{
    [allAnnotations addObject:annotation];
    [self doClustering];
}

- (void)addAnnotations:(NSArray *)annotations{
    [allAnnotations addObjectsFromArray:annotations];
    [self doClustering];
}

- (void)removeAnnotation:(id < MKAnnotation >)annotation{
    [allAnnotations removeObject:annotation];
    [self doClustering];
}

- (void)removeAnnotations:(NSArray *)annotations{
    for (id<MKAnnotation> annotation in annotations) {
        [allAnnotations removeObject:annotation];
    }
    [self doClustering];
}


// ======================================
#pragma mark - Properties
//
// Returns, like the original method,
// all annotations in the map unclustered.
- (NSArray *)annotations{
    return [allAnnotations allObjects];
}

//
// Returns all annotations which are actually displayed on the map. (clusters)
- (NSArray *)displayedAnnotations{
    return super.annotations;    
}

// ======================================
#pragma mark - Clustering

- (void)doClustering{
    
    // Remove the annotation which should be ignored
    NSMutableArray *bufferArray = [[NSMutableArray alloc] initWithArray:[allAnnotations allObjects]];
    [bufferArray removeObjectsInArray:[annotationsToIgnore allObjects]];
    NSMutableArray *annotationsToCluster = [[NSMutableArray alloc] initWithArray:[self filterAnnotationsForVisibleMap:bufferArray]];
    
    //calculate cluster radius
    CLLocationDistance clusterRadius = self.region.span.longitudeDelta * clusterSize;
    
    // Do clustering
    NSArray *clusteredAnnotations;
    
    // Check if clustering is enabled and map is above the minZoom
    if (self.region.span.longitudeDelta > minLongitudeDeltaToCluster) {
        
        clusteredAnnotations = [[NSArray alloc] initWithArray:[CAAlgorithms clusterWithAnnotations:annotationsToCluster andClusterRadius:clusterRadius]];
    }
    // pass through without when not
    else{
        clusteredAnnotations = annotationsToCluster;
    }
    
    // Clear map but leave Userlcoation
    NSMutableArray *annotationsToRemove = [[NSMutableArray alloc] initWithArray:self.displayedAnnotations];
    [annotationsToRemove removeObject:self.userLocation];
    
    // add clustered and ignored annotations to map
    [super addAnnotations: clusteredAnnotations];
    
    // fix for flickering
    [annotationsToRemove removeObjectsInArray: clusteredAnnotations];
    [super removeAnnotations:annotationsToRemove];
    
    // add ignored annotations
    [super addAnnotations: [annotationsToIgnore allObjects]];
    

    annotationsToCluster = nil;
}

// ======================================
#pragma mark - Helpers

- (NSArray *)filterAnnotationsForVisibleMap:(NSArray *)annotationsToFilter{
    // return array
    NSMutableArray *filteredAnnotations = [[NSMutableArray alloc] initWithCapacity:[annotationsToFilter count]];
    
    // border calculation
    CLLocationDistance a = self.region.span.latitudeDelta/2.0;
    CLLocationDistance b = self.region.span.longitudeDelta /2.0;
    CLLocationDistance radius = sqrt(a*a + b*b);
    
    for (id<MKAnnotation> annotation in annotationsToFilter) {
        // if annotation is not inside the coordinates, kick it
        if (isLocationNearToOtherLocation(annotation.coordinate, self.centerCoordinate, radius)) {
            [filteredAnnotations addObject:annotation];
        }
    }
    
    return filteredAnnotations;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
