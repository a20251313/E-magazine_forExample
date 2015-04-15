//
//  CAAlgorithms.h
//  myMapTest
//
//  Created by aplee on 12-10-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

/// ProtCAol for notifying on Cluster events. NOT in use yet.
/** Implement this protocol if you are using asynchronous clustering algorithms.
 In fact, there isn't one yet. This just demonstrates where this class will develop to in future.*/
@protocol CAAlgorithmDelegate <NSObject>
@required
/// Called when an algorithm finishes a block of calculations
- (NSArray *)algorithmClusteredPartially;
@optional
/// Called when algorithm starts calculating.
- (void)algorithmDidBeganClustering;
/// Called when algorithm finishes calculating.
- (void)algorithmDidFinishClustering;
@end

/// Class containing clustering algorithms.
/** The first release of CAMapView brings two different algorithms.
 This class is supposed to hold those algorithms.
 More algorithms are planned for future releases of CAMapView.
 
 Note for CAMapView developers:
 Every algorithm has to be a class method which returns an array of CAAnnotations or a subclass of it. 
 OR for future releases
 They can be instance methods if they run asynchronously. The instance holder needs to implement the delegate protCAol and the method needs to call the delegate.
 */
@interface CAAlgorithms : NSObject{
    /// Delegate for notifying on finished tasks
    /** NOT USED YET.
     Just reserved for future usage.*/
    id <CAAlgorithmDelegate> delegate;
}

/// Bubble clustering with iteration
/** This algorithm creates clusters based on the distance
 between single annotations.
 
 @param annotationsToCluster contains the Annotations that should be clustered
 @param radius represents the cluster size. 
 
 It iterates through all annotations in the array and compare their distances. If they are near engough, they will be clustered.*/
+(NSArray*) clusterWithAnnotations:(NSArray*)annotationsToCluster andClusterRadius:(CLLocationDistance)radius;



@end


