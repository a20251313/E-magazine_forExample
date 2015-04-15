//
//  Page.h
//  E-magazine
//
//  Created by summer.zhu on 4/18/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import "ViewControllerAndPage.h"
#import "BAText.h"

@interface Page : UIView{
    NSMutableAttributedString *testAttributeString;
    BAText *baTextTest;
}

//竖屏纯文字页可以显示的文字长度
@property (nonatomic) int totalLengthInContentPagePor;
//横屏纯文字页可以显示的文字长度
@property (nonatomic) int totalLengthInContentPage;
@property (nonatomic) NSInteger iRows;
@property (nonatomic) NSInteger iViewControllerIndex;
@property (nonatomic, retain) ViewControllerAndPage *vcAndPage;
@property (nonatomic, retain) BAText *baText;

//获取测试纯文字页文字
- (void)initTestAttributeString:(NSAttributedString *)strAttributeContent;

//获取纯文本页文字的长度 该长度不仅和矩形有关还和文字有关
- (void)initTotalLength:(NSAttributedString *)strAttributeContent;

-(void)changeFrames:(NSNotification *)notification;
- (int)getLengthInRect:(NSAttributedString *)string rect:(CGRect)rect;
- (int)getAttributedStringHeightWithString:(NSMutableAttributedString *)string WidthValue:(int)width;

-(NSArray*)getTargetAndIndex;

//搜索的关键字变色
-(void)setKeyWordFontWithData:(NSDictionary *)dataDic;

-(void)setText;
-(void)setText:(NSString *)strSearchWordPara;

@end
