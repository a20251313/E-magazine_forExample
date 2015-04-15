//
//  BATestViewController.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-11-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BFGraphViewController1.h"
#import "BADocumentButton.h"
#import "BAColorHelper.h"
#import "BADefinition.h"
#import "BATestCell.h"
#import "BAMixGraph2.h"

@interface BFGraphViewController1 ()

@end

@implementation BFGraphViewController1
{
    BADocument *document;
    BAMixGraph2 *graph;
    CGPoint originalPosition;
    BAReport *myReport;
    NSUInteger flag;
    //NSUInteger selectedButton;
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
    if (0<=selectedIndex&&selectedIndex<entity.entityValues.count) {
        entityName.text=[entity.entityValues objectAtIndex:selectedIndex];
    }
    
    if (0<=selectedIndex&&selectedIndex<metric.dataValues.count) {
        metricValue.text=[NSString stringWithFormat:@"%@", [metric.dataValues objectAtIndex:selectedIndex]];
    }else {
        metricValue.text=@"";
    }
    
}

-(void)renderGraph
{
    BAReport *report=[document.reports objectAtIndex:arc4random()%7];
    graph=[[BAMixGraph2 alloc]init];
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
                documentButton.selectedButtonIndex=i;
                UIImage *backImage=[UIImage imageNamed:@"test-button.png"];
                UIImage *linkImage=[UIImage imageNamed:@"test-button-link.png"];
                [documentButton setImage:backImage forState:UIControlStateNormal];
                [documentButton setImage:linkImage forState:UIControlStateHighlighted];
                if (i%2==0) {
                    documentButton.dataValue.textColor=[BAColorHelper stringToUIColor:@"f39121" alpha:@"1"]; 
                    documentButton.arrow.image=[UIImage imageNamed:@"arrow-orange.png"];
                }else {
                    documentButton.dataValue.textColor=[BAColorHelper stringToUIColor:@"8ac340" alpha:@"1"];
                    documentButton.arrow.image=[UIImage imageNamed:@"arrow-green.png"];
                }
                documentButton.metric.text=metric.metricName;
                documentButton.entity.text=[report.reportData.entity.entityValues objectAtIndex:i];
                documentButton.dataValue.text=dataValue.stringValue;
                
                //[documentButton addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
                [scrollView addSubview:documentButton];
            }
        }
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(backAction)];
    UIBarButtonItem *home=[[UIBarButtonItem alloc]initWithTitle:@"主页" style:UIBarButtonItemStylePlain target:self action:@selector(backHome)];
    [self navigationItem].leftBarButtonItems=[NSArray arrayWithObjects:home,back, nil];

    UIBarButtonItem *next=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextController)];
    [self navigationItem].rightBarButtonItem=next;

//scrollView.contentSize=CGSizeMake(211*8, 138);
    scrollView.contentSize=CGSizeMake(211*(dataCount*report.reportData.metrics.count+1), 138);
    [self renderGraph];
    //mySlider.frame=[self.view convertRect:graph.graph.plotAreaFrame.frame fromView:graph.graph.plotAreaFrame];
    [mySlider setThumbImage:[UIImage imageNamed:@"thumb-normal" ] forState:UIControlStateNormal];
    [mySlider setThumbImage:[UIImage imageNamed:@"thumb-highlight"] forState:UIControlStateHighlighted];
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
    //int index=sender.selectedButtonIndex;
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
    BAEntity *entity=myReport.reportData.entity;
    BATestCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];    
    if (cell==nil) {
        cell=(BATestCell*)[[[NSBundle mainBundle]loadNibNamed:@"BATestCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.row%2==0) {
        cell.bgView.backgroundColor=[BAColorHelper stringToUIColor:@"1b1b1b" alpha:@"1"]; 
    }else {
        cell.bgView.backgroundColor=[BAColorHelper stringToUIColor:@"202020" alpha:@"1"]; 
    }
    if (indexPath.row<metric.dataValues.count) {
        cell.name.text=metric.metricName;
        cell.entity.text=[entity.entityValues objectAtIndex:indexPath.row];
        NSDecimalNumber *value=[metric.dataValues objectAtIndex:indexPath.row];
        cell.value.text=[NSString stringWithFormat:@"%@",value ];

        
        CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];   
        CGRect frame=cell.bar.bounds;
        float width=[value doubleValue]/120*frame.size.width;
        frame.size.width=width;
        float temp=[value doubleValue]* (((arc4random()%7)+5)/10.0);
        float location=temp/120*frame.size.width;
        CGRect flagFrame=cell.flag.frame;
        flagFrame.origin.x=location+cell.bar.frame.origin.x;
        cell.flag.frame=flagFrame;
        
        newShadow.frame = frame;
        if (width>location) {
            newShadow.colors = [NSArray arrayWithObjects:(id)[BAColorHelper stringToUIColor:@"536f1d" alpha:@"1"].CGColor,(id)[BAColorHelper stringToUIColor:@"a9d447" alpha:@"1"].CGColor,nil]; 
        }else
        {
            newShadow.colors = [NSArray arrayWithObjects:(id)[BAColorHelper stringToUIColor:@"ff0000" alpha:@"1"].CGColor,(id)[BAColorHelper stringToUIColor:@"ffffff" alpha:@"1"].CGColor,nil]; 
        }
        
        [cell.bar.layer addSublayer:newShadow]; 
    }else {
        cell.flag.alpha=0;
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
