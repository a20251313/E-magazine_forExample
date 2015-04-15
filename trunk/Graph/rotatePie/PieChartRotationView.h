//
//  PieChartRotationView.h
//  PieChartRotation
//
//  Created by summer.zhu on 3/28/13.
//  Copyright (c) 2013 zbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChartRotationHostingView.h"

@protocol PieChartRotateDelegate;

@interface PieChartRotationView : UIView
<
PieChartRotationHostDelegate
>
{
    PieChartRotationHostingView *pieView;
//    IBOutlet UIView *viewPieView;
    IBOutlet UIImageView *imageviewInnerCircle;
    IBOutlet UIImageView *imageviewWhiteCircle;
    IBOutlet UIImageView *imageviewIndicator;
    IBOutlet UIImageView *imageviewOutCircle;
    CGPoint lastPoint;
    
    NSMutableArray *arrRate;//各模块所占的比例数组
    NSMutableArray *arrBeginAngle;//各饼块开始的角度
    NSMutableArray *arrEndAngle;//各饼块结束的角度
}
@property (nonatomic) BOOL bLarge;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic) CGPoint centerPoint;
@property (nonatomic) CGPoint destPoint;
@property (nonatomic) CGFloat fRadius;
@property (nonatomic) NSInteger iCurrent;
@property (nonatomic, weak) id<PieChartRotateDelegate> delegate;

- (void)rotateToSector:(NSInteger)iSector;

@end

@protocol PieChartRotateDelegate <NSObject>

@optional
- (void)endRotatePie:(id)sender;

@end
