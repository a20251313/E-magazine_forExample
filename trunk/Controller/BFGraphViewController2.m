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
#import "BFGraph2Model.h"
#import "BFAppDelegate.h"
#import "Global.h"

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
    NSMutableArray *sections;
    BFGraph2Model *curModel;
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
@synthesize shadeView;

#pragma mark -
#pragma mark render method
-(void)renderMicroGraph
{
    microGraph=[[BAMicroGraph alloc]init];
    [microGraph configure:curModel.report];
    
}

-(void)renderGraph
{
    graph=[[BAMixGraph3 alloc]init];
    //graph->selectedIndex=2;
    [graph configurePlots:curModel.report];
    
    [graph renderInHostView:[self hostView]];
    [floatingView setHidden:YES];
    [bar setHidden:YES];
    [bar1 setHidden:YES];
    [bar2 setHidden:YES];
    [shadeView setHidden:YES];
}

-(void)renderSlider
{
    entitySliderControl=[[BAEntitySliderControl alloc]init];
    entitySliderControl.baseGraph=graph;
    NMRangeSlider *slider=[entitySliderControl configureWithBounds:hostSlider.bounds];
    
    microGraph=[[BAMicroGraphslider alloc]init];
    [microGraph configure:curModel.report];
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

#pragma mark -
#pragma mark tableview method
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"graph2section-background2.png"]];
    UIView *imageView=[[UIView alloc]init];
    imageView.backgroundColor=[UIColor clearColor];
    UIImageView *bgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"graph2tableheader01"]];
    bgView.frame=CGRectMake(0, 0, CGRectGetWidth(tableView.frame),39);
    [imageView addSubview:bgView];
    //imageView.frame=CGRectMake(0, 0, CGRectGetWidth(tableView.frame), tableView.sectionHeaderHeight);
    //view.backgroundColor=[UIColor grayColor];
    UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100,tableView.sectionHeaderHeight)];
    nameLabel.font=[UIFont systemFontOfSize:12];
    nameLabel.textColor=[BAColorHelper stringToUIColor:@"082b41" alpha:@"1"];
    nameLabel.backgroundColor=[UIColor clearColor];
    
    UILabel *targetLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 0, 100, tableView.sectionHeaderHeight)];
    targetLabel.font=[UIFont systemFontOfSize:12];
    targetLabel.textColor=[BAColorHelper stringToUIColor:@"082b41" alpha:@"1"];
    targetLabel.backgroundColor=[UIColor clearColor];
    
    UILabel *valueLabel=[[UILabel alloc]initWithFrame:CGRectMake(210, 0, 100, tableView.sectionHeaderHeight)];
    valueLabel.font=[UIFont systemFontOfSize:12];
    valueLabel.textColor=[BAColorHelper stringToUIColor:@"082b41" alpha:@"1"];
    valueLabel.backgroundColor=[UIColor clearColor];
    
    switch (section) {
        case 0:
        {
            nameLabel.text=@"产品品类";
            targetLabel.text=@"目标销量（万元）";
            valueLabel.text=@"销量（万元）";
        }
            break;
            case 1:
        {
            nameLabel.text=@"地区";
            targetLabel.text=@"目标销量（万元）";
            valueLabel.text=@"销量（万元）";
        }
            break;
            
        default:
            break;
    }
    [imageView addSubview:nameLabel];
    [imageView addSubview:targetLabel];
    [imageView addSubview:valueLabel];
    return imageView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    BFGraph2Cell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=(BFGraph2Cell*)[[[NSBundle mainBundle]loadNibNamed:@"BFGraph2Cell" owner:self options:nil]lastObject];
    }

    cell.selectedBackgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"graph2cellselected-01"]];
    cell.selectedBackgroundView.frame=cell.frame;
    //cell.selectedBackgroundView.backgroundColor=[UIColor orangeColor];
//    UIView *backgroundView=[[UIView alloc]initWithFrame:cell.frame];
//    if (indexPath.row%2==0)
//    {
//        backgroundView.backgroundColor=[BAColorHelper stringToUIColor:@"0b182c	" alpha:@"1"];
//    }
//    else
//    {
//        backgroundView.backgroundColor=[BAColorHelper stringToUIColor:@"020a20" alpha:@"1"];
//    }
    UIImageView *backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"graph2cell"]];
    cell.backgroundView=backgroundView;

    BFGraph2Model *model=[[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.nameLabel.text=model.name;
    cell.valueLabel.text=[NSString stringWithFormat:@"%.1f",[model.salesTarget doubleValue]];
    cell.ratioLabel.text=[NSString stringWithFormat:@"%.1f",[model.sales doubleValue]];
    if ([model.salesTarget doubleValue]>[model.sales doubleValue]) {
//        cell.image.image=[UIImage imageNamed:@"graph4-button-red"];
        cell.ratioLabel.textColor=[UIColor redColor];
        cell.ratioLabel.text=[NSString stringWithFormat:@"-%.1f",[model.sales doubleValue]];
    }else
    {
//        cell.image.image=[UIImage imageNamed:@"graph4-button-green"];
        cell.ratioLabel.textColor=[UIColor greenColor];
        cell.ratioLabel.text=[NSString stringWithFormat:@"+%.1f",[model.sales doubleValue]];
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setBackgroundView:[[UIView alloc] initWithFrame:CGRectZero]];

    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[sections objectAtIndex:section] count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    curModel=[[sections objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    [self renderGraph];
    [self renderSlider];
    [self renderMicroGraph];
}
#pragma mark -
#pragma mark control method
-(void)changeEntity:(NMRangeSlider*)sender
{
    
    NSRange range=NSMakeRange((int)sender.lowerValue,(int)sender.upperValue+1-(int)sender.lowerValue);
    if(range.length!=aRange.length){
        
        [entitySliderControl changeEntity:sender.lowerValue upperValue:sender.upperValue];
        aRange=range;
        [floatingView setHidden:YES];
        [bar setHidden:YES];
        [bar1 setHidden:YES];
        [bar2 setHidden:YES];
        [shadeView setHidden:YES];
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
        //NSLog(@"%f",[graphX doubleValue]-[[[NSDecimalNumber alloc]initWithDecimal:plotSpace.xRange.length] doubleValue]/6-1);
        selectedIndex=round([graphX doubleValue]-[[[NSDecimalNumber alloc]initWithDecimal:plotSpace.xRange.length] doubleValue]/6)-1;
        //selectedIndex=round([graphX doubleValue])-7;
        //NSLog(@"selectedIndex:%d",selectedIndex);
        graph->selectedIndex=selectedIndex;
        if (0<=selectedIndex&&selectedIndex<=36) {
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
        //selectedIndex2=round([graphX doubleValue])-7;
        selectedIndex2=round([graphX doubleValue]-[[[NSDecimalNumber alloc]initWithDecimal:plotSpace.xRange.length] doubleValue]/6)-1;
        NSLog(@"selectedIndex2:%d",selectedIndex2);
        graph->selectedIndex2=selectedIndex2;
        if (0<=selectedIndex2&&selectedIndex2<=36) {
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
        shadeView.hidden=NO;
        shadeView.frame=CGRectMake(CGRectGetMidX(tempbar.frame),tempbar.frame.origin.y+10, CGRectGetMidX(tempbar2.frame)-CGRectGetMidX(tempbar.frame), CGRectGetHeight(tempbar.frame)-20);
    }
    else if (x2 == 0){
        tempbar2.hidden = YES;
        shadeView.hidden=YES;
    }
    [graph.graph reloadData];
    
    BAMetric *metric=[curModel.report.reportData.metrics objectAtIndex:0];
    BAEntity *entity=curModel.report.reportData.entity;
    NSString *valueString;
    NSString *dateString;
    if ((x == 0)||(x2 == 0)) {
        if (0<=selectedIndex&&selectedIndex<metric.dataValues.count) {
            valueString=[NSString stringWithFormat:@"%@", [metric.dataValues objectAtIndex:selectedIndex]];
            dateString=[entity.entityValues objectAtIndex:selectedIndex];
            //metricValue.textColor = [UIColor grayColor];
            //entityName.text = [entity.entityValues objectAtIndex:selectedIndex];
            //NSLog(@"tempx:%f tempx2:%f",tempX,tempX2);
            if((tempX == 0)&&(tempX2 != 0)){
                tempbar.hidden = YES;
                tempbar2.hidden = NO;
            }
            if((tempX != 0)&&(tempX2 == 0)){
                tempbar.hidden = NO;
                tempbar2.hidden = YES;
            }
            [bar1 setImage:[UIImage imageNamed:@"graph1-bar"]];
            [bar2 setImage:[UIImage imageNamed:@"graph1-bar"]];
            floatingView.hidden = NO;
            floatingView.center = CGPointMake((x == 0)?x2:x, 20);
            //[floatingView setBackgroundColor:[UIColor darkGrayColor]];
            
            UILabel *valueLabel=(UILabel*)[floatingView viewWithTag:11];
            valueLabel.text = [NSString stringWithFormat:@"%@（万元）",valueString];
            UILabel *dateLabel=(UILabel*)[floatingView viewWithTag:12];
            dateLabel.text = [NSString stringWithFormat:@"%@",dateString];
            
            floatingView.image=[UIImage imageNamed:@"graph2-button-lightblue"];
            //[touchView addSubview:floatingView];
        }
    }else if((x != 0)&&(x2 != 0)){
        if ((0<=selectedIndex&&selectedIndex<metric.dataValues.count)&&(0<=selectedIndex2&&selectedIndex2<metric.dataValues.count)) {
            NSString *startTime = [entity.entityValues objectAtIndex:(selectedIndex<=selectedIndex2)?selectedIndex:selectedIndex2];
            NSString *endTime = [entity.entityValues objectAtIndex:(selectedIndex<=selectedIndex2)?selectedIndex2:selectedIndex];
            float startValue = [[metric.dataValues objectAtIndex:(selectedIndex<=selectedIndex2)?selectedIndex:selectedIndex2] floatValue];
            float endValue = [[metric.dataValues objectAtIndex:(selectedIndex<=selectedIndex2)?selectedIndex2:selectedIndex] floatValue];
            dateString = [NSString stringWithFormat:@"%@ - %@",startTime,endTime];
            float subtractValue = (endValue-startValue)/startValue*100;
            NSString *perMark = @"%";
            if (subtractValue >= 0) {
                valueString = [NSString stringWithFormat:@"▲%.1f（万元）  %.1f%@",subtractValue*startValue/100, subtractValue,perMark];
                //metricValue.textColor = [UIColor greenColor];
                [bar2 setImage:[UIImage imageNamed:@"graph2-bar-green"]];
                floatingView.image=[UIImage imageNamed:@"graph4-button-green"];
                //[floatingView setBackgroundColor:[UIColor darkGrayColor]];
                //floatingView.textColor = [UIColor greenColor];
            }
            else if (subtractValue < 0)
            {
                valueString = [NSString stringWithFormat:@"▼%.1f（万元）  %.1f%@",subtractValue*startValue/100,subtractValue,perMark];
                //metricValue.textColor = [UIColor redColor];
                [bar2 setImage:[UIImage imageNamed:@"graph2-bar-red"]];
                floatingView.image=[UIImage imageNamed:@"graph4-button-red"];
                //[floatingView setBackgroundColor:[UIColor darkGrayColor]];
                //floatingView.textColor = [UIColor redColor];
            }
            floatingView.hidden = NO;
//            [UIView animateWithDuration:1 animations:^(void)
//            {
//                floatingView.frame=CGRectMake(floatingView.frame.origin.x, floatingView.frame.origin.y, 200, floatingView.frame.size.height);
//            }];
            floatingView.center = CGPointMake((x2+x)/2, 20);
            
            
            UILabel *valueLabel=(UILabel*)[floatingView viewWithTag:11];
            valueLabel.text = [NSString stringWithFormat:@"%@",valueString];
            UILabel *dateLabel=(UILabel*)[floatingView viewWithTag:12];
            dateLabel.text = [NSString stringWithFormat:@"%@",dateString];

        }
    }
}
- (IBAction)backAction:(UIBarButtonItem *)sender {
    [self dismissModalViewControllerAnimated:YES];
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
    document=[documentService getDocumentWithDictionary:[dataSourceService getDocumentDictionaryMagazine:@"000000"]];

    NSMutableArray *reports=[NSMutableArray arrayWithObjects:[document.reports objectAtIndex:60],[document.reports objectAtIndex:61] ,nil];
    sections=[[NSMutableArray alloc]init];
    flag=0;
    for (int i=0;i<reports.count; i++) {
        NSMutableArray *models=[[NSMutableArray alloc]init];
        BAReport *report=[reports objectAtIndex:i];
        int dataCount=report.reportData.entity.entityValues.count;
        for (int j=0; j<dataCount; j++) {
            
            BFGraph2Model *model=[[BFGraph2Model alloc]init];
            BAMetric *metric1=[report.reportData.metrics objectAtIndex:0];
            NSNumber *sales=[metric1.dataValues objectAtIndex:j];
            BAMetric *metric2=[report.reportData.metrics objectAtIndex:1];
            NSNumber *salesTarget=[metric2.dataValues objectAtIndex:j];
            BAEntity *entity=report.reportData.entity;
            NSString *name=[entity.entityValues objectAtIndex:j];
            model.sales=sales;
            model.salesTarget=salesTarget;
            model.name=name;
            model.report=[document.reports objectAtIndex:62+flag];
            flag++;
            [models addObject:model];
        }
        [sections addObject:models];
    }
    curModel=[[sections objectAtIndex:0]objectAtIndex:0];
    [self renderGraph];
    [self renderSlider];
    //mySlider.frame=[self.view convertRect:graph.graph.plotAreaFrame.frame fromView:graph.graph.plotAreaFrame];
//    [mySlider setThumbImage:[UIImage imageNamed:@"thumb-normal2" ] forState:UIControlStateNormal];
//    [mySlider setThumbImage:[UIImage imageNamed:@"thumb-highlight2"] forState:UIControlStateHighlighted];
    
    
    tempX = 1;
    tempX2 = 1;
    touchView.delegate=self;
    floatingView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"graph2-button-lightblue"]];
    floatingView.tag=111;
    floatingView.frame = CGRectMake(0, 0, 180, 40);
    [floatingView setHidden:YES];
    UILabel *dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(floatingView.frame), CGRectGetHeight(floatingView.frame)/2)];
    dateLabel.tag=12;
    dateLabel.textAlignment=NSTextAlignmentCenter;
    dateLabel.backgroundColor=[UIColor clearColor];
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.font = [UIFont fontWithName:@"helvetica" size:14];
    [floatingView addSubview:dateLabel];
    UILabel *valueLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(floatingView.frame)/2, CGRectGetWidth(floatingView.frame), CGRectGetHeight(floatingView.frame)/2)];
    valueLabel.tag=11;
    valueLabel.textAlignment=NSTextAlignmentCenter;
    valueLabel.backgroundColor=[UIColor clearColor];
    valueLabel.textColor = [UIColor whiteColor];
    valueLabel.font = [UIFont fontWithName:@"helvetica" size:14];
    [floatingView addSubview:valueLabel];
    [touchView addSubview:floatingView];
    
    
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [myTableView setBackgroundView:[[UIView alloc] initWithFrame:CGRectZero]];
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
    [self setShadeView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}
-(BOOL)shouldAutorotate{
    return YES;
}
-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}

@end
