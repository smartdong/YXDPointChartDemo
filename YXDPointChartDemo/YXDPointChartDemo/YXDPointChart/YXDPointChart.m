//
//  YXDPointChart.m
//  YXDPointChartDemo
//
//  Created by YangXudong on 15/5/21.
//  Copyright (c) 2015年 YangXudong. All rights reserved.
//


#define Define_YXDPointChart_Margin_Left                30
#define Define_YXDPointChart_Margin_Right               5
#define Define_YXDPointChart_Margin_Top                 5
#define Define_YXDPointChart_Margin_Bottom              5

#define Define_YXDPointChart_Padding_Top                10
#define Define_YXDPointChart_Padding_Bottom             30

#define Define_YXDPointChart_Max_XValue                 3
#define Define_YXDPointChart_Gap_In_XValue              5

#define Define_YXDPointChart_Color_Default              [UIColor blackColor]

#define Define_YXDPointChart_Lable_Font_Size_Default    12

#define Define_YXDPointChart_Point_Radius_Default       3


#import "YXDPointChart.h"

@interface YXDPointChart ()
{
    CGRect pointChartFrame;                     //实际表格大小
    
    NSInteger linesCount;                       //横线数量
    CGFloat linesGap;                           //横线之间的间距
    NSArray *yValues;                           //y轴数值
    NSArray *yColors;                           //y轴对应的颜色
    
    CGFloat chartContentWidth;                  //表格总宽度
    
    NSInteger maxXValuesNumberPerScreen;        //每页显示的最多数量
    NSInteger xValuesCount;                     //数据组数量
    NSArray *xLableValues;                      //x轴标签内容
    NSArray *xValues;                           //x轴数据
    NSArray *xColors;                           //x轴数据点颜色
    NSInteger valueCountInGroup;                //每组数据的个数
    
    CGFloat xValueWidth;                        //每组数据的宽度
    CGFloat xValueGap;                          //数据组之间的间隙
    
    CGFloat xValueInGap;                        //每组数据内部数据的间隙
    
    NSInteger xLableFontSize;                   //x轴标签字体大小
    NSInteger yLableFontSize;                   //y轴标签字体大小
    UIColor *xLableTextColor;                   //x轴标签字体颜色
    
    NSInteger pointRadius;                      //数据点的大小
}


@property (nonatomic, strong) UIScrollView *pointChartView;

@end

@implementation YXDPointChart

- (void) action_showChart {
    
    //获取y轴数量
    if ([self.delegate respondsToSelector:@selector(yValuesOfPointChart:)]) {
        yValues = [self.delegate yValuesOfPointChart:self];
        linesCount = yValues.count;
    }
    
    if (!linesCount) {
        return;
    }
    
    //生成点图表
    CGSize selfSize = self.frame.size;
    self.pointChartView = [[UIScrollView alloc] initWithFrame:CGRectMake(Define_YXDPointChart_Margin_Left,
                                                                         Define_YXDPointChart_Margin_Top,
                                                                         selfSize.width-Define_YXDPointChart_Margin_Left-Define_YXDPointChart_Margin_Right,
                                                                         selfSize.height-Define_YXDPointChart_Margin_Top-Define_YXDPointChart_Margin_Bottom)];
    self.pointChartView.showsHorizontalScrollIndicator = NO;
    self.pointChartView.showsVerticalScrollIndicator = NO;
    
    if ([self.delegate respondsToSelector:@selector(pageEnableOfPointChart:)]) {
        self.pointChartView.pagingEnabled = [self.delegate pageEnableOfPointChart:self];
    }
    
    [self addSubview:self.pointChartView];
    pointChartFrame = self.pointChartView.frame;
    
    //获取虚线之间的间隙
    linesGap = (pointChartFrame.size.height - Define_YXDPointChart_Padding_Top - Define_YXDPointChart_Padding_Bottom) / (linesCount - 1);
    
    
    //获取x轴标签数据和数量
    if ([self.delegate respondsToSelector:@selector(xLablesOfPointChart:)]) {
        xLableValues = [self.delegate xLablesOfPointChart:self];
        xValuesCount = xLableValues.count;
    }
    
    //获取x轴数据
    if ([self.delegate respondsToSelector:@selector(xValuesOfPointChart:)]) {
        xValues = [self.delegate xValuesOfPointChart:self];
    }
    
//    NSAssert(xValues.count == xValuesCount, @"x轴标签数量与数据数量不一致");
    
    //获取x轴数据组内部间隙
    if ([self.delegate respondsToSelector:@selector(gapBetweenXValuesOfChart:)]) {
        xValueInGap = [self.delegate gapBetweenXValuesOfChart:self];
        if (xValueInGap < 1) {
            xValueInGap = Define_YXDPointChart_Gap_In_XValue;
        }
    } else {
        xValueInGap = Define_YXDPointChart_Gap_In_XValue;
    }
    
    //获取每组数据的宽度
    if ([self.delegate respondsToSelector:@selector(valueCountInGroupOfChart:)]) {
        valueCountInGroup = [self.delegate valueCountInGroupOfChart:self];
    } else {
        if (xValues.count) {
            NSArray *data = [xValues firstObject];
            if ([data isKindOfClass:[NSArray class]]) {
                valueCountInGroup = data.count;
            }
        }
    }
    xValueWidth = xValueInGap * (valueCountInGroup + 1);
    
    //获取每页显示的最大数量
    if ([self.delegate respondsToSelector:@selector(maxNumberOfXLablesOfChart:)]) {
        maxXValuesNumberPerScreen = [self.delegate maxNumberOfXLablesOfChart:self];
    } else {
        maxXValuesNumberPerScreen = Define_YXDPointChart_Max_XValue;
    }
    
    //获取每组数据间的间隙
    xValueGap = (pointChartFrame.size.width - (maxXValuesNumberPerScreen * xValueWidth)) / maxXValuesNumberPerScreen;
    
    //获取表格总宽度
    chartContentWidth = (xValueWidth + xValueGap) * xValuesCount;
    
    //给图表content赋值
    self.pointChartView.contentSize = CGSizeMake(chartContentWidth, pointChartFrame.size.height);
    
    
    //获取y轴标签和横线颜色
    if ([self.delegate respondsToSelector:@selector(yValueColorsOfPointChart:)]) {
        yColors = [self.delegate yValueColorsOfPointChart:self];
    }
    
    //获取x轴数据点颜色
    if ([self.delegate respondsToSelector:@selector(xValueColorsOfPointChart:)]) {
        xColors = [self.delegate xValueColorsOfPointChart:self];
    }
    
    //获取x轴标签字体大小
    if ([self.delegate respondsToSelector:@selector(xLableFontSizeOfPointChart:)]) {
        xLableFontSize = [self.delegate xLableFontSizeOfPointChart:self];
    } else {
        xLableFontSize = Define_YXDPointChart_Lable_Font_Size_Default;
    }
    
    //获取x轴标签字体颜色
    if ([self.delegate respondsToSelector:@selector(xLableTextColorOfPointChart:)]) {
        xLableTextColor = [self.delegate xLableTextColorOfPointChart:self];
    } else {
        xLableTextColor = Define_YXDPointChart_Color_Default;
    }
    
    //获取y轴标签字体大小
    if ([self.delegate respondsToSelector:@selector(yLableFontSizeOfPointChart:)]) {
        yLableFontSize = [self.delegate yLableFontSizeOfPointChart:self];
    } else {
        yLableFontSize = Define_YXDPointChart_Lable_Font_Size_Default;
    }
    
    //获取数据点大小
    if ([self.delegate respondsToSelector:@selector(pointRadiusOfPointChart:)]) {
        pointRadius = [self.delegate pointRadiusOfPointChart:self];
    } else {
        pointRadius = Define_YXDPointChart_Point_Radius_Default;
    }
    
    //画横线 生成y轴标签
    for (int i = 0; i < linesCount; i++) {
        
        CGFloat yValue = [yValues[i] floatValue];
        UIColor *color = (yColors.count == linesCount)?yColors[i]:(yColors.count?yColors[i]:Define_YXDPointChart_Color_Default);
        
        //画线
        CGRect lineFrame = CGRectMake(0, pointChartFrame.size.height - Define_YXDPointChart_Padding_Bottom - i*linesGap, (chartContentWidth > self.pointChartView.frame.size.width)?chartContentWidth:self.pointChartView.frame.size.width, 0.5);
        [self.pointChartView.layer addSublayer:[self action_lineLayerWithFrame:lineFrame color:color]];
        
        //生成y轴标签
        UILabel *yLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Define_YXDPointChart_Margin_Left, linesGap)];
        yLable.center = CGPointMake(Define_YXDPointChart_Margin_Left/2-2, lineFrame.origin.y+Define_YXDPointChart_Margin_Top);
        yLable.textAlignment = NSTextAlignmentRight;
        yLable.font = [UIFont systemFontOfSize:yLableFontSize];
        yLable.textColor = color;
        yLable.text = [NSString stringWithFormat:@"%.1lf",yValue];
        [self addSubview:yLable];
    }
    
    //生成x轴标签 画点
    for (int i = 0; i < xValuesCount; i++) {
        
        CGPoint xLableCenter = CGPointMake((xValueWidth + xValueGap) * (i + 0.5), pointChartFrame.size.height - (Define_YXDPointChart_Padding_Bottom/2));
        
        //生成x轴标签
        UILabel *xLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, xValueWidth+xValueGap, Define_YXDPointChart_Padding_Bottom)];
        xLable.center = xLableCenter;
        xLable.text = xLableValues[i];
        xLable.textAlignment = NSTextAlignmentCenter;
        xLable.textColor = xLableTextColor;
        xLable.font = [UIFont systemFontOfSize:xLableFontSize];
        [self.pointChartView addSubview:xLable];
        
        //生成x轴点
        NSArray *data = xValues[i];
        
        if (![data isKindOfClass:[NSArray class]] || !data.count) {
            continue;
        }
        
        //数据内部的元素还是数组 则需要针对每个子数组给不同的颜色
        if ([[data firstObject] isKindOfClass:[NSArray class]]) {
            
            NSInteger groupCount = 0;
            //先获取data里面元素的总数
            for (NSArray *arr in data) {
                groupCount += ([arr isKindOfClass:[NSArray class]])?arr.count:0;
            }
            
            //计算每个点的位置
            
            NSInteger currentIndex = 0;
            
            for (NSArray *arr in data) {
                
                if (![arr isKindOfClass:[NSArray class]]) {
                    continue;
                }
                
                for (int j = 0; j < arr.count; j++) {
                    
                    CGFloat yValue = [arr[j] floatValue];
                    CGFloat pointY = Define_YXDPointChart_Padding_Top;
                    
                    //计算y值
                    pointY += [self action_yLengthWithValue:yValue];
                    
                    if (pointY > 0) {
                        //x轴显示标签的中心
                        CGFloat pointX = xLableCenter.x;
                        //计算x值
                        pointX += [self action_xLengthWithIndex:currentIndex++ count:groupCount];
                        
                        UIColor *color = Define_YXDPointChart_Color_Default;
                        
                        if (xColors.count && [[xColors firstObject] isKindOfClass:[NSArray class]]) {
                            NSArray *colorGroup = [xColors firstObject];
                            color = [colorGroup objectAtIndex:([data indexOfObject:arr])%colorGroup.count];
                        }
                        
                        [self.pointChartView.layer addSublayer:[self action_pointWithCenter:CGPointMake(pointX, pointY) radius:pointRadius color:color]];
                    }
                }
            }
            
        } else {
            //绘制每组的数据
            for (int j = 0; j < data.count; j++) {
                
                CGFloat yValue = [data[j] floatValue];
                CGFloat pointY = Define_YXDPointChart_Padding_Top;
                
                //计算y值
                pointY += [self action_yLengthWithValue:yValue];
                
                if (pointY > 0) {
                    //x轴显示标签的中心
                    CGFloat pointX = xLableCenter.x;
                    //计算x值
                    pointX += [self action_xLengthWithIndex:j count:data.count];
                
                    UIColor *color = Define_YXDPointChart_Color_Default;
                    
                    if (xColors.count && [[xColors firstObject] isKindOfClass:[UIColor class]]) {
                        color = [xColors objectAtIndex:i%xColors.count];
                    }
                    
                    [self.pointChartView.layer addSublayer:[self action_pointWithCenter:CGPointMake(pointX, pointY) radius:pointRadius color:color]];
                }
            }
        }
    }
}

//根据当前点的index和所有点数判断当前点应在的位置
- (CGFloat) action_xLengthWithIndex:(NSInteger)index count:(NSInteger)count {
    
    if (!count) {
        return 0;
    }
    
    NSInteger centerIndex = count/2;
    
    if (count%2) {
        //奇数点
        return (index - centerIndex) * xValueInGap;
    } else {
        //偶数点
        return (index - centerIndex + 0.5) * xValueInGap;
    }
    
    return 0;
}

//通过当前y值大小 判断所在的高度
- (CGFloat) action_yLengthWithValue:(CGFloat)yValue {
    
    CGFloat maxY = [[yValues lastObject] floatValue];
    CGFloat minY = [[yValues firstObject] floatValue];
    
    //大于最大值 小于最小值 不显示
    if (yValue > maxY || yValue < minY) {
        return -999;
    }
    
    for (int i = 0; i < yValues.count; i++) {
        
        CGFloat yLineValue = [yValues[i] floatValue];
        CGFloat yPreviousLineValue = (i>0)?[yValues[i-1] floatValue]:0;
        
        if (yValue <= yLineValue) {
            return (((yLineValue - yValue) / (yLineValue - yPreviousLineValue)) + (yValues.count - 1 - i)) * linesGap;
        }
    }
    
    return -999;
}

#pragma mark -

+(YXDPointChart *)pointChartWithFrame:(CGRect)frame delegate:(id<YXDPointChartDelegate>)delegate {
    YXDPointChart *chart = [[YXDPointChart alloc] initWithFrame:frame];
    chart.delegate = delegate;
    return chart;
}


#pragma mark -

//绘制虚线
- (CAShapeLayer *) action_lineLayerWithFrame:(CGRect)frame color:(UIColor *)color {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFrame:frame];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:[color CGColor]];
    [shapeLayer setLineWidth:frame.size.height];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:@[@10,@2]];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, frame.size.width,0);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    return shapeLayer;
}

//画圆点
- (CALayer *) action_pointWithCenter:(CGPoint)center radius:(NSInteger)radius color:(UIColor *)color {
    
    CALayer *pointLayer = [CALayer layer];
    [pointLayer setFrame:CGRectMake(0, 0, 2*radius, 2*radius)];
    [pointLayer setPosition:center];
    [pointLayer setMasksToBounds:YES];
    [pointLayer setBackgroundColor:color.CGColor];
    [pointLayer setCornerRadius:radius];
    
    return pointLayer;
}

@end
