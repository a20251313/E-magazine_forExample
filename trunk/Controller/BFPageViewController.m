//
//  BFPageViewController.m
//  E-magazine
//
//  Created by zhonghao zhang on 1/31/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "BFPageViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BFAppDelegate.h"
#import "BFScrollMenuView.h"
#import "BFImageScrollView.h"
#import "BFHeaderView.h"
#import "BFMenuHeaderView.h"
#import "BFPageViewController.h"
#import "ArticleListViewController.h"
@interface BFPageViewController ()
{
    BFHeaderView *header;
    BFMenuHeaderView *menuHeader;
    BFScrollMenuView *scrollMenuView;
    BFImageScrollView *imageMenuView;
}
@end

@implementation BFPageViewController
@synthesize bookData;
@synthesize dataSource;
@synthesize scrollView;
@synthesize scrollViewImage0;
@synthesize scrollViewImage1;
@synthesize scrollViewImage2;
@synthesize strMsgkey;
@synthesize strBookMarks;
@synthesize menuInfoArray;
@synthesize arrModelViews;
@synthesize arrTitle;
@synthesize arrPages;
@synthesize arrViews;
@synthesize arrCustomAllViews;
@synthesize arrCustomAllViewIndexs;
@synthesize arrCustomAllViewAtIndexs;
@synthesize dicSearchDataSource;
@synthesize menuTitle;
@synthesize titleLabel;
@synthesize pageControl;
@synthesize imageArray;
@synthesize klpImgArr;
@synthesize imageInfoArray;
@synthesize imageInfoPorArray;
@synthesize bookMarksStr;
@synthesize visiblePages;
@synthesize recycledPages;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMsg:) name:@"HaveMsg" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMsg_1:) name:@"HaveMsg_1" object:nil];
    }
    return self;
}
- (void)handleMsg:(NSNotification *)noti{
    NSArray *arr = [noti object];
    [header reloadMsg:arr];
}
- (void)handleMsg_1:(NSNotification *)noti{
    NSArray *arr = [noti object];
    [header reloadMsg_1:arr];
}
//图片展示
-(void)showContent{
    imageMenuView=[[[NSBundle mainBundle] loadNibNamed:@"BFImageScrollView" owner:nil options:nil] lastObject];
    mark = 20;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])){
        imageMenuView.frame = CGRectMake(0, 0+IOS7DISTANCE, 768, 1004);
    }
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        imageMenuView.frame = CGRectMake(0, 0+IOS7DISTANCE, 1024, 748);
    }
    [self initScrollMenuView1];
    menuHeader=[[[NSBundle mainBundle] loadNibNamed:@"BFMenuHeaderView" owner:nil options:nil]lastObject];
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])){
        menuHeader.frame = CGRectMake(0, 0+IOS7DISTANCE, 768, 44);
    }
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        menuHeader.frame = CGRectMake(0, 0+IOS7DISTANCE, 1024, 44);
    }
    menuHeader.delegate = self;
    
    [imageMenuView addSubview:menuHeader];
    canRemoveImage = YES;
    [self.view addSubview:imageMenuView];
}
//目录展示
-(void)showContent:(UIButton *)rect{
    scrollMenuView=[[[NSBundle mainBundle] loadNibNamed:@"BFScrollMenuView" owner:nil options:nil]lastObject];
    mark = 10;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])){
        scrollMenuView.frame = CGRectMake(0, 0+IOS7DISTANCE, 768, 1004);
    }
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        scrollMenuView.frame = CGRectMake(0, 0+IOS7DISTANCE, 1024, 748);
    }
    [self initScrollMenuView];
    menuHeader=[[[NSBundle mainBundle] loadNibNamed:@"BFMenuHeaderView" owner:nil options:nil]lastObject];
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])){
        menuHeader.frame = CGRectMake(0, 0+IOS7DISTANCE, 768, 44);
    }
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        menuHeader.frame = CGRectMake(0, 0+IOS7DISTANCE, 1024, 44);
    }
    menuHeader.delegate = self;
    [scrollMenuView addSubview:menuHeader];
    canRemoveMenu = YES;
    [self.view addSubview:scrollMenuView];
}
//我的收藏界面
-(void)showCollect:(UIButton *)rect{
    ArticleListViewController *collectViewController = [[ArticleListViewController alloc] init];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:collectViewController];
    nav.navigationBar.barStyle=UIBarStyleDefault;
    [self presentViewController:nav animated:NO completion:nil];
    
}
//初始化目录页面
-(void)initScrollMenuView{
    self.imageArray = [[NSMutableArray alloc] initWithCapacity:imageInfoArray.count];
    index = 0;
    scrollMenuView.menuInfoString.text = [menuInfoArray objectAtIndex:index];
    self.menuTitle = scrollMenuView.menuInfoString;
    
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        CGRect temp = scrollMenuView.imageScrollView.frame;
        temp.size.height = 270;
        scrollMenuView.imageScrollView.frame = temp;
        CGSize size2 = scrollMenuView.imageScrollView.frame.size;
        for (int i=0; i<imageInfoPorArray.count; i++) {
            iv = [[UIImageView alloc] initWithFrame:CGRectMake(197*i+imageInfoPorArray.count*i+285.5,0,197,270)];
            [iv setImage:[UIImage imageNamed:[imageInfoPorArray objectAtIndex:i]]];
            [scrollMenuView.imageScrollView addSubview:iv];
            [self.imageArray addObject:iv];
            iv = nil;
        }
        scrollMenuView.imageScrollView.delegate = self;
        scrollMenuView.imageScrollView.contentOffset = CGPointMake(285.5, 0);
        [scrollMenuView.imageScrollView setContentSize:CGSizeMake(197*imageInfoPorArray.count+8*(imageInfoPorArray.count-1)+571,size2.height)];
        klp = [[klpView alloc] initWithFrame:((UIImageView*)[self.imageArray objectAtIndex:index]).frame];
        [scrollMenuView.imageScrollView addSubview:klp];
        scrollMenuView.imageScrollView.showsHorizontalScrollIndicator = NO;
        self.scrollViewImage0 = scrollMenuView.imageScrollView;
    }
    else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        CGRect temp = scrollMenuView.imageScrollView.frame;
        temp.size.height = 197;
        scrollMenuView.imageScrollView.frame = temp;
        CGSize size2 = scrollMenuView.imageScrollView.frame.size;
        for (int i=0; i<imageInfoArray.count; i++) {
            iv = [[UIImageView alloc] initWithFrame:CGRectMake(270*i+imageInfoArray.count*i+377,0,270,197)];
            [iv setImage:[UIImage imageNamed:[imageInfoArray objectAtIndex:i]]];
            [scrollMenuView.imageScrollView addSubview:iv];
            [self.imageArray addObject:iv];
            iv = nil;
        }
        scrollMenuView.imageScrollView.delegate = self;
        scrollMenuView.imageScrollView.contentOffset = CGPointMake(377, 0);
        [scrollMenuView.imageScrollView setContentSize:CGSizeMake(270*imageInfoArray.count+8*(imageInfoArray.count-1)+754,size2.height)];
        
        klp = [[klpView alloc] initWithFrame:((UIImageView*)[self.imageArray objectAtIndex:index]).frame];
        [scrollMenuView.imageScrollView addSubview:klp];
        scrollMenuView.imageScrollView.showsHorizontalScrollIndicator = NO;
        self.scrollViewImage0 = scrollMenuView.imageScrollView;
    }
    
    UITapGestureRecognizer *imageTapToSelect = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTapToSelect:)];
    [imageTapToSelect setNumberOfTapsRequired:1];
    [scrollMenuView.imageScrollView addGestureRecognizer:imageTapToSelect];
}
//初始化图片浏览页面
-(void)initScrollMenuView1{
    index = 0;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        klpArr = self.imageInfoPorArray;
        self.klpImgArr = [[NSMutableArray alloc] initWithCapacity:[self.imageInfoPorArray count]];
        
        CGSize size = imageMenuView.klpScrollView1.frame.size;
        for (int i=0; i < [klpArr count]; i++) {
            iv = [[UIImageView alloc] initWithFrame:CGRectMake(size.width * i, 0, size.width, size.height)];
            [iv setImage:[UIImage imageNamed:[klpArr objectAtIndex:i]]];
            [imageMenuView.klpScrollView1 addSubview:iv];
            iv = nil;
        }
        imageMenuView.klpScrollView1.delegate = self;
        [imageMenuView.klpScrollView1 setContentSize:CGSizeMake(size.width * [self.imageInfoPorArray count], size.height)];
        imageMenuView.klpScrollView1.pagingEnabled = YES;
        imageMenuView.klpScrollView1.showsHorizontalScrollIndicator = NO;
        self.scrollViewImage1 = imageMenuView.klpScrollView1;
        
        CGRect temp = imageMenuView.klpScrollView2.frame;
        temp.size.height = 100;
        imageMenuView.klpScrollView2.frame = temp;
        CGSize size2 = imageMenuView.klpScrollView2.frame.size;
        for (int i=0; i<[self.imageInfoPorArray count]; i++) {
            iv = [[UIImageView alloc] initWithFrame:CGRectMake(70*i+5*i+349,0,70,100)];
            [iv setImage:[UIImage imageNamed:[klpArr objectAtIndex:i]]];
            [imageMenuView.klpScrollView2 addSubview:iv];
            [self.klpImgArr addObject:iv];
            iv = nil;
        }
        imageMenuView.klpScrollView2.delegate = self;
        imageMenuView.klpScrollView2.contentOffset = CGPointMake(349, 0);
        [imageMenuView.klpScrollView2 setContentSize:CGSizeMake(70*[self.imageInfoPorArray count]+5*([self.imageInfoPorArray count]-1)+698,size2.height)];
        
        klp = [[klpView alloc] initWithFrame:((UIImageView*)[self.klpImgArr objectAtIndex:index]).frame];
        [imageMenuView.klpScrollView2 addSubview:klp];
        imageMenuView.klpScrollView2.showsHorizontalScrollIndicator = NO;
        self.scrollViewImage2 = imageMenuView.klpScrollView2;
    }
    else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        klpArr = self.imageInfoArray;
        self.klpImgArr = [[NSMutableArray alloc] initWithCapacity:[self.imageInfoArray count]];
        CGSize size = imageMenuView.klpScrollView1.frame.size;
        for (int i=0; i < [klpArr count]; i++) {
            iv = [[UIImageView alloc] initWithFrame:CGRectMake(size.width * i, 0, size.width, size.height)];
            [iv setImage:[UIImage imageNamed:[klpArr objectAtIndex:i]]];
            [imageMenuView.klpScrollView1 addSubview:iv];
            iv = nil;
        }
        imageMenuView.klpScrollView1.delegate = self;
        [imageMenuView.klpScrollView1 setContentSize:CGSizeMake(size.width * [self.imageInfoArray count], size.height)];
        imageMenuView.klpScrollView1.pagingEnabled = YES;
        imageMenuView.klpScrollView1.showsHorizontalScrollIndicator = NO;
        self.scrollViewImage1 = imageMenuView.klpScrollView1;
        
        CGRect temp = imageMenuView.klpScrollView2.frame;
        temp.size.height = 70;
        imageMenuView.klpScrollView2.frame = temp;
        CGSize size2 = imageMenuView.klpScrollView2.frame.size;
        for (int i=0; i<[self.imageInfoArray count]; i++) {
            iv = [[UIImageView alloc] initWithFrame:CGRectMake(100*i+5*i+462,0,100,70)];
            [iv setImage:[UIImage imageNamed:[klpArr objectAtIndex:i]]];
            [imageMenuView.klpScrollView2 addSubview:iv];
            [self.klpImgArr addObject:iv];
            iv = nil;
        }
        imageMenuView.klpScrollView2.delegate = self;
        imageMenuView.klpScrollView2.contentOffset = CGPointMake(462, 0);
        [imageMenuView.klpScrollView2 setContentSize:CGSizeMake(100*[self.imageInfoArray count]+5*([self.imageInfoArray count]-1)+924,size2.height)];
        
        klp = [[klpView alloc] initWithFrame:((UIImageView*)[self.klpImgArr objectAtIndex:index]).frame];
        [imageMenuView.klpScrollView2 addSubview:klp];
        imageMenuView.klpScrollView2.showsHorizontalScrollIndicator = NO;
        self.scrollViewImage2 = imageMenuView.klpScrollView2;
    }
}
//scroll view代理方法  包括图片浏览，目录浏览，和主页面浏览
#pragma mark-- UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView1{
    if (scrollView.contentOffset.x>scrollView.frame.size.width*([self.arrViews count]-1)+100) {
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.size.width*0,0,scrollView.frame.size.width,scrollView.frame.size.height) animated:NO];
    }

	if (scrollView1 == self.scrollViewImage1) {
		CGFloat pageWidth = scrollView1.frame.size.width;
		int page = floor((scrollView1.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		index = page;
	}
    if (scrollView1 == self.scrollViewImage2) {
        CGFloat offset;
        CGFloat width;
        NSInteger currentIndex;
        if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
            width = 70.0f;
            offset = scrollViewImage2.contentOffset.x;
            currentIndex = (384-349+offset+2.5)/width;
        }
        else{
            width = 100.0f;
            offset = scrollViewImage2.contentOffset.x;
            currentIndex = (512-462+offset+2.5)/width;
        }
        if (currentIndex>imageInfoArray.count-1) {
            currentIndex = imageInfoArray.count-1;
        }
        if (currentIndex<0) {
            currentIndex = 0;
        }
        
        CGRect frame = self.scrollViewImage1.frame;
        frame.origin.x = frame.size.width * currentIndex;
        [scrollViewImage1 scrollRectToVisible:frame animated:NO];
        
        klp.frame = ((UIImageView*)[self.klpImgArr objectAtIndex:currentIndex]).frame;
    }
    if(scrollView1 == self.scrollView){
        [self reUseScrollWithViews];
        if (bSwipe) {
            CGFloat offset = scrollView1.contentOffset.x;
            CGFloat width = scrollView1.frame.size.width;
            NSInteger currentPage = (offset+(width/2))/width;
            if (currentPage>[self.arrViews count]-1) {
                currentPage = [self.arrViews count]-1;
            }
            if (currentPage<0) {
                currentPage = 0;
            }
            pageMarkIndex=currentPage;
            
            //更新appdelegate的信息
            ViewControllerAndPage *vcAndPage = [del getChapterAndPage:currentPage chapters:arrCustomAllViewAtIndexs];
            del.numberOfPage = currentPage;
            del.titleStr = [menuInfoArray objectAtIndex:[vcAndPage.viewControllerIndex intValue]];
            
            //更新标题
            [header loadTitle:del.titleStr];
            
            //更新下方的前一项，后一项
            NSInteger viewControllerIndex = [vcAndPage.viewControllerIndex intValue];
            BFChapterView *vc = (BFChapterView *)[arrModelViews objectAtIndex:viewControllerIndex];
            header.arrPagesData = vc.data.arrPageData;
            [header refreshMiniSearchBtns:vcAndPage];
            
            if (currentPage !=10) {
                BFChapterView *vc = (BFChapterView *)[arrModelViews objectAtIndex:5];
                [vc stopMovieInController];
            }
        }
    }
    if(scrollView1 == self.scrollViewImage0){
        CGFloat offset;
        CGFloat width;
        NSInteger currentPage;
        if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
            width = 205.0f;
            offset = scrollViewImage0.contentOffset.x;
            currentPage = (384-285+offset+4)/width;
        }
        else{
            width = 278.0f;
            offset = scrollViewImage0.contentOffset.x;
            currentPage = (512-377+offset+4)/width;
        }
        if (currentPage>imageInfoArray.count-1) {
            currentPage = imageInfoArray.count-1;
        }
        if (currentPage<0) {
            currentPage = 0;
        }
        menuTitle.text = [menuInfoArray objectAtIndex:currentPage];
        klp.frame = ((UIImageView*)[self.imageArray objectAtIndex:currentPage]).frame;
    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView1{
    bSwipe = YES;
	if (scrollView1 == self.scrollViewImage1) {
		;
	}else if(scrollView1 == self.scrollViewImage2){
        
	}
    else{
        
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1{
    bSwipe = NO;
	if (scrollView1 == self.scrollViewImage1) {
        CGRect frame = self.scrollViewImage2.frame;
        frame.origin.x = frame.size.width * index;
        [scrollViewImage2 scrollRectToVisible:frame animated:YES];
        klp.frame = ((UIImageView*)[self.klpImgArr objectAtIndex:index]).frame;
        
	}else if(scrollView1 == self.scrollViewImage2) {
        
	}
    else if(scrollView1 == self.scrollView) {
        //        CGFloat offset = scrollView1.contentOffset.x;
        //        CGFloat width = scrollView1.frame.size.width;
        //        NSInteger currentPage = (offset+(width/2))/width;
        //        if (currentPage != 9) {
        //            BFChapterViewController *vc = (BFChapterViewController *)[_viewControllers objectAtIndex:5];
        //            [vc stopMovieInController];
        //        }
	}
    else{
        
    }
}
//目录浏览页面的点击事件
- (void) handleImageTapToSelect:(UITapGestureRecognizer *) gestureRecognizer{
    CGFloat gap = 8;
    CGFloat rowHeight;
    CGFloat columeWith;
    NSInteger touchIndex;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        rowHeight = 270;
        columeWith = 197;
        CGPoint loc = [gestureRecognizer locationInView:scrollMenuView.imageScrollView];
        touchIndex = floor((loc.x-285) / (columeWith + gap)) + 3 * floor(loc.y / (rowHeight + gap)) ;
        if (touchIndex > self.imageArray.count) {
            return;
        }
    }
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        rowHeight = 197;
        columeWith = 270;
        CGPoint loc = [gestureRecognizer locationInView:scrollMenuView.imageScrollView];
        touchIndex = floor((loc.x-377) / (columeWith + gap)) + 3 * floor(loc.y / (rowHeight + gap)) ;
        if (touchIndex > self.imageArray.count) {
            return;
        }
    }
    index = touchIndex;
    scrollMenuView.menuInfoString.text = [menuInfoArray objectAtIndex:index];
    klp.frame = ((UIImageView*)[self.imageArray objectAtIndex:index]).frame;
    [klp setAlpha:0];
    [UIView animateWithDuration:0.2f animations:^(void){
        [klp setAlpha:.85f];
    }];
	[scrollMenuView.imageScrollView setContentOffset:CGPointMake(klp.frame.origin.x, 0) animated:YES];
    [scrollMenuView removeFromSuperview];
    canRemoveMenu = NO;
    
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * [[self.arrCustomAllViewAtIndexs objectAtIndex:index] intValue];
    frame.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame animated:NO];
    
    pageMarkIndex=[[self.arrCustomAllViewAtIndexs objectAtIndex:index] intValue];
    ViewControllerAndPage *vcAndPage = [del getChapterAndPage:pageMarkIndex chapters:arrCustomAllViewAtIndexs];
    del.numberOfPage = pageMarkIndex;
    del.titleStr = [menuInfoArray objectAtIndex:[vcAndPage.viewControllerIndex intValue]];
    [header loadTitle:del.titleStr];
    NSInteger viewControllerIndex = [vcAndPage.viewControllerIndex intValue];
    BFChapterView *vc = (BFChapterView *)[arrModelViews objectAtIndex:viewControllerIndex];
    header.arrPagesData = vc.data.arrPageData;
}

#pragma mark -
#pragma mark scrollMenu delegates
-(void)menuSelect:(UIButton *)sender{
    CGRect frame2 = self.scrollView.frame;
    pageMarkIndex=(sender.tag-10)/10;
    
    ViewControllerAndPage *vcAndPage = [del getChapterAndPage:pageMarkIndex chapters:arrCustomAllViewAtIndexs];
    del.numberOfPage = pageMarkIndex;
    del.titleStr = [menuInfoArray objectAtIndex:[vcAndPage.viewControllerIndex intValue]];
    [header loadTitle:del.titleStr];
    NSInteger viewControllerIndex = [vcAndPage.viewControllerIndex intValue];
    BFChapterView *vc = (BFChapterView *)[arrModelViews objectAtIndex:viewControllerIndex];
    header.arrPagesData = vc.data.arrPageData;
    
    frame2.origin.x = frame2.size.width * ((sender.tag-10)/10);
    frame2.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame2 animated:NO];
    
}
#pragma mark -
#pragma mark bookMark delegates
- (void)comeToController:(int)controllerIndex{
    CGRect frame2 = self.scrollView.frame;
    pageMarkIndex=controllerIndex;
    
    ViewControllerAndPage *vcAndPage = [del getChapterAndPage:pageMarkIndex chapters:arrCustomAllViewAtIndexs];
    del.numberOfPage = pageMarkIndex;
    del.titleStr = [menuInfoArray objectAtIndex:[vcAndPage.viewControllerIndex intValue]];
    [header loadTitle:del.titleStr];
    NSInteger viewControllerIndex = [vcAndPage.viewControllerIndex intValue];
    BFChapterView *vc = (BFChapterView *)[arrModelViews objectAtIndex:viewControllerIndex];
    header.arrPagesData = vc.data.arrPageData;
    
    frame2.origin.x = frame2.size.width *pageMarkIndex;
    frame2.origin.y = 0;
    bSwipe = YES;
    [self.scrollView scrollRectToVisible:frame2 animated:NO];
    bSwipe = NO;
}

#pragma mark - search delegate
-(void)comeToIndexView:(ViewControllerAndPage *)vcAndPage{
    pageMarkIndex=[del getPage:vcAndPage chapters:arrCustomAllViewAtIndexs];
    del.numberOfPage = pageMarkIndex;
    del.titleStr = [menuInfoArray objectAtIndex:[vcAndPage.viewControllerIndex intValue]];
    [header loadTitle:del.titleStr];
    NSInteger viewControllerIndex = [vcAndPage.viewControllerIndex intValue];
    BFChapterView *vc = (BFChapterView *)[arrModelViews objectAtIndex:viewControllerIndex];
    header.arrPagesData = vc.data.arrPageData;
    
    bSwipe = YES;
    CGRect frame2 = self.scrollView.frame;
    frame2.origin.x = frame2.size.width*pageMarkIndex;
    frame2.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame2 animated:NO];
    bSwipe = NO;
    
}

//点击上方的title按钮选择该章节的page
- (void)selectPageInChapter:(NSInteger)iPageIndexInScroll{
    pageMarkIndex=iPageIndexInScroll;
    ViewControllerAndPage *vcAndPage = [del getChapterAndPage:pageMarkIndex chapters:arrCustomAllViewAtIndexs];
    del.numberOfPage = pageMarkIndex;
    del.titleStr = [menuInfoArray objectAtIndex:[vcAndPage.viewControllerIndex intValue]];
    [header loadTitle:del.titleStr];
    NSInteger viewControllerIndex = [vcAndPage.viewControllerIndex intValue];
    BFChapterView *vc = (BFChapterView *)[arrModelViews objectAtIndex:viewControllerIndex];
    header.arrPagesData = vc.data.arrPageData;
    
    CGRect frame2 = self.scrollView.frame;
    frame2.origin.x = frame2.size.width*pageMarkIndex;
    frame2.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame2 animated:NO];
}


#pragma mark -
#pragma mark miniSearch delegates
-(void)miniSearchPrevSwitch:(ViewControllerAndPage *)vcAndPage{
    pageMarkIndex=[del getPage:vcAndPage chapters:arrCustomAllViewAtIndexs];
    del.numberOfPage = pageMarkIndex;
    del.titleStr = [menuInfoArray objectAtIndex:[vcAndPage.viewControllerIndex intValue]];
    [header loadTitle:del.titleStr];
    NSInteger viewControllerIndex = [vcAndPage.viewControllerIndex intValue];
    BFChapterView *vc = (BFChapterView *)[arrModelViews objectAtIndex:viewControllerIndex];
    header.arrPagesData = vc.data.arrPageData;
    
    CGRect frame2 = self.scrollView.frame;
    frame2.origin.x = frame2.size.width*pageMarkIndex;
    frame2.origin.y = 0;
    bSwipe = YES;
    [self.scrollView scrollRectToVisible:frame2 animated:NO];
    bSwipe = NO;
}
-(void)miniSearchNextSwitch:(ViewControllerAndPage *)vcAndPage{
    pageMarkIndex=[del getPage:vcAndPage chapters:arrCustomAllViewAtIndexs];
    del.numberOfPage = pageMarkIndex;
    del.titleStr = [menuInfoArray objectAtIndex:[vcAndPage.viewControllerIndex intValue]];
    [header loadTitle:del.titleStr];
    NSInteger viewControllerIndex = [vcAndPage.viewControllerIndex intValue];
    BFChapterView *vc = (BFChapterView *)[arrModelViews objectAtIndex:viewControllerIndex];
    header.arrPagesData = vc.data.arrPageData;
    
    CGRect frame2 = self.scrollView.frame;
    frame2.origin.x = frame2.size.width*pageMarkIndex;
    frame2.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame2 animated:NO];
}
#pragma mark -
#pragma mark gestureRecognizer delegates
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIButton class]]||[touch.view isKindOfClass:[UIImageView class]]) {
        return NO;
    }
    else{
        return YES;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [AppDelegateEntity.activityView stopAnimating];
    AppDelegateEntity.activityView.hidden = YES;
}

//移除目录或图片浏览页面
-(void)hideContent:(UIButton *)rect{
    if (mark == 10) {
        [scrollMenuView removeFromSuperview];
        canRemoveMenu = NO;
    }
    if (mark == 20) {
        [imageMenuView removeFromSuperview];
        canRemoveImage = NO;
    }
    
}

- (void)setBookData:(BABookData *)_bookData{
    if (bookData != _bookData) {
        bookData = nil;
        bookData = _bookData;
    }
    self.dataSource = self.bookData.bookContent;
    self.dicSearchDataSource = self.bookData.dicSearchData;
    self.arrSearchKey = self.bookData.arrSearchKey;
    self.strBookMarks = self.bookData.strBookMarks;
    self.strMsgkey = self.bookData.strMsgkey;
    self.arrCustomAllViewIndexs = self.bookData.arrViewControllersType;
    self.arrCustomAllViewAtIndexs = self.bookData.arrViewControllersAtIndex;
    self.menuInfoArray = self.bookData.arrTitle;
}

- (void)reloadCustomViewByModel
{
    self.arrViews = [[NSMutableArray alloc] init];
    self.arrModelViews = [[NSMutableArray alloc] initWithCapacity:arrCustomAllViewIndexs.count];
    self.imageInfoArray = [[NSMutableArray alloc] initWithCapacity:arrCustomAllViewIndexs.count];
    self.imageInfoPorArray = [[NSMutableArray alloc] initWithCapacity:arrCustomAllViewIndexs.count];

    for (int i=0; i<arrCustomAllViewIndexs.count; i++) {
        BFChapterView *vc = [[BFChapterView alloc] init];
        NSString *strIndex = [arrCustomAllViewIndexs objectAtIndex:i];
        vc.viewIndex = strIndex;
        vc.delegate = self;
        vc.data = [self getDataByIndex:i];
        vc.iPosition = [[arrCustomAllViewAtIndexs objectAtIndex:i] intValue];
        vc.viewController = self;
        vc.strBookMarks = self.strBookMarks;
        switch ([strIndex intValue]) {//根据index判断需要创建的哪种view
            case 0:
            {
                [vc createView1];
            }
                break;
            case 1:
            {
                [vc createView2];
            }
                break;
            case 2:
            {
                [vc createView3];
            }
                break;
            case 3:
            {
                [vc createView4];
            }
                break;
            case 4:
            {
                [vc createView5];
            }
                break;
            case 5:
            {
                [vc createView6];
            }
                break;
            case 6:
            {
                [vc createView7];
            }
                break;
            case 7:
            {
                [vc createView8];
            }
                break;
            case 8:
            {
                [vc createView9];
            }
                break;
                
            default:
                break;
        }
        [self.arrViews addObjectsFromArray:vc.arrViews];
        [self.arrModelViews addObject:vc];
        [self.imageInfoArray addObject:vc.data.imagedata.strLandscapeImageName];
        [self.imageInfoPorArray addObject:vc.data.imagedata.strPortraitImageName];
    }
    self.bookMarksStr = self.strBookMarks;
}

- (BAData *)getDataByIndex:(NSInteger)iIndex{
    BAData *data = nil;
    switch (iIndex) {//分配数据
        case 0:
            data = dataSource.data1;
            break;
        case 1:
            data = dataSource.data2;
            break;
        case 2:
            data = dataSource.data3;
            break;
        case 3:
            data = dataSource.data4;
            break;
        case 4:
            data = dataSource.data5;
            break;
        case 5:
            data = dataSource.data6;
            break;
        case 6:
            data = dataSource.data7;
            break;
        case 7:
            data = dataSource.data8;
            break;
        case 8:
            data = dataSource.data9;
            break;
        case 9:
            data = dataSource.data10;
            break;
            
        default:
            break;
    }
    return data;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    arrPages = [[NSMutableArray alloc] init];
    visiblePages = [[NSMutableSet alloc] init];
    recycledPages = [[NSMutableSet alloc] init];
    [self reloadCustomViewByModel];

    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    self.scrollView.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
    self.scrollView.frame = CGRectMake(0, 0+IOS7DISTANCE+44,self.view.frame.size.width,self.view.frame.size.height-44);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*[self.arrViews count],self.scrollView.frame.size.height);
    [self.view addSubview:self.scrollView];
        
    header=[[[NSBundle mainBundle] loadNibNamed:@"BFHeaderView" owner:nil options:nil]lastObject];
    header.frame=CGRectMake(0, 0+IOS7DISTANCE, self.view.frame.size.width,44);
    header.controller = self;
    header.delegate = self;
    header.strMsgKey = self.strMsgkey;
    [self.view addSubview:header];
    
    [header loadTitle:[menuInfoArray objectAtIndex:0]];//第一个

    BFChapterView *vc = (BFChapterView *)[self.arrModelViews objectAtIndex:0];
    header.arrPagesData = vc.data.arrPageData;
    header.hidden = NO;
    
    del = (BFAppDelegate *)[[UIApplication sharedApplication] delegate];
    del.numberOfPage = 0;
    del.titleStr = [menuInfoArray objectAtIndex:0];
    
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        self.view.frame=CGRectMake(0, 0+IOS7DISTANCE, 768, 1004);
        self.scrollView.frame=CGRectMake(0, 0+IOS7DISTANCE, 768, 1004);
    }
    else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        self.view.frame=CGRectMake(0, 0+IOS7DISTANCE, 1024, 748);
        self.scrollView.frame=CGRectMake(0, 0+IOS7DISTANCE, 1024, 748);
    }
    [self reUseScrollWithViews];
    
}

- (void)reUseScrollWithViews{
    // 计算是不是在可见区域
    CGRect visibleBounds =self.scrollView.bounds;
    int firstNeededPageIndex = floorf(CGRectGetMinX(visibleBounds) / CGRectGetWidth(visibleBounds));
    int lastNeededPageIndex  = floorf((CGRectGetMaxX(visibleBounds)-1) / CGRectGetWidth(visibleBounds));
    firstNeededPageIndex = MAX(firstNeededPageIndex, 0);
    lastNeededPageIndex  = MIN(lastNeededPageIndex, [self.arrViews count] - 1);

    // 循环可见视图，将不在当前可见范围视图添加到循环队列中，然后从父视图中移除
    for (BFChapterView *page in visiblePages) {
        if (page.index < firstNeededPageIndex || page.index > lastNeededPageIndex) {
            [recycledPages addObject:page];
            [page removeFromSuperview];
        }
    }
    // 可见视图的集合减去循环队列的集合
    [visiblePages minusSet:recycledPages];
    
    // 添加缺少的cell
    for (int pageIndex = firstNeededPageIndex; pageIndex <= lastNeededPageIndex; pageIndex++) {
        if (![self isDisplayingPageForIndex:pageIndex]) {
            BFChapterView *page = [self dequeueRecycledPage];
            if (page == nil) {
                page = [[BFChapterView alloc] init];
            }
            [self configurePage:page forIndex:pageIndex];
            [visiblePages addObject:page];
        }
    }
}
// 判断index对应的视图是否在可见队列中
- (BOOL)isDisplayingPageForIndex:(NSUInteger)aIndex
{
    BOOL foundPage = NO;
    for (BFChapterView *page in visiblePages) {
        if (page.index == aIndex) {
            foundPage = YES;
            break;
        }
    }
    return foundPage;
}

- (void)configurePage:(BFChapterView *)page forIndex:(NSUInteger)aIndex
{
    pageMarkIndex = aIndex;
    viewPageIndex = page.index;
    page.index = aIndex;
    page = (BFChapterView *)[self.arrViews objectAtIndex:aIndex];
    page.frame =CGRectMake(self.scrollView.frame.size.width*aIndex, 0, self.scrollView.frame.size.width,self.scrollView.frame.size.height);
    if ([page isKindOfClass:[PicPage class]]) {
        [(PicPage *)page changeFramesWhenRotate];
    }
    if ([page isKindOfClass:[Page0 class]]) {
        [(Page0 *)page changeFramesWhenRotate];
    }
    [self.scrollView addSubview:page];
}
- (void)changePageFrame:(BFChapterView *)page forIndex:(NSUInteger)aIndex
{
    pageMarkIndex = aIndex;
    viewPageIndex = page.index;
    page.index = aIndex;
    page = (BFChapterView *)[self.arrViews objectAtIndex:aIndex];
    page.frame =CGRectMake(self.scrollView.frame.size.width*aIndex, 0, self.scrollView.frame.size.width,self.scrollView.frame.size.height);
    if ([page isKindOfClass:[PicPage class]]) {
        [(PicPage *)page changeFramesWhenRotate];
    }
    if ([page isKindOfClass:[Page0 class]]) {
        [(Page0 *)page changeFramesWhenRotate];
    }
}
// 重用
- (BFChapterView *)dequeueRecycledPage
{
    BFChapterView *page = [recycledPages anyObject];
    if (page) {
        [recycledPages removeObject:page];
    }
    return page;
}

-(void)viewDidUnload{
    self.bookData=nil;
    self.dataSource=nil;
    self.scrollView=nil;
    self.scrollViewImage0=nil;
    self.scrollViewImage1=nil;
    self.scrollViewImage2=nil;
    self.strMsgkey=nil;
    self.strBookMarks = nil;
    self.menuInfoArray=nil;
    self.arrModelViews=nil;
    self.arrTitle=nil;
    self.arrPages=nil;
    self.arrViews=nil;
    self.arrCustomAllViews=nil;
    self.arrCustomAllViewIndexs=nil;
    self.arrCustomAllViewAtIndexs=nil;
    self.dicSearchDataSource=nil;
    self.menuTitle=nil;
    self.titleLabel=nil;
    self.pageControl=nil;
    self.imageArray=nil;
    self.klpImgArr=nil;
    self.imageInfoArray=nil;
    self.imageInfoPorArray=nil;
    self.bookMarksStr = nil;
    self.visiblePages = nil;
    self.recycledPages = nil;
    
    [super viewDidUnload];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [header loadTitle:del.titleStr];
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        self.scrollView.frame=CGRectMake(0, 0+IOS7DISTANCE, 768, 1004);
        header.homeBtn.frame = CGRectMake(6, 9, 25, 25);
        header.menuBtn.frame = CGRectMake(56, 9, 25, 25);
        header.collectBtn.frame = CGRectMake(107, 9, 25, 25);
        header.btnMsg_1.frame = CGRectMake(687, 4, 36, 36);
        header.btnMsg.frame = CGRectMake(734, 4, 36, 36);
        header.savedBookmarks.frame = CGRectMake(556, 9, 25, 25);
        header.shareBtn.frame = CGRectMake(616, 9, 25, 25);
        header.toolBtn.frame = CGRectMake(671, 9, 25, 25);
        header.searchBtn.frame = CGRectMake(721, 11, 23, 23);
        CGRect frame2 =CGRectMake(768*pageMarkIndex, 0, 768, 1004);
        [self.scrollView scrollRectToVisible:frame2 animated:NO];
    }
    else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        self.scrollView.frame=CGRectMake(0, 0+IOS7DISTANCE, 1024, 748);
        header.homeBtn.frame = CGRectMake(6, 9, 25, 25);
        header.menuBtn.frame = CGRectMake(56, 9, 25, 25);
        header.collectBtn.frame = CGRectMake(107, 9, 25, 25);
        header.btnMsg_1.frame = CGRectMake(687, 4, 36, 36);
        header.btnMsg.frame = CGRectMake(734, 4, 36, 36);
        header.savedBookmarks.frame = CGRectMake(792, 9, 25, 25);
        header.shareBtn.frame = CGRectMake(852, 9, 25, 25);
        header.toolBtn.frame = CGRectMake(907, 9, 25, 25);
        header.searchBtn.frame = CGRectMake(957, 11, 23, 23);
        CGRect frame2 =CGRectMake(1024*pageMarkIndex, 0, 1024, 748);
        [self.scrollView scrollRectToVisible:frame2 animated:NO];
    }
    [self changeFrames];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    [header loadTitle:del.titleStr];
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        self.scrollView.frame=CGRectMake(0, 0+IOS7DISTANCE, 768, 1004);
        header.homeBtn.frame = CGRectMake(6, 9, 25, 25);
        header.menuBtn.frame = CGRectMake(56, 9, 25, 25);
        header.collectBtn.frame = CGRectMake(107, 9, 25, 25);
        header.btnMsg_1.frame = CGRectMake(687, 4, 36, 36);
        header.btnMsg.frame = CGRectMake(734, 4, 36, 36);
        header.savedBookmarks.frame = CGRectMake(556, 9, 25, 25);
        header.shareBtn.frame = CGRectMake(616, 9, 25, 25);
        header.toolBtn.frame = CGRectMake(671, 9, 25, 25);
        header.searchBtn.frame = CGRectMake(721, 11, 23, 23);
        CGRect frame2 =CGRectMake(768*pageMarkIndex, 0, 768, 1004);
        [self.scrollView scrollRectToVisible:frame2 animated:NO];
    }
    else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        self.scrollView.frame=CGRectMake(0, 0+IOS7DISTANCE, 1024, 748);
        header.homeBtn.frame = CGRectMake(6, 9, 25, 25);
        header.menuBtn.frame = CGRectMake(56, 9, 25, 25);
        header.collectBtn.frame = CGRectMake(107, 9, 25, 25);
        header.btnMsg_1.frame = CGRectMake(687, 4, 36, 36);
        header.btnMsg.frame = CGRectMake(734, 4, 36, 36);
        header.savedBookmarks.frame = CGRectMake(792, 9, 25, 25);
        header.shareBtn.frame = CGRectMake(852, 9, 25, 25);
        header.toolBtn.frame = CGRectMake(907, 9, 25, 25);
        header.searchBtn.frame = CGRectMake(957, 11, 23, 23);
        CGRect frame2 =CGRectMake(1024*pageMarkIndex, 0, 1024, 748);
        [self.scrollView scrollRectToVisible:frame2 animated:NO];
    }
    [self changeFrames];
    return UIInterfaceOrientationIsLandscape(interfaceOrientation)||UIInterfaceOrientationIsPortrait(interfaceOrientation);
}
///ios 6.0
-(BOOL)shouldAutorotate{
    return YES;
}
-(NSUInteger)supportedInterfaceOrientations{
    [header loadTitle:del.titleStr];
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        self.scrollView.frame=CGRectMake(0, 0+IOS7DISTANCE, 768, 1004);
        header.homeBtn.frame = CGRectMake(6, 9, 25, 25);
        header.menuBtn.frame = CGRectMake(56, 9, 25, 25);
        header.collectBtn.frame = CGRectMake(107, 9, 25, 25);
        header.btnMsg_1.frame = CGRectMake(687, 4, 36, 36);
        header.btnMsg.frame = CGRectMake(734, 4, 36, 36);
        header.savedBookmarks.frame = CGRectMake(556, 9, 25, 25);
        header.shareBtn.frame = CGRectMake(616, 9, 25, 25);
        header.toolBtn.frame = CGRectMake(671, 9, 25, 25);
        header.searchBtn.frame = CGRectMake(721, 11, 23, 23);
        header.miniSearchView.frame=CGRectMake(0, 960, 768,44);
        CGRect frame2 =CGRectMake(768*pageMarkIndex, 0, 768, 1004);
        [self.scrollView scrollRectToVisible:frame2 animated:NO];
    }
    else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        self.scrollView.frame=CGRectMake(0, 0+IOS7DISTANCE, 1024, 748);
        header.homeBtn.frame = CGRectMake(6, 9, 25, 25);
        header.menuBtn.frame = CGRectMake(56, 9, 25, 25);
        header.collectBtn.frame = CGRectMake(107, 9, 25, 25);
        header.btnMsg_1.frame = CGRectMake(687, 4, 36, 36);
        header.btnMsg.frame = CGRectMake(734, 4, 36, 36);
        header.savedBookmarks.frame = CGRectMake(792, 9, 25, 25);
        header.shareBtn.frame = CGRectMake(852, 9, 25, 25);
        header.toolBtn.frame = CGRectMake(907, 9, 25, 25);
        header.searchBtn.frame = CGRectMake(957, 11, 23, 23);
        header.miniSearchView.frame=CGRectMake(0, 704, 1024,44);
        CGRect frame2 =CGRectMake(1024*pageMarkIndex, 0, 1024, 748);
        [self.scrollView scrollRectToVisible:frame2 animated:NO];
    }
    [self changeFrames];
    return UIInterfaceOrientationMaskAll;
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    if ([header.actionActionSheet2 isVisible]) {
        [header.actionActionSheet2 dismissWithClickedButtonIndex:header.actionActionSheet2.cancelButtonIndex animated:YES];
        header.actionActionSheet2 = nil;
        [header doEditSavedBookmark:header.savedBookmarks];
    }
    if ([header.actionActionSheet isVisible]) {
        [header.actionActionSheet dismissWithClickedButtonIndex:header.actionActionSheet.cancelButtonIndex animated:NO];
        header.actionActionSheet = nil;
        [header doAddBookMarkAndPrint:header.shareBtn];
    }
}

-(void)backToHome{
    for (BFChapterView *vc in arrCustomAllViews) {
        [vc stopMovieInController];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"markWord"];
    [self dismissModalViewControllerAnimated:YES];
}
-(void)changeFrames{
    if ([header.addBookmarkPopoverController isPopoverVisible]) {
        [header.addBookmarkPopoverController presentPopoverFromRect:header.savedBookmarks.frame inView:header.controller.view permittedArrowDirections:UIPopoverArrowDirectionDown|UIPopoverArrowDirectionUp animated:YES];
    }
    if ([header.bookmarkPopoverController isPopoverVisible]) {
        [header.bookmarkPopoverController presentPopoverFromRect:header.savedBookmarks.frame inView:header.controller.view permittedArrowDirections:UIPopoverArrowDirectionDown|UIPopoverArrowDirectionUp animated:YES];
    }
    if ([header.addCollectPopoverController isPopoverVisible]) {
        [header.addCollectPopoverController presentPopoverFromRect:header.shareBtn.frame inView:header.controller.view permittedArrowDirections:UIPopoverArrowDirectionDown|UIPopoverArrowDirectionUp animated:YES];
    }
    if ([header.showNotePopoverController isPopoverVisible]) {
        [header.showNotePopoverController presentPopoverFromRect:header.toolBtn.frame  inView:header.controller.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:NO];
    }
    if ([header.searchWordPopoverController isPopoverVisible]) {
        [header.searchWordPopoverController presentPopoverFromRect:header.searchBtn.frame  inView:header.controller.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:NO];
    }
    if ([header.searchWordPopoverController isPopoverVisible]) {
        [header.searchWordPopoverController presentPopoverFromRect:header.searchBtn.frame  inView:header.controller.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:NO];
    }    
    if (canRemoveMenu == YES) {
        [scrollMenuView removeFromSuperview];
        [self showContent:nil];
    }
    if (canRemoveImage == YES) {
        [imageMenuView removeFromSuperview];
        [self showContent];
    }
    
    
    for (BFChapterView *page in visiblePages) {
        [self changePageFrame:page forIndex:page.index];
    }
    
}
@end
