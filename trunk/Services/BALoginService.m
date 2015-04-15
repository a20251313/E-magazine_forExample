//
//  BALoginService.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BALoginService.h"
#import "BAGeneralTools.h"
#import "BADocument.h"

@implementation BALoginService
-(BOOL)localValidation:(NSString*)username password:(NSString*)password
{
    //NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];  
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"validation" ofType:@"plist"]; 
    
    //NSString *plistPath = [rootPath stringByAppendingPathComponent:@"validation.plist"]; 
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    if([username isEqualToString:[dict objectForKey:@"username"]]&&[password isEqualToString:[dict objectForKey:@"password"]]){
        return YES;
    }else {
        [BAGeneralTools showMsg:@"Username or Password error!"];
        return NO;
    }
}

-(NSMutableArray *)getDocumentListWithDictionary:(NSMutableDictionary *)dict{
    NSMutableArray *sourceDocumentList=[dict objectForKey:@"documents"];
    NSMutableArray *documentList=[[NSMutableArray alloc]init];
    for (NSMutableDictionary *sourceDocument in sourceDocumentList) {
        BADocument *document=[[BADocument alloc]init];
        document.documentID=[sourceDocument objectForKey:@"documentID"];
        document.documentName=[sourceDocument objectForKey:@"documentName"];
        document.documentDesc=[sourceDocument objectForKey:@"documentDesc"];
        [documentList addObject:document];
    }
    return documentList;
}
@end
