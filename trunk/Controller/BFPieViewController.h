//
//  BFPieViewController.h
//  E-magazine
//
//  Created by summer.zhu on 5/3/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChartRotationView.h"
#import "BADefinition.h"

@interface BFPieViewController : UIViewController
<
UITableViewDataSource,
UITableViewDelegate,
PieChartRotateDelegate
>{
    IBOutlet UITableView *tableviewPie;
    IBOutlet UIScrollView *scrollViewPie;
    IBOutlet UIPageControl *pageControl;
    IBOutlet UILabel *lblTitle;
    IBOutlet UILabel *lblType;
    IBOutlet UILabel *lblData;
    
    NSMutableArray *arrDataSource;
    NSMutableArray *arrPies;
    NSMutableArray *arrSelectedInPie;
    NSInteger ICurrentSelectedPie;
    NSInteger iPieTag;
    
    //cell重用机制数组
    NSMutableArray *arrVisiablePie;
    NSMutableArray *arrReusedPie;
}
@property (nonatomic, strong) PieChartRotationView *pieView;
@property (nonatomic, strong) BADocument *document;

- (IBAction)didPressedBtnBack;
- (void)initScrollPie:(NSString *)iIndex;

@end
