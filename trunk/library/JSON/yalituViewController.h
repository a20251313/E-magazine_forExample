//
//  yalituViewController.h
//  yalitu
//
//  Created by 顾民 on 12-10-31.
//
//

#import <UIKit/UIKit.h>
#import "TreemapView.h"
#import "gradientView.h"
@class DTReport;

@interface yalituViewController :UIViewController<TreemapViewDelegate, TreemapViewDataSource, UIPopoverControllerDelegate,UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    
    __weak IBOutlet UIScrollView *myScroll;
    IBOutlet TreemapView *treemapView;
    IBOutlet gradientView *gView;
    
    NSArray* valueDatas;
    NSArray* colorDatas;    //存储UIColor
    NSArray* nameDatas;
    NSArray* colorValues;   //存储实际的color对应度量的值数组
    
    //DTReport* report;
    
    UIColor* beginColor;
    UIColor* endColor;
    
    //labels
    IBOutlet UILabel *valueLabel;
    IBOutlet UILabel *valueLabelMin;
    IBOutlet UILabel *valueLabelMax;
    IBOutlet UILabel *colorLabel;
    IBOutlet UILabel *colorLabelMin;
    IBOutlet UILabel *colorLabelMax;
    
    //多维度array
    NSArray* reportsArray;
    
}

@property (nonatomic, retain) NSArray* valueDatas;
@property (nonatomic, retain) NSArray* colorDatas;
@property (nonatomic, retain) NSArray* nameDatas;
@property (nonatomic, retain) NSArray* colorValues;
@property (nonatomic, retain) UIColor* beginColor;
@property (nonatomic, retain) UIColor* endColor;

@property (retain, nonatomic) IBOutlet UILabel *valueLabel;
@property (retain, nonatomic) IBOutlet UILabel *valueLabelMin;
@property (retain, nonatomic) IBOutlet UILabel *valueLabelMax;
@property (retain, nonatomic) IBOutlet UILabel *colorLabel;
@property (retain, nonatomic) IBOutlet UILabel *colorLabelMin;
@property (retain, nonatomic) IBOutlet UILabel *colorLabelMax;

@property (nonatomic, retain) NSArray *reportsArray;

-(id)initWithDTReport:(DTReport*)dreport;

-(void)setDataReport:(DTReport*)dreport;

-(void)setDataReportArray:(NSArray*)array;
-(void)reDraw;

@end
