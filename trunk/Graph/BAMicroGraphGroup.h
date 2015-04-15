//
//  BAMicroGraph.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-10-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BABaseGraph.h"
@protocol BAMicroGraphGroupDelegate;
@interface BAMicroGraphGroup:UIView <UITableViewDelegate,UITableViewDataSource>
{

}
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) NSMutableArray *graphs;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) id<BAMicroGraphGroupDelegate>delegate;
-(void)renderTable;
@end

@protocol BAMicroGraphGroupDelegate<NSObject>

-(void)microGraphGroup:(BAMicroGraphGroup*)microGraphGroup didSelectRowAtIndexPath:(NSUInteger)index;
@end
