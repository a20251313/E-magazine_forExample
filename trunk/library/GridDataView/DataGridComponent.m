//
//  DataGridComponent.m
//
//  Created by lee jory on 09-10-22.
//  Copyright 2009 Netgen. All rights reserved.
//

#import "DataGridComponent.h"
#import "BAReport.h"
#import "BAMetric.h"
#import <QuartzCore/QuartzCore.h>
#import "UIUnderlineLabel.h"

@implementation DataGridScrollView
@synthesize dataGridComponent;
@synthesize selfdelegate;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *t = [touches anyObject];
	if([t tapCount] == 1){
		DataGridComponent *d = (DataGridComponent*)dataGridComponent;
		int idx = [t locationInView:self].y / d.cellHeight;
        
        //添加protocol响应
        if (selfdelegate && [selfdelegate respondsToSelector:@selector(onPressFromIndexAtRow:dataComponent:)]) {
            [selfdelegate onPressFromIndexAtRow:idx dataComponent:dataGridComponent];
        }
        
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.65];
		for(int i=0;i<[d.dataSource.titles count];i++){
			UILabel *l = (UILabel*)[dataGridComponent viewWithTag:idx * d.cellHeight + i + 1000];
			l.alpha = .5;
		}
		for(int i=0;i<[d.dataSource.titles count];i++){
			UILabel *l = (UILabel*)[dataGridComponent viewWithTag:idx * d.cellHeight + i + 1000];
			l.alpha = 1.0;
		}		
		[UIView commitAnimations];
        
        
        
	}
}

@end

@implementation DataGridComponentDataSource
@synthesize titles,data,columnWidth, cellHeight, dontChange;

- (id)init
{
    self = [super init];
    if (self) {
        dontChange = NO;
    }
    return self;
}

+(id)initDataSourceWithReport:(BAReport*)report totalWidth:(float)width avlWidth:(BOOL)avl arg:(NSString*)cellWidth titleName:(NSString*)title needInvert:(BOOL)isInvert;
{
    DataGridComponentDataSource* instance = [[[DataGridComponentDataSource alloc] init] autorelease];
    
    //获取报表数据
    NSMutableDictionary *sourceData=[[[NSMutableDictionary alloc]init]autorelease];
    for(BAMetric *metric in report.reportData.metrics){
        [sourceData setObject:metric.dataValues forKey:metric.metricName];
    }
    
    NSMutableArray* sourceDataKey = [[[NSMutableArray alloc] init] autorelease];
    
    for(BAMetric *metric in report.reportData.metrics){
        [sourceDataKey addObject:metric.metricName];
    }
    //获取报表label
    NSMutableArray *sourceLabel=report.reportData.entity.entityValues;
    
    instance.columnWidth=[[[NSMutableArray alloc]initWithObjects:nil] autorelease];
    
    NSMutableArray* titles, *detailData, *keys;
    int columns = 0;
    
    if (!isInvert) {
        //不需要做转置处理
        titles = [[[NSMutableArray alloc] initWithArray:sourceLabel] autorelease];
        [titles insertObject:title atIndex:0];
        detailData = [[[NSMutableArray alloc] init] autorelease];
        
        keys=sourceDataKey;
        
        for (int i = 0; i < [keys count]; i++) {
            NSString* keyValue = [keys objectAtIndex:i];
            NSMutableArray* rowData = [[[NSMutableArray alloc] initWithArray: [sourceData objectForKey:keyValue]] autorelease];
            [rowData insertObject:keyValue atIndex:0];
            [detailData addObject:rowData];
            columns = [rowData count];
            
        }
        
    }
    else{
        titles = sourceDataKey;
        [titles insertObject:title atIndex:0];
        detailData = [[[NSMutableArray alloc] init] autorelease];
        
        keys = [[[NSMutableArray alloc] initWithArray:sourceLabel] autorelease];
        
        for (int i = 0; i < [keys count]; i++) {
            NSMutableArray* rowData = [[[NSMutableArray alloc] init] autorelease];
            
            for (int j = 1; j < [titles count]; j++) {
                NSString* keyValue = [titles objectAtIndex:j];
                NSMutableArray* wholeData = [[[NSMutableArray alloc] initWithArray: [sourceData objectForKey:keyValue]] autorelease];
                
                [rowData addObject:[wholeData objectAtIndex:i]];
            }
            
            [rowData insertObject:[keys objectAtIndex:i] atIndex:0];
            
            columns = [rowData count];
            
            [detailData addObject:rowData];
            
        }
    
    }
    
    
    
    //columns width
    float leftAnno = 0.0f;
    float otherAnno = 0.0f;
    for (int j = 0; j < columns; j++) {
        if (!avl && cellWidth == nil) {
            if (j == 0) {
                NSString* str = [[[detailData objectAtIndex:0] objectAtIndex:0] description];
                CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:20.0]];
                leftAnno = size.width;
                
                otherAnno = (width - leftAnno) / (columns-1);
                [instance.columnWidth addObject:[NSString stringWithFormat:@"%f", leftAnno]];
            }
            else {
                [instance.columnWidth addObject:[NSString stringWithFormat:@"%f", otherAnno]];
            }
        }
        else {
            if (j == 0) {
                [instance.columnWidth addObject:cellWidth];
                
                leftAnno = [cellWidth floatValue];
                
                otherAnno = (width - leftAnno) / (columns-1);
            }
            else {
                [instance.columnWidth addObject:[NSString stringWithFormat:@"%f", otherAnno]];
            }
            
        }
    }
    
    instance.titles = titles;
    instance.data = detailData;
    instance.dontChange = NO;
    
    return instance;
}

+(id)initDataSourceWithTitles:(NSArray*)titlesdata andSingleLineData:(NSArray*)dataValue totalWidth:(float)totalwidth
{
    DataGridComponentDataSource* instance = [[[DataGridComponentDataSource alloc] init] autorelease];
    
    //todo:titles， datas， columnWidth
    NSArray* tempTitles = [[[NSArray alloc] initWithArray:titlesdata] autorelease];
    NSArray* tempDatas = [[[NSArray alloc] initWithArray:[dataValue objectAtIndex:0]] autorelease];
    
    int counts = MIN([tempDatas count], [tempTitles count]);
    NSMutableArray* tempColums = [[[NSMutableArray alloc] init] autorelease];
    for (NSString* str in tempTitles) {
        float width = [str sizeWithFont:[UIFont boldSystemFontOfSize:20]].width;
        [tempColums addObject:[NSString stringWithFormat:@"%f", width]];
    }
    
    //need totol width
    float calWidth = totalwidth;
    for (int i = 0; i < counts; i ++ ) {
        NSString* str = [[tempDatas objectAtIndex:i] description];
        float width = [str sizeWithFont:[UIFont boldSystemFontOfSize:20]].width;
        float recordWidth = [[tempColums objectAtIndex:i] floatValue];
        
        if ( (i == counts-1) && (MAX(width, recordWidth) < calWidth)) {
            [tempColums replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%f", calWidth]];
        }
        else
        {
            if (width <= recordWidth) {
                calWidth -= recordWidth;
            }
            else
            {
                [tempColums replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%f", width]];
                calWidth -= width;
            }
        }
        
    }
    
    instance.titles = [[[NSMutableArray alloc] initWithArray:tempTitles] autorelease];
    instance.data = [[[NSMutableArray alloc] initWithArray:dataValue] autorelease];
    instance.columnWidth = [[[NSMutableArray alloc] initWithArray:tempColums] autorelease];
    instance.cellHeight = 24.0f;
    
    instance.dontChange = YES;
    return instance;
}

- (void)dealloc
{
    [titles release];
    titles = nil;
    
    [data release];
    data = nil;
    
    [columnWidth release];
    columnWidth = nil;
    
    [super dealloc];
}

@end

//声明私有方法
@interface DataGridComponent(Private)

/**
 * 初始化各子视图
 */
-(void)layoutSubView:(CGRect)aRect;

/**
 * 用数据项填冲数据
 */
-(void)fillData;



@end


@implementation DataGridComponent
@synthesize cellHeight,vRight,vLeft, dataSource, isLinkable,dontChange;

- (id)initWithFrame:(CGRect)aRect data:(DataGridComponentDataSource*)aDataSource  isLinkable:(BOOL)linkable{
	self = [super initWithFrame:aRect];
    
	if(self != nil){
        
        self.isLinkable = linkable;
        self.dontChange = aDataSource.dontChange;
		self.clipsToBounds = YES;
		self.backgroundColor = [UIColor clearColor];
        
		self.dataSource = aDataSource;
        
		//初始显示视图及Cell的长宽高
		contentWidth = .0;
		cellHeight = aDataSource.cellHeight;
		cellWidth = [[dataSource.columnWidth objectAtIndex:0] intValue];
        
		for(int i=1;i<[dataSource.columnWidth count];i++)
			contentWidth += [[dataSource.columnWidth objectAtIndex:i] floatValue];
		contentHeight = [dataSource.data count] * cellHeight;	
        
        /*float firstCell = [[dataSource.columnWidth objectAtIndex:0] floatValue];
		contentWidth = contentWidth + [[dataSource.columnWidth objectAtIndex:0] intValue]  < (aRect.size.width - firstCell)? (aRect.size.width-firstCell) : contentWidth;*/
        
        
        
		//初始化各视图
		[self layoutSubView:aRect];
		
		//填冲数据
		[self fillData];
        
	}
	return self;
}

- (void)setScrollDelegate:(id<DataGridScrollViewDelegate>)delegate
{
    [vLeft setSelfdelegate:delegate];
}

-(void)layoutSubView:(CGRect)aRect{
    
    //左下列视图
	DataGridScrollView *_vLeft;
	
	//右下列视图
	DataGridScrollView *_vRight;
	
	//右下列表内容
	UIView *_vRightContent;
	
	//左下列表内容
	UIView *_vLeftContent;
	
	//右上标题
	UIView *_vTopRight;
	
	//左上标题
	UIView *_vTopLeft;
    
    
    
	_vLeftContent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, contentHeight)];
    
    
    //[_vLeftContent release];

	_vRightContent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, aRect.size.width - cellWidth, contentHeight)];
	
	_vLeftContent.opaque = YES;
	_vRightContent.opaque = YES;
	
	
	//初始化各视图
	_vTopLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cellWidth, cellHeight)];
	_vLeft = [[DataGridScrollView alloc] initWithFrame:CGRectMake(0, cellHeight, aRect.size.width, aRect.size.height - cellHeight)];
	_vRight = [[DataGridScrollView alloc] initWithFrame:CGRectMake(cellWidth, 0, aRect.size.width - cellWidth, contentHeight)];
	_vTopRight = [[UIView alloc] initWithFrame:CGRectMake(cellWidth, 0, aRect.size.width - cellWidth, cellHeight)];
	
	_vLeft.dataGridComponent = self;
	_vRight.dataGridComponent = self;
	
	_vLeft.opaque = YES;
	_vRight.opaque = YES;
	_vTopLeft.opaque = YES;
	_vTopRight.opaque = YES;
	
	//设置ScrollView的显示内容
	_vLeft.contentSize = CGSizeMake(aRect.size.width, contentHeight);
	_vRight.contentSize = CGSizeMake(contentWidth,aRect.size.height - cellHeight);
	
	//设置ScrollView参数
	_vRight.delegate = self;
    //设置列标题的边框颜色
	_vLeft.backgroundColor=[UIColor grayColor];
	//设置表头每列的右边框的颜色
    _vTopRight.backgroundColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1];	
	//设置cell中表格下边框的颜色
	_vRight.backgroundColor = [UIColor grayColor];
	//vTopLeft.backgroundColor = [UIColor grayColor];设置实体表头右边框线的颜色
    _vTopLeft.backgroundColor=[UIColor colorWithRed:.7 green:.7 blue:.7 alpha:1];
    
	
	//添加各视图
	[_vRight addSubview:_vRightContent];
	[_vLeft addSubview:_vLeftContent];
	[_vLeft addSubview:_vRight];
	[self addSubview:_vTopLeft];
	[self addSubview:_vLeft];
	
	[_vLeft bringSubviewToFront:_vRight];
	[self addSubview:_vTopRight];
	[self bringSubviewToFront:_vTopRight];	
    
    [_vRight release];
    [_vRightContent release];
    [_vLeftContent release];
    
    vLeft = _vLeft;
    vRight = _vRight;
    vRightContent = _vRightContent;
    vLeftContent = _vLeftContent;
    vTopLeft = _vTopLeft;
    vTopRight = _vTopRight;
    
}


-(void)fillData{
    
	float columnOffset = 0.0;
	//填冲标题数据
	for(int column = 0;column < [dataSource.titles count];column++){
		float columnWidth = [[dataSource.columnWidth objectAtIndex:column] floatValue];
		UILabel *l = [[[UILabel alloc] initWithFrame:CGRectMake(columnOffset, 0, columnWidth -1, cellHeight )] autorelease];
		l.font = [UIFont systemFontOfSize:16.0f];
		l.text = [dataSource.titles objectAtIndex:column];
        [[l layer] setBorderColor:[[UIColor grayColor] CGColor]];
        [[l layer] setBorderWidth:0.5f];
        //设置表头的背景颜色
		l.backgroundColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1] ;
		
		l.textAlignment = UITextAlignmentCenter;
        
		if( 0 == column){
            //设置表头的文字颜色
            l.textColor = [UIColor colorWithRed:4/255.0 green:62/255.0 blue:91/255.0 alpha:1];
			[vTopLeft addSubview:l];
		}
		else{	
            l.textColor = [UIColor colorWithRed:4/255.0 green:62/255.0 blue:91/255.0 alpha:1];
			[vTopRight addSubview:l];
			columnOffset += columnWidth;
		}
		//[l release];
	}	
    
	//填冲数据内容	
	for(int i = 0;i<[dataSource.data count];i++){
		NSArray *rowData = [dataSource.data objectAtIndex:i];
		columnOffset = 0.0;
		
		for(int column=0;column<[rowData count];column++){
			float columnWidth = [[dataSource.columnWidth objectAtIndex:column] floatValue];
			UIUnderlineLabel *l = [[[UIUnderlineLabel alloc] initWithFrame:CGRectMake(columnOffset, i * cellHeight  , columnWidth, cellHeight -1 )] autorelease];
			l.font = [UIFont systemFontOfSize:14.0f];
			
            [[l layer] setBorderColor:[[UIColor grayColor] CGColor]];
            [[l layer] setBorderWidth:0.5f];
            //l.textColor=[UIColor colorWithRed:0.3 green:.5 blue:.1 alpha:1];
            //l.backgroundColor=[UIColor colorWithRed:0.8 green:.9 blue:.9 alpha:1];
			
			l.tag = i * cellHeight + column + 1000;
            
			if( column==0 ){
                
                l.textAlignment = UITextAlignmentLeft;
                l.text = [[rowData objectAtIndex:column] description];
                
                if (i%2==0) {
                    l.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1] ;
                }else {
                    l.backgroundColor=[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1] ;
                }
                l.textColor=[UIColor colorWithRed:4/255.0 green:62/255.0 blue:91/255.0 alpha:1];
				l.frame = CGRectMake(columnOffset,  i * cellHeight , columnWidth -1 , cellHeight -1 );
                if (self.isLinkable) {
                    l.isLinkable = YES;
                    l.textColor = [UIColor blueColor];
                }
				[vLeftContent addSubview:l];
			}
			else{
                
                l.textAlignment = UITextAlignmentRight;
                if (dontChange) {
                    l.text = [[rowData objectAtIndex:column] description];
                }
                else {
                    NSNumber* floatNum = [rowData objectAtIndex:column];
                    l.text = [NSString stringWithFormat:@"%.2f  ", [floatNum floatValue]];
                }
                
                
                if (i%2==0) {
                    l.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1] ;
                }else {
                    l.backgroundColor=[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1] ;
                }
                
                l.textColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
				[vRightContent addSubview:l];
				columnOffset += columnWidth;
			}
			//[l release];
		}
		
		
	}
	
    
}


//-------------------------------以下为事件处发方法----------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	
	vTopRight.frame = CGRectMake(cellWidth, 0, vRight.contentSize.width, vTopRight.frame.size.height);
	vTopRight.bounds = CGRectMake(scrollView.contentOffset.x, 0, vTopRight.frame.size.width, vTopRight.frame.size.height);
	vTopRight.clipsToBounds = YES;	
	vRightContent.frame = CGRectMake(0, 0  , 
									 vRight.contentSize.width , contentHeight);
	[self addSubview:vTopRight];
	vRight.frame =CGRectMake(cellWidth, 0, self.frame.size.width - cellWidth, vLeft.contentSize.height); 
	[vLeft addSubview:scrollView];
	
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
	scrollView.frame = CGRectMake(cellWidth, 0, scrollView.frame.size.width, self.frame.size.height);
	vRightContent.frame = CGRectMake(0, cellHeight - vLeft.contentOffset.y  , 
									 vRight.contentSize.width , contentHeight);
	
	vTopRight.frame = CGRectMake(0, 0, vRight.contentSize.width, vTopRight.frame.size.height);
	vTopRight.bounds = CGRectMake(0, 0, vRight.contentSize.width, vTopRight.frame.size.height);
	[scrollView addSubview:vTopRight];
	[self addSubview:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	if(!decelerate)
		[self scrollViewDidEndDecelerating:scrollView];
}

- (void) dealloc
{
    [vLeft release];
    vLeft = nil;
    [vTopLeft release];
    vTopLeft = nil;
    [vTopRight release];
    vTopRight = nil;
    
    [dataSource release];
    dataSource = nil;
     
    [super dealloc];
}


@end
