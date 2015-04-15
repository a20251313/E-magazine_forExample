//
//  BFPieViewController.m
//  E-magazine
//
//  Created by summer.zhu on 5/3/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "BFPieViewController.h"
#import "PieViewCell.h"
#import "BFGraph4LeftModel.h"
#import "Global.h"
#import "BFAppDelegate.h"

#define pieViewWidth 1024
#define maxShowPie 3//要为基数
#define removeBefore 0
#define removeAfter 1

@interface BFPieViewController()
- (void)initJSONData;
- (NSMutableArray *)getPieData:(NSInteger)iIndex;
- (void)reloadView:(NSInteger)iIndex;
- (void)reloadMonthSales:(NSInteger)iMonth;
- (NSString *)calcRate:(NSInteger)iMonth;
- (void)tableViewScrollToSelectedCell:(NSInteger)iCell;
- (void)drawPies:(NSInteger)iIndex;
@end

@implementation BFPieViewController
@synthesize document;
@synthesize pieView;

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
    // Do any additional setup after loading the view from its nib.
    iPieTag = 0;
    arrVisiablePie = [[NSMutableArray alloc] init];
    arrReusedPie = [[NSMutableArray alloc] init];
    [self initJSONData];
    [self initScrollPie:@"0"];
    scrollViewPie.contentSize = CGSizeMake(arrDataSource.count * pieViewWidth, 660);
    [scrollViewPie setBackgroundColor:[UIColor clearColor]];
    pageControl.numberOfPages = [arrDataSource count];
    
    [self reloadView:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initScrollPie:(NSString *)strIndex{
    NSInteger iIndex = [strIndex intValue];
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"PieChartRotationView" owner:self options:nil];
    PieChartRotationView *pie = [nibs objectAtIndex:0];
    pie.centerPoint = CGPointMake(256, 256);
    pie.fRadius = 256;
    pie.destPoint = CGPointMake(256, 0);
    NSMutableArray *arr = [self getPieData:iIndex];
    pie.dataSource = arr;
    pie.delegate = self;
    pie.frame = CGRectMake(pieViewWidth*iIndex+8, 136-64, 512, 512);
    pie.tag = iIndex;
    pie.bLarge = YES;
    [arrVisiablePie addObject:pie];
    [scrollViewPie addSubview:pie];
}

- (void)drawPies:(NSInteger)iIndex{
    if (arrReusedPie.count == 0) {
        NSString *str = [NSString stringWithFormat:@"%d", iIndex];
        [self initScrollPie:str];
        PieChartRotationView *pieVisiable = (PieChartRotationView *)[arrVisiablePie objectAtIndex:0];
        [arrReusedPie addObject:pieVisiable];
        [arrVisiablePie removeObject:pieVisiable];
    }else{
        //重用机制
        PieChartRotationView *pieReused = (PieChartRotationView *)[arrReusedPie objectAtIndex:0];
        [arrReusedPie removeObject:pieReused];
        PieChartRotationView *pieVisiable = (PieChartRotationView *)[arrVisiablePie objectAtIndex:0];
        [arrReusedPie addObject:pieVisiable];
        [arrVisiablePie removeObject:pieVisiable];
        [arrVisiablePie addObject:pieReused];
        
        pieReused.centerPoint = CGPointMake(256, 256);
        pieReused.fRadius = 256;
        pieReused.destPoint = CGPointMake(256, 0);
        NSMutableArray *arr = [self getPieData:iIndex];
        pieReused.dataSource = arr;
        pieReused.delegate = self;
        pieReused.frame = CGRectMake(pieViewWidth*iIndex+20, 136-64, 512, 512);
        pieReused.tag = iIndex;
        [scrollViewPie addSubview:pieReused];
    }
    self.pieView = (PieChartRotationView *)[arrVisiablePie lastObject];
}

- (NSMutableArray *)getPieData:(NSInteger)iIndex{
    BFGraph4LeftModel *model = (BFGraph4LeftModel *)[arrDataSource objectAtIndex:iIndex];
    NSMutableArray *arr = (NSMutableArray *)model.salesReport.reportData.metrics;
    BAMetric *metric = (BAMetric *)[arr objectAtIndex:0];
    return metric.dataValues;
}

- (IBAction)didPressedBtnBack{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)initJSONData{
    BADocumentService *documentService=[[BADocumentService alloc]init];
    BADataSourceService *dataSourceService=[[BADataSourceService alloc]init];
    document = [documentService getDocumentWithDictionary:[dataSourceService getDocumentDictionaryMagazine:@"000000"]];
    
    BFGraph4LeftModel *model2001=[[BFGraph4LeftModel alloc]initWithParams:@"手机" level:2   salesReport:[document.reports objectAtIndex:14] metricReport:[document.reports objectAtIndex:13] entityIndex:0];
    BFGraph4LeftModel *model2002=[[BFGraph4LeftModel alloc]initWithParams:@"MP3/MP4" level:2 salesReport:[document.reports objectAtIndex:16] metricReport:[document.reports objectAtIndex:15] entityIndex:0];
    BFGraph4LeftModel *model2003=[[BFGraph4LeftModel alloc]initWithParams:@"耳机" level:2 salesReport:[document.reports objectAtIndex:17] metricReport:[document.reports objectAtIndex:15] entityIndex:1];
    BFGraph4LeftModel *model2004=[[BFGraph4LeftModel alloc]initWithParams:@"零食" level:2 salesReport:[document.reports objectAtIndex:19] metricReport:[document.reports objectAtIndex:18] entityIndex:0];
    BFGraph4LeftModel *model2005=[[BFGraph4LeftModel alloc]initWithParams:@"酒精饮料" level:2 salesReport:[document.reports objectAtIndex:21] metricReport:[document.reports objectAtIndex:20] entityIndex:0];
    BFGraph4LeftModel *model2006=[[BFGraph4LeftModel alloc]initWithParams:@"软饮料" level:2 salesReport:[document.reports objectAtIndex:22] metricReport:[document.reports objectAtIndex:20] entityIndex:1];
    BFGraph4LeftModel *model2007=[[BFGraph4LeftModel alloc]initWithParams:@"衬衫" level:2 salesReport:[document.reports objectAtIndex:24] metricReport:[document.reports objectAtIndex:23] entityIndex:0];
    BFGraph4LeftModel *model2008=[[BFGraph4LeftModel alloc]initWithParams:@"西服" level:2 salesReport:[document.reports objectAtIndex:25] metricReport:[document.reports objectAtIndex:23] entityIndex:1];
    BFGraph4LeftModel *model2009=[[BFGraph4LeftModel alloc]initWithParams:@"针织衫" level:2 salesReport:[document.reports objectAtIndex:27] metricReport:[document.reports objectAtIndex:26] entityIndex:0];
    BFGraph4LeftModel *model2010=[[BFGraph4LeftModel alloc]initWithParams:@"裙子" level:2 salesReport:[document.reports objectAtIndex:28] metricReport:[document.reports objectAtIndex:26] entityIndex:1];
    BFGraph4LeftModel *model2011=[[BFGraph4LeftModel alloc]initWithParams:@"牛仔" level:2 salesReport:[document.reports objectAtIndex:29] metricReport:[document.reports objectAtIndex:26] entityIndex:2];
    
    arrDataSource = [[NSMutableArray alloc] initWithObjects:model2001, model2002, model2003, model2004, model2005, model2006, model2007, model2008, model2009, model2010, model2011, nil];
    
    [model2001 release];
    [model2002 release];
    [model2003 release];
    [model2004 release];
    [model2005 release];
    [model2006 release];
    [model2007 release];
    [model2008 release];
    [model2009 release];
    [model2010 release];
    [model2011 release];
    
    arrSelectedInPie = [[NSMutableArray alloc] init];
    for (int i=0; i<arrDataSource.count; i++) {
        [arrSelectedInPie addObject:@"0"];
    }
    [documentService release];
    [dataSourceService release];
}

#pragma mark - pieview delegate
- (void)endRotatePie:(id)sender{
    PieChartRotationView *pie = (PieChartRotationView *)sender;
    NSString *str = [NSString stringWithFormat:@"%d", pie.iCurrent];
    [arrSelectedInPie replaceObjectAtIndex:ICurrentSelectedPie withObject:str];
    [tableviewPie reloadData];
    
    //月份销售额信息
    NSString *strMonth = [arrSelectedInPie objectAtIndex:ICurrentSelectedPie];
    [self reloadMonthSales:[strMonth intValue]];
    
    [self tableViewScrollToSelectedCell:[strMonth intValue]];
}

//tableview自动滑动到选择的cell上
- (void)tableViewScrollToSelectedCell:(NSInteger)iCell{
    NSIndexPath *indexPathSelected = [NSIndexPath indexPathForRow:iCell inSection:0];
    CGRect rect = [tableviewPie rectForRowAtIndexPath:indexPathSelected];
    
    NSInteger iTotalRows = tableviewPie.frame.size.height/rect.size.height;
    NSInteger iRowRemainder = tableviewPie.frame.size.height - (iTotalRows*rect.size.height);
    
    if (rect.origin.y<=tableviewPie.contentOffset.y) {//在tableview的可视区域外
        tableviewPie.contentOffset = CGPointMake(0, iCell*rect.size.height);
    }else if (rect.origin.y-tableviewPie.contentOffset.y+rect.size.height>tableviewPie.frame.size.height){//在tableview的可视区域外
        tableviewPie.contentOffset = CGPointMake(0, (iCell-iTotalRows)*rect.size.height+iRowRemainder);
    }
}

#pragma mark - scrollview delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == scrollViewPie) {
        self.pieView  = nil;
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (scrollView == scrollViewPie) {
        self.pieView  = nil;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == scrollViewPie) {
        CGFloat xPosition = scrollView.contentOffset.x;
        NSInteger iScrollToPie = (xPosition+pieViewWidth/2)/pieViewWidth;
        
        if (iScrollToPie != iPieTag) {
            iPieTag = iScrollToPie;
            //保证创建一次
            [self drawPies:iPieTag];
            [self reloadView:iPieTag];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == scrollViewPie) {
        
        NSString *strMonth = [arrSelectedInPie objectAtIndex:ICurrentSelectedPie];
        [self reloadMonthSales:[strMonth intValue]];
        
        [self tableViewScrollToSelectedCell:[strMonth intValue]];
    } 
}

- (void)reloadView:(NSInteger)iIndex{
    ICurrentSelectedPie = iIndex;
    
    //pageControll
    [pageControl setCurrentPage:iIndex];
    
    BFGraph4LeftModel *model = (BFGraph4LeftModel *)[arrDataSource objectAtIndex:iIndex];
    
    //title
    lblTitle.text = model.desc;
    
    [tableviewPie reloadData];
    
    //月份销售额信息
    NSString *str = [arrSelectedInPie objectAtIndex:ICurrentSelectedPie];
    [self reloadMonthSales:[str intValue]];
}

#pragma mark - tableviewdelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BFGraph4LeftModel *model = (BFGraph4LeftModel *)[arrDataSource objectAtIndex:ICurrentSelectedPie];
    NSMutableArray *arr = (NSMutableArray *)model.salesReport.reportData.metrics;
    BAMetric *metric = (BAMetric *)[arr objectAtIndex:0];
    return metric.dataValues.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 72.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"PieViewCellIndentifier";
    PieViewCell *cell = (PieViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"PieViewCell" owner:self options:nil];
        for (id nib in nibs) {
            if ([nib isKindOfClass:[PieViewCell class]]) {
                cell = nib;
            }
        }
    }
    
    BFGraph4LeftModel *model = (BFGraph4LeftModel *)[arrDataSource objectAtIndex:ICurrentSelectedPie];
    
    NSMutableArray *arr = (NSMutableArray *)model.salesReport.reportData.metrics;
    BAMetric *metric = (BAMetric *)[arr objectAtIndex:0];
    NSNumber *number = [metric.dataValues objectAtIndex:indexPath.row];
    cell.strValue = [NSString stringWithFormat:@"%f", [number floatValue]];
    
    BAEntity *baEntity = model.salesReport.reportData.entity;
    NSMutableArray *arrNames = baEntity.entityValues;
    NSString *strName = [arrNames objectAtIndex:indexPath.row];
    cell.strType = strName;
    
    NSString *str = [arrSelectedInPie objectAtIndex:ICurrentSelectedPie];
    
    if (indexPath.row == [str intValue]) {
        cell.bSelected = YES;
    }else{
        cell.bSelected = NO;
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setBackgroundView:[[UIView alloc] initWithFrame:CGRectZero]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [NSString stringWithFormat:@"%d", indexPath.row];
    [arrSelectedInPie replaceObjectAtIndex:ICurrentSelectedPie withObject:str];
    [tableView reloadData];
    [self.pieView rotateToSector:indexPath.row];
    
    [self reloadMonthSales:indexPath.row];
}

- (void)reloadMonthSales:(NSInteger)iMonth{
    BFGraph4LeftModel *model = (BFGraph4LeftModel *)[arrDataSource objectAtIndex:ICurrentSelectedPie];
    BAEntity *baEntity = model.salesReport.reportData.entity;
    NSMutableArray *arrNames = baEntity.entityValues;
    NSString *strName = [arrNames objectAtIndex:iMonth];
    lblType.text = strName;
    
    NSMutableArray *arr = (NSMutableArray *)model.salesReport.reportData.metrics;
    BAMetric *metric = (BAMetric *)[arr objectAtIndex:0];
    NSNumber *number = [metric.dataValues objectAtIndex:iMonth];
    
    NSString *strRate = [self calcRate:iMonth];
    NSString *strContent = [NSString stringWithFormat:@"%@:%f", strRate, [number floatValue]];
    lblData.text = strContent;
}

- (NSString *)calcRate:(NSInteger)iMonth{
    BFGraph4LeftModel *model = (BFGraph4LeftModel *)[arrDataSource objectAtIndex:ICurrentSelectedPie];
    
    NSMutableArray *arr = (NSMutableArray *)model.salesReport.reportData.metrics;
    BAMetric *metric = (BAMetric *)[arr objectAtIndex:0];
    NSNumber *numberSel = [metric.dataValues objectAtIndex:iMonth];
    
    CGFloat fTotalSales = 0;
    for (int i=0; i<metric.dataValues.count; i++) {
        NSNumber *number = [metric.dataValues objectAtIndex:i];
        fTotalSales += [number floatValue];
    }
    
    CGFloat fRate = [numberSel floatValue]/fTotalSales;
    NSString *str = [NSString stringWithFormat:@"%f", fRate*100];
    if (str.length > 5) {
        str = [str substringToIndex:5];
    }
    NSString *strRate = [str stringByAppendingString:@"%"];
    return strRate;
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

- (void)dealloc{
    [tableviewPie release];
    [scrollViewPie release];
    [pageControl release];
    [lblTitle release];
    [lblType release];
    [lblData release];
    
    [arrDataSource release];
    [arrPies release];
    [arrSelectedInPie release];
    
    self.pieView = nil;
//    self.document = nil;
    [super dealloc];
}

@end
