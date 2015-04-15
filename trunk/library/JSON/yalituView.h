//
//  yalituView.h
//  IRnovationBI
//
//  Created by 顾民 on 12-11-4.
//
//

#import <UIKit/UIKit.h>
#import "TreemapView.h"
#import "gradientView.h"
@class DTReport;

@interface yalituView : UIView<TreemapViewDelegate, TreemapViewDataSource, UIPopoverControllerDelegate, UIScrollViewDelegate>
{
    UIScrollView* myScroll;
    TreemapView *treemapView;
    gradientView* gView;
    
    NSArray* valueDatas;
    NSArray* colorDatas;    //存储UIColor
    NSArray* nameDatas;
    NSArray* colorValues;   //存储实际的color对应度量的值数组
    
    //DTReport* report;
    
    UIColor* beginColor;
    UIColor* endColor;
    
    //labels
    UILabel *valueLabel;
    UILabel *valueLabelMin;
    UILabel *valueLabelMax;
    UILabel *colorLabel;
    UILabel *colorLabelMin;
    UILabel *colorLabelMax;
    
    UIPopoverController* popOver;
}

//@property (nonatomic, retain) UIScrollView* myScroll;
@property (nonatomic, retain) NSArray* valueDatas;
@property (nonatomic, retain) NSArray* colorDatas;
@property (nonatomic, retain) NSArray* nameDatas;
@property (nonatomic, retain) NSArray* colorValues;
@property (nonatomic, retain) UIColor* beginColor;
@property (nonatomic, retain) UIColor* endColor;

@property (retain, nonatomic) UILabel *valueLabel;
@property (retain, nonatomic) UILabel *valueLabelMin;
@property (retain, nonatomic) UILabel *valueLabelMax;
@property (retain, nonatomic) UILabel *colorLabel;
@property (retain, nonatomic) UILabel *colorLabelMin;
@property (retain, nonatomic) UILabel *colorLabelMax;

@property (strong, nonatomic) UIPopoverController* popOver;

-(void)loadWithDTReport:(DTReport*)dreport;

@end
