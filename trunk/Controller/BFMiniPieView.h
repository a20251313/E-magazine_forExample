//
//  BFMiniPieView.h
//  E-magazine
//
//  Created by summer.zhu on 5/31/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChartRotationView.h"
#import "BADefinition.h"

@protocol BFMiniPieDelegate;

@interface BFMiniPieView : UIView
<
PieChartRotateDelegate,
UIScrollViewDelegate
>{
    IBOutlet UILabel *lblTitle;
    IBOutlet UILabel *lblData;
    IBOutlet UIScrollView *scrollViewPie;
    IBOutlet UIPageControl *pageControlPie;
    
    NSMutableArray *arrDataSource;
    NSMutableArray *arrSelectedInPie;
    
    //cell重用机制数组
    NSMutableArray *arrVisiablePie;
    NSMutableArray *arrReusedPie;
    
    NSInteger iPieTag;
    //当前选中的哪个pie
//    NSInteger ICurrentSelectedPie;
}

@property(nonatomic, assign) id<BFMiniPieDelegate> delegate;
@property (nonatomic, strong) BADocument *document;
@property (nonatomic, strong) PieChartRotationView *pieViewSelected;

- (IBAction)didPressedBtnAllScreen:(id)sender;
- (void)initJSONData;
- (void)initScrollPie:(NSString *)strIndex;
- (NSMutableArray *)getPieData:(NSInteger)iIndex;
- (void)drawPies:(NSInteger)iIndex;
- (void)reloadView:(NSInteger)iIndex;
- (void)reloadMonthSales:(NSInteger)iMonth;
@end

@protocol BFMiniPieDelegate <NSObject>

@optional
- (void)showAllScreen;

@end