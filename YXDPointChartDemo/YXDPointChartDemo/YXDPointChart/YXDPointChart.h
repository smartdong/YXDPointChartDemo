//
//  YXDPointChart.h
//  YXDPointChartDemo
//
//  Created by YangXudong on 15/5/21.
//  Copyright (c) 2015年 YangXudong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXDPointChart;

@protocol YXDPointChartDelegate <NSObject>

@required

/**
 *  配置y轴
 *
 *  @param pointChart pointChart
 *
 *  @return y轴数据 NSNumber类型 从小到大排列
 */
- (NSArray *) yValuesOfPointChart:(YXDPointChart *)pointChart;

/**
 *  x轴显示的数据
 *
 *  @param pointChart pointChart
 *
 *  @return 数组的元素为数组  例如@[@[@1,@2],@[@4,@5],@[@6]]
 *          如果元素的数组的元素还是数组 例如@[@[@[@1,@2],@[@4,@5]],@[@[@1,@2],@[@4,@5]]] 则可以设置小组内部每组的颜色
 */
- (NSArray *) xValuesOfPointChart:(YXDPointChart *)pointChart;

/**
 *  x轴显示的标签
 *
 *  @param pointChart pointChart
 *
 *  @return x轴的标签  数量必须与 - (NSArray *) xValuesOfPointChart:(YXDPointChart *)pointChart 返回的数组元素数量一致
 */
- (NSArray *) xLablesOfPointChart:(YXDPointChart *)pointChart;

@optional

/**
 *  当前图表显示的最大数量
 *
 *  @param pointChart pointChart
 *
 *  @return 最大数量  剩下的可以滚动显示  默认为3
 */
- (NSInteger) maxNumberOfXLablesOfChart:(YXDPointChart *)pointChart;

/**
 *  每组数据里的数据个数
 *
 *  @param pointChart pointChart
 *
 *  @return 个数 默认第一组数据的个数
 */
- (NSInteger) valueCountInGroupOfChart:(YXDPointChart *)pointChart;

/**
 *  每组数据内部之间的间隙
 *
 *  @param pointChart pointChart
 *
 *  @return 间隙 小于1时默认为5
 */
- (NSInteger) gapBetweenXValuesOfChart:(YXDPointChart *)pointChart;

/**
 *  y轴标签的颜色数组
 *
 *  @param pointChart pointChart
 *
 *  @return 颜色数组 如果数量小于y轴标签的数量 则默认只使用第一个颜色
 */
- (NSArray *) yValueColorsOfPointChart:(YXDPointChart *)pointChart;

/**
 *  x轴数据点的颜色
 *
 *  @param pointChart pointChart
 *
 *  @return 如果数组的元素是颜色 如@[[UIColor whiteColor],[UIColor blackColor]] 则x轴数据的第一组数组颜色都为白色,第二组数据都为黑色,以此类推
 *          如果数组的元素是数组 如@[@[[UIColor whiteColor],[UIColor blackColor]]],则每组数据内部,第一组数据为白色,第二组数据为黑色..
 */
- (NSArray *) xValueColorsOfPointChart:(YXDPointChart *)pointChart;

/**
 *  y轴标签的字体大小
 *
 *  @param pointChart pointChart
 *
 *  @return 字体大小 默认为12号
 */
- (NSInteger) yLableFontSizeOfPointChart:(YXDPointChart *)pointChart;

/**
 *  x轴标签的字体大小
 *
 *  @param pointChart pointChart
 *
 *  @return 字体大小 默认为12号
 */
- (NSInteger) xLableFontSizeOfPointChart:(YXDPointChart *)pointChart;

/**
 *  x轴标签字体颜色
 *
 *  @param pointChart pointChart
 *
 *  @return 字体颜色 默认黑色
 */
- (UIColor *) xLableTextColorOfPointChart:(YXDPointChart *)pointChart;

/**
 *  数据点的半径大小
 *
 *  @param pointChart pointChart
 *
 *  @return 半径 默认为3
 */
- (NSInteger) pointRadiusOfPointChart:(YXDPointChart *)pointChart;

/**
 *  当数据比较多时 是否分页滚动
 *
 *  @param pointChart pointChart
 *
 *  @return 是否分页
 */
- (BOOL) pageEnableOfPointChart:(YXDPointChart *)pointChart;

@end

@interface YXDPointChart : UIView

+ (YXDPointChart *) pointChartWithFrame:(CGRect)frame delegate:(id<YXDPointChartDelegate>)delegate;

- (void) action_showChart;

@property (nonatomic, weak) id<YXDPointChartDelegate> delegate;

@end