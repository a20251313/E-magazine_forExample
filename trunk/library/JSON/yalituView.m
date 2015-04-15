//
//  yalituView.m
//  IRnovationBI
//
//  Created by 顾民 on 12-11-4.
//
//

#import "yalituView.h"
#import "documentMgr.h"
#import "Util.h"
#import <QuartzCore/QuartzCore.h>
#import "DataGridComponent.h"
#import "DataGridViewController.h"

@interface yalituView ()
{
    
    
    NSString* strValueName;//value 对应的名称
    NSString* strValueMinName;
    NSString* strValueMaxName;
    NSString* strColorName;//color 对应度量的名称
    NSString* strColorMinName;
    NSString* strColorMaxName;
    
    float lastScale;
    BOOL isPercentFloat; //计算key值对应的数据是否是百分化数字
}

-(NSArray*)prepareForTitles:(NSString*)name;
-(NSArray*)prepareForDatas:(NSUInteger)index;

//自定义初始化
-(void)customInit;

@end

@implementation yalituView
//@synthesize myScroll;
@synthesize popOver;
@synthesize valueDatas, colorDatas, nameDatas, beginColor, endColor, colorValues;
@synthesize valueLabel, valueLabelMin, valueLabelMax, colorLabel, colorLabelMin, colorLabelMax;

#pragma mark private functions
-(NSArray*)prepareForTitles:(NSString*)name
{
    NSMutableArray* tempArray = [[NSMutableArray alloc] init];
    [tempArray addObject:name];
    
    [tempArray addObject:strValueName];
    [tempArray addObject:strColorName];
    
    return tempArray;
}

-(NSArray*)prepareForDatas:(NSUInteger)index
{
    //现在制作一个data数据
    NSMutableArray* tempArray = [[NSMutableArray alloc] init];
    [tempArray addObject:[nameDatas objectAtIndex:index]];
    
    NSNumber* valueNum = [valueDatas objectAtIndex:index];
    float realValue = [valueNum floatValue];
    NSString* valueStr;
    if ( realValue > 1.0f) {
        valueStr = [NSString stringWithFormat:@"%.0f  ", realValue];
    }
    else {
        valueStr = [NSString stringWithFormat:@"%.2f%%  ", realValue*100];
    }
    [tempArray addObject:valueStr];
    
    //将这个数据百分化
    NSNumber* floatNum = [colorValues objectAtIndex:index];
    float realData = [floatNum floatValue];
    NSString* dataStr;
    if (isPercentFloat) {
        dataStr = [NSString stringWithFormat:@"%.2f%%  ", realData*100];
    }
    else {
        dataStr = [NSString stringWithFormat:@"%.0f  ", realData];
    }
    [tempArray addObject:dataStr];
    
    NSMutableArray* returnArray = [[NSMutableArray alloc] initWithObjects:tempArray, nil];
    
    return returnArray;
}

-(void)customInit
{
    self.backgroundColor = [UIColor blackColor];
    
    //UI, 数据初始化
    float totalWidth = [self bounds].size.width;
    float totalHeight = [self bounds].size.height;
    
    myScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, totalWidth, totalHeight*0.8)];
    myScroll.minimumZoomScale = 1.0f;
    myScroll.maximumZoomScale = 5.0f;
    //[myScroll setContentSize:CGSizeMake(myScroll.bounds.size.width*5, myScroll.bounds.size.height*5)];
    [myScroll setDelegate:self];
    [self addSubview:myScroll];
    
    treemapView = [[TreemapView alloc] initWithFrame:CGRectMake(0, 0, totalWidth, totalHeight*0.8)];
    //[treemapView setDataSource:self];
    //[treemapView setDelegate:self];
    //[self addSubview:treemapView];
    [myScroll addSubview:treemapView];
    
    //变色条
    gView = [[gradientView alloc] initWithFrame:CGRectMake(totalWidth*0.6, totalHeight*0.84, totalWidth*0.3, totalHeight*0.06)];
    [self addSubview:gView];
    
    //labels
    float offsetX = totalWidth*0.05f;
    const float offsetY = totalHeight*0.92f;
    const float xgap = totalWidth*0.005f;
    const float valueWidth = totalWidth*0.1f;
    const float nameWidth = totalWidth*0.25f;
    const float textHeight = totalHeight*0.06f;
    
    //valueLabelMin
    valueLabelMin = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, offsetY, valueWidth, textHeight)];
    valueLabelMin.textAlignment = UITextAlignmentCenter;
    valueLabelMin.text = @"begin";
    valueLabelMin.textColor = [UIColor whiteColor];
    valueLabelMin.backgroundColor = [UIColor blackColor];
    [self addSubview:valueLabelMin];
    offsetX += valueWidth + xgap;
    
    //valueLabel
    valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, offsetY, nameWidth, textHeight)];
    valueLabel.textAlignment = UITextAlignmentCenter;
    valueLabel.text = @"value";
    valueLabel.textColor = [UIColor whiteColor];
    valueLabel.backgroundColor = [UIColor blackColor];
    [self addSubview:valueLabel];
    
    //显示固定的文字Rectangle Size:
    UILabel* fixedLabel = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, offsetY*0.9, nameWidth, textHeight)];
    fixedLabel.textAlignment = UITextAlignmentCenter;
    fixedLabel.text = @"矩形面积 :";
    fixedLabel.textColor = [UIColor whiteColor];
    fixedLabel.backgroundColor = [UIColor blackColor];
    [self addSubview:fixedLabel];
    
    
    offsetX += nameWidth + xgap;
    
    //valueLabelMax
    valueLabelMax = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, offsetY, valueWidth, textHeight)];
    valueLabelMax.textAlignment = UITextAlignmentCenter;
    valueLabelMax.text = @"end";
    valueLabelMax.textColor = [UIColor whiteColor];
    valueLabelMax.backgroundColor = [UIColor blackColor];
    [self addSubview:valueLabelMax];
    offsetX += valueWidth + xgap*4;
    
    //colorLabelmin
    colorLabelMin = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, offsetY, valueWidth, textHeight)];
    colorLabelMin.textAlignment = UITextAlignmentCenter;
    colorLabelMin.text = @"begin";
    colorLabelMin.textColor = [UIColor whiteColor];
    colorLabelMin.backgroundColor = [UIColor blackColor];
    [self addSubview:colorLabelMin];
    offsetX += valueWidth + xgap;
    
    //colorLabel
    colorLabel = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, offsetY, nameWidth, textHeight)];
    colorLabel.textAlignment = UITextAlignmentCenter;
    colorLabel.text = @"color";
    colorLabel.textColor = [UIColor whiteColor];
    colorLabel.backgroundColor = [UIColor blackColor];
    [self addSubview:colorLabel];
    offsetX += nameWidth + xgap;
    
    //colorLabelMax
    colorLabelMax = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, offsetY, valueWidth, textHeight)];
    colorLabelMax.textAlignment = UITextAlignmentCenter;
    colorLabelMax.text = @"end";
    colorLabelMax.textColor = [UIColor whiteColor];
    colorLabelMax.backgroundColor = [UIColor blackColor];
    [self addSubview:colorLabelMax];
    
    //datas
    valueDatas = [[NSArray alloc] init];
    colorDatas = [[NSArray alloc] init];
    nameDatas = [[NSArray alloc] init];
    colorValues = [[NSArray alloc] init];
    
    beginColor = [[UIColor alloc] init];
    endColor = [[UIColor alloc] init];
    
}

-(void)loadWithDTReport:(DTReport*)dreport
{
    //清除原来的数据
    valueDatas = nil;
    colorDatas = nil;
    nameDatas = nil;
    colorValues = nil;
    
    [myScroll setZoomScale:1.0f];
    isPercentFloat = YES;
    //加载report数据，需要将原数据清除的功能暂时不考虑
    DTReportData* drd = [dreport.reportDatas lastObject];
    
    //遍历，找出关键array，作为辨识颜色的data，另外的作为valueData
    for (DTMetric* dtm in drd.metrics) {
        if (dtm.isKey) {
            //key DTMetric 用来辨识显示颜色
            
            NSArray* colorFloatArray = dtm.dataValue;
            self.beginColor = [dtm getColor1];
            self.endColor = [dtm getColor2];
            
            strColorName = [dtm name];
            //[gView setStartColor:beginColor withEndColor:endColor];
            
            float begin = [dtm getBeginValue];
            float end = [dtm getEndValue];
            
            if (end > 1.0f) {
                isPercentFloat = NO;
            }
            
            NSMutableArray* tempArray = [[NSMutableArray alloc] init];
            for (int i = 0; i < [colorFloatArray count]; i++) {
                NSNumber* number = [colorFloatArray objectAtIndex:i];
                float cur = [number floatValue];
                float percent = (cur - begin) / (end - begin);
                UIColor* color = [Util colorFormBegin:beginColor end:endColor percent:percent];
                [tempArray addObject:color];
            }
            [self setColorDatas:tempArray];
            [self setColorValues:colorFloatArray];
            
            //在init的时候无效，用于reload
            //设置颜色辨析label
            //在init的时候无效，用于reload
            //设置颜色辨析label
            if (isPercentFloat) {
                strColorMinName = [NSString stringWithFormat:@"%.2f%%", begin*100];
                strColorMaxName = [NSString stringWithFormat:@"%.2f%%", end*100];
            }
            else {
                strColorMinName = [NSString stringWithFormat:@"%.0f", begin];
                strColorMaxName = [NSString stringWithFormat:@"%.0f", end];
            }
            
            [ colorLabelMin setText:strColorMinName];
            [ colorLabelMax setText:strColorMaxName];
            [colorLabel setText:strColorName];
            

        }
        else{
            [self setValueDatas:dtm.dataValue];
            //str纪录value数据的度量名称
            strValueName = [dtm name];
            
            //在init的时候无效，用于reload
            //设置value辨析label
            strValueMinName = [NSString stringWithFormat:@"%.0f", [dtm getBeginValue]];
            strValueMaxName = [NSString stringWithFormat:@"%.0f", [dtm getEndValue]];
            [ valueLabelMin setText:strValueMinName];
            [ valueLabelMax setText:strValueMaxName];
            [valueLabel setText:[NSString stringWithFormat:@"<     %@   <", strValueName]];
            
        }
    }
    
    DTEntity* de = [drd.entities lastObject];
    [self setNameDatas:de.data];
    
    
    //在加载完数据后，才设置delegate
    [treemapView setDelegate:self];
    [treemapView setDataSource:self];
    
    [gView setStartColor:self.beginColor withEndColor:self.endColor];
    
    [treemapView reloadData];
    
}

#pragma mark system functions
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self customInit];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self customInit];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self customInit];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark protocol
- (void)updateCell:(TreemapViewCell *)cell forIndex:(NSInteger)index {
	/*NSNumber *val = [[fruits objectAtIndex:index] valueForKey:@"value"];
     cell.textLabel.text = [[fruits objectAtIndex:index] valueForKey:@"name"];
     cell.valueLabel.text = [val stringValue];
     cell.backgroundColor = [UIColor colorWithHue:(float)index / (fruits.count + 3)
     saturation:1 brightness:0.75 alpha:1];*/
    
    NSNumber* val = [[self valueDatas] objectAtIndex:index];
    cell.textLabel.text = [[self nameDatas] objectAtIndex:index];
    cell.valueLabel.text = [val stringValue];
    cell.backgroundColor = [[self colorDatas] objectAtIndex:index];
}

#pragma mark -
#pragma mark TreemapView delegate

- (void)treemapView:(TreemapView *)_treemapView tapped:(NSInteger)index {
	/*
	 * change the value
	 */
	/*NSDictionary *dic = [fruits objectAtIndex:index];
     [dic setValue:[NSNumber numberWithInt:[[dic valueForKey:@"value"] intValue] + 300]
     forKey:@"value"];*/
    
    
	/*
	 * resize rectangles with animation
	 */
	/*[UIView beginAnimations:@"reload" context:nil];
     [UIView setAnimationDuration:0.5];
     
     [(TreemapView *)self.view reloadData];
     
     [UIView commitAnimations];*/
    
	/*
	 * highlight the background
	 */
    if (popOver) {
        return;
    }
    
	[UIView beginAnimations:@"highlight" context:nil];
    [UIView setAnimationDuration:1.0];
    
    TreemapViewCell *cell = [_treemapView getCellAtIndex:index];
    UIColor *color = cell.backgroundColor;
    [cell setBackgroundColor:[UIColor whiteColor]];
    [cell setBackgroundColor:color];
    
    [UIView commitAnimations];
    
    //pop over
    NSArray* titles = [self prepareForTitles:@"度量"];
    NSArray* datas = [self prepareForDatas:index];
    DataGridComponentDataSource* ds = [DataGridComponentDataSource initDataSourceWithTitles:titles andSingleLineData:datas totalWidth:300];
    DataGridViewController* dvc = [[DataGridViewController alloc] initWithDataResource:ds withRect:CGRectMake(0, 0, 300, 48)];
    
    popOver = [[UIPopoverController alloc] initWithContentViewController:dvc];
    [popOver setPopoverContentSize:CGSizeMake(300, 48)];
    [popOver setDelegate:self];
    
    //to confirm the direction
    [popOver presentPopoverFromRect:[cell frame] inView:_treemapView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

#pragma mark popoverController delegate
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    popOver = nil;
}

#pragma mark -
#pragma mark TreemapView data source

- (NSArray *)valuesForTreemapView:(TreemapView *)treemapView {
	/*if (!fruits) {
     NSBundle *bundle = [NSBundle mainBundle];
     NSString *plistPath = [bundle pathForResource:@"data" ofType:@"plist"];
     NSArray *array = [[NSArray alloc] initWithContentsOfFile:plistPath];
     
     self.fruits = [[NSMutableArray alloc] initWithCapacity:array.count];
     for (NSDictionary *dic in array) {
     NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:dic];
     [fruits addObject:mDic];
     }
     }
     
     NSMutableArray *values = [NSMutableArray arrayWithCapacity:fruits.count];
     for (NSDictionary *dic in fruits) {
     [values addObject:[dic valueForKey:@"value"]];
     }
     return values;*/
    
    return valueDatas;
    
}

- (TreemapViewCell *)treemapView:(TreemapView *)treemapView cellForIndex:(NSInteger)index forRect:(CGRect)rect {
	TreemapViewCell *cell = [[TreemapViewCell alloc] initWithFrame:rect];
	[self updateCell:cell forIndex:index];
	return cell;
    
}

- (void)treemapView:(TreemapView *)treemapView updateCell:(TreemapViewCell *)cell forIndex:(NSInteger)index forRect:(CGRect)rect {
	[self updateCell:cell forIndex:index];
}

#pragma mark UIScrollView delegate
-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return treemapView;
}

@end
