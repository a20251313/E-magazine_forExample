//
//  OCReflection.h
//  Register
//
//  Created by zbq on 13-2-6.
//  Copyright (c) 2013年 zbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCReflection : NSObject

+ (NSDictionary *)getDictionaryFromClass:(id)classInstance;
+ (id)getClassFromDictionary:(NSMutableDictionary *)dict className:(NSString *)className;

@end
