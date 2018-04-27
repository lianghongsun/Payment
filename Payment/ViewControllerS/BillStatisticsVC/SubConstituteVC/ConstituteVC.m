//
//  ConstituteVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/8.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "ConstituteVC.h"
#import "AAChartKit.h"
#import "HistoryTimeVC.h"
#import "PercentBillApi.h"
#import "YHKModel.h"

@interface ConstituteVC ()
{
    NSString *mybegintime;
    NSString *mymonthtime;
    NSMutableArray  *_array;
    UserInfo *user;
    float weixinmoney;
    float ailmoney;
}
@property (nonatomic, strong) AAChartModel *aaChartModel;
@property (nonatomic, strong) AAChartView  *aaChartView;
@end

@implementation ConstituteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收款构成";
    user = [UserInfo shareObject];
    mybegintime = [JCAUtility stringWithCurrentTime:@"yyyy年MM月"];
    mymonthtime = [JCAUtility stringWithCurrentTime:@"yyyy-MM"];
    self.timeLab.text = [NSString stringWithFormat:@"%@份",mybegintime];
    
    [self PercentBillApi:user.uid Monthdata:[JCAUtility stringWithCurrentTime:@"yyyy-MM"]];
    
    _array = [NSMutableArray array];
    [_array addObject:@"90"];
    [_array addObject:@"10"];
    
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
                            @[@"Firefox",   [NSNumber numberWithFloat:ailmoney]],
                            @[@"IE",        [NSNumber numberWithFloat:weixinmoney]],

                            ]
                          ),
                 ]
               )
    ;
    
    

    
     [self.aaChartView aa_drawChartWithChartModel:_aaChartModel];
}


- (IBAction)choosetimeAction:(id)sender {
    HistoryTimeVC *vc = [[HistoryTimeVC alloc]initWithNibName:@"HistoryTimeVC" bundle:nil];
    vc.choosetime = mybegintime;
    vc.startDate = [JCAUtility DataWithTimestr:mybegintime formatStr:@"yyyy年MM月"];
    vc.choosetimeBlock = ^(NSString *begintime,NSDate *choosedata ) {
        mybegintime = begintime;
        self.timeLab.text = [NSString stringWithFormat:@"%@份",begintime];
        mybegintime = [JCAUtility stringWithData:choosedata formatStr:@"yyyy年MM月"];
        mymonthtime = [JCAUtility stringWithData:choosedata formatStr:@"yyyy-MM"];
        [self PercentBillApi:user.uid Monthdata:[JCAUtility stringWithData:choosedata formatStr:@"yyyy-MM"]];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)PercentBillApi:(NSString *)uid Monthdata:(NSString *)monthdata{
    [self showLoding:@"请稍后"];
    PercentBillApi *monbill = [[PercentBillApi alloc]initWithUid:uid MonthDate:monthdata];
    [monbill startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            [self closeLoding];
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    
                    NSMutableArray*listarr = [NSMutableArray array];
                    [listarr addObjectsFromArray:[TodayBillFirstModel mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"data"]]];
                    
                    TodayBillFirstModel *model1 = listarr[0];
                    TodayBillFirstModel *model2 = listarr[1];
                    
                    self.totalrevenueLab.text = [NSString stringWithFormat:@"¥%.2f",[model1.totalAmount floatValue]+[model2.totalAmount floatValue]];

                    if ([model1.platformId isEqualToString:@"100"]) {
                        self.weixinincomeLab.text = [NSString stringWithFormat:@"%.2f元",[model1.totalAmount floatValue]];
                        weixinmoney = [model1.totalAmount floatValue];
                    }
                    else{
                        self.ailpayincomeLab.text = [NSString stringWithFormat:@"%.2f元",[model1.totalAmount floatValue]];
                        ailmoney = [model1.totalAmount floatValue];
                    }

                    if ([model2.platformId isEqualToString:@"100"]) {
                        self.weixinincomeLab.text = [NSString stringWithFormat:@"%.2f元",[model2.totalAmount floatValue]];
                        weixinmoney = [model2.totalAmount floatValue];
                    }
                    else{
                        self.ailpayincomeLab.text = [NSString stringWithFormat:@"%.2f元",[model2.totalAmount floatValue]];
                        ailmoney = [model2.totalAmount floatValue];
                    }
                    
                    [self setUpTheAAChartViewWithChartType:AAChartTypePie];
                }
                    break;
                default:
                {
                    NSString *mesgStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"msg"]];
                    [self showMessage:mesgStr viewHeight:0];
                }
                    break;
            }
        }
    } failure:^(YTKBaseRequest *request) {
        [self closeLoding];
        
        
    }];
}


@end
