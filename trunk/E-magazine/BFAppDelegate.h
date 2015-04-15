//
//  BFAppDelegate.h
//  E-magazine
//
//  Created by Yann on 13-1-25.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNViewController.h"
#import "ViewControllerAndPage.h"
#import "BADefinition.h"
@class SinaWeibo;

#define kAppKey             @"3197804057"
#define kAppSecret          @"827fe1e73ba3c40ed6054f12fe6cd462"
#define kAppRedirectURI     @"http://www.in-rich.com"



@interface BFAppDelegate : UIResponder <UIApplicationDelegate>
{
    SinaWeibo *sinaweibo;
}
+ (BFAppDelegate *) instance;

@property (strong, nonatomic) UIWindow *window;
@property (readonly, nonatomic) SinaWeibo *sinaweibo;
@property (strong,nonatomic) SNViewController *viewController3;
@property (assign,nonatomic) NSInteger numberOfPage;
@property (strong,nonatomic) NSString *titleStr;
@property (strong,nonatomic) NSString *bookName;
@property (strong,nonatomic) NSString *selectedMark;
@property (strong,nonatomic) NSMutableDictionary *selectedDataAll;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

//根据页数和章节页数数组获得第几章节第几页
- (ViewControllerAndPage *)getChapterAndPage:(NSInteger)page chapters:(NSArray *)chapters;
//根据第几章节第几页和章节页数数组获得页数
- (NSInteger)getPage:(ViewControllerAndPage *)vcAndPage chapters:(NSArray *)chapters;

#warning startTimer
//
- (void)startTimer;
- (void)startTimer_1;

@end
