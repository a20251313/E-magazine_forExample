//
//  bookData.h
//  E-magazine
//
//  Created by summer.zhu on 6/4/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface bookData : NSObject

@property(nonatomic, retain) NSString *bookName;
@property(nonatomic, retain) NSString *covorImage;
@property(nonatomic, retain) NSMutableArray *chapterData;

@end
