//
//  BFChapterView.h
//  E-magazine
//
//  Created by mike.sun on 6/13/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Page0.h"
#import "PicPage.h"
#import "BAData.h"
#import "Global.h"
#import "CustomUILabel.h"
#import "BFHeaderViewDelegate.h"
#import "BAImagaNameData.h"
#import "BAThreeData.h"
#import "BAFourData.h"
#import "BAFiveData.h"
#import "BAFiveDataExtend.h"
#import "PieChartRotationView.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
@class BFPageViewController;
@interface BFChapterView : UIView<Page0Delegate,CustomUILabelDelegate,UIScrollViewDelegate,AVAudioPlayerDelegate>
{
    NSMutableArray *arrButtons;
    UIImageView *image;
    Page0 *page;
    Page0 *page1;
    Page0 *page2;
    Page0 *page3;
    PicPage *picPage;
    NSUInteger index;
}
@property (assign) NSUInteger index;
@property (nonatomic, strong) PicPage *picPage;
@property (nonatomic, strong) NSString *strBookMarks;
@property (nonatomic, strong) BAData *data;
@property (nonatomic) NSInteger iPosition;
@property (nonatomic, strong) NSMutableArray *arrViews;
@property (nonatomic, strong) NSString *viewIndex;

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) BAImagaNameData *baImageNameData;
@property (nonatomic, strong) BAThreeData *baThreeData;
@property (nonatomic, strong) BAFourData *baData;
@property (nonatomic, strong) BAFiveData *baFiveData;
@property (nonatomic, strong) BAFiveDataExtend *baFiveDataExtend;
@property (nonatomic, strong) BFPageViewController *viewController;
@property (assign, nonatomic) id<BFHeaderViewDelegate> delegate;

- (void)scrollToViewController:(int)page;
-(void)stopMovieInController;
- (void)changeButtomsFrame:(BOOL)bPor;

- (void)createView1;
- (void)createView2;
- (void)createView3;
- (void)createView4;
- (void)createView5;
- (void)createView6;
- (void)createView7;
- (void)createView8;
- (void)createView9;

-(void)viewImages;
-(void)didResignActive;
- (void)label:(CustomUILabel*)label didBeginTouch:(UITouch*)touch onCharacterAtIndex:(KeyWord*)keyword;
- (void)label:(CustomUILabel*)label didMoveTouch:(UITouch*)touch onCharacterAtIndex:(KeyWord*)keyword;
- (void)label:(CustomUILabel*)label didEndTouch:(UITouch*)touch onCharacterAtIndex:(KeyWord*)keyword;
- (void)label:(CustomUILabel*)label didCancelTouch:(UITouch*)touch;

@end
