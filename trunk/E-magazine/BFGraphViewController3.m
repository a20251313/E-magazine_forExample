//
//  BATestViewController.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-11-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BFGraphViewController3.h"
#import "BADocumentButton.h"
#import "BAColorHelper.h"
#import "BADefinition.h"
#import "BATestCell.h"
#import "BAMixGraph4.h"
#import "BFGraph3Cell.h"
@interface BFGraphViewController3 ()

@end

@implementation BFGraphViewController3
{
    BADocument *document;
    BAMixGraph4 *graph;
    CGPoint originalPosition;
    BAReport *myReport;
    NSUInteger flag;
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
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
        metricValue.text=@"";    }
    
}

-(void)renderGraph
{
    BAReport *report=[document.reports objectAtIndex:arc4random()%2];
    graph=[[BAMixGraph4 alloc]init];
    //graph->selectedIndex=2;
    [graph configurePlots:report];
    
    [graph renderInHostView:[self hostView]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    BADocumentService *documentService=[[BADocumentService alloc]init];
    BADataSourceService *dataSourceService=[[BADataSourceService alloc]init];
    //从数据源获取document
    document=[documentService getDocumentWithDictionary:[dataSourceService getDocumentDictionaryTest:@"000028"]];
    BAReport *report=[document.reports objectAtIndex:0];
    int dataCount=report.reportData.entity.entityValues.count;
    myReport=report;
    for (int j=0;j<report.reportData.metrics.count;j++)
    {
        BAMetric *metric=[report.reportData.metrics objectAtIndex:j];
        for(int i=0;i<metric.dataValues.count;i++)
        {
            NSDecimalNumber *dataValue=[metric.dataValues objectAtIndex:i];
            BADocumentButton *documentButton=[[[NSBundle mainBundle]loadNibNamed:@"documentButton" owner:self options:nil]lastObject];
            documentButton.frame=CGRectMake((211+9)*i+j*(211+9)*metric.dataValues.count, 9, 211, 138);
            [documentButton addTarget:self action:@selector(showGraph:) forControlEvents:UIControlEventTouchUpInside];
            UIImage *backImage=[UIImage imageNamed:@"test-button2.png"];
            UIImage *linkImage=[UIImage imageNamed:@"test-button-link2.png"];
            [documentButton setImage:backImage forState:UIControlStateNormal];
            [documentButton setImage:linkImage forState:UIControlStateHighlighted];
            if (i%2==0) {
                documentButton.dataValue.textColor=[BAColorHelper stringToUIColor:@"f39121" alpha:@"1"];
                documentButton.arrow.image=[UIImage imageNamed:@"arrow-orange"];
            }else {
                documentButton.dataValue.textColor=[BAColorHelper stringToUIColor:@"8ac340" alpha:@"1"];
                documentButton.arrow.image=[UIImage imageNamed:@"arrow-green"];
            }
            documentButton.metric.text=metric.metricName;
            documentButton.entity.text=[report.reportData.entity.entityValues objectAtIndex:i];
            documentButton.dataValue.text=dataValue.stringValue;
            
            //[documentButton addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:documentButton];
        }
    }
    //UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(backAction)];
    //UIBarButtonItem *home=[[UIBarButtonItem alloc]initWithTitle:@"主页" style:UIBarButtonItemStylePlain target:self action:@selector(backHome)];
    //[self navigationItem].leftBarButtonItems=[NSArray arrayWithObjects:home,back, nil];
    //UIBarButtonItem *next=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextController)];
    //[self navigationItem].rightBarButtonItem=next;
    
    //scrollView.contentSize=CGSizeMake(211*8, 138);
    scrollView.contentSize=CGSizeMake(211*(dataCount*report.reportData.metrics.count+1), 138);
    [self renderGraph];
    //mySlider.frame=[self.view convertRect:graph.graph.plotAreaFrame.frame fromView:graph.graph.plotAreaFrame];
    [mySlider setThumbImage:[UIImage imageNamed:@"thumb-normal2" ] forState:UIControlStateNormal];
    [mySlider setThumbImage:[UIImage imageNamed:@"thumb-highlight2"] forState:UIControlStateHighlighted];
    
    host.layer.borderColor=[[UIColor grayColor]CGColor];
    host.layer.borderWidth=1.0;
    tempX = 1;
    tempX2 = 1;
    touchView.delegate=self;
    floatingView = [[UILabel alloc] init];
    floatingView.frame = CGRectMake(0, 0, 140, 32);
    [[floatingView layer] setBorderWidth:1.5f];
}
-(void)nextController
{
    
}
-(void)backHome
{
    BAAnimationHelper *animation=[[BAAnimationHelper alloc]init];
    [self.navigationController.view.layer addAnimation:animation.showNavigationController forKey:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
    document=nil;
    graph=nil;
    
    myReport=nil;
    
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
-(void)setHighlight:(UIButton*)button
{
    [button setHighlighted:YES];
    for (id view in scrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            
        }
    }
}
/*
 -(void)showGraph:(BADocumentButton*)sender
 {
 CGRect rect=host.frame;
 originalPosition=rect;
 rect.origin.x=self.view.frame.size.width;
 [UIView animateWithDuration:0.5 animations:^
 {
 host.frame=rect;
 host.alpha=0;
 } completion:^(BOOL finished)
 {
 [self renderGraph];
 metricName.text=sender.metric.text;
 entityName.text=sender.entity.text;
 metricValue.text=sender.dataValue.text;
 CGRect rect=[self.view convertRect:sender.frame fromView:scrollView];
 host.frame=rect;
 mySlider.alpha=0;
 //host.backgroundColor=[BAColorHelper stringToUIColor:@"383c45" alpha:@"0.5"];
 [UIView animateWithDuration:0.5 animations:^
 {
 host.frame=originalPosition;
 host.alpha=1;
 }completion:^(BOOL finished)
 {
 mySlider.alpha=1;
 //host.backgroundColor=[UIColor clearColor];
 
 }];
 }];
 //[self performSelector:@selector(setHighlight:) withObject:sender afterDelay:0];
 }
 */

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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BAMetric *metric=[myReport.reportData.metrics objectAtIndex:0];
    BFGraph3Cell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=(BFGraph3Cell*)[[[NSBundle mainBundle]loadNibNamed:@"BFGraph3Cell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    //cell.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"graphCell3-background"]];
    if (indexPath.row<metric.dataValues.count) {
        cell.nameLabel.text=metric.metricName;
        NSDecimalNumber *value=[metric.dataValues objectAtIndex:indexPath.row];
        cell.valueLabel.text=[NSString stringWithFormat:@"%@",value ];

    }else {
        
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BAMetric *metric=[myReport.reportData.metrics objectAtIndex:0];
    NSUInteger extra=(int) tableView.frame.size.height/40;
    return metric.dataValues.count+extra;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint contentOffsetPoint = myTableView.contentOffset;
    NSUInteger index=contentOffsetPoint.y/40;
    if (flag!=index) {
        
        flag=index;
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint contentOffsetPoint = myTableView.contentOffset;
    NSUInteger index=nearbyintf(contentOffsetPoint.y/40);
    if (index>=12) {
        index=11;
    }
    contentOffsetPoint.y=index*40;
    myTableView.contentOffset=contentOffsetPoint;
    [self renderGraph];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGPoint contentOffsetPoint = myTableView.contentOffset;
    NSUInteger index=nearbyintf(contentOffsetPoint.y/40);
    if (index>=12) {
        index=11;
    }
    contentOffsetPoint.y=index*40;
    myTableView.contentOffset=contentOffsetPoint;
    [self renderGraph];
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
            [floatingView setBackgroundColor:[UIColor darkGrayColor]];
            floatingView.textColor = [UIColor whiteColor];
            floatingView.font = [UIFont fontWithName:@"helvetica" size:13];
            floatingView.text = [NSString stringWithFormat:@"%@\n%@",[entity.entityValues objectAtIndex:selectedIndex], metricValue.text];
            floatingView.numberOfLines = 0;
            floatingView.textAlignment = UITextAlignmentCenter;
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
                floatingView.textColor = [UIColor greenColor];
            }
            else if (subtractValue < 0)
            {
                metricValue.text = [NSString stringWithFormat:@"▼%8.3f %8.2f%@",-subtractValue*startValue/100,-subtractValue,perMark];
                metricValue.textColor = [UIColor redColor];
                [bar2 setImage:[UIImage imageNamed:@"bar-red.png"]];
                [floatingView setBackgroundColor:[UIColor darkGrayColor]];
                floatingView.textColor = [UIColor redColor];
            }
            floatingView.hidden = NO;
            floatingView.center = CGPointMake((x2+x)/2, 20);
            floatingView.text = [NSString stringWithFormat:@"%@--%@\n%@",startTime,endTime,metricValue.text];
            floatingView.font = [UIFont fontWithName:@"helvetica" size:13];
            floatingView.numberOfLines = 0;
            floatingView.textAlignment = UITextAlignmentCenter;
            [touchView addSubview:floatingView];
        }
    }
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
