//
//  PieChartRotationView.m
//  PieChartRotation
//
//  Created by summer.zhu on 3/28/13.
//  Copyright (c) 2013 zbq. All rights reserved.
//

#import "PieChartRotationView.h"
#import <AudioToolbox/AudioToolbox.h>

@interface PieChartRotationView()

- (void)generateData;
- (void)setInitPosition;
- (CGFloat)angleByPoint2:(CGPoint)point center:(CGPoint) center;
- (CGFloat)calcNewAngleByRotationAngle:(CGFloat)rotationAngle originalAngle:(CGFloat)oAngle;
- (void)upDateAngleByRotationAngle:(CGFloat)rotationAngle;
- (BOOL)judgeInAreaByAngles:(CGFloat)destAngle startAngle:(CGFloat)sAngle endAngle:(CGFloat)eAngle;
- (NSInteger)getAreaByDestAngle:(CGFloat)destAngle;
- (CGFloat)calcMiddleAngleByOriginalAndDest:(CGFloat)originalAngle destAngle:(CGFloat)dAngle;
- (CGFloat)calcDistanceBetweenPoints:(CGPoint)point1 point:(CGPoint)point2;

- (void)playSound;

@end

@implementation PieChartRotationView
@synthesize bLarge;
@synthesize destPoint;
@synthesize dataSource;
@synthesize centerPoint;
@synthesize fRadius;
@synthesize iCurrent;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)rotateToSector:(NSInteger)iSector{
    //指针指向的饼图中间线旋转到目标点
    CGFloat fStartAngle = [[arrBeginAngle objectAtIndex:iSector] floatValue];
    CGFloat fEndAngle = [[arrEndAngle objectAtIndex:iSector] floatValue];
    CGFloat fMiddleAngle = [self calcMiddleAngleByOriginalAndDest:fStartAngle destAngle:fEndAngle];
    CGFloat angleDest = [self angleByPoint2:destPoint center:centerPoint];
    
    [UIView beginAnimations:@"rotation" context:nil];
    [UIView setAnimationDuration:0.3];
    [self playSound];
    pieView.transform = CGAffineTransformRotate(pieView.transform, (fMiddleAngle-angleDest));
    [UIView commitAnimations];
    
    [self upDateAngleByRotationAngle:(fMiddleAngle-angleDest)];
}

-(void)generateData
{
    CGFloat fTotal = 0;
    
    for (int i=0; i<dataSource.count; i++) {
        fTotal += [[dataSource objectAtIndex:i] floatValue];
    }
    
    arrRate = [[NSMutableArray alloc] initWithCapacity:dataSource.count];
    for (int i=0; i<dataSource.count; i++) {
        CGFloat rate = [[dataSource objectAtIndex:i] floatValue]/fTotal;
        NSNumber *number = [NSNumber numberWithFloat:rate];
        [arrRate addObject:number];
    }
    
    arrBeginAngle = [[NSMutableArray alloc] initWithCapacity:dataSource.count];
    arrEndAngle = [[NSMutableArray alloc] initWithCapacity:dataSource.count];
    CGFloat fBeginRotation = 5.0;//_pie.startAngle;
    for (int i=0; i<dataSource.count; i++) {
        NSNumber *beginRotation = [NSNumber numberWithFloat:fBeginRotation];
        [arrBeginAngle addObject:beginRotation];
        fBeginRotation += 2*M_PI*([[arrRate objectAtIndex:i] floatValue]);
        if (fBeginRotation >= 2*M_PI) {
            fBeginRotation -= 2*M_PI;
        }
        NSNumber *endAngle = [NSNumber numberWithFloat:fBeginRotation];
        [arrEndAngle addObject:endAngle];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (pieView == nil) {
        [self generateData];
        
        pieView = [[PieChartRotationHostingView alloc] initWithFrame:CGRectMake(bLarge?16:8, bLarge?16:8, 2*fRadius, 2*fRadius)];
        pieView.dataSource = self.dataSource;
        pieView.arrRate = arrRate;
        pieView.delegate = self;
        [self addSubview:pieView];
        [self setInitPosition];
    }
    
    [self addSubview:imageviewWhiteCircle];
    imageviewWhiteCircle.image = [UIImage imageNamed:bLarge?@"pieWhitwCircle.png":@"pieWhitwCircleHalfSize.png"];
    CGRect imageviewWhiteRect = imageviewWhiteCircle.frame;
    imageviewWhiteRect.origin.x = bLarge?16:8;
    imageviewWhiteRect.origin.y = bLarge?16:8;
    imageviewWhiteRect.size.width = bLarge?imageviewWhiteRect.size.width:(imageviewWhiteRect.size.width/2);
    imageviewWhiteRect.size.height = bLarge?imageviewWhiteRect.size.height:(imageviewWhiteRect.size.height/2);
    imageviewWhiteCircle.frame = imageviewWhiteRect;
//
    [self addSubview:imageviewInnerCircle];
    imageviewInnerCircle.image = [UIImage imageNamed:bLarge?@"pieInnerCircle.png":@"pieInnerCircleHalfSize.png"];
    CGRect imageviewRect = imageviewInnerCircle.frame;
    imageviewRect.origin.x = bLarge?143:72;
    imageviewRect.origin.y = bLarge?144:72;
    imageviewRect.size.width = bLarge?imageviewRect.size.width:(imageviewRect.size.width/2);
    imageviewRect.size.height = bLarge?imageviewRect.size.height:(imageviewRect.size.height/2);
    imageviewInnerCircle.frame = imageviewRect;
    
    [self addSubview:imageviewIndicator];
    imageviewIndicator.image = [UIImage imageNamed:bLarge?@"pieIndicator.png":@"pieIndicatorHalfSize.png"];
    CGRect indicatorRect = imageviewIndicator.frame;
    indicatorRect.origin.x = bLarge?244:122;
    indicatorRect.origin.y = bLarge?11:6;
    indicatorRect.size.width = bLarge?indicatorRect.size.width:(indicatorRect.size.width/2);
    indicatorRect.size.height = bLarge?indicatorRect.size.height:(indicatorRect.size.height/2);
    imageviewIndicator.frame = indicatorRect;
    
    [self addSubview:imageviewOutCircle];
    imageviewOutCircle.image = [UIImage imageNamed:bLarge?@"pieOutCircle.png":@"pieOutCircleHalfSize.png"];
    imageviewOutCircle.frame = CGRectMake(imageviewOutCircle.frame.origin.x,
                                          imageviewOutCircle.frame.origin.y,
                                          bLarge?imageviewOutCircle.frame.size.width:(imageviewOutCircle.frame.size.height/2),
                                          bLarge?imageviewOutCircle.frame.size.width:(imageviewOutCircle.frame.size.height/2));
    
    UIPanGestureRecognizer * panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePiePanTouchFrom:)];
    [self addGestureRecognizer:panGestureRecognizer];
//    [panGestureRecognizer release];
}

#pragma mark - PieChartRotationHostDelegate
- (void)sliceWasSelected:(NSInteger)iSelected{
    [self rotateToSector:iSelected];
    iCurrent = iSelected;
    if ([self.delegate respondsToSelector:@selector(endRotatePie:)]) {
        [self.delegate endRotatePie:self];
    }
}

//使指针指向的饼图块中间线指向指针
- (void)setInitPosition{
    CGFloat angleDest = [self angleByPoint2:destPoint center:centerPoint];
    NSInteger iIndex = self.iCurrent;//[self getAreaByDestAngle:angleDest];
    
    CGFloat fStartAngle = [[arrBeginAngle objectAtIndex:iIndex] floatValue];
    CGFloat fEndAngle = [[arrEndAngle objectAtIndex:iIndex] floatValue];
    CGFloat fMiddleAngle = [self calcMiddleAngleByOriginalAndDest:fStartAngle destAngle:fEndAngle];
    
    pieView.transform = CGAffineTransformRotate(self.transform, (fMiddleAngle-angleDest));
    
    [self upDateAngleByRotationAngle:(fMiddleAngle-angleDest)];
}

-(void) handlePiePanTouchFrom:(UIPanGestureRecognizer*)recognizer{
    if(recognizer.state == UIGestureRecognizerStateBegan){
        lastPoint = [recognizer locationInView:self];
    }
    else if(recognizer.state == UIGestureRecognizerStateChanged){
        CGPoint curPoint = [recognizer locationInView:self];
//        CGFloat distance = [self calcDistanceBetweenPoints:centerPoint point:curPoint];
//        if (distance > self.fRadius) {
//            return;
//        }
        
        if((curPoint.x==0&&curPoint.y==0)||(lastPoint.x==0 && lastPoint.y==0)){
            return;
        }
        
        CGFloat anglePre = [self angleByPoint2:lastPoint center:centerPoint];
        CGFloat angleCur = [self angleByPoint2:curPoint center:centerPoint];
        
        //旋转
        lastPoint = curPoint;
        CGAffineTransform transform = pieView.transform;
        CGAffineTransform newTransform = CGAffineTransformRotate(transform, anglePre-angleCur);
        [pieView setTransform:newTransform];
        
        //更新角度
        [self upDateAngleByRotationAngle:anglePre-angleCur];
        
        CGFloat angleDest = [self angleByPoint2:destPoint center:centerPoint];
        NSInteger iIndex = [self getAreaByDestAngle:angleDest];
        if (iCurrent != iIndex) {
            [self playSound];
        }
        iCurrent = iIndex;
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded){
        CGPoint curPoint = [recognizer locationInView:self];
//        CGFloat distance = [self calcDistanceBetweenPoints:centerPoint point:curPoint];
//        if (distance > self.fRadius) {
//            curPoint = lastPoint;
//        }
        
        if((curPoint.x==0&&curPoint.y==0)||(lastPoint.x==0 && lastPoint.y==0)){
            return;
        }
        
        CGFloat anglePre = [self angleByPoint2:lastPoint center:centerPoint];
        CGFloat angleCur = [self angleByPoint2:curPoint center:centerPoint];
        
        //旋转
        lastPoint = curPoint;
        CGAffineTransform transform = pieView.transform;
        CGAffineTransform newTransform = CGAffineTransformRotate(transform, (anglePre-angleCur));
        [pieView setTransform:newTransform];
        
        //判断在哪个饼快
        [self upDateAngleByRotationAngle:(anglePre-angleCur)];
        CGFloat angleDest = [self angleByPoint2:destPoint center:centerPoint];
        NSInteger iIndex = [self getAreaByDestAngle:angleDest];
        iCurrent = iIndex;
        //指针指向的饼图中间线旋转到目标点
        CGFloat fStartAngle = [[arrBeginAngle objectAtIndex:iIndex] floatValue];
        CGFloat fEndAngle = [[arrEndAngle objectAtIndex:iIndex] floatValue];
        CGFloat fMiddleAngle = [self calcMiddleAngleByOriginalAndDest:fStartAngle destAngle:fEndAngle];
        
        [UIView beginAnimations:@"rotation" context:nil];
        [UIView setAnimationDuration:0.3];
        pieView.transform = CGAffineTransformRotate(transform, (fMiddleAngle-angleDest));
        [UIView commitAnimations];
        [self upDateAngleByRotationAngle:(fMiddleAngle-angleDest)];
        if ([self.delegate respondsToSelector:@selector(endRotatePie:)]) {
            [self.delegate endRotatePie:self];
        }
    }
}

//每次旋转后，更新arrBeginAngle， arrEndAngle
- (void)upDateAngleByRotationAngle:(CGFloat)rotationAngle{
    for (int i=0; i<arrBeginAngle.count; i++) {
        CGFloat fBeginOld = [[arrBeginAngle objectAtIndex:i] floatValue];
        CGFloat fBeginNew = [self calcNewAngleByRotationAngle:rotationAngle originalAngle:fBeginOld];
        NSNumber *beginNew = [NSNumber numberWithFloat:fBeginNew];
        [arrBeginAngle replaceObjectAtIndex:i withObject:beginNew];
        
        CGFloat fEndOld = [[arrEndAngle objectAtIndex:i] floatValue];
        CGFloat fEndNew = [self calcNewAngleByRotationAngle:rotationAngle originalAngle:fEndOld];
        NSNumber *endNew = [NSNumber numberWithFloat:fEndNew];
        [arrEndAngle replaceObjectAtIndex:i withObject:endNew];
    }
}

//原始角度oAngle旋转rotationAngle后的角度
- (CGFloat)calcNewAngleByRotationAngle:(CGFloat)rotationAngle originalAngle:(CGFloat)oAngle{
    CGFloat newAngle = 0;
    if (rotationAngle >= 0) {//顺时针旋转
        newAngle = oAngle - rotationAngle;
        if (newAngle < 0) {
            newAngle += 2*M_PI;
        }
    }else{//逆时针
        newAngle = oAngle - rotationAngle;
        if (newAngle >= 2*M_PI) {
            newAngle -= 2*M_PI;
        }
    }
    return newAngle;
}

//从point到center连成的直线与x轴之间的夹角
-(CGFloat) angleByPoint2:(CGPoint)point center:(CGPoint) center{
    
    CGFloat dy = abs(point.y-center.y);
    
    CGFloat dx = abs(point.x-center.x);
    
    NSInteger area = [self areaBy2Point:point center:center];
    
    if(area==0){
        
        return atan2(dy, dx);
        
    }else if(area==1){
        
        CGFloat angle = atan2(dx,dy);//和x轴形成的角
        return M_PI/2.0+angle;
        
    }else if(area ==2){
        
        CGFloat angle = atan2(dy,dx);//和y轴形成的角
        
        return M_PI+angle;
        
    }else{
        
        CGFloat angle = atan2(dx,dy);//和x轴形成的角
        
        return M_PI*1.5+angle;
        
    }
}

//在以center为圆心建立的坐标轴中，point所在的象限
//0:第一象限(右上角) 1:第二象限（左上角） 2: 3:
-(NSInteger) areaBy2Point:(CGPoint)point center:(CGPoint)center{
    
    if(point.x>center.x && point.y <= center.y){
        
        return 0;
        
    }else if(point.x<=center.x&&point.y<center.y){
        return 1;
    }else if(point.x<center.x&&point.y>= center.y){
        
        return 2;
        
    }else if(point.x>=center.x&&point.y>center.y){
        
        return 3;
        
    }else{
        
        [NSException raise:@"not found area for point" format:@"not found area for point(%f,%f)",point.x,point.y];
        
        return -1;
        
    }
}

//计算2点之间的距离
- (CGFloat)calcDistanceBetweenPoints:(CGPoint)point1 point:(CGPoint)point2{
    CGFloat x = (point2.x-point1.x)*(point2.x-point1.x);
    CGFloat y = (point2.y-point1.y)*(point2.y-point1.y);
    CGFloat dis = x+y;
    return sqrtf(dis);
}

//根据目标点获取所在的区域
//返回所在区域的位置
//destAngle目标点到x轴的夹角
- (NSInteger)getAreaByDestAngle:(CGFloat)destAngle{
    for (int i=0; i<arrBeginAngle.count; i++) {
        CGFloat fBegin = [[arrBeginAngle objectAtIndex:i] floatValue];
        CGFloat fEnd = [[arrEndAngle objectAtIndex:i] floatValue];
        if ([self judgeInAreaByAngles:destAngle startAngle:fBegin endAngle:fEnd]) {
            return i;
        }
    }
    return 0;
}

//根据开始角度（sAngle），终点角度（eAngle），判断destAnglesh是否在该区间内
- (BOOL)judgeInAreaByAngles:(CGFloat)destAngle startAngle:(CGFloat)sAngle endAngle:(CGFloat)eAngle{
    if (sAngle <= eAngle) {
        if (destAngle >= sAngle && destAngle < eAngle) {
            return YES;
        }else{
            return NO;
        }
    }else{//起始轴在X轴下面，结束轴下X轴的上面
        if (destAngle >= eAngle && destAngle < sAngle) {
            return NO;
        }else{
            return YES;
        }
    }
}

//根据初始角度和终点角度计算中间的角度
//OriginalAngle 起始角度
//dAngle 终点角度
- (CGFloat)calcMiddleAngleByOriginalAndDest:(CGFloat)originalAngle destAngle:(CGFloat)dAngle{
    CGFloat middleAngle = 0;
    if (originalAngle < dAngle) {
        middleAngle = (originalAngle + dAngle)/2;
    }else{
        middleAngle = (originalAngle + dAngle + 2*M_PI)/2;
        if (middleAngle >= 2*M_PI) {
            middleAngle = middleAngle-2*M_PI;
        }
    }
    return middleAngle;
}

- (void)playSound{
    static SystemSoundID soundID = 0;
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"Tock" ofType:@"aiff"];
    if (strPath.length > 0) {
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL URLWithString:strPath], &soundID);
    }
    AudioServicesPlaySystemSound(soundID);
}

//- (void)dealloc{
//    [pieView release];
//    [viewPieView release];
//    [super dealloc];
//}

@end
