//
//  BATestViewController.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-11-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BFGraphViewController2.h"
#import "BADocumentButton.h"
#import "BAColorHelper.h"
#import "BADefinition.h"
#import "BATestCell.h"
#import "BAMixGraph3.h"
#import "BFGraph2Cell.h"
#import "BAEntitySliderControl.h"
#import "BAMicroGraphslider.h"
@interface BFGraphViewController2 ()

@end

@implementation BFGraphViewController2
{
    BADocument *document;
    BAMixGraph3 *graph;
    CGPoint originalPosition;
    BAReport *myReport;
    NSUInteger flag;
    BAEntitySliderControl *entitySliderControl;
    NSRange aRange;
    BAMicroGraphslider *microGraph;
}
@synthesize scrollView;
@synthesize hostView;
@synthesize host;
@synthesize myTableView;
@synthesize metricName;
@synthesize entityName;
@synthesize metricValue;
@synthesize mySlider;
@synthesize bar;
@synthesize bar1;
@synthesize bar2;
@synthesize touchView;
@synthesize floatingView;
@synthesize hostSlider;

#pragma mark -
#pragma mark render method
-(void)renderMicroGraph
{
    BAReport *report=[document.reports objectAtIndex:4];
    microGraph=[[BAMicroGraph alloc]init];
    [microGraph configure:report];
    
}

- (IBAction)sliderAction:(UISlider *)sender {
    float sliderRange = sender.frame.size.width - sender.currentThumbImage.size.width;
    float sliderOrigin = sender.frame.origin.x + (sender.currentThumbImage.size.width / 2.0);
    
    float sliderValueToPixels = ((((sender.value-sender.minimumValue)/(sender.maximumValue-sender.minimumValue)) * sliderRange) + sliderOrigin);
    
    /*CGRect barFrame=bar.frame;
     barFrame.origin.x=sliderValueToPixels;
     bar.frame=barFrame;*/
    CGPoint barCenter=bar.center;
    barCenter.x=sliderValueToPixels;
    bar.center=barCenter;
    
    CPTXYPlotSpace *plotSpace=(CPTXYPlotSpace*)[graph.graph plotSpaceAtIndex:0];
    NSDecimal d[2];
    [plotSpace plotPoint:d forPlotAreaViewPoint:barCenter];
    NSDecimalNumber *x=[[NSDecimalNumber alloc]initWithDecimal:d[0]];
    //NSDecimalNumber *y=[[NSDecimalNumber alloc]initWithDecimal:d[1]];
    //NSLog(@"%d----%d",[x intValue],[y intValue]);
    int selectedIndex=[x intValue]-1;
    graph->selectedIndex=selectedIndex;
    [graph.graph reloadData];
    BAMetric *metric=[myReport.reportData.metrics objectAtIndex:0];
    BAEntity *entity=myReport.reportData.entity;
    entityName.text=entity.entityName;
    if (0<=selectedIndex&&selectedIndex<metric.dataValues.count) {
        metricValue.text=[NSString stringWithFormat:@"%@", [metric.dataValues objectAtIndex:selectedIndex]];
    }else {
        metricValue.text=@"";
    }
    
}

-(void)renderGraph
{
    BAReport *report=[document.reports objectAtIndex:4];
    graph=[[BAMixGraph3 alloc]init];
    //graph->selectedIndex=2;
    [graph configurePlots:report];
    
    [graph renderInHostView:[self hostView]];
}

-(void)renderSlider
{
    entitySliderControl=[[BAEntitySliderControl alloc]init];
    entitySliderControl.baseGraph=graph;
    NMRangeSlider *slider=[entitySliderControl configureWithBounds:hostSlider.bounds];
    
    BAReport *report=[document.reports objectAtIndex:4];
    microGraph=[[BAMicroGraphslider alloc]init];
    [microGraph configure:report];
    slider.trackBackgroundImage=[microGraph microImage];
    
    if (hostSlider.subviews.count>0) {
        [[hostSlider.subviews objectAtIndex:0] removeFromSuperview];
    }
    [hostSlider addSubview:slider];
    [slider addTarget:self action:@selector(changeEntity:) forControlEvents:UIControlEventValueChanged];
}

-(void)backAction
{
    BAAnimationHelper *animation=[[BAAnimationHelper alloc]init];
    [self.navigationController.view.layer addAnimation:animation.showNavigationController forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
    document=nil;
    graph=nil;
    
    myReport=nil;
    
}


-(void)showGraph:(BADocumentButton*)sender
{
    [self renderGraph];
    originalPosition=host.center;
    metricName.text=sender.metric.text;
    entityName.text=sender.entity.text;
    metricValue.text=sender.dataValue.text;
    CGPoint point=[self.view convertPoint:sender.center fromView:scrollView];
    host.center=point;
    CGAffineTransform newTransform = CGAffineTransformMakeScale( 0 , 0);
    [host setTransform :newTransform];
    mySlider.alpha=0;
    bar.alpha=0;
    metricName.alpha=0;
    entityName.alpha=0;
    metricValue.alpha=0;
    [UIView animateWithDuration:1 animations:^
     {
         
         host.center=CGPointMake(originalPosition.x,originalPosition.y);
         CGAffineTransform newTransform = CGAffineTransformMakeScale( 1 ,1);
         [host setTransform :newTransform];
         
     }completion:^(BOOL finished)
     {
         mySlider.alpha=1;
         bar.alpha=1;
         metricName.alpha=1;
         entityName.alpha=1;
         metricValue.alpha=1;
     }];
}
#pragma mark -
#pragma mark tableview method

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"延滞率";
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"graph2section-background.png"]];
    imageView.frame=CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 50);
    //view.backgroundColor=[UIColor grayColor];
    return imageView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BAMetric *metric=[myReport.reportData.metrics objectAtIndex:0];
    BAEntity *entity=myReport.reportData.entity;
    BFGraph2Cell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=(BFGraph2Cell*)[[[NSBundle mainBundle]loadNibNamed:@"BFGraph2Cell" owner:self options:nil]lastObject];
    }

    //cell.selectionStyle=UITableViewCellSelectionStyleGray;
    cell.selectedBackgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"graphCell2-selected-background.png"]];
    cell.selectedBackgroundView.frame=cell.frame;
    cell.selectedBackgroundView.backgroundColor=[UIColor orangeColor];
    UIView *backgroundView=[[UIView alloc]initWithFrame:cell.frame];
    if (indexPath.row%2==0)
    {
        backgroundView.backgroundColor=[BAColorHelper stringToUIColor:@"1b1b1b	" alpha:@"1"];
    }
    else
    {
        backgroundView.backgroundColor=[BAColorHelper stringToUIColor:@"202020" alpha:@"1"];
    }
    cell.backgroundView=backgroundView;

    if (indexPath.row<metric.dataValues.count) {
        cell.nameLabel.text=metric.metricName;
        cell.valueLabel.text=[entity.entityValues objectAtIndex:indexPath.row];
        NSDecimalNumber *value=[metric.dataValues objectAtIndex:indexPath.row];
        cell.ratioLabel.text=[NSString stringWithFormat:@"%@",value ];
    }else
    {
        cell.nameLabel.alpha=0;
        cell.valueLabel.alpha=0;
        cell.image.alpha=0;
        cell.ratioLabel.alpha=0;
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BAMetric *metric=[myReport.reportData.metrics objectAtIndex:0];
    NSUInteger extra=(int) tableView.frame.size.height/40-metric.dataValues.count;
    return metric.dataValues.count+extra;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGPoint contentOffsetPoint = myTableView.contentOffset;
//    NSUInteger index=contentOffsetPoint.y/40;
//    if (flag!=index) {
//        
//        flag=index;
//    }
//}
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    CGPoint contentOffsetPoint = myTableView.contentOffset;
//    NSUInteger index=nearbyintf(contentOffsetPoint.y/40);
//    if (index>=12) {
//        index=11;
//    }
//    contentOffsetPoint.y=index*40;
//    myTableView.contentOffset=contentOffsetPoint;
//    [self renderGraph];
//}
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    CGPoint contentOffsetPoint = myTableView.contentOffset;
//    NSUInteger index=nearbyintf(contentOffsetPoint.y/40);
//    if (index>=12) {
//        index=11;
//    }
//    contentOffsetPoint.y=index*40;
//    myTableView.contentOffset=contentOffsetPoint;
//    [self renderGraph];
//}
#pragma mark -
#pragma mark control method
-(void)changeEntity:(NMRangeSlider*)sender
{
    
    NSRange range=NSMakeRange((int)sender.lowerValue,(int)sender.upperValue+1-(int)sender.lowerValue);
    if(range.length!=aRange.length){
        
        [entitySliderControl changeEntity:sender.lowerValue upperValue:sender.upperValue];
        aRange=range;
    }
}
-(void)removeBar1{
    touchView.x = 0;
    touchView.x2 = 0;
    tempX = 1;
    tempX2 = 1;
    [self getTouchPointX];
    floatingView.hidden = YES;
}
-(void)removeBar2{
    touchView.x = 0;
    touchView.x2 = 0;
}

-(void)getTouchPointX
{
    float x;
    float x2;
    int selectedIndex;
    int selectedIndex2;
    UIImageView *tempbar;
    UIImageView *tempbar2;
    
    if (tempX == 0) {
        x = touchView.x2;
        x2 = 0;
        tempX = 0;
        tempX2 = (x2 != 0)?x2:1;
        tempbar = bar1;
        tempbar2 = nil;
    }
    else{
        x = touchView.x;
        x2 = touchView.x2;
        tempX = (x != 0)?x:1;
        tempX2 = (x2 != 0)?x2:1;
        tempbar = ((x <= x2)||((x >= x2)&&(x2 == 0)))?bar1:bar2;
        tempbar2 = ((x <= x2)||((x >= x2)&&(x2 == 0)))?bar2:bar1;
    }
    if (x!=0) {
        CGPoint barCenter=tempbar.center;
        barCenter.x=x;
        CPTXYPlotSpace *plotSpace=(CPTXYPlotSpace*)[graph.graph plotSpaceAtIndex:0];
        NSDecimal d[2];
        [plotSpace plotPoint:d forPlotAreaViewPoint:barCenter];
        NSDecimalNumber *graphX=[[NSDecimalNumber alloc]initWithDecimal:d[0]];
        selectedIndex=[graphX intValue]-1;
        NSLog(@"selectedIndex:%d",selectedIndex);
        graph->selectedIndex=selectedIndex;
        if (0<=selectedIndex&&selectedIndex<=11) {
            tempbar.center=barCenter;
            tempbar.hidden=NO;
            floatingView.hidden = NO;
            tempX = 1;
        }
        else{
            tempbar.hidden = YES;
            floatingView.hidden = YES;
            tempX = 0;
            x = 0;
        }
    }
    else if (x == 0){
        tempbar.hidden = YES;
    }
    if (x2!=0) {
        CGPoint barCenter=tempbar2.center;
        barCenter.x=x2;
        CPTXYPlotSpace *plotSpace=(CPTXYPlotSpace*)[graph.graph plotSpaceAtIndex:0];
        NSDecimal d[2];
        [plotSpace plotPoint:d forPlotAreaViewPoint:barCenter];
        NSDecimalNumber *graphX=[[NSDecimalNumber alloc]initWithDecimal:d[0]];
        selectedIndex2=[graphX intValue]-1;
        NSLog(@"selectedIndex2:%d",selectedIndex2);
        graph->selectedIndex2=selectedIndex2;
        if (0<=selectedIndex2&&selectedIndex2<=11) {
            tempbar2.center=barCenter;
            tempbar2.hidden=NO;
            floatingView.hidden = NO;
            tempX2 = 1;
        }
        else{
            tempbar2.hidden = YES;
            floatingView.hidden = YES;
            tempX2 = 0;
            x2 = 0;
        }
    }
    else if (x2 == 0){
        tempbar2.hidden = YES;
    }
    [graph.graph reloadData];
    
    BAMetric *metric=[myReport.reportData.metrics objectAtIndex:0];
    BAEntity *entity=myReport.reportData.entity;
    if ((x == 0)||(x2 == 0)) {
        if (0<=selectedIndex&&selectedIndex<metric.dataValues.count) {
            metricValue.text=[NSString stringWithFormat:@"%@", [metric.dataValues objectAtIndex:selectedIndex]];
            metricValue.textColor = [UIColor grayColor];
            entityName.text = [entity.entityValues objectAtIndex:selectedIndex];
            NSLog(@"tempx:%f tempx2:%f",tempX,tempX2);
            if((tempX == 0)&&(tempX2 != 0)){
                tempbar.hidden = YES;
                tempbar2.hidden = NO;
            }
            if((tempX != 0)&&(tempX2 == 0)){
                tempbar.hidden = NO;
                tempbar2.hidden = YES;
            }
            [bar1 setImage:[UIImage imageNamed:@"bar2.png"]];
            [bar2 setImage:[UIImage imageNamed:@"bar2.png"]];
            floatingView.hidden = NO;
            floatingView.center = CGPointMake((x == 0)?x2:x, 20);
            //[floatingView setBackgroundColor:[UIColor darkGrayColor]];
            UILabel *valueLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(floatingView.frame)/2, CGRectGetWidth(floatingView.frame), CGRectGetHeight(floatingView.frame)/2)];
            valueLabel.backgroundColor=[UIColor clearColor];
            valueLabel.textColor = [UIColor whiteColor];
            valueLabel.font = [UIFont fontWithName:@"helvetica" size:13];
            valueLabel.text = [NSString stringWithFormat:@"%@\n%@",[entity.entityValues objectAtIndex:selectedIndex], metricValue.text];
            valueLabel.numberOfLines = 0;
            valueLabel.textAlignment = UITextAlignmentCenter;
            [floatingView addSubview:valueLabel];
            [touchView addSubview:floatingView];
        }
    }else if((x != 0)&&(x2 != 0)){
        if ((0<=selectedIndex&&selectedIndex<metric.dataValues.count)&&(0<=selectedIndex2&&selectedIndex2<metric.dataValues.count)) {
            NSString *startTime = [entity.entityValues objectAtIndex:(selectedIndex<=selectedIndex2)?selectedIndex:selectedIndex2];
            NSString *endTime = [entity.entityValues objectAtIndex:(selectedIndex<=selectedIndex2)?selectedIndex2:selectedIndex];
            float startValue = [[metric.dataValues objectAtIndex:(selectedIndex<=selectedIndex2)?selectedIndex:selectedIndex2] floatValue];
            float endValue = [[metric.dataValues objectAtIndex:(selectedIndex<=selectedIndex2)?selectedIndex2:selectedIndex] floatValue];
            entityName.text = [NSString stringWithFormat:@"%@--%@",startTime,endTime];
            float subtractValue = (endValue-startValue)/startValue*100;
            NSString *perMark = @"%";
            if (subtractValue >= 0) {
                metricValue.text = [NSString stringWithFormat:@"▲%8.3f %8.2f%@",subtractValue*startValue/100, subtractValue,perMark];
                metricValue.textColor = [UIColor greenColor];
                [bar2 setImage:[UIImage imageNamed:@"bar-green.png"]];
                [floatingView setBackgroundColor:[UIColor darkGrayColor]];
                //floatingView.textColor = [UIColor greenColor];
            }
            else if (subtractValue < 0)
            {
                metricValue.text = [NSString stringWithFormat:@"▼%8.3f %8.2f%@",-subtractValue*startValue/100,-subtractValue,perMark];
                metricValue.textColor = [UIColor redColor];
                [bar2 setImage:[UIImage imageNamed:@"bar-red.png"]];
                [floatingView setBackgroundColor:[UIColor darkGrayColor]];
                //floatingView.textColor = [UIColor redColor];
            }
            floatingView.hidden = NO;
            floatingView.center = CGPointMake((x2+x)/2, 20);
            UILabel *valueLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(floatingView.frame)/2, CGRectGetWidth(floatingView.frame), CGRectGetHeight(floatingView.frame)/2)];
            [floatingView addSubview:valueLabel];
            valueLabel.text = [NSString stringWithFormat:@"%@--%@\n%@",startTime,endTime,metricValue.text];
            valueLabel.backgroundColor=[UIColor clearColor];
            valueLabel.font = [UIFont fontWithName:@"helvetica" size:13];
            valueLabel.numberOfLines = 0;
            valueLabel.textAlignment = UITextAlignmentCenter;
            [touchView addSubview:floatingView];
        }
    }
}
#pragma mark -
#pragma mark system method
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    BADocumentService *documentService=[[BADocumentService alloc]init];
    BADataSourceService *dataSourceService=[[BADataSourceService alloc]init];
    //从数据源获取document
    document=[documentService getDocumentWithDictionary:[dataSourceService getDocumentDictionary:@"000008"]];
    BAReport *report=[document.reports objectAtIndex:4];
    int dataCount=report.reportData.entity.entityValues.count;
    myReport=report;
    
    //UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(backAction)];
    //UIBarButtonItem *home=[[UIBarButtonItem alloc]initWithTitle:@"主页" style:UIBarButtonItemStylePlain target:self action:@selector(backHome)];
    //[self navigationItem].leftBarButtonItems=[NSArray arrayWithObjects:home,back, nil];
    //UIBarButtonItem *next=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextController)];
    //[self navigationItem].rightBarButtonItem=next;
    
    //scrollView.contentSize=CGSizeMake(211*8, 138);
    scrollView.contentSize=CGSizeMake(211*(dataCount*report.reportData.metrics.count+1), 138);
    [self renderGraph];
    [self renderSlider];
    //mySlider.frame=[self.view convertRect:graph.graph.plotAreaFrame.frame fromView:graph.graph.plotAreaFrame];
    [mySlider setThumbImage:[UIImage imageNamed:@"thumb-normal2" ] forState:UIControlStateNormal];
    [mySlider setThumbImage:[UIImage imageNamed:@"thumb-highlight2"] forState:UIControlStateHighlighted];
    
    tempX = 1;
    tempX2 = 1;
    touchView.delegate=self;
    floatingView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"graph2-button-blue"]];
    floatingView.frame = CGRectMake(0, 0, 120, 50);
    //[[floatingView layer] setBorderWidth:1.5f];
}
- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setHostView:nil];
    [self setHost:nil];
    [self setMyTableView:nil];
    [self setMetricName:nil];
    [self setEntityName:nil];
    [self setMetricValue:nil];
    [self setMySlider:nil];
    [self setBar:nil];
    [self setBar1:nil];
    [self setBar2:nil];
    [self setTouchView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
