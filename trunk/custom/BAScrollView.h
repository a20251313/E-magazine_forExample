//
//  BAScrollView.h
//  BizFocus-periodical
//
//  Created by Yann on 13-1-21.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTCoreTextView.h"
@interface BAScrollView : UIScrollView<FTCoreTextViewDelegate>
@property (nonatomic,weak) id myDelegate;
@property (nonatomic,weak) id dataSource;
@property (nonatomic,assign) NSInteger currentPage;
//-(void)scrollToPage:(NSInteger)page;
-(void)configure;
-(void)adjust;
-(void)renderContent;
@end

@protocol BAScrollViewDataSource <NSObject>
@required
-(NSInteger)numberOfPage;
@end

@protocol BAScrollViewDelegate <NSObject>
@optional
-(void)didScrollToPage:(BAScrollView*)scrollView page:(NSInteger)page;
@end
