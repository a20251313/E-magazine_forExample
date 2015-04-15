//
//  KeyWord.h
//  Test
//
//  Created by mac  on 13-1-29.
//  Copyright (c) 2013年 mac . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyWord : NSObject

//标题,关键字
@property int tag;                                  //序号.根据tag来判定
@property NSRange Range;                            //在文章中的Rang//自己标记
@end
