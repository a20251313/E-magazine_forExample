//
//  testViewController.m
//  yalitu
//
//  Created by aplee on 12-10-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "yalituViewController.h"
#import "documentMgr.h"
#import "Util.h"
#import <QuartzCore/QuartzCore.h>
#import "DataGridComponent.h"
#import "DataGridViewController.h"
#import "BAAnimationHelper.h"

@interface yalituViewController ()
{
    
    UIPopoverController* popOver;
    
    NSString* strValueName;//value 对应的名称
    NSString* strValueMinName;
    NSString* strValueMaxName;
    NSString* strColorName;//color 对应度量的名称
    NSString* strColorMinName;
    NSString* strColorMaxName;
    
    float lastScale;
    
    NSArray* btnNameArray;//按钮名字数组
    BOOL isPercentFloat; //计算key值对应的数据是否是百分化数字
    NSString* titleName;  //保存titlename
}

-(NSArray*)prepareForTitles:(NSString*)name;
-(NSArray*)prepareForDatas:(NSUInteger)index;

-(void)onTopTitlePress;

//弹出多维度选择框

@end

@implementation yalituViewController
@synthesize reportsArray;
@synthesize valueDatas, colorDatas, nameDatas, beginColor, endColor, colorValues;
@synthesize valueLabel, valueLabelMin, valueLabelMax, colorLabel, colorLabelMin, colorLabelMax;


#pragma mark self functions
-(void)setDataReport:(DTReport*)dreport;
{
    [valueDatas release];
    valueDatas = nil;
    [colorDatas release];
    colorDatas = nil;
    [nameDatas release];
    nameDatas = nil;
    [colorValues release];
    colorValues = nil;
    [strValueName release];
    strValueName = nil;
    [strValueMinName release];
    strValueMinName = nil;
    [strValueMaxName release];
    strValueMaxName = nil;
    [strColorName release];
    strColorName = nil;
    [strColorMinName release];
    strColorMinName = nil;
    [strColorMaxName release];
    strColorMaxName = nil;
    
    [myScroll setZoomScale:1.0f];
    isPercentFloat = YES;
    DTReportData* drd = [dreport.reportDatas lastObject];
    titleName = dreport.reportDesc;
    
    //遍历，找出关键array，作为辨识颜色的data，另外的作为valueData
    for (DTMetric* dtm in drd.metrics) {
        if (dtm.isKey) {
            //key DTMetric 用来辨识显示颜色
            
            NSArray* colorFloatArray = dtm.dataValue;
            self.beginColor = [dtm getColor1];
            self.endColor = [dtm getColor2];
            
            strColorName = [dtm name];
            [strColorName retain];
            //[gView setStartColor:beginColor withEndColor:endColor];
            
            float begin = [dtm getBeginValue];
            float end = [dtm getEndValue];
            if (end > 1.0f) {
                isPercentFloat = NO;
            }
            NSMutableArray* tempArray = [[[NSMutableArray alloc] init] autorelease];
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
            if (isPercentFloat) {
                strColorMinName = [NSString stringWithFormat:@"%.2f%%", begin*100];
                strColorMaxName = [NSString stringWithFormat:@"%.2f%%", end*100];
            }
            else {
                strColorMinName = [NSString stringWithFormat:@"%.0f", begin];
                strColorMaxName = [NSString stringWithFormat:@"%.0f", end];
            }
            
            
            [strColorMaxName retain];
            [strColorMinName retain];
        }
        else{
            [self setValueDatas:dtm.dataValue];
            //str纪录value数据的度量名称
            strValueName = [dtm name];
            [strValueName retain];
            
             //在init的时候无效，用于reload
            //设置value辨析label
            strValueMinName = [NSString stringWithFormat:@"%.0f", [dtm getBeginValue]];
            strValueMaxName = [NSString stringWithFormat:@"%.0f", [dtm getEndValue]];
            
            [strValueMaxName retain];
            [strValueMinName retain];
        }
    }
    
    DTEntity* de = [drd.entities lastObject];
    [self setNameDatas:de.data];
    
    [treemapView reloadData];
    
    [[self navigationItem] setTitle:titleName];
    
}

-(void)setDataReportArray:(NSArray*)array
{
    //the error situation
    if ([array count] < 1) {
        return;
    }
    
    //set the reportArray
    self.reportsArray = array;
    
    //set the button name array
    [btnNameArray release];
    NSMutableArray* muArray = [[NSMutableArray alloc] init];
    for (DTReport* rp in array) {
        NSString* description = rp.reportDesc;
        [muArray addObject:description];
    }
    btnNameArray = [[NSArray alloc] initWithArray:muArray];
    [muArray release];
    muArray = nil;
    
    //set the button at the middle of navigatonBar
    //如果要自定义按钮，在这里修改
    NSString* str = [btnNameArray objectAtIndex:0];
    [[self navigationItem] setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStyleBordered target:self action:@selector(onTopTitlePress)] autorelease]];
    
    
}

#pragma mark self function in .m
-(NSArray*)prepareForTitles:(NSString*)name
{
    NSMutableArray* tempArray = [[[NSMutableArray alloc] init] autorelease];
    [tempArray addObject:name];
    
    [tempArray addObject:strValueName];
    [tempArray addObject:strColorName];
    
    return tempArray;
}

-(NSArray*)prepareForDatas:(NSUInteger)index
{
    //现在制作一个data数据
    NSMutableArray* tempArray = [[[NSMutableArray alloc] init] autorelease];
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
    
    return [returnArray autorelease];
}

-(void)onTopTitlePress
{
    if (popOver) {
        return;
    }
    
    UITableViewController* tvc = [[[UITableViewController alloc] init] autorelease];
    [[tvc tableView] setDelegate:self];
    [[tvc tableView] setDataSource:self];
    popOver = [[UIPopoverController alloc] initWithContentViewController:tvc];
    [popOver setPopoverContentSize:CGSizeMake(160, 200)];
    [popOver setDelegate:self];
    [popOver presentPopoverFromRect:CGRectMake(940, -1, 64, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(id)initWithDTReport:(DTReport*)dreport
{
    self = [super init];
    if (self) {
        [self setDataReport:dreport];
    }
    
    return self;
}

#pragma mark system function
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [treemapView setDelegate:self];
    [treemapView setDataSource:self];
    
    //NSLog(@"%@ : %@", self.beginColor, self.endColor);
    [gView setStartColor:self.beginColor withEndColor:self.endColor];
    
    //设置颜色辨析label
    [ colorLabel setText:strColorName];
    [ colorLabelMin setText:strColorMinName];
    [ colorLabelMax setText:strColorMaxName];

    //设置value辨析label
    [ valueLabel setText:strValueName];
    [ valueLabelMin setText:strValueMinName];
    [ valueLabelMax setText:strValueMaxName];
    
    [self navigationItem].leftBarButtonItem =[[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(backAction)] autorelease];
    
    [myScroll setDelegate:self];
    [myScroll setMinimumZoomScale:1.0f];
    [myScroll setMaximumZoomScale:5.0f];
    //[myScroll setContentSize:CGSizeMake(5120, 3000)];
    
    [[self navigationItem] setTitle:titleName];
    
}

-(void)reDraw
{
    //NSLog(@"%@ : %@", self.beginColor, self.endColor);
    [gView setStartColor:self.beginColor withEndColor:self.endColor];
    
    //设置颜色辨析label
    [ colorLabel setText:strColorName];
    [ colorLabelMin setText:strColorMinName];
    [ colorLabelMax setText:strColorMaxName];
    
    //设置value辨析label
    [ valueLabel setText:strValueName];
    [ valueLabelMin setText:strValueMinName];
    [ valueLabelMax setText:strValueMaxName];
}

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return treemapView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [treemapView setScaleFactor:myScroll.zoomScale];
    [treemapView setNeedsLayout];
}

-(void)backAction
{
    BAAnimationHelper *animation=[[[BAAnimationHelper alloc]init] autorelease];
    [self.navigationController.view.layer addAnimation:animation.showNavigationController forKey:nil];
    [self.navigationController popViewControllerAnimated:NO]; 
}

- (void)viewDidUnload
{
    [treemapView release];
    treemapView = nil;
    
    [strValueMaxName release];
    [strValueMinName release];
    [strColorMaxName release];
    [strColorMinName release];
    
    [self setValueLabel:nil];
    [self setValueLabelMin:nil];
    [self setValueLabelMax:nil];
    [self setColorLabel:nil];
    [self setColorLabelMin:nil];
    [self setColorLabelMax:nil];
    myScroll = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)dealloc {
    
    [valueDatas release];
    valueDatas = nil;
    [colorDatas release];
    colorDatas = nil;
    [nameDatas release];
    nameDatas = nil;
    
    [beginColor release];
    [endColor release];
    
    [strValueMaxName release];
    [strValueMinName release];
    [strColorMaxName release];
    [strColorMinName release];
    [strValueName release];
    [strColorName release];
    
    [treemapView release];
    [myScroll release];
    myScroll = nil;
    [super dealloc];
}

#pragma mark protocol
- (void)updateCell:(TreemapViewCell *)cell forIndex:(NSInteger)index {
    
    NSNumber* val = [[self valueDatas] objectAtIndex:index];
    cell.textLabel.text = [[self nameDatas] objectAtIndex:index];
    cell.valueLabel.text = [val stringValue];
    cell.backgroundColor = [[self colorDatas] objectAtIndex:index];
}

#pragma mark -
#pragma mark TreemapView delegate

- (void)treemapView:(TreemapView *)_treemapView tapped:(NSInteger)index {
    
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
    DataGridViewController* dvc = [[[DataGridViewController alloc] initWithDataResource:ds withRect:CGRectMake(0, 0, 300, 48)] autorelease];
    
    popOver = [[UIPopoverController alloc] initWithContentViewController:dvc];
    [popOver setPopoverContentSize:CGSizeMake(300, 48)];
    [popOver setDelegate:self];
    
    //to confirm the direction
    [popOver presentPopoverFromRect:[cell frame] inView:_treemapView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

#pragma mark popoverController delegate
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [popOver release];
    popOver = nil;
}

#pragma mark -
#pragma mark TreemapView data source

- (NSArray *)valuesForTreemapView:(TreemapView *)treemapView {
    
    return valueDatas;
    
}

- (TreemapViewCell *)treemapView:(TreemapView *)treemapView cellForIndex:(NSInteger)index forRect:(CGRect)rect {
	TreemapViewCell *cell = [[[TreemapViewCell alloc] initWithFrame:rect] autorelease];
	[self updateCell:cell forIndex:index];
	return cell;
    
}

- (void)treemapView:(TreemapView *)treemapView updateCell:(TreemapViewCell *)cell forIndex:(NSInteger)index forRect:(CGRect)rect {
	[self updateCell:cell forIndex:index];
}

#pragma mark TableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选中按钮后的效果
    int index = [indexPath row];
    DTReport* dtReport = [reportsArray objectAtIndex:index];
    [self setDataReport:dtReport];
    [self reDraw];
    
    //button text
    //set the button at the middle of navigatonBar
    //如果要自定义按钮，在这里修改
    NSString* str = [btnNameArray objectAtIndex:index];
    UIBarButtonItem* barBtn = [[[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStyleBordered target:self action:@selector(onTopTitlePress)]autorelease];
    [[self navigationItem] setRightBarButtonItem:barBtn];
    
    [popOver setDelegate:self];
    [popOver dismissPopoverAnimated:YES];
    [popOver release];
    popOver = nil;
}

#pragma mark tableView dataResource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [reportsArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%d", [indexPath row]]];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell%d", [indexPath row]]] autorelease];
        
        [[cell textLabel] setText:[btnNameArray objectAtIndex:[indexPath row]]];
        
    }
    
    return cell;
}

@end

