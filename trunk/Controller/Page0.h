//
//  Page0.h
//  E-magazine
//
//  Created by mac  on 13-2-3.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUILabel.h"
#import "BFHeaderViewDelegate.h"
#import <MediaPlayer/MediaPlayer.h>
#import "BFSearchWordViewController.h"
#import "BAText.h"
#import "Page.h"
#import "PicButton.h"
#import "BFMiniPieView.h"

@protocol Page0Delegate;
@protocol ChangeFrameComplate;

@interface Page0 : Page
<
BFHeaderViewDelegate,
BFSearchWordDelegate,
BFMiniPieDelegate
>
{
    NSMutableArray *BGPics;
    NSMutableArray *allPics;
    NSString *tmptext;
    NSTimer *timer0;
}
@property (nonatomic, retain) BFMiniPieView *pieMini;
@property (nonatomic,retain) NSDictionary *keyWordsDic;
//attributeString可以内部创建也可以外部给
@property (nonatomic,retain) NSMutableAttributedString *attributeString;
@property (nonatomic,retain) CustomUILabel *Label1;
@property (retain,nonatomic) MPMoviePlayerController *movie;
@property (nonatomic,assign) id delegate;
@property (nonatomic) NSInteger *buttonTag;
@property (nonatomic,retain) NSString *strSearchWord;

//需要添加的页面
@property (nonatomic, retain) NSMutableArray *arrViews;
//需要添加的页面的数据源
@property (nonatomic, retain) NSMutableArray *arrViewsAttributeString;
@property (nonatomic, assign) id<ChangeFrameComplate> frameDelegate;
@property (nonatomic, assign) id<Page0Delegate> graphicsDelegate;

//设置数据源NSAttributedString
-(void)setText;
//设置数据源NSAttributedString根据searchword
-(void)setText:(NSString *)strSearchWordPara;
//设置数据源NSAttributedString
-(void)setKeyWordFontWithData:(NSDictionary *)dataDic;
-(void)refreshViewsDataSource;

-(void)initAttributeString;
-(void)needPages;
-(NSInteger)getContentLengthInPage;
-(void)createPagesDataSource:(NSMutableAttributedString *)strAttributeContent;
-(void)stopMovie;

-(NSDictionary*)searchWordInPage:(NSString *) keyword searchContent:(NSString *)searchContent;

-(void)changeFramesWhenRotate;

@end

@protocol ChangeFrameComplate <NSObject>

@optional
- (void)changeFrameComplate;
-(void)stopMovie;

@end

@protocol Page0Delegate <NSObject>

@optional
-(void)showGraphicsAllScreen;
-(void)pushControllerAtPic:(NSString *)className;
@end
