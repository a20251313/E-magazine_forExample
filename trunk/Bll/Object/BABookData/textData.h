//
//  textData.h
//  E-magazine
//
//  Created by summer.zhu on 6/4/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface textData : NSObject

@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *text;
@property(nonatomic, retain) NSString *titleFontSize;
@property(nonatomic, retain) NSString *titleFontName;
@property(nonatomic, retain) NSString *titleLength;
@property(nonatomic, retain) NSString *contentFontSize;
@property(nonatomic, retain) NSString *contentFontName;
@property(nonatomic, retain) NSMutableArray *colors;
@property(nonatomic, retain) NSMutableArray *ranges;
@property(nonatomic, retain) NSMutableArray *colorsPor;
@property(nonatomic, retain) NSMutableArray *rangesPor;
@property(nonatomic, retain) NSMutableArray *bgRects;
@property(nonatomic, retain) NSMutableArray *bgNames;
@property(nonatomic, retain) NSMutableArray *bgRectsPor;
@property(nonatomic, retain) NSMutableArray *bgNamesPor;
@property(nonatomic, retain) NSMutableArray *picRects;
@property(nonatomic, retain) NSMutableArray *picNames;
@property(nonatomic, retain) NSMutableArray *picRectsPor;
@property(nonatomic, retain) NSMutableArray *picNamesPor;
@property(nonatomic, retain) NSMutableArray *rects;
@property(nonatomic, retain) NSMutableArray *rectsPor;
@property(nonatomic, retain) NSMutableArray *key;
@property(nonatomic, retain) NSMutableArray *pushClassNames;

@end
