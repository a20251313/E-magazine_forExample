//
//  BALoginService.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BALoginService : NSObject
-(BOOL)localValidation:(NSString*)username password:(NSString*)password;
-(NSMutableArray *)getDocumentListWithDictionary:(NSMutableDictionary *)dict;
@end
