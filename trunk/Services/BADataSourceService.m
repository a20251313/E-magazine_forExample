//
//  BADataSourceService.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BADataSourceService.h"
//#import "ASIHTTPRequest.h"
//#import "ASIFormDataRequest.h"

#import "BAGeneralTools.h"
#import "AES128.h"
#import "BASE64.h"

@implementation BADataSourceService
{
    NSString *responseString;
}
-(NSMutableDictionary*)getDocumentListDictionary{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"documentList" ofType:@"json"]; 
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *error = nil;
    NSMutableDictionary *jsonObject = (NSMutableDictionary*)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    return jsonObject;
}
/*
-(NSMutableDictionary*)getDocumentListDictionaryFromService
{
    //webservice请求
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.93:8080/cabi/index.php"];
    //NSURL *url = [NSURL URLWithString:@"http://172.16.191.128/cabi"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request addRequestHeader:@"Content-Type" value:@"application/xml;charset=UTF-8;"];
    [request setRequestMethod:@"POST"];
    [request setShouldUseRFC2616RedirectBehaviour:YES];
    
    [request setDelegate:self];
    [request startAsynchronous];
    [request setTag:0];
    NSLog(@"%@",responseString);
    //状态指示器
    //MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.labelText = @"loading...";
return nil;
}

//webservice返回值
- (void)requestFinished:(ASIHTTPRequest *)request
{    
    //[MBProgressHUD hideHUDForView:self.view animated:YES];
    //int tag= request.tag;
    if (request.responseStatusCode == 400) {
        [BAGeneralTools showMsg:@"Invalid code"];     
    } else if (request.responseStatusCode == 403) {
        [BAGeneralTools showMsg:@"Code already used"];
    } else if (request.responseStatusCode == 200) {
        responseString=request.responseString;
        
    } else {
        NSLog(@"%d",request.responseStatusCode);
        [BAGeneralTools showMsg:@"Unexpected error"];
    }
}
请求失败后回调
- (void)requestFailed:(ASIHTTPRequest *)request
{    
    //[MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSError *error = [request error];
    [BAGeneralTools showMsg:error.localizedDescription];
}
*/
-(NSMutableDictionary*)getDocumentDictionaryTest:(NSString *)documentID
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    /*
     //解密key(Base64)
     NSData *keydata=[BASE64 base64Decode:@"a2V5"];
     NSString *key=[[NSString alloc]initWithData:keydata encoding:NSUTF8StringEncoding];
     
     //读取加密文件,并解密(AES128)
     NSString *filePath = [[NSBundle mainBundle] pathForResource:@"document1" ofType:@"txt"];
     NSData *jsonDataEncoded=[[NSData alloc]initWithContentsOfFile:filePath];
     NSData *jsonData=[jsonDataEncoded AES128DecryptWithKey:key iv:@"iv"];
     */
    
    NSError *error = nil;
    NSMutableArray *jsonObject = (NSMutableArray*)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    NSMutableDictionary *document=[[NSMutableDictionary alloc]init];
    for (NSMutableDictionary *sourceDocument in jsonObject) {
        if ([documentID isEqualToString:[sourceDocument objectForKey:@"documentID"]]) {
            document=sourceDocument;
            break;
        }
    }
    return document;
}
-(NSMutableDictionary*)getDocumentDictionaryMagazine:(NSString *)documentID
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"magazine" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];

    NSError *error = nil;
    NSMutableArray *jsonObject = (NSMutableArray*)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    NSMutableDictionary *document=[[NSMutableDictionary alloc]init];
    for (NSMutableDictionary *sourceDocument in jsonObject) {
        if ([documentID isEqualToString:[sourceDocument objectForKey:@"documentID"]]) {
            document=sourceDocument;
            break;
        }
    }
    return document;
}
-(NSMutableDictionary*)getDocumentDictionary:(NSString *)documentID
{
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"document" ofType:@"json"]; 
    //NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    
    //解密key(Base64)
    NSData *keydata=[BASE64 base64Decode:@"a2V5"];
    NSString *key=[[NSString alloc]initWithData:keydata encoding:NSUTF8StringEncoding];
    
    //读取加密文件,并解密(AES128)
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"document1" ofType:@"txt"];
    NSData *jsonDataEncoded=[[NSData alloc]initWithContentsOfFile:filePath];
    NSData *jsonData=[jsonDataEncoded AES128DecryptWithKey:key iv:@"iv"];
    
    
    NSError *error = nil;
    NSMutableArray *jsonObject = (NSMutableArray*)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    NSMutableDictionary *document=[[NSMutableDictionary alloc]init];
    for (NSMutableDictionary *sourceDocument in jsonObject) {
        if ([documentID isEqualToString:[sourceDocument objectForKey:@"documentID"]]) {
            document=sourceDocument;
            break;
        }
    }
    return document;
}
@end
