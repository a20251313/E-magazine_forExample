//
//  CollectmarkObject.h
//  E-magazine
//
//  Created by sunjian on 13-1-30.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectmarkObject : NSObject <NSCoding> {
    NSString *name;
    NSString *BookNumber;
}
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *pageNumber;
- (id) initWithName:(NSString *)aName andNumber:(NSString *)aNumber;



@end
