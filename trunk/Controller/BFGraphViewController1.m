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
#import "BFGraph1Model.h"
#import "BFAppDelegate.h"
#import "Global.h"
@interface BFGraphViewController1 ()

@end

@implementation BFGraphViewController1
{
    BADocument *document;
    BAMixGraph2 *graph;
    CGPoint originalPosition;
    BAReport *myReport;
    NSUInteger flag;
    BFGraph1Model *curModel;
    NSUInteger curRect;
    NSUInteger curIndex;
    NSMutableArray *models;
    NSArray *productNameArray;
    NSMutableArray *rects;
    NSMutableArray *tableCellValues;
    //NSUInteger selectedButton;
}
@synthesize scrollView;
@synthesize hostView;
@synthesize host;
@synthesize myTableView;
@synthesize curValueLabel;
@synthesize compareValueLabel;
@synthesize diversityValueLabel;
@synthesize diversityRatioLabel;
@synthesize mySlider;
@synthesize bar;
@synthesize curItemLabel;
@synthesize compareItemLabel;
@synthesize productNameLabel;
@synthesize rectNameLabel;
@synthesize button;
#pragma mark - custom method
-(void)reloadDocument//4
{
    [self reloadTableCells];
    [self reloadRects];
    [self renderGraph];
    [self reloadItems];
}
-(void)reloadTableCells
{
    //NSMutableArray *cellValues=[[NSMutableArray alloc]init];
    tableCellValues=[[NSMutableArray alloc]init];
    for (int i=0; i<models.count; i++) {
        BFGraph1Model *model=[models objectAtIndex:i];
        BAReport *report=[model.reports objectAtIndex:curRect];
        NSMutableArray *values;
        if (curRect==0||curRect==3||curRect==5) {
            BAMetric *metric=[report.reportData.metrics objectAtIndex:0];
            double curValue=[[metric.dataValues objectAtIndex:curIndex]doubleValue];
            NSString *curString=[NSString stringWithFormat:@"%.1f",curValue];
            NSString *preString;
            NSString *colorString;
            
            if (0<curIndex) {
                double preValue=[[metric.dataValues objectAtIndex:curIndex-1]doubleValue];
                preString=[NSString stringWithFormat:@"%.1f",preValue];
                double diversityValue=curValue-preValue;
                if (diversityValue>0) {
                    colorString=@"00ff00";
                }else{
                    colorString=@"ff0000";
                }
            }else
            {
                preString=@"-";
                colorString=@"00ff00";
            }
            values=[NSArray arrayWithObjects:preString,curString,colorString, nil];
            
        }else
        {
            BAMetric *metric1=[report.reportData.metrics objectAtIndex:0];
            BAMetric *metric2=[report.reportData.metrics objectAtIndex:1];
            double curValue=[[metric1.dataValues objectAtIndex:curIndex] doubleValue];
            double compareValue=[[metric2.dataValues objectAtIndex:curIndex]doubleValue];
            double diversityValue=curValue-compareValue;
            NSString *curString=[NSString stringWithFormat:@"%.1f",curValue];
            NSString *compareValueString=[NSString stringWithFormat:@"%.1f",compareValue];
            NSString *colorString;
            if (diversityValue>0) {
                colorString=@"00ff00";
            }else{
                colorString=@"ff0000";
            }
            values=[NSArray arrayWithObjects:compareValueString,curString,colorString, nil];
        }
        //[cellValues addObject:values];
        [tableCellValues addObject:values];
    }
    //tableCellValues=[NSMutableArray arrayWithArray:cellValues];
    [myTableView reloadData];
}
-(void)reloadLabels
{
    BAReport *report=[curModel.reports objectAtIndex:curRect];
    if (curRect==0||curRect==3||curRect==5) {
        BAMetric *metric=[report.reportData.metrics objectAtIndex:0];
        double curValue=[[metric.dataValues objectAtIndex:curIndex] doubleValue];
        if (0<curIndex) {
            double preValue=[[metric.dataValues objectAtIndex:curIndex-1] doubleValue];
            compareValueLabel.text=[NSString stringWithFormat:@"%.1f", preValue];
            double diversityValue=curValue-preValue;
            double diversityRatio=diversityValue/curValue;
            if (diversityValue>=0) {
                diversityValueLabel.textColor=[UIColor greenColor];
                diversityRatioLabel.textColor=[UIColor greenColor];
                graph->isPositive=YES;
            }else
            {
                diversityValueLabel.textColor=[UIColor redColor];
                diversityRatioLabel.textColor=[UIColor redColor];
                graph->isPositive=NO;
            }
            diversityValueLabel.text=[NSString stringWithFormat:@"%.1f", diversityValue];
            
            diversityRatioLabel.text=[NSString stringWithFormat:@"%.1f%%", diversityRatio*100];
        }else
        {
            diversityValueLabel.textColor=[UIColor whiteColor];
            diversityRatioLabel.textColor=[UIColor whiteColor];
            diversityValueLabel.text=@"-";
            diversityRatioLabel.text=@"-";
        }
        curValueLabel.text=[NSString stringWithFormat:@"%.1f", curValue];
    }else
    {
        BAMetric *metric1=[report.reportData.metrics objectAtIndex:0];
        BAMetric *metric2=[report.reportData.metrics objectAtIndex:1];
        double curValue=[[metric1.dataValues objectAtIndex:curIndex] doubleValue];

        double compareValue=[[metric2.dataValues objectAtIndex:curIndex] doubleValue];
        compareValueLabel.text=[NSString stringWithFormat:@"%.1f", compareValue];
        double diversityValue=curValue-compareValue;
        double diversityRatio=diversityValue/curValue;
        if (diversityValue>=0) {
            diversityValueLabel.textColor=[UIColor greenColor];
            diversityRatioLabel.textColor=[UIColor greenColor];
            graph->isPositive=YES;
        }else
        {
            diversityValueLabel.textColor=[UIColor redColor];
            diversityRatioLabel.textColor=[UIColor redColor];
            graph->isPositive=NO;
        }
        diversityValueLabel.text=[NSString stringWithFormat:@"%.1f", diversityValue];
        
        diversityRatioLabel.text=[NSString stringWithFormat:@"%.1f%%", diversityRatio*100];

        curValueLabel.text=[NSString stringWithFormat:@"%.1f", curValue];
    }
}
-(void)reloadRects
{
    for (int i=0; i<6; i++) {
        BADocumentButton *rect=[rects objectAtIndex:i];
        BAReport *report=[curModel.reports objectAtIndex:i];
        if (i==0||i==3||i==5) {
            BAMetric *metric=[report.reportData.metrics objectAtIndex:0];
                double curValue=[[metric.dataValues objectAtIndex:curIndex] doubleValue];
            if (curIndex>0) {
                double preValue=[[metric.dataValues objectAtIndex:curIndex-1] doubleValue];
                
                rect.dataValue.text=[NSString stringWithFormat:@"%.1f",preValue];
                double diversityValue=curValue-preValue;
                if (diversityValue>=0) {
                    rect.arrow.image=[UIImage imageNamed:@"arrow-up01"];
                    rect.dataValue.textColor=[UIColor greenColor];
                    rect.ratioLebel.textColor=[UIColor greenColor];
                }else
                {
                    rect.arrow.image=[UIImage imageNamed:@"arrow-down01"];
                    rect.dataValue.textColor=[UIColor redColor];
                    rect.ratioLebel.textColor=[UIColor redColor];
                }
                rect.ratioLebel.text=[NSString stringWithFormat:@"%.1f%%",diversityValue/curValue*100];
            }else
            {
                
            }
            rect.entity.text=[NSString stringWithFormat:@"%.1f",curValue];
        }else
        {
            BAMetric *metric1=[report.reportData.metrics objectAtIndex:0];
            double curValue=[[metric1.dataValues objectAtIndex:curIndex] doubleValue];
            BAMetric *metric2=[report.reportData.metrics objectAtIndex:1];
            double compareValue=[[metric2.dataValues objectAtIndex:curIndex] doubleValue];
            rect.entity.text=[NSString stringWithFormat:@"%.1f",curValue];
            rect.dataValue.text=[NSString stringWithFormat:@"%.1f",compareValue];
            double diversityValue=curValue-compareValue;
            if (diversityValue>=0) {
                rect.arrow.image=[UIImage imageNamed:@"arrow-up01"];
                rect.dataValue.textColor=[UIColor greenColor];
                rect.ratioLebel.textColor=[UIColor greenColor];
            }else
            {
                rect.arrow.image=[UIImage imageNamed:@"arrow-down01"];
                rect.dataValue.textColor=[UIColor redColor];
                rect.ratioLebel.textColor=[UIColor redColor];
            }
            rect.ratioLebel.text=[NSString stringWithFormat:@"%.1f%%",diversityValue/curValue*100];
            
        }
    }
}
-(void)reloadItems
{
    productNameLabel.text=curModel.name;
    productNameLabel.frame = CGRectMake(20, 42+IOS7DISTANCE,265,39);
    rectNameLabel.frame = CGRectMake(288, 55+IOS7DISTANCE,125,19);
    switch (curRect) {
        case 0:
        {
            curItemLabel.text=@"当月销量";
            compareItemLabel.text=@"上月销量";
            rectNameLabel.text=@"销量";
        }
            break;
        case 1:
        {
            curItemLabel.text=@"当前销量";
            compareItemLabel.text=@"目标销量";
            rectNameLabel.text=@"销量达成";
        }
            break;
        case 2:
        {
            curItemLabel.text=@"当年销量";
            compareItemLabel.text=@"去年销量";
            rectNameLabel.text=@"销量环比";
        }
            break;
        case 3:
        {
            curItemLabel.text=@"当月利润率";
            compareItemLabel.text=@"上月利润率";
            rectNameLabel.text=@"利润率";
        }
            break;
        case 4:
        {
            curItemLabel.text=@"当前利润率";
            compareItemLabel.text=@"目标利润率";
            rectNameLabel.text=@"利润率达成";
        }
            break;
        case 5:
        {
            curItemLabel.text=@"当前市场占有率";
            compareItemLabel.text=@"目标市场占有率";
            rectNameLabel.text=@"市场占有率";
        }
            break;
        default:
        {
            curItemLabel.text=@"";
            compareItemLabel.text=@"";
        }
            break;
    }
}
-(void)selectRect:(BADocumentButton*)sender
{
    curRect=sender.selectedButtonIndex;
    for (id view in sender.superview.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *but=(UIButton*)view;
            [but setHighlighted:NO];
        }
    }
    [self performSelector:@selector(highlightButton:) withObject:sender afterDelay:0.0];
    [self reloadDocument];
    //[sender setHighlighted:YES];
}
-(void)highlightButton:(UIButton*)sender
{
    [sender setHighlighted:YES];
    
}
- (IBAction)sliderAction:(UISlider *)sender {
    [self reloadTableCells];
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
    //NSLog(@"%f----%d",[x doubleValue],[y intValue]);
    int selectedIndex=round([x doubleValue])-2; //[x intValue]-2;
    if (selectedIndex<0) {
        selectedIndex=0;
        
    }else if (selectedIndex>11)
    {
        selectedIndex=11;
    }
    //NSLog(@"%d",selectedIndex);
    curIndex=selectedIndex;
    if (graph->selectedIndex!=selectedIndex) {

        [self reloadLabels];
        [self reloadRects];
        [self reloadTableCells];
        graph->selectedIndex=selectedIndex;
        [graph.graph reloadData];
        
    }
    
    //curIndex=selectedIndex;
    
}

-(void)renderGraph
{
    graph=[[BAMixGraph2 alloc]init];

    [graph configurePlots:[curModel.reports objectAtIndex:curRect]];
    
    [graph renderInHostView:[self hostView]];
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
    //int index=sender.selectedButtonIndex;
    [self renderGraph];
    originalPosition=host.center;

    CGPoint point=[self.view convertPoint:sender.center fromView:scrollView];
    host.center=point;
    CGAffineTransform newTransform = CGAffineTransformMakeScale( 0 , 0);
    [host setTransform :newTransform];
    mySlider.alpha=0;
    bar.alpha=0;
    curValueLabel.alpha=0;
    compareValueLabel.alpha=0;
    diversityValueLabel.alpha=0;
    [UIView animateWithDuration:0.5 animations:^
    {
        
        host.center=CGPointMake(originalPosition.x,originalPosition.y);
        CGAffineTransform newTransform = CGAffineTransformMakeScale( 1 ,1);
        [host setTransform :newTransform];
        
    }completion:^(BOOL finished)
     {
         mySlider.alpha=1;
         bar.alpha=1;
         curValueLabel.alpha=1;
         compareValueLabel.alpha=1;
         diversityValueLabel.alpha=1;
     }];
}
- (IBAction)backAction:(UIBarButtonItem *)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark - tableview delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [tableView setTableFooterView:v];
    BATestCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];    
    if (cell==nil) {
        cell=(BATestCell*)[[[NSBundle mainBundle]loadNibNamed:@"BATestCell" owner:self options:nil]lastObject];
    }
    //cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.selectedBackgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"table-selected"]];
//    UIView *view=[[UIView alloc]initWithFrame:cell.bounds];
//    cell.backgroundView=view;
//    if (indexPath.row%2==0) {
//        cell.backgroundView.backgroundColor=[BAColorHelper stringToUIColor:@"1b1b1b" alpha:@"1"];
//    }else {
//        cell.backgroundView.backgroundColor=[BAColorHelper stringToUIColor:@"202020" alpha:@"1"];
//    }
    
    [cell setBackgroundView:[[UIView alloc] initWithFrame:CGRectZero]];
    [cell setBackgroundColor:[UIColor clearColor]];

    if (indexPath.row<productNameArray.count) {

        cell.name.text=[productNameArray objectAtIndex:indexPath.row];

        cell.entity.text=[[tableCellValues objectAtIndex:indexPath.row] objectAtIndex:0];
        cell.value.text=[[tableCellValues objectAtIndex:indexPath.row] objectAtIndex:1];
        cell.value.textColor=[BAColorHelper stringToUIColor:[[tableCellValues objectAtIndex:indexPath.row] objectAtIndex:2] alpha:@"1"];
    }else {
        cell.entity.text=nil;
        cell.value.text=nil;
        cell.name.text=nil;
    }
    
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    //NSUInteger extra=(int) tableView.frame.size.height/40;
    return 5;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    curModel=[models objectAtIndex:indexPath.row];
    [self renderGraph];
    [self reloadRects];
    [self reloadItems];
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//#pragma mark - scrollview delegate
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGPoint contentOffsetPoint = myTableView.contentOffset;
//    NSUInteger index=contentOffsetPoint.y/40;
//    if (flag!=index) {
//        
//        flag=index;
//    }
//}
//
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    CGPoint contentOffsetPoint = myTableView.contentOffset;
//    NSUInteger index=nearbyintf(contentOffsetPoint.y/40);
//    if (index>=models.count) {
//        index=models.count-1;
//    }
//    contentOffsetPoint.y=index*40;
//
//    [myTableView setContentOffset:contentOffsetPoint animated:YES];
//
//    curModel=[models objectAtIndex:index];
//    [self reloadDocument];
//}
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if (decelerate) {
//        return;
//    }else
//    {
//        CGPoint contentOffsetPoint = myTableView.contentOffset;
//        NSUInteger index=nearbyintf(contentOffsetPoint.y/40);
//        if (index>=models.count) {
//            index=models.count-1;
//        }
//        contentOffsetPoint.y=index*40;
//        
//        [myTableView setContentOffset:contentOffsetPoint animated:YES];
//        curModel=[models objectAtIndex:index];
//        [self reloadDocument];
//    }
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


#pragma mark - system method
- (void)viewDidLoad
{
    [super viewDidLoad];
    BADocumentService *documentService=[[BADocumentService alloc]init];
    BADataSourceService *dataSourceService=[[BADataSourceService alloc]init];
    //从数据源获取document
    document = [documentService getDocumentWithDictionary:[dataSourceService getDocumentDictionaryMagazine:@"000000"]];
    productNameArray=[NSArray arrayWithObjects:@"欣百达  Cymbalta",@"力比泰  Alimta",@"希爱力  Cialis",@"优泌乐  Humalog",@"健择  Gemzar",nil];
    models=[[NSMutableArray alloc]initWithCapacity:5];
    for (int i=0; i<5; i++) {
        NSMutableArray *productReports=[[NSMutableArray alloc]initWithCapacity:6];
        for (int j=0; j<6;j++) {
            [productReports addObject:[document.reports objectAtIndex:30+i*6+j]];
        }
        BFGraph1Model *model=[[BFGraph1Model alloc] initWithReports:productReports];
        model.name=[productNameArray objectAtIndex:i];
        [models addObject:model];
    }
    
    curModel=[models objectAtIndex:0];
    curRect=0;
    curIndex=0;
    
    NSArray *nameArray=[NSArray arrayWithObjects:@"销量",@"销量达成",@"销量同比",@"利润率",@"利润率达成",@"市场占有率",nil];
    rects=[[NSMutableArray alloc] init];
    scrollView.layer.masksToBounds=NO;
    for (int i=0; i<6;i++) {
        BADocumentButton *documentButton=[[[NSBundle mainBundle] loadNibNamed:@"documentButton" owner:self options:nil]lastObject];
        if (i==0) {
            [documentButton setHighlighted:YES];
        }
        //documentButton.selectedButtonIndex=i;
        documentButton.frame=CGRectMake((211+10)*i, 2, 211, 158);
        [documentButton addTarget:self action:@selector(showGraph:) forControlEvents:UIControlEventTouchUpInside];
        documentButton.selectedButtonIndex=i;
        UIImage *backImage=[UIImage imageNamed:@"btn01"];
        UIImage *linkImage=[UIImage imageNamed:@"btn-selected01"];
        [documentButton setImage:backImage forState:UIControlStateNormal];
        [documentButton setImage:linkImage forState:UIControlStateHighlighted];
        
       
//        if (i%2==0) {
//            documentButton.dataValue.textColor=[BAColorHelper stringToUIColor:@"f39121" alpha:@"1"];
//            documentButton.arrow.image=[UIImage imageNamed:@"arrow-up01"];
//        }else {
//            documentButton.dataValue.textColor=[BAColorHelper stringToUIColor:@"8ac340" alpha:@"1"];
//            documentButton.arrow.image=[UIImage imageNamed:@"arrow-down01"];
//        }
        documentButton.metric.text=[nameArray objectAtIndex:i];
        //documentButton.entity.text=[nameArray objectAtIndex:i];
        //documentButton.dataValue.text=dataValue.stringValue;
        
        [documentButton addTarget:self action:@selector(selectRect:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:documentButton];
        [rects addObject:documentButton];
    }
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(backAction)];
    UIBarButtonItem *home=[[UIBarButtonItem alloc]initWithTitle:@"主页" style:UIBarButtonItemStylePlain target:self action:@selector(backHome)];
    [self navigationItem].leftBarButtonItems=[NSArray arrayWithObjects:home,back, nil];
    
    UIBarButtonItem *next=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextController)];
    [self navigationItem].rightBarButtonItem=next;
    
    //scrollView.contentSize=CGSizeMake(211*8, 138);
    scrollView.contentSize=CGSizeMake(221*6, 138);
    //[self renderGraph];
    //mySlider.frame=[self.view convertRect:graph.graph.plotAreaFrame.frame fromView:graph.graph.plotAreaFrame];
//    mySlider.minimumTrackTintColor=[BAColorHelper stringToUIColor:@"162841" alpha:@"1"];
//    mySlider.maximumTrackTintColor=[BAColorHelper stringToUIColor:@"162841" alpha:@"1"];
    [mySlider setThumbImage:[UIImage imageNamed:@"graph1-thumb" ] forState:UIControlStateNormal];
    [mySlider setThumbImage:[UIImage imageNamed:@"graph1-thumb-selected"] forState:UIControlStateHighlighted];
    
    [self reloadDocument];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
 
    }
    return self;
}
- (void)viewDidUnload
{
//    [self setDocument:nil];
    [self setScrollView:nil];
    [self setHostView:nil];
    [self setHost:nil];
    [self setMyTableView:nil];
    [self setCurValueLabel:nil];
    [self setCompareValueLabel:nil];
    [self setDiversityValueLabel:nil];
    [self setDiversityRatioLabel:nil];
    [self setMySlider:nil];
    [self setBar:nil];
    [self setCurItemLabel:nil];
    [self setCompareItemLabel:nil];
    [self setProductNameLabel:nil];
    [self setRectNameLabel:nil];
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
