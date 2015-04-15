//
//  CADistance.m
//  myMapTest
//
//  Created by aplee on 12-10-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CADistance.h"

//
// calculates the distance
// between two given coordinates
CLLocationDistance getDistance(CLLocationCoordinate2D firstLocation, CLLocationCoordinate2D secondLocation){
    // Calculate differences of the to annotations
    CLLocationDistance distance;
    
    CLLocationDistance deltaLat = firstLocation.latitude - secondLocation.latitude;
    CLLocationDistance deltaLon = firstLocation.longitude - secondLocation.longitude;
    distance = sqrt(deltaLat*deltaLat + deltaLon*deltaLon);
    
    return distance;
}


//
// This c function returns true if the distance
// between two given locations is shorter
// or equal than the designated distance.
// The distance represents the cluster size.
BOOL isLocationNearToOtherLocation(CLLocationCoordinate2D firstLocation, CLLocationCoordinate2D secondLocation, CLLocationDistance distanceInGeoCoordinates){
	// Return value
	BOOL retVal = YES;
	
	// get distance
	CLLocationDistance distance = getDistance(firstLocation, secondLocation);
    
	// If the distance between these two things is longer than the
	// requested distanceInGeoCoordinates, the two annotations are not near to each other.
	if (distance > distanceInGeoCoordinates) {
		retVal = NO;
	}
	
	return retVal;
}