//
//  BFMiniPieView.m
//  E-magazine
//
//  Created by summer.zhu on 5/31/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "BFMiniPieView.h"
#import "BFGraph4LeftModel.h"

@implementation BFMiniPieView
@synthesize document;
@synthesize delegate;
@synthesize pieViewSelected;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    iPieTag = 0;
    arrVisiablePie = [[NSMutableArray alloc] init];
    arrReusedPie = [[NSMutableArray alloc] init];
    
    [self initJSONData];
    scrollViewPie.contentSize = CGSizeMake(arrDataSource.count * self.frame.size.width, 330);
    pageControlPie.numberOfPages = arrDataSource.count;
    [self initScrollPie:@"0"];
    [self reloadMonthSales:0];
}

- (IBAction)didPressedBtnAllScreen:(id)sender{
    if ([self.delegate respondsToSelector:@selector(showAllScreen)]) {
        [self.delegate showAllScreen];
    }
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

- (void)initScrollPie:(NSString *)strIndex{
    NSInteger iIndex = [strIndex intValue];
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"PieChartRotationView" owner:self options:nil];
    PieChartRotationView *pie = [nibs objectAtIndex:0];
    pie.centerPoint = CGPointMake(128, 128);
    pie.fRadius = 128;
    pie.destPoint = CGPointMake(128, 0);
    NSMutableArray *arr = [self getPieData:iIndex];
    pie.dataSource = arr;
    pie.delegate = self;
    pie.frame = CGRectMake(self.frame.size.width*iIndex+(self.frame.size.width-272)/2, 0, 272, 272);
    pie.tag = iIndex;
    pie.bLarge = NO;
    [arrVisiablePie addObject:pie];
    [scrollViewPie addSubview:pie];
}

- (NSMutableArray *)getPieData:(NSInteger)iIndex{
    BFGraph4LeftModel *model = (BFGraph4LeftModel *)[arrDataSource objectAtIndex:iIndex];
    NSMutableArray *arr = (NSMutableArray *)model.salesReport.reportData.metrics;
    BAMetric *metric = (BAMetric *)[arr objectAtIndex:0];
    return metric.dataValues;
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
        
        pieReused.centerPoint = CGPointMake(128, 128);
        pieReused.fRadius = 128;
        pieReused.destPoint = CGPointMake(128, 0);
        NSMutableArray *arr = [self getPieData:iIndex];
        pieReused.dataSource = arr;
        pieReused.delegate = self;
        pieReused.frame = CGRectMake(self.frame.size.width*iIndex+(self.frame.size.width-272)/2, 0, 272, 272);
        pieReused.tag = iIndex;
        [scrollViewPie addSubview:pieReused];
    }
    self.pieViewSelected = (PieChartRotationView *)[arrVisiablePie lastObject];
}

- (void)reloadView:(NSInteger)iIndex{
    
    //pageControll
    [pageControlPie setCurrentPage:iIndex];
    
    BFGraph4LeftModel *model = (BFGraph4LeftModel *)[arrDataSource objectAtIndex:iIndex];
    
    //title
    lblTitle.text = model.desc;
    
    NSString *str = [arrSelectedInPie objectAtIndex:iPieTag];
    [self reloadMonthSales:[str intValue]];

}

//更新类型和数据
- (void)reloadMonthSales:(NSInteger)iMonth{
    BFGraph4LeftModel *model = (BFGraph4LeftModel *)[arrDataSource objectAtIndex:iPieTag];
    lblTitle.text = model.desc;
    
    NSMutableArray *arr = (NSMutableArray *)model.salesReport.reportData.metrics;
    BAMetric *metric = (BAMetric *)[arr objectAtIndex:0];
    NSNumber *number = [metric.dataValues objectAtIndex:iMonth];
    
    NSString *strContent = [NSString stringWithFormat:@"%f", [number floatValue]];
    lblData.text = strContent;
}

#pragma mark - scroll delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == scrollViewPie) {
        self.pieViewSelected  = nil;
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (scrollView == scrollViewPie) {
        self.pieViewSelected  = nil;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == scrollViewPie) {
        CGFloat xPosition = scrollView.contentOffset.x;
        NSInteger iScrollToPie = (xPosition+self.frame.size.width/2)/self.frame.size.width;
        
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
    }
}


#pragma mark - pieview delegate
- (void)endRotatePie:(id)sender{
    PieChartRotationView *pie = (PieChartRotationView *)sender;
    NSNumber *number = [pie.dataSource objectAtIndex:pie.iCurrent];
    lblData.text = [NSString stringWithFormat:@"%@", number];
}

- (void)dealloc{
    [lblTitle release];
    [lblData release];
    [arrDataSource release];
    [arrSelectedInPie release];
    [scrollViewPie release];
    [pageControlPie release];
    [super dealloc];
}

@end
