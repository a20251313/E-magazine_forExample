//
//  BFHeaderViewDelegate.h
//  E-magazine
//
//  Created by sunjian on 13-1-25.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewControllerAndPage.h"

@protocol BFHeaderViewDelegate <NSObject>
@optional
- (void)backToHome;
- (void)showContent;
- (void)showContent:(UIButton *)rect;
- (void)hideContent:(UIButton *)rect;
- (void)showCollect:(UIButton *)rect;
- (void)hideHeaderView;
- (void)showHeaderView;
- (void)backAction;
- (void)cleanImage;
- (void)generateComment;
- (void)showTools:(UIButton*)button;
- (void)showLogin;
- (void)dismissComment;
- (void)PostComment:(NSString *)commentword;
- (void)searchWord:(NSString *) word;
- (void)bookMartAction;
- (void)menuSelect:(UIButton *)sender;
- (void)comeToIndexView:(ViewControllerAndPage *)vcAndPage;
- (void)comeToController:(int)controllerIndex;
- (void)miniSearchPrevSwitch:(ViewControllerAndPage *)vcAndPage;
- (void)miniSearchNextSwitch:(ViewControllerAndPage *)vcAndPage;
//点击上方的title按钮选择该章节的page
- (void)selectPageInChapter:(NSInteger)iPageIndexInScroll;
@end
