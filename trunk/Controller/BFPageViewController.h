//
//  BFPageViewController.h
//  E-magazine
//
//  Created by zhonghao zhang on 1/31/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "klpView.h"
#import "BAScrollView.h"
#import "BFHeaderView.h"
#import "BFChapterView.h"
#import "BABookData.h"
#import "BADataSource.h"
#import "BFAppDelegate.h"
#import "BFHeaderViewDelegate.h"


@interface BFPageViewController : UIViewController<BFHeaderViewDelegate,ChangeFrameComplate,UIScrollViewDelegate,UIGestureRecognizerDelegate>{
    NSArray *menuInfoArray;//章节缩略图对应的title
    NSInteger pageMarkIndex;
    NSArray *klpArr;
    
    int mark;
    BFAppDelegate *del;
	klpView *klp;
    klpView *klp2;
	int index;
    UIImageView *iv;
    
    BOOL bSwipe;
    BOOL canRemoveMenu;
    BOOL canRemoveImage;
    int viewPageIndex;
    
    NSTimer *timer;
}
@property (nonatomic, strong) BABookData *bookData;
@property (nonatomic, strong) BADataSource *dataSource;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIScrollView *scrollViewImage0;
@property (nonatomic, strong) UIScrollView *scrollViewImage1;
@property (nonatomic, strong) UIScrollView *scrollViewImage2;

@property (nonatomic, strong) NSString *strMsgkey;
@property (nonatomic, strong) NSString *strBookMarks;
@property (nonatomic, strong) NSArray *menuInfoArray;
@property (nonatomic, strong) NSMutableArray *arrModelViews;
@property (nonatomic, strong) NSMutableArray *arrTitle;
@property (nonatomic, strong) NSMutableArray *arrPages;
@property (nonatomic, strong) NSMutableArray *arrSearchKey;
@property (nonatomic, strong) NSMutableArray *arrViews;
@property (nonatomic, strong) NSMutableArray *arrCustomAllViews;
@property (nonatomic, strong) NSMutableArray *arrCustomAllViewIndexs;
@property (nonatomic, strong) NSMutableArray *arrCustomAllViewAtIndexs;
@property (nonatomic, strong) NSMutableDictionary *dicSearchDataSource;

@property (nonatomic, strong) UILabel *menuTitle;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *klpImgArr;
@property (nonatomic, strong) NSMutableArray *imageInfoArray;
@property (nonatomic, strong) NSMutableArray *imageInfoPorArray;
@property (nonatomic, strong) NSString *bookMarksStr;

@property (nonatomic, strong) NSMutableSet *visiblePages;// 可见的cell集合
@property (nonatomic, strong) NSMutableSet *recycledPages;// 可循环的cell集合

@end
