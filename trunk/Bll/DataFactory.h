//
//  DataFactory.h
//  E-magazine
//
//  Created by summer.zhu on 4/13/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAFourData.h"
#import "BADataSource.h"
#import "BABookData.h"
#import "OCReflection.h"
#import "NSObject+Helper.h"

#define DataSourceNumber 3
#define ChapterNumber 4

@interface DataFactory : NSObject

+ (DataFactory *)shareInstance;

+ (BABookData *)createBookData:(int)bookIndex;

+ (BADataSource *)createDataSource:(int)bookIndex;
+ (NSMutableDictionary *)searchDataSource:(NSInteger)bookIndex;//获取该本杂志的搜索数据源以及对应的viewController的位置
+ (NSMutableArray *)searchKey:(NSInteger)bookIndex;//获取该本杂志的搜索数据源的key值

#pragma mark - row 1
+ (BAImagaNameData *)create1Data;
+ (BAImagaNameData *)create2Data;
+ (BAThreeData *)create3Data;
+ (BAFourData *)create4Data;
+ (BAFiveDataExtend *)create5Data;
+ (BAFourData *)create6Data;
+ (BAImagaNameData *)create7Data;
+ (BAImagaNameData *)create8Data;

#pragma mark - row 2
+ (BAImagaNameData *)create1_1Data;
+ (BAThreeData *)create2_1Data;
+ (BAFiveData *)create3_1Data;
+ (BAFiveData *)create4_1Data;
+ (BAFiveData *)create5_1Data;
+ (BAFourData *)create6_1Data;
+ (BAFourData *)create7_1Data;
+ (BAFourData *)create8_1Data;
+ (BAImagaNameData *)create9_1Data;
+ (BAImagaNameData *)create10_1Data;

#pragma mark - row 3
+ (BAImagaNameData *)create1_2Data;
+ (BAThreeData *)create3_2Data;
+ (BAFiveData *)create4_2Data;
+ (BAFourData *)create5_2Data;
+ (BAFiveData *)create6_2Data;
+ (BAFourData *)create7_2Data;
+ (BAFourData *)create8_2Data;
+ (BAImagaNameData *)create9_2Data;
+ (BAThreeData *)create10_2Data;

#pragma mark - row 4
+ (BAImagaNameData *)create1_3Data;
+ (BAThreeData *)create2_3Data;
+ (BAFourData *)create3_3Data;
+ (BAFiveDataExtend *)create4_3Data;
+ (BAFourData *)create5_3Data;
+ (BAFourData *)create6_3Data;
+ (BAImagaNameData *)create8_3Data;
+ (BAThreeData *)create9_3Data;

@end
