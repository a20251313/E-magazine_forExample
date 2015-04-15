//
//  BABaseControl.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BABaseGraph.h"

@interface BABaseControl : UIView
{
    NSMutableArray *graphs;
    //NSMutableDictionary *tempData;
    //NSMutableDictionary *sourceData;
    //NSMutableArray *tempLabel;
    //NSArray *sourceLabel;
    BABaseGraph *baseGraph;
}
@property (nonatomic,strong) NSMutableArray *graphs;
//@property (nonatomic,strong) NSMutableDictionary *tempData;
//@property (nonatomic,strong) NSMutableDictionary *sourceData;
//@property (nonatomic,strong) NSMutableArray *tempLabel;
//@property (nonatomic,strong) NSArray *sourceLabel;
@property (nonatomic,strong) BABaseGraph *baseGraph;
@end
