//
//  CAAnnotation.h
//  myMapTest
//
//  Created by aplee on 12-10-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "CAMapInfoPackage.h"

enum ANNO_COLOR {
    ANNO_GREEN,
    ANNO_RED,
};

//cluster annotations
@interface CAAnnotation : NSObject<MKAnnotation>
{
    NSMutableArray *annotationsInCluster;
    NSString *title;
    NSString *subtitle;
    CLLocationCoordinate2D coordinate;
    enum ANNO_COLOR color;
    
    BOOL isCluster;
    
    //the infomation detail
    CAMapInfoPackage* infoPkg;
}

/// Init with annotations.
/** Init object with containing annotations*/
- (id)initWithAnnotation:(id <MKAnnotation>) annotation;

//
/// List of annotations in the cluster.
/** Returns all annotations in the cluster.
 READONLY
 */
@property(nonatomic, retain) NSMutableArray *annotationsInCluster;
@property (nonatomic, readwrite) BOOL isCluster;
@property (nonatomic) enum ANNO_COLOR color;
@property (nonatomic, retain) CAMapInfoPackage* infoPkg;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* subtitle;


//
// manipulate cluster
/// Adds a single annotation to the cluster.
/** Adds a given annotation to the cluster and sets the title to the number of containing annotations.*/
- (void)addAnnotation:(id < MKAnnotation >)annotation;

-(void)setTitle:(NSString*)text;
- (void)setSubtitle:(NSString *)text;
- (void)setCoordinate:(CLLocationCoordinate2D)coord;

-(void)removeAllAnotations;

- (NSString *)title;

@end
