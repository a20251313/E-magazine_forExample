//
//  NewDataFactory.h
//  E-magazine
//
//  Created by summer.zhu on 6/4/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "bookData.h"
#import "chapterData.h"
#import "textData.h"

@interface NewDataFactory : NSObject

+ (bookData *)createBook1;
+ (textData *)createTextData0;
+ (textData *)createTextData1;
+ (textData *)createTextData2;
+ (textData *)createTextData2_1;

+ (bookData *)createBook2;
+ (bookData *)createBook3;
+ (bookData *)createBook4;

@end
