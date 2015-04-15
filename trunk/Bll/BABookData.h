//
//  BABookData.h
//  E-magazine
//
//  Created by summer.zhu on 5/30/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BADataSource.h"

@interface BABookData : NSObject

@property(nonatomic, retain) BADataSource *bookContent;//书中章节地内容（每个章节的文字，图片及文章所在的页数）
@property(nonatomic, retain) NSMutableDictionary *dicSearchData;//书中搜索的数据
@property(nonatomic, retain) NSMutableArray *arrSearchKey;//书中搜索内容的key
@property(nonatomic, retain) NSString *strBookMarks;//书中用于标注本书书签的key
@property(nonatomic, retain) NSString *strMsgkey;//书中用于标注本书消息的key
@property(nonatomic, retain) NSMutableArray *arrViewControllersType;//书中章节的类型
@property(nonatomic, retain) NSMutableArray *arrViewControllersAtIndex;//书中章节所在的位置
@property(nonatomic, retain) NSMutableArray *arrTitle;//书中章节的title

@end
