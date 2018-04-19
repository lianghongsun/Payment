//
//  ConstituteVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/8.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "ConstituteVC.h"
#import "AAChartKit.h"

@interface ConstituteVC ()
{
    
    NSMutableArray  *_array;
}
@property (nonatomic, strong) AAChartModel *aaChartModel;
@property (nonatomic, strong) AAChartView  *aaChartView;
@end

@implementation ConstituteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收款构成";
    _array = [NSMutableArray array];
    [_array addObject:@"90"];
    [_array addObject:@"10"];
    
   [self setUpTheAAChartViewWithChartType:AAChartTypePie];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}



- (void)setUpTheAAChartViewWithChartType:(AAChartType)chartType {
    
    self.aaChartView = [[AAChartView alloc]init];
    self.aaChartView.frame = CGRectMake(0, 10, SCREEN_W, 130);
    //    self.aaChartView.delegate = self;
    self.aaChartView.scrollEnabled = NO;//禁用 AAChartView 滚动效果
    //    设置aaChartVie 的内容高度(content height)
    //    self.aaChartView.contentHeight = chartViewHeight;
    [self.backgrView addSubview:self.aaChartView];
    
    
    //设置 AAChartView 的背景色是否为透明
//    self.aaChartView.isClearBackgroundColor = YES;
    
    self.aaChartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypePie)
    .colorsThemeSet(@[@"#B8E0F2",@"#C8DDA5"])
    .titleSet(@"")
    .subtitleSet(@"")
    .legendEnabledSet(false)//隐藏图例(底部可点按的小圆点)
    .dataLabelEnabledSet(true)//是否直接显示扇形图数据
    .yAxisTitleSet(@"摄氏度")
    .tooltipEnabledSet(false)//禁用浮动提示框 tooltip
    .seriesSet(
               @[
                 AAObject(AASeriesElement)
                 .nameSet(@"语言热度值")
                 .innerSizeSet(@"0%")//内部圆环半径大小占比
                 .allowPointSelectSet(true)//是否允许在点击数据点标记(扇形图点击选中的块发生位移)
                 .dataSet(
                          @[
                            @[@"Firefox",   @500],
                            @[@"IE",        @100],

                            ]
                          ),
                 ]
               )
    ;
    
    

    
     [self.aaChartView aa_drawChartWithChartModel:_aaChartModel];
}


- (IBAction)choosetimeAction:(id)sender {
}
@end
