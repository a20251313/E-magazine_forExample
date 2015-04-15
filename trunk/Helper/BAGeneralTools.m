//
//  BAGeneralTools.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BAGeneralTools.h"

@implementation BAGeneralTools
+(void)showMsg:(NSString *)msg
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
@end
