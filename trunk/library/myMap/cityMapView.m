//
//  cityMapView.m
//  IRnovationBI
//
//  Created by 顾民 on 12-11-4.
//
//

#import "cityMapView.h"
#import "CAAnnotation.h"
#import "NCInfoView.h"
#import "CInfoView.h"
#import "CAMapView.h"
#import "BaseAnnotationView.h"

#import "documentMgr.h"
#import "NetMgr.h"
#import "Util.h"

@interface cityMapView ()
{
    NCInfoView* testView1;
    CInfoView* testView2;
    
    BOOL isBtnPress;
    NSString* titleName;
    NSString* titleName2;
    BOOL isNull;
}

//@private
-(void)dealWithDTReport:(DTReport*)report;

-(CGRect)confirmShowFrame:(CGPoint)pt size:(CGSize)size;
-(float)getPercentFromMin:(float)min andMax:(float)max andCurrentValue:(float)cur;
-(float)getCurrentValueFromMin:(float)min andMax:(float)max currentPercent:(float)percent;

//真正的自定义初始化，要将控件加载到self上
-(void)customInit;

@end

@implementation cityMapView
@synthesize dtReport;
@synthesize rootViewController;


#pragma mark private functions
-(void)dealWithDTReport:(DTReport*)report
{
    [caannotationArray removeAllObjects];
    
    //处理dtreport数据，将其转换为Array
    self.dtReport = report;
    
    DTReportData* drd = [self.dtReport.reportDatas lastObject];
    //度量，多个，isKey定义数据是否用百分号，
    //plotType定义了这个metric的顺序
    
    DTEntity* dte = [drd.entities lastObject];
    //需要录入城市名，经度，纬度，度量名称，度量值
    //NSString* entityName = dte.name;
    //这里需要录取该度量的最大值和最小值, 这个值是用来控制城市显示大小的
    float minValue, maxValue;
    
    //根据type数值来鉴定数据的意义
    //0--extraInfo1
    //1--extraInfo2以此类推
    int metricsCount = [drd.metrics count];
    if (metricsCount < MAP_EXTRA_INFOS) {
        //这里对数据做硬性的返回处理，如果少于2个则返回错误
        //目前只对2个数据源做处理
        return;
    }
    
    DTMetric* dtm1 = [drd.metrics objectAtIndex:0];
    DTMetric* dtm2 = [drd.metrics objectAtIndex:1];
    
    //这个是显示城市圆圈大小的
    minValue = [dtm1 getBeginValue];
    maxValue = [dtm1 getEndValue];
    titleName = dtm1.name;
    titleName2 = dtm2.name;
    isNull = NO;
    
    //现在的规则dtm1，管理地图表示的大小
    //dtm2，管理地图的颜色
    //dtm2中的angele是阈值
    //dtm2种的isGradient是BOOL值，控制颜色区分
    //YES，大于阈值的部分成红色
    //NO,大于阈值的部分成绿色
    float threshold = [dtm2 getAngle];
    BOOL isRedSmall = [dtm2 getIsGradient];
    
    NSUInteger sum = [dtm1 getCoordsSum];
    for (int i = 0; i < sum; i++) {
        NSString* cityName = [dte getStringAtIndex:i];
        float longitude = [dtm1 getLongitudeAtIndex:i];
        float latitude = [dtm1 getLatitudeAtIndex:i];
        //extra value 1
        float value = [dtm1 getDataValueAtIndex:i];
        float scale = 1.0f;
        scale = [self getPercentFromMin:minValue andMax:maxValue andCurrentValue:value];
        scale = [self getCurrentValueFromMin:0.5 andMax:1.4 currentPercent:scale];
        
        NSString* valueStr;
        //判断value是否进行百分比处理,如果是YES，则将值设置成.2f
        /*if (dtm1.isKey == YES) {
            //做百分比处理
            valueStr = [NSString stringWithFormat:@"%.2f%%", value*100.0];
        }
        else {
            //不做百分比处理
            valueStr = [NSString stringWithFormat:@"%.2f", value];
        }*/
        //现在对extraValue1都不做百分比处理
        valueStr = [NSString stringWithFormat:@"%.0f", value];
        
        //extra info 1
        NSString* metricName1 = dtm1.name;
        
        //extraInfo2
        NSString* metricName2 = dtm2.name;
        float value2 = [dtm2 getDataValueAtIndex:i];
        NSString* valueStr2;
        
        //判断value是否进行百分比处理,如果是YES，则将值设置成.2f
        if (dtm2.isKey == YES) {
            //做百分比处理
            valueStr2 = [NSString stringWithFormat:@"%.2f%%", value2*100.0];
        }
        else {
            //不做百分比处理
            if (value2 == 0) {
                valueStr2 = @"";
                isNull = YES;
            }
            else {
                valueStr2 = [NSString stringWithFormat:@"%.0f", value2];
            }
            
        }
        
        //为了让extraInfo2的空内容，不显示错误信息
        
        if (![metricName2 isEqualToString:@""]) {
            metricName2 = [NSString stringWithFormat:@"%@ :", metricName2];
        }
        
        
        CAMapInfoPackage* pkg = [CAMapInfoPackage initWithCityName:cityName longitude:longitude latitude:latitude extraInfo1:[NSString stringWithFormat:@"%@ :",metricName1] extraValue1:valueStr extraInfo2:metricName2 extraValue2:valueStr2 scaleFactor:scale];
        
        CAAnnotation* ca = [[CAAnnotation alloc] init];
        if (isRedSmall) {
            if (value2 >= threshold) {
                [ca setColor:ANNO_GREEN];
            }
            else {
                [ca setColor:ANNO_RED];
            }
        }
        else {
            if (isNull) {
                [ca setColor:ANNO_GREEN];
            }
            else {
                if (value2 >= threshold) {
                    [ca setColor:ANNO_RED];
                }
                else {
                    [ca setColor:ANNO_GREEN];
                }
            }
            
        }
        
        [ca setCoordinate:CLLocationCoordinate2DMake(latitude, longitude)];
        [ca setInfoPkg:pkg];
        [ca setTitle:cityName];
        
        [caannotationArray addObject:ca];
    }
    
    [titleLabel setText:[NSString stringWithFormat:@"大小表示%@", titleName]];
    if (isNull) {
        [titleLabel2 setText:@""];
    }else {
        [titleLabel2 setText:[NSString stringWithFormat:@"颜色表示%@", titleName2]];
    }
}

//通过给定的annotationView在显示屏中的位置，来确定文字显示框的位置
//param:size是显示框的width，height
-(CGRect)confirmShowFrame:(CGPoint)pt size:(CGSize)size
{
    float widthPad = size.width * 1.2f;
    float heightPad = size.height * 1.2f;
    
    //判断，如果padding超过了主显示区域的一半，则把padding设置为主显示区的1/4
    CGRect rootViewRect = [self bounds];
    if (widthPad >= rootViewRect.size.width/2) {
        widthPad = rootViewRect.size.width/4;
    }
    
    if (heightPad >= rootViewRect.size.height/2) {
        heightPad = rootViewRect.size.height/2;
    }
    
    const float gap = 10.0f;
    //具体逻辑
    float returnX, returnY;
    if (pt.x <= widthPad) {
        returnX = gap;
    }
    else if(pt.x >= [self bounds].size.width - widthPad)
    {
        returnX = -(gap + size.width);
    }
    else
    {
        returnX = -size.width/2;
    }
    
    if (pt.y >= [self bounds].size.height - heightPad) {
        returnY = - (gap + size.height);
    }
    else
    {
        returnY = gap*4;
    }
    
    CGRect rt = CGRectMake(returnX+pt.x, returnY+pt.y, size.width, size.height);
    return rt;
    
}

-(float)getPercentFromMin:(float)min andMax:(float)max andCurrentValue:(float)cur
{
    return (cur - min)/(max - min);
}

-(float)getCurrentValueFromMin:(float)min andMax:(float)max currentPercent:(float)percent
{
    return (max-min) * percent + min;
}

//真正的自定义初始化，要将控件加载到self上
-(void)customInit
{
    //首先是ui部分
    myMapView = [[CAMapView alloc] initWithFrame:[self bounds]];
    [self addSubview:myMapView];
    [myMapView setDelegate:self];
    
    float segGap = ([self bounds].size.width - 240)/2;
    segment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"标准图", @"卫星图", @"鸟瞰图", nil]];
    //segment 一系列状态的初始化
    [segment setSegmentedControlStyle:UISegmentedControlStyleBar];
    [segment setFrame:CGRectMake(segGap, 0, 240, 30)];
    [segment setSelectedSegmentIndex:0];
    //add target
    [segment addTarget:self action:@selector(onSegmentValueChange) forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:segment];
    
    //titleBgView
    titleBgView = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 300, self.bounds.size.height - 50, 300, 48)];
    [[titleBgView layer] setCornerRadius:10.0f];
    [titleBgView setBackgroundColor:[UIColor blackColor]];
    [self addSubview:titleBgView];
    
    //titleLabel
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 24)];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setTextAlignment:UITextAlignmentCenter];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleBgView addSubview:titleLabel];
    
    //titleLabel2
    titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, 300, 24)];
    [titleLabel2 setTextColor:[UIColor whiteColor]];
    [titleLabel2 setTextAlignment:UITextAlignmentCenter];
    [titleLabel2 setBackgroundColor:[UIColor clearColor]];
    [titleBgView addSubview:titleLabel2];
    
    
    //ui部分结束
    
    //数据部分初始化
    caannotationArray = [[NSMutableArray alloc] init];
    isBtnPress = NO;
    
    //设定地图的其实显示地区
    MKCoordinateRegion region;
    region.center = CLLocationCoordinate2DMake(35, 101);
    region.span.longitudeDelta = 30;
    region.span.latitudeDelta = 30;
    [myMapView setRegion:region];
    
    //如果处于无网络状态，使地图无法缩放
    if (![NetMgr connectedToNetwork]) {
        [myMapView setScrollEnabled:NO];
        [myMapView setZoomEnabled:NO];
    }
    else
    {
        [myMapView setZoomEnabled:YES];
        [myMapView setScrollEnabled:YES];
    }

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


#pragma mark public functions
//初始化方法
//从外部调用该方法，传入DTReport
//同时实现了reloadData
-(void)loadWithDTReport:(DTReport*)report;
{
    //先要把原有的数据清除
    //先将地图上所有的annotation删除，再处理report数据，再加载所有新的annotation
    //1
    [myMapView removeAnnotations:[myMapView annotations]];
    
    //2
    [self dealWithDTReport:report];
    
    //3
    for (CAAnnotation* ca in caannotationArray) {
        [myMapView addAnnotation:ca];
    }
    
}

//重载数据方法
//-(void)reloadReport:(DTReport*)report;

//segment数值改变响应
-(void)onSegmentValueChange
{
    switch ([segment selectedSegmentIndex]) {
        case 0:
            [myMapView setMapType:MKMapTypeStandard];
            break;
            
        case 1:
            [myMapView setMapType:MKMapTypeSatellite];
            break;
            
        case 2:
            [myMapView setMapType:MKMapTypeHybrid];
            break;
            
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark MKMapViewDelegate
-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView* returnView;
    
    if ([annotation isKindOfClass:[CAAnnotation class]]) {
        CAAnnotation* ca = (CAAnnotation*)annotation;
        
        returnView = (BaseAnnotationView*)[myMapView dequeueReusableAnnotationViewWithIdentifier:ca.infoPkg.cityName];
        if (!returnView) {
            returnView = [[BaseAnnotationView alloc] initWithAnnotation:ca reuseIdentifier:ca.infoPkg.cityName];
            returnView.canShowCallout = NO;
            
            UIImage* img;
            CGSize size = CGSizeMake(32, 32);
            switch ([ca color]) {
                case ANNO_GREEN:
                    img = [Util getRoundWithSize:size fillColor:[Util getMuteGreen] strokeColor:[UIColor whiteColor]];
                    break;
                    
                case ANNO_RED:
                    img = [Util getRoundWithSize:size fillColor:[Util getMuteRed] strokeColor:[UIColor whiteColor]];
                    break;
                    
                default:
                    break;
            }
            [returnView setImage:img];
            
            
            //用setBounds来设置城市定位图大小
            [returnView setBounds:CGRectMake(0, 0, returnView.frame.size.width*ca.infoPkg.scaleFactor, returnView.frame.size.height*ca.infoPkg.scaleFactor)];
        }
        
        
        return returnView;
    }
    
    return nil;
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if ([view isKindOfClass:[BaseAnnotationView class]])
    {
        CAAnnotation* anno = (CAAnnotation*)[view annotation];
        if (anno.isCluster) {
            
            if ([clusteAnno count] > 0 && [clusteAnno containsObject:anno] &&
                isBtnPress == YES) {
                //if the array has the annotation
                
                CGRect rt1 = [view frame];
                CGRect rt2 = [mapView annotationVisibleRect];
                CGPoint pt  = CGPointMake(rt1.origin.x-rt2.origin.x, rt1.origin.y-rt2.origin.y);
                CGSize size = CGSizeMake(_SELF_WIDTH_, _SELF_HEIGHT_);
                
                testView2 = [[CInfoView alloc] initWithFrame:[self confirmShowFrame:pt size:size]];
                [testView2 setFrame:[self confirmShowFrame:pt size:size]];
                //[testView2 setFrame:CGRectMake(testView2.frame.origin.x, testView2.frame.origin.y, anno.infoPkg.scaleFactor*testView2.frame.size.width, anno.infoPkg.scaleFactor*testView2.frame.size.height)];
                [testView2 setDelegate:self];
                
                //view 的部分，要将它加在主view上
                [testView2 setFrame:CGRectMake(testView2.frame.origin.x+self.frame.origin.x, testView2.frame.origin.y+self.frame.origin.y, testView2.frame.size.width, testView2.frame.size.height)];
                [rootViewController.view addSubview:testView2];
                
                //计算index
                int index = [clusteAnno indexOfObject:anno];
                currentIndex = index;[testView2.titleName setText:[NSString stringWithFormat:@"%d  in %d", currentIndex+1, [clusteAnno count]]];
                
                //todo: refresh the testView2 infomation
                //地名，经度，纬度，extraInfo1，extravalue1
                [[testView2 cityName] setText:anno.infoPkg.cityName];
                //[[testView2 longitude] setText:[anno.infoPkg getLongitudeStr]];
                //[[testView2 latitude] setText:[anno.infoPkg getLatitudeStr]];
                [[testView2 extraInfo1] setText:anno.infoPkg.extraInfo1];
                [[testView2 extraValue1] setText:anno.infoPkg.extraValue1];
                [[testView2 extraInfo2] setText:anno.infoPkg.extraInfo2];
                [[testView2 extraValue2] setText:anno.infoPkg.extraValue2];
                
            }
            else {
                //new annotation by tap
                [testView2 removeFromSuperview];
                
                CGRect rt1 = [view frame];
                CGRect rt2 = [mapView annotationVisibleRect];
                CGPoint pt  = CGPointMake(rt1.origin.x-rt2.origin.x, rt1.origin.y-rt2.origin.y);
                CGSize size = CGSizeMake(_SELF_WIDTH_, _SELF_HEIGHT_);
                
                testView2 = [[CInfoView alloc] initWithFrame:[self confirmShowFrame:pt size:size]];
                //[testView2 setFrame:CGRectMake(testView2.frame.origin.x, testView2.frame.origin.y, anno.infoPkg.scaleFactor*testView2.frame.size.width, anno.infoPkg.scaleFactor*testView2.frame.size.height)];
                [testView2 setDelegate:self];
                
                [testView2 setFrame:CGRectMake(testView2.frame.origin.x+self.frame.origin.x, testView2.frame.origin.y+self.frame.origin.y, testView2.frame.size.width, testView2.frame.size.height)];
                [rootViewController.view addSubview:testView2];
                
                
                //calculate
                curr = anno;
                [clusteAnno removeAllObjects];
                clusteAnno = [[NSMutableArray alloc] initWithArray:curr.annotationsInCluster];
                currentIndex = [clusteAnno indexOfObject:anno];
                
                [testView2.titleName setText:[NSString stringWithFormat:@"%d  in %d", currentIndex+1, [clusteAnno count]]];
                
                //todo: refresh the testView2 infomation
                //地名，经度，纬度，extraInfo1，extravalue1
                [[testView2 cityName] setText:anno.infoPkg.cityName];
                //[[testView2 longitude] setText:[anno.infoPkg getLongitudeStr]];
                //[[testView2 latitude] setText:[anno.infoPkg getLatitudeStr]];
                [[testView2 extraInfo1] setText:anno.infoPkg.extraInfo1];
                [[testView2 extraValue1] setText:anno.infoPkg.extraValue1];
                [[testView2 extraInfo2] setText:anno.infoPkg.extraInfo2];
                [[testView2 extraValue2] setText:anno.infoPkg.extraValue2];
            }
            
            
        }
        else {
            
            CGRect rt1 = [view frame];
            CGRect rt2 = [mapView annotationVisibleRect];
            CGPoint pt  = CGPointMake(rt1.origin.x-rt2.origin.x, rt1.origin.y-rt2.origin.y);
            CGSize size = CGSizeMake(_SELF_WIDTH_, _SELF_HEIGHT_);
            
            testView1 = [[NCInfoView alloc] initWithFrame:[self confirmShowFrame:pt size:size]];
            //[testView1 setFrame:CGRectMake(testView1.frame.origin.x, testView1.frame.origin.y, anno.infoPkg.scaleFactor*testView1.frame.size.width, anno.infoPkg.scaleFactor*testView1.frame.size.height)];
            
            [testView1 setFrame:CGRectMake(testView1.frame.origin.x+self.frame.origin.x, testView1.frame.origin.y+self.frame.origin.y, testView1.frame.size.width, testView1.frame.size.height)];
            [rootViewController.view addSubview:testView1];
            
            //[testView2.titleName setText:[NSString stringWithFormat:@"%d  in %d", currentIndex+1, [clusteAnno count]]];
            //todo: refresh the testView2 infomation
            //地名，经度，纬度，extraInfo1，extravalue1
            [[testView1 cityName] setText:anno.infoPkg.cityName];
            //[[testView1 longitude] setText:[anno.infoPkg getLongitudeStr]];
            //[[testView1 latitude] setText:[anno.infoPkg getLatitudeStr]];
            [[testView1 extraInfo1] setText:anno.infoPkg.extraInfo1];
            [[testView1 extraValue1] setText:anno.infoPkg.extraValue1];
            [[testView1 extraInfo2] setText:anno.infoPkg.extraInfo2];
            [[testView1 extraValue2] setText:anno.infoPkg.extraValue2];
        }
        
    }
    
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    if ([view isKindOfClass:[BaseAnnotationView class]]) {
        CAAnnotation* anno = (CAAnnotation*)[view annotation];
        if (anno.isCluster)
        {
            //先隐藏，然后在再次生成testView2的时候再处理testView2
            [testView2 setAlpha:0];
            
            
        }
        else {
            [testView1 removeFromSuperview];
        }
        
    }
    
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [myMapView doClustering];
    [clusteAnno removeAllObjects];
}


-(void)onRightBtnPress
{
    isBtnPress = YES;
    int sum = [clusteAnno count];
    currentIndex++;
    if (currentIndex >= sum) {
        currentIndex -= sum;
    }
    
    CAAnnotation* anno = [clusteAnno objectAtIndex:currentIndex];
    
    //在btn点击事件结束后，才把textView2给注销
    [testView2 setDelegate:nil];
    [testView2 removeFromSuperview];
    
    
    [myMapView selectAnnotation:anno animated:YES];
    
    
}



@end
