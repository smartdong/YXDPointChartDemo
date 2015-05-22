//
//  ViewController.m
//  YXDPointChartDemo
//
//  Created by YangXudong on 15/5/21.
//  Copyright (c) 2015年 YangXudong. All rights reserved.
//

#import "ViewController.h"
#import "YXDPointChart.h"

@interface ViewController ()<YXDPointChartDelegate>

@property (nonatomic, strong) YXDPointChart *pointChart_1;

@property (nonatomic, strong) YXDPointChart *pointChart_2;

@end

@implementation ViewController

/**
 *  配置y轴
 *
 *  @param pointChart pointChart
 *
 *  @return y轴数据 NSNumber类型 从小到大排列
 */
- (NSArray *) yValuesOfPointChart:(YXDPointChart *)pointChart {
    return @[@4.4,@7.0,@10.0];
}

/**
 *  x轴显示的数据
 *
 *  @param pointChart pointChart
 *
 *  @return 数组的元素为一组数据  例如@[@[@1,@2],@[@4,@5],@[@6]]
 */
- (NSArray *) xValuesOfPointChart:(YXDPointChart *)pointChart {
    if (pointChart == _pointChart_1) {
        return @[@[@7,@6],@[@10,@4.4],@[@6,@7],@[@8]];
    }
    return @[@[@[@8,@6],@[@9,@7],@[@7,@6],@[@6]],
             @[@[@5,@7],@[@8,@5],@[@9,@4],@[@7]],
             @[@[@9,@6],@[@6,@9],@[@8,@6],@[@9]],
             @[@[@8,@6],@[@9,@7],@[@8,@6],@[@5]],
             @[@[@8,@6],@[@9,@7],@[@8,@6],@[@5]],
             @[@[@8,@6],@[@9,@7],@[@8,@6],@[@5]],
             @[@[@8,@6],@[@9,@7],@[@8,@6],@[@5]]];
}

/**
 *  x轴显示的标签
 *
 *  @param pointChart pointChart
 *
 *  @return x轴的标签  数量必须与 - (NSArray *) xValuesOfPointChart:(YXDPointChart *)pointChart 返回的数组元素数量一致
 */
- (NSArray *) xLablesOfPointChart:(YXDPointChart *)pointChart {
    if (pointChart == _pointChart_1) {
        return @[@"早餐",@"午餐",@"晚餐",@"凌晨"];
    }
    return @[@"05-01",@"05-02",@"05-03",@"05-04",@"05-05",@"05-06",@"05-07"];
}


/**
 *  当前图表显示的最大数量
 *
 *  @param pointChart pointChart
 *
 *  @return 最大数量  剩下的可以滚动显示  默认为3
 */
- (NSInteger) maxNumberOfXLablesOfChart:(YXDPointChart *)pointChart {
    if (pointChart == _pointChart_1) {
        return 4;
    }
    return 3;
}

/**
 *  每组数据内部之间的间隙
 *
 *  @param pointChart pointChart
 *
 *  @return 间隙 小于1时默认为5
 */
- (NSInteger) gapBetweenXValuesOfChart:(YXDPointChart *)pointChart {
    if (pointChart == _pointChart_1) {
        return 10;
    }
    return 7;
}

/**
 *  y轴标签的颜色数组
 *
 *  @param pointChart pointChart
 *
 *  @return 颜色数组 如果数量小于y轴标签的数量 则默认只使用第一个颜色
 */
- (NSArray *) yValueColorsOfPointChart:(YXDPointChart *)pointChart {
    return @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor]];
}

/**
 *  x轴数据点的颜色
 *
 *  @param pointChart pointChart
 *
 *  @return 如果数组的元素是颜色 如@[[UIColor whiteColor],[UIColor blackColor]] 则x轴数据的第一组数组颜色都为白色,第二组数据都为黑色,以此类推
 *          如果数组的元素是数组 如@[@[[UIColor whiteColor],[UIColor blackColor]]],则每组数据内部,第一组数据为白色,第二组数据为黑色..
 */
- (NSArray *) xValueColorsOfPointChart:(YXDPointChart *)pointChart {
    if (pointChart == _pointChart_1) {
        return @[[UIColor redColor],[UIColor greenColor]];
    }
    
    return @[@[[UIColor redColor],[UIColor greenColor],[UIColor blueColor],[UIColor purpleColor]]];
}

-(UIColor *)xLableTextColorOfPointChart:(YXDPointChart *)pointChart {
    return [UIColor darkGrayColor];
}

-(BOOL)pageEnableOfPointChart:(YXDPointChart *)pointChart {
    return YES;
}

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.pointChart_1 = [YXDPointChart pointChartWithFrame:CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 20*2, 100) delegate:self];
    [self.pointChart_1 action_showChart];
    [self.view addSubview:self.pointChart_1];
    
    
    self.pointChart_2 = [YXDPointChart pointChartWithFrame:CGRectMake(20, 300, [UIScreen mainScreen].bounds.size.width - 20*2, 100) delegate:self];
    [self.pointChart_2 action_showChart];
    [self.view addSubview:self.pointChart_2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
