//
//  DataGridComponent.h
//
//  Created by lee jory on 09-10-22.
//  Copyright 2009 Netgen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * DataGrid所用数据源对象
 */
@class  BAReport;
@interface DataGridComponentDataSource : NSObject
{
	/**
	 * 标题列表
	 */
	NSMutableArray *titles;
	
	/**
	 * 数据体，其中包函其它列表(NSArray)
	 */
	NSMutableArray *data;
	
	/**
	 * 列宽
	 */
	NSMutableArray *columnWidth;
    
    float cellHeight;
    float totalWidth;
    BOOL dontChange;

}

@property(retain) NSMutableArray *titles;
@property(retain) NSMutableArray *data;
@property(retain) NSMutableArray *columnWidth;
@property(assign) float cellHeight;
@property(assign) BOOL dontChange;

+(id)initDataSourceWithReport:(BAReport*)report totalWidth:(float)width avlWidth:(BOOL)avl arg:(NSString*)cellWidth titleName:(NSString*)title needInvert:(BOOL)isInvert;

+(id)initDataSourceWithTitles:(NSArray*)titlesdata andSingleLineData:(NSArray*)dataValue totalWidth:(float)width;

@end

@class DataGridComponent;
@protocol DataGridScrollViewDelegate <NSObject>

@optional
-(void)onPressFromIndexAtRow:(NSUInteger)row dataComponent:(DataGridComponent*)component;

@end

@interface DataGridScrollView : UIScrollView
{
	id dataGridComponent;
    id<DataGridScrollViewDelegate> selfdelegate;
}
@property(assign, nonatomic)id dataGridComponent;
@property(nonatomic, retain)id<DataGridScrollViewDelegate> selfdelegate;
@end


/**
 * 数据列表组件，支持上下与左右滑动
 */
@interface DataGridComponent : UIView<UIScrollViewDelegate> {
	
	//左下列视图
	DataGridScrollView *vLeft;
	
	//右下列视图
	DataGridScrollView *vRight;
	
	//右下列表内容
	UIView *vRightContent;
	
	//左下列表内容
	UIView *vLeftContent;
	
	//右上标题
	UIView *vTopRight;
	
	//左上标题
	UIView *vTopLeft;
	
	//列表数据源
	DataGridComponentDataSource *dataSource;
	
	//内容总高度
	float contentHeight ;
	
	//内容总宽度
	float contentWidth;
	
	//单元格默认高度
	float cellHeight;
	
	//单元格默认宽度
	float cellWidth;
    
    BOOL isLinkable;
	BOOL dontChange;
}

@property(readonly) DataGridScrollView *vRight;
@property(readonly) DataGridScrollView *vLeft;
@property(readonly) float cellHeight;
@property(strong) 	DataGridComponentDataSource *dataSource;
@property (nonatomic, assign) BOOL isLinkable;
@property (nonatomic, assign) BOOL dontChange;

/**
 * 用指定显示区域 与 数据源初始化对象
 */
- (id)initWithFrame:(CGRect)aRect data:(DataGridComponentDataSource*)aDataSource isLinkable:(BOOL)linkable;

- (void)setScrollDelegate:(id<DataGridScrollViewDelegate>)delegate;

@end
