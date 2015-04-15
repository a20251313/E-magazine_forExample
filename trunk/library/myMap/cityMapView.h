//
//  cityMapView.h
//  IRnovationBI
//
//  Created by 顾民 on 12-11-4.
//
//
//地图UIView

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CInfoView.h"

@class CAMapView, CAAnnotation, DTReport;

@interface cityMapView : UIView<MKMapViewDelegate, clusterBtnPress>
{
    CAMapView* myMapView;
    UISegmentedControl* segment;
    
    //保存当前被选中的CAAnnotation，为多选预留的选择器
    CAAnnotation* curr;
    NSMutableArray* clusteAnno; //cluste中的多个CAAnnotation
    int currentIndex;   //多个选择的时候，表示当前被选择项的index
    
    //数据报告
    DTReport* dtReport;
    //CAAnnotation数据array， 总体的
    NSMutableArray* caannotationArray;
    UIViewController* rootViewController;
    UILabel* titleLabel;
    UILabel* titleLabel2;
    UIView* titleBgView;
    
}

@property (nonatomic, retain) DTReport* dtReport;
@property (nonatomic, retain) UIViewController* rootViewController;

//初始化方法
-(void)loadWithDTReport:(DTReport*)report;

//重载数据方法
//-(void)reloadReport:(DTReport*)report;

//segment数值改变响应
-(void)onSegmentValueChange;

@end
