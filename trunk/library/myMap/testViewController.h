//
//  testViewController.h
//  myMapDemo
//
//  Created by aplee on 12-11-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CInfoView.h"
#import "BAAnimationHelper.h"

@class CAMapView, CAAnnotation, DTReport;

@interface testViewController : UIViewController<MKMapViewDelegate, clusterBtnPress, BAAnimationDelegate, UITableViewDataSource, UITableViewDelegate, UIPopoverControllerDelegate>
{
    
    __weak IBOutlet CAMapView *myMapView;
    IBOutlet UISegmentedControl *segment;
    
    //保存当前被选中的CAAnnotation，为多选预留的选择器    
    CAAnnotation* curr;
    NSMutableArray* clusteAnno;
    int currentIndex;
    
    //数据报告
    DTReport* dtReport;
    //CAAnnotation数据array
    NSMutableArray* caannotationArray;
    
    //多报告数据数组
    NSArray* reportsArray;
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *titleLabel2;
    __weak IBOutlet UIView *strBgView;
}

@property (nonatomic, retain) DTReport* dtReport;
@property (nonatomic, retain) NSArray* reportsArray;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *leftButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *rightButton;

-(id)initWithDTReport:(DTReport*)report;
- (IBAction)onStyleChoose:(id)sender;

-(void)reloadReport:(DTReport*)report;

-(void)setDataReportArray:(NSArray*)array;

@end
