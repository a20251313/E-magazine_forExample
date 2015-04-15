//
//  BFChapterView.m
//  E-magazine
//
//  Created by mike.sun on 6/13/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "BFChapterView.h"
#import "ImagePath.h"
#import "BFGraphViewController1.h"
#import "BFGraphViewController2.h"
#import "BFGraphViewController3.h"
#import "BFGraphViewController4.h"
#import "BFPieViewController.h"
#import "BFPageViewController.h"
#import "ViewControllerAndPage.h"
@interface BFChapterView ()
{
    AVAudioPlayer *player;
    int currentpage;
}
@end

@implementation BFChapterView
@synthesize index;
@synthesize picPage;
@synthesize strBookMarks;
@synthesize data;
@synthesize iPosition;
@synthesize arrViews;
@synthesize viewIndex;
@synthesize baImageNameData;
@synthesize baThreeData;
@synthesize baData;
@synthesize baFiveData;
@synthesize baFiveDataExtend;
@synthesize viewController;
@synthesize delegate;
@synthesize image;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        currentpage=0;
        arrViews = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)createView1{
    [self transformDataToCustom1];
    picPage = [[PicPage alloc] init];
    picPage.imageNamePor=[ImagePath getImagePath:baImageNameData.imagedata.strPortraitImageName];
    picPage.imageName=[ImagePath getImagePath:baImageNameData.imagedata.strLandscapeImageName];
    [self.arrViews addObject:picPage];
}
- (void)createView2{
    [self transformDataToCustom2];
    picPage = [[PicPage alloc] init];
    picPage.imageNamePor=[ImagePath getImagePath:baImageNameData.imagedata.strPortraitImageName];
    picPage.imageName=[ImagePath getImagePath:baImageNameData.imagedata.strLandscapeImageName];
    [self.arrViews addObject:picPage];
}

- (void)createView3{
    [self transformDataToCustom3];
    picPage = [[PicPage alloc] init];
    picPage.imageNamePor=[ImagePath getImagePath:baThreeData.imagedata.strPortraitImageName];
    picPage.imageName=[ImagePath getImagePath:baThreeData.imagedata.strLandscapeImageName];
    
    arrButtons = [[NSMutableArray alloc] init];
    for (int i=0; i<baThreeData.arrButtonTag.count; i++) {
        CGRect rect;
        if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])){
            rect = CGRectFromString([baThreeData.arrButtonFramePor objectAtIndex:i]);
        }else{
            rect = CGRectFromString([baThreeData.arrButtonFrame objectAtIndex:i]);
        }
        UIButton *btn = [[UIButton alloc] initWithFrame:rect];
        [btn setBackgroundImage:[UIImage imageNamed:@"blackHalf.png"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(menuSel:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = [[baThreeData.arrButtonTag objectAtIndex:i] intValue];
        [self.image addSubview:btn];
        [arrButtons addObject:btn];
    }
    image.userInteractionEnabled = YES;
    
    [self.arrViews addObject:picPage];
}
- (void)createView4{
    [self transformDataToCustom4];
    picPage = [[PicPage alloc] init];
    picPage.imageNamePor=[ImagePath getImagePath:self.baData.imagedata.strPortraitImageName];
    picPage.imageName=[ImagePath getImagePath:self.baData.imagedata.strLandscapeImageName];
    
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        page = [[Page0 alloc] init];
        page.buttonTag = 10;
        page.backgroundColor=[UIColor whiteColor];
        page.Label1.delegate=self;
        page.delegate=self;
        page.baText = self.baData.baText;
        ViewControllerAndPage *vcAndPage = [[ViewControllerAndPage alloc] init];
        vcAndPage.viewControllerIndex = [NSString stringWithFormat:@"%d", self.iPosition];
        vcAndPage.pageIndex = @"1";
        page.vcAndPage = vcAndPage;
        
        [self.viewController.arrPages addObject:page];
    }
    else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        page = [[Page0 alloc] init];
        page.buttonTag = 10;
        page.backgroundColor=[UIColor whiteColor];
        page.Label1.delegate=self;
        page.delegate=self;
        page.baText = self.baData.baText;
        ViewControllerAndPage *vcAndPage = [[ViewControllerAndPage alloc] init];
        vcAndPage.viewControllerIndex = [NSString stringWithFormat:@"%d", self.iPosition];
        vcAndPage.pageIndex = @"1";
        page.vcAndPage = vcAndPage;
        [self.viewController.arrPages addObject:page];
    }
    [self.arrViews addObject:picPage];
    [self.arrViews addObject:page];
    [page needPages];
    int iOtherPageBeginNumber=2;
    for (int i=0; i<page.arrViews.count; i++) {
        Page0 *page0 = (Page0 *)[page.arrViews objectAtIndex:i];
        ViewControllerAndPage *vcAndPage = [[ViewControllerAndPage alloc] init];
        vcAndPage.viewControllerIndex = [NSString stringWithFormat:@"%d", self.iPosition];
        vcAndPage.pageIndex = [NSString stringWithFormat:@"%d", i+iOtherPageBeginNumber];
        page0.vcAndPage = vcAndPage;
        [self.arrViews addObject:page0];
    }
}
- (void)createView5{
    [self transformDataToCustom5];
    picPage = [[PicPage alloc] init];
    picPage.imageNamePor=[ImagePath getImagePath:baFiveData.imagedata.strPortraitImageName];
    picPage.imageName=[ImagePath getImagePath:baFiveData.imagedata.strLandscapeImageName];
    
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        page1 = [[Page0 alloc] init];
        page1.buttonTag = 10;
        page1.backgroundColor=[UIColor whiteColor];
        page1.Label1.delegate=self;
        page1.delegate=self;
        page1.baText = baFiveData.baText;
        ViewControllerAndPage *vcAndPage = [[ViewControllerAndPage alloc] init];
        vcAndPage.viewControllerIndex = [NSString stringWithFormat:@"%d", self.iPosition];
        vcAndPage.pageIndex = @"1";
        page1.vcAndPage = vcAndPage;
        [self.viewController.arrPages addObject:page1];
        
        page2 = [[Page0 alloc] init];
        page2.buttonTag = 20;
        page2.backgroundColor=[UIColor whiteColor];
        page2.Label1.delegate=self;
        page2.delegate=self;
        page2.baText = baFiveData.baText1;
        ViewControllerAndPage *vcAndPage1 = [[ViewControllerAndPage alloc] init];
        vcAndPage1.viewControllerIndex = [NSString stringWithFormat:@"%d", self.iPosition];
        vcAndPage1.pageIndex = @"2";
        page2.vcAndPage = vcAndPage1;
        
        [self.viewController.arrPages addObject:page2];
    }
    else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        page1 = [[Page0 alloc] init];
        page1.buttonTag = 10;
        page1.backgroundColor=[UIColor whiteColor];
        page1.Label1.delegate=self;
        page1.delegate=self;
        page1.baText = baFiveData.baText;
        ViewControllerAndPage *vcAndPage = [[ViewControllerAndPage alloc] init];
        vcAndPage.viewControllerIndex = [NSString stringWithFormat:@"%d", self.iPosition];
        vcAndPage.pageIndex = @"1";
        page1.vcAndPage = vcAndPage;
        [self.viewController.arrPages addObject:page1];
        
        page2 = [[Page0 alloc] init];
        page2.buttonTag = 20;
        page2.backgroundColor=[UIColor whiteColor];
        page2.Label1.delegate=self;
        page2.delegate=self;
        page2.baText = baFiveData.baText1;
        ViewControllerAndPage *vcAndPage1 = [[ViewControllerAndPage alloc] init];
        vcAndPage1.viewControllerIndex = [NSString stringWithFormat:@"%d", self.iPosition];
        vcAndPage1.pageIndex = @"2";
        page2.vcAndPage = vcAndPage1;
        [self.viewController.arrPages addObject:page2];
    }
    
    [self.arrViews addObject:picPage];
    [self.arrViews addObject:page1];
    [page1 needPages];
    int iOtherPageBeginNumber=3;
    for (int i=0; i<page1.arrViews.count; i++) {
        Page0 *page0_1 = (Page0 *)[page1.arrViews objectAtIndex:i];
        ViewControllerAndPage *vcAndPage = [[ViewControllerAndPage alloc] init];
        vcAndPage.viewControllerIndex = [NSString stringWithFormat:@"%d", self.iPosition];
        vcAndPage.pageIndex = [NSString stringWithFormat:@"%d", i+iOtherPageBeginNumber];
        page0_1.vcAndPage = vcAndPage;
        [self.arrViews addObject:page0_1];
    }
    iOtherPageBeginNumber += page1.arrViews.count;
    [self.arrViews addObject:page2];
    [page2 needPages];
    for (int i=0; i<page2.arrViews.count; i++) {
        Page0 *page0_2 = (Page0 *)[page2.arrViews objectAtIndex:i];
        ViewControllerAndPage *vcAndPage = [[ViewControllerAndPage alloc] init];
        vcAndPage.viewControllerIndex = [NSString stringWithFormat:@"%d", self.iPosition];
        vcAndPage.pageIndex = [NSString stringWithFormat:@"%d", iOtherPageBeginNumber+i];
        page0_2.vcAndPage = vcAndPage;
        [self.arrViews addObject:page0_2];
    }
}
-(void)createView6{
    [self transformDataToCustom6];
    picPage = [[PicPage alloc] init];
    picPage.imageNamePor=[ImagePath getImagePath:self.baData.imagedata.strPortraitImageName];
    picPage.imageName=[ImagePath getImagePath:self.baData.imagedata.strLandscapeImageName];
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        page3 = [[Page0 alloc]init];
        page3.buttonTag = 100;
        page3.backgroundColor=[UIColor whiteColor];
        page3.Label1.delegate=self;
        page3.delegate=self;
        page3.baText = self.baData.baText;
        ViewControllerAndPage *vcAndPage = [[ViewControllerAndPage alloc] init];
        vcAndPage.viewControllerIndex = [NSString stringWithFormat:@"%d", self.iPosition];
        vcAndPage.pageIndex = @"1";
        page3.vcAndPage = vcAndPage;
        
        [self.viewController.arrPages addObject:page3];
    }
    else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        page3 = [[Page0 alloc]init];
        page3.buttonTag = 100;
        page3.backgroundColor=[UIColor whiteColor];
        page3.Label1.delegate=self;
        page3.delegate=self;
        page3.baText = self.baData.baText;
        ViewControllerAndPage *vcAndPage = [[ViewControllerAndPage alloc] init];
        vcAndPage.viewControllerIndex = [NSString stringWithFormat:@"%d", self.iPosition];
        vcAndPage.pageIndex = @"1";
        page3.vcAndPage = vcAndPage;
        [self.viewController.arrPages addObject:page3];
    }
    [self.arrViews addObject:picPage];
    [self.arrViews addObject:page3];
    [page3 needPages];
    int iOtherPageBeginNumber=2;
    for (int i=0; i<page3.arrViews.count; i++) {
        Page0 *page0_3 = (Page0 *)[page3.arrViews objectAtIndex:i];
        ViewControllerAndPage *vcAndPage = [[ViewControllerAndPage alloc] init];
        vcAndPage.viewControllerIndex = [NSString stringWithFormat:@"%d", self.iPosition];
        vcAndPage.pageIndex = [NSString stringWithFormat:@"%d", i+iOtherPageBeginNumber];
        page0_3.vcAndPage = vcAndPage;
        [self.arrViews addObject:page0_3];
    }
}
- (void)createView7{
    [self transformDataToCustom7];
    picPage = [[PicPage alloc] init];
    picPage.imageNamePor=[ImagePath getImagePath:baImageNameData.imagedata.strPortraitImageName];
    picPage.imageName=[ImagePath getImagePath:baImageNameData.imagedata.strLandscapeImageName];
    [self.arrViews addObject:picPage];
}
- (void)createView8{
    [self transformDataToCustom8];
    picPage = [[PicPage alloc] init];
    picPage.imageNamePor=[ImagePath getImagePath:baThreeData.imagedata.strPortraitImageName];
    picPage.imageName=[ImagePath getImagePath:baThreeData.imagedata.strLandscapeImageName];
    
    arrButtons = [[NSMutableArray alloc] init];
    for (int i=0; i<baThreeData.arrButtonTag.count; i++) {
        CGRect rect;
        if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])){
            rect = CGRectFromString([baThreeData.arrButtonFramePor objectAtIndex:i]);
        }else{
            rect = CGRectFromString([baThreeData.arrButtonFrame objectAtIndex:i]);
        }
        UIButton *btn = [[UIButton alloc] initWithFrame:rect];
        [btn setBackgroundImage:[UIImage imageNamed:@"blackHalf.png"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(indexSel:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = [[baThreeData.arrButtonTag objectAtIndex:i] intValue];
        [self.image addSubview:btn];
        [arrButtons addObject:btn];
    }
    image.userInteractionEnabled = YES;
    [self.arrViews addObject:picPage];
}
- (void)createView9{
    [self transformDataToCustom9];
    picPage = [[PicPage alloc] init];
    picPage.imageNamePor=[ImagePath getImagePath:baFiveDataExtend.imagedata.strPortraitImageName];
    picPage.imageName=[ImagePath getImagePath:baFiveDataExtend.imagedata.strLandscapeImageName];
    
    page1 = [[Page0 alloc] init];
    page1.buttonTag = 10;
    page1.backgroundColor=[UIColor whiteColor];
    page1.Label1.delegate=self;
    page1.delegate=self;
    page1.graphicsDelegate = self;
    page1.baText = baFiveDataExtend.baText;
    ViewControllerAndPage *vcAndPage = [[ViewControllerAndPage alloc] init];
    vcAndPage.viewControllerIndex = [NSString stringWithFormat:@"%d", self.iPosition];
    vcAndPage.pageIndex = @"1";
    page1.vcAndPage = vcAndPage;
    [self.viewController.arrPages addObject:page1];
    
    page2 = [[Page0 alloc] init];
    page2.buttonTag = 20;
    page2.backgroundColor=[UIColor whiteColor];
    page2.Label1.delegate=self;
    page2.delegate=self;
    page2.graphicsDelegate = self;
    page2.baText = baFiveDataExtend.baText1;
    ViewControllerAndPage *vcAndPage1 = [[ViewControllerAndPage alloc] init];
    vcAndPage1.viewControllerIndex = [NSString stringWithFormat:@"%d", self.iPosition];
    vcAndPage1.pageIndex = @"2";
    page2.vcAndPage = vcAndPage1;
    [self.viewController.arrPages addObject:page2];
    
    page3 = [[Page0 alloc] init];
    page3.buttonTag = 30;
    page3.backgroundColor=[UIColor whiteColor];
    page3.Label1.delegate=self;
    page3.delegate=self;
    page3.graphicsDelegate = self;
    page3.baText = baFiveDataExtend.baText2;
    ViewControllerAndPage *vcAndPage2 = [[ViewControllerAndPage alloc] init];
    vcAndPage2.viewControllerIndex = [NSString stringWithFormat:@"%d", self.iPosition];
    vcAndPage2.pageIndex = @"3";
    page3.vcAndPage = vcAndPage2;
    [self.viewController.arrPages addObject:page3];
    
    [self.arrViews addObject:picPage];
    [self.arrViews addObject:page1];
    [page1 needPages];
    int iOtherPageBeginNumber = 4;
    for (int i=0; i<page1.arrViews.count; i++) {
        Page0 *page0_1 = (Page0 *)[page1.arrViews objectAtIndex:i];
        ViewControllerAndPage *vcAndPage = [[ViewControllerAndPage alloc] init];
        vcAndPage.viewControllerIndex = [NSString stringWithFormat:@"%d", self.iPosition];
        vcAndPage.pageIndex = [NSString stringWithFormat:@"%d", i+iOtherPageBeginNumber];
        page0_1.vcAndPage = vcAndPage;
        [self.arrViews addObject:page0_1];
    }
    iOtherPageBeginNumber += page1.arrViews.count;
    
    [self.arrViews addObject:page2];
    [page2 needPages];
    for (int i=0; i<page2.arrViews.count; i++) {
        Page0 *page0_2 = (Page0 *)[page2.arrViews objectAtIndex:i];
        ViewControllerAndPage *vcAndPage = [[ViewControllerAndPage alloc] init];
        vcAndPage.viewControllerIndex = [NSString stringWithFormat:@"%d", self.iPosition];
        vcAndPage.pageIndex = [NSString stringWithFormat:@"%d", i+iOtherPageBeginNumber];
        page0_2.vcAndPage = vcAndPage;
        [self.arrViews addObject:page0_2];
    }
    iOtherPageBeginNumber += page1.arrViews.count;
    
    [self.arrViews addObject:page3];
    [page3 needPages];
    for (int i=0; i<page2.arrViews.count; i++) {
        Page0 *page0_3 = (Page0 *)[page3.arrViews objectAtIndex:i];
        ViewControllerAndPage *vcAndPage = [[ViewControllerAndPage alloc] init];
        vcAndPage.viewControllerIndex = [NSString stringWithFormat:@"%d", self.iPosition];
        vcAndPage.pageIndex = [NSString stringWithFormat:@"%d", i+iOtherPageBeginNumber];
        page0_3.vcAndPage = vcAndPage;
        [self.arrViews addObject:page0_3];
    }
}
- (void)transformDataToCustom1{
    self.baImageNameData = (BAImagaNameData *)self.data;
}
- (void)transformDataToCustom2{
    self.baImageNameData = (BAImagaNameData *)self.data;
}

- (void)transformDataToCustom3{
    self.baThreeData = (BAThreeData *)self.data;
}
- (void)transformDataToCustom4{
    self.baData = (BAFourData *)self.data;
}
- (void)transformDataToCustom5{
    self.baFiveData = (BAFiveData *)self.data;
}
- (void)transformDataToCustom6{
    self.baData = (BAFourData *)self.data;
}
- (void)transformDataToCustom7{
    self.baImageNameData = (BAImagaNameData *)self.data;
}
- (void)transformDataToCustom8{
    self.baThreeData = (BAThreeData *)self.data;
}
- (void)transformDataToCustom9{
    self.baFiveDataExtend = (BAFiveDataExtend *)self.data;
}

- (void)changeButtomsFrame:(BOOL)bPor{
    for (int i=0; i<arrButtons.count; i++) {
        UIButton *btn = (UIButton *)[arrButtons objectAtIndex:i];
        CGRect rect;
        if (bPor) {
            rect = CGRectFromString([baThreeData.arrButtonFramePor objectAtIndex:i]);
        }else{
            rect = CGRectFromString([baThreeData.arrButtonFrame objectAtIndex:i]);
        }
        btn.frame = rect;
    }
}
- (void)menuSel:(UIButton *)sender {
    if (delegate && [delegate respondsToSelector:@selector(menuSelect:)]) {
        [delegate menuSelect:sender];
    }
}
- (void)scrollToViewController:(int)page{
    
}
- (void)showGraphicsAllScreen{
    BFPieViewController *pieVC = [[BFPieViewController alloc] initWithNibName:@"BFPieViewController" bundle:nil];
    if ([[UIDevice currentDevice].systemVersion floatValue] < 6.0) {
        [viewController presentModalViewController:pieVC animated:YES];
    }else{
        [viewController presentViewController:pieVC animated:YES completion:nil];
    }
}

-(void)didResignActive{
    [page3 stopMovie];
}
-(void)stopMovieInController{
    [page3 stopMovie];
}
-(void)viewImages{
    
}
-(void)viewImages5{
    [delegate showContent];
}
- (void)indexSel:(UIButton *)sender {
    [delegate menuSelect:sender];
}
-(void)pushControllerAtPic:(NSString *)className{
    Class pushClass = NSClassFromString(className);
    id anObject = [[pushClass alloc] init];
    if ([[UIDevice currentDevice].systemVersion floatValue] < 6.0) {
        [viewController presentModalViewController:anObject animated:YES];
    }else{
        [viewController presentViewController:anObject animated:YES completion:nil];
    }
    
}
- (void)label:(CustomUILabel*)label didBeginTouch:(UITouch*)touch onCharacterAtIndex:(KeyWord*)keyword{
}
- (void)label:(CustomUILabel*)label didMoveTouch:(UITouch*)touch onCharacterAtIndex:(KeyWord*)keyword{
}
- (void)label:(CustomUILabel*)label didEndTouch:(UITouch*)touch onCharacterAtIndex:(KeyWord*)keyword{
}
- (void)label:(CustomUILabel*)label didCancelTouch:(UITouch*)touch{
}

@end
