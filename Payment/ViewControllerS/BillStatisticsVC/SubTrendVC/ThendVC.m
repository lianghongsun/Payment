//
//  ThendVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/18.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "ThendVC.h"
#import "AAChartKit.h"
#import "VersionCell.h"
#import "YearHistoryBillApi.h"
#import "YHKModel.h"

@interface ThendVC ()<UITableViewDataSource,UITableViewDelegate,WeChatStylePlaceHolderDelegate>
{
    NSInteger indexnum;
    UserInfo *user;
    NSString *lastmonth;
    NSString *firstmonth;
    NSString *secondmonth;
    NSString *threemonth;
    NSString *fourmonth;
    NSString *fivetmonth;
    NSString *sixtmonth;
    
    double lastmoney;
    double firstmoney;
    double secondmoney;
    double threemoney;
    double fourmoney;
    double fivetmoney;
    double sixtmoney;
    
    NSInteger  lastpen;
    NSInteger firstpen;
    NSInteger secondpen;
    NSInteger threepen;
    NSInteger fourpen;
    NSInteger fivetpen;
    NSInteger sixtpen;
    
}
@property (nonatomic, strong) AAChartModel *aaChartModel;
@property (nonatomic, strong) AAChartView  *aaChartView;
@property (nonatomic,strong) NSMutableArray *listdataArr;

@end

@implementation ThendVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收款趋势";
    self.listdataArr = [NSMutableArray array];
    user = [UserInfo shareObject];
    [self YearHistoryBillApi:user.uid];
    [self setBtntitleColour:self.timeBtn1 OtheroneBtn:self.timeBtn2 OthertwoBtn:self.timeBtn3 OtherthreeBtn:self.timeBtn4 OtherfourBtn:self.timeBtn5 OthertfiveBtn:self.timeBtn6 FirstColour:[UIColor whiteColor] OtherColour:RGB(195, 224, 246)];
    indexnum = 1;
    [self.tableview registerNib:[UINib nibWithNibName:@"VersionCell" bundle:nil] forCellReuseIdentifier:@"VersionCell"];
    [self setrefreshHeaderOrFooter];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -- sterefresh

- (void)setrefreshHeaderOrFooter {
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

- (void)loadNewData {
    [self.tableview cyl_reloadData];
    [self.tableview.mj_header endRefreshing];
}

- (void)setUpTheAAChartViewWithChartType:(AAChartType)chartType
{
    
    self.aaChartView = [[AAChartView alloc]init];
    self.aaChartView.frame = CGRectMake(0, 0, SCREEN_W, 160);
//    self.aaChartView.delegate = self;
    self.aaChartView.scrollEnabled = NO;//禁用 AAChartView 滚动效果
    //    设置aaChartVie 的内容高度(content height)
    //    self.aaChartView.contentHeight = chartViewHeight;
    [self.backgrview addSubview:self.aaChartView];
    
    
    //设置 AAChartView 的背景色是否为透明
    self.aaChartView.isClearBackgroundColor = YES;
    
    self.aaChartModel= AAObject(AAChartModel)
    .legendEnabledSet(false)//隐藏图例(底部可点按的小圆点)
    .chartTypeSet(chartType)//图表类型
    .titleSet(@"")//图表主标题
    .titleFontSizeSet(@18)
    .titleFontColorSet(@"#FFFFFF")
    .subtitleSet(@"")//图表副标题
    .yAxisVisibleSet(false)//设置 Y 轴是否可见
    .categoriesSet(@[firstmonth,secondmonth,threemonth,fourmonth, fivetmonth,sixtmonth])//图表横轴的内容
    .xAxisVisibleSet(false)//设置 X 轴是否可见
    .colorsThemeSet(@[@"#FFFFFF",@"#FFFFFF",@"#FFFFFF",@"#FFFFFF"])//设置主体颜色数组
    .yAxisTitleSet(@"")//设置 Y 轴标题
    .tooltipValueSuffixSet(@"")//设置浮动提示框单位后缀
//    .backgroundColorSet(@"#00AEEC")
    .yAxisGridLineWidthSet(@0)//y轴横向分割线宽度为0(即是隐藏分割线)
    .xAxisGridLineWidthSet(@0)
    .xAxisTickIntervalSet(@0)
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"金额")
                 .dataSet(@[[NSNumber numberWithDouble:firstmoney], [NSNumber numberWithDouble:secondmoney], [NSNumber numberWithDouble:threemoney], [NSNumber numberWithDouble:fourmoney], [NSNumber numberWithDouble:fivetmoney], [NSNumber numberWithDouble:sixtmoney]]),
                 AAObject(AASeriesElement)
                 .nameSet(@"金额")
                 .dataSet(@[]),
                 AAObject(AASeriesElement)
                 .nameSet(@"金额")
                 .dataSet(@[]),
                 AAObject(AASeriesElement)
                 .nameSet(@"笔数")
                 .dataSet(@[[NSNumber numberWithInteger:firstpen], [NSNumber numberWithInteger:secondpen], [NSNumber numberWithInteger:threepen], [NSNumber numberWithInteger:fourpen], [NSNumber numberWithInteger:fivetpen], [NSNumber numberWithInteger:sixtpen]])
                 ]
               );
    
    
    /*配置 Y 轴标注线,解开注释,即可查看添加标注线之后的图表效果(NOTE:必须设置 Y 轴可见)*/
        [self configureTheYAxisPlotLineForAAChartView];
    
    [self.aaChartView aa_drawChartWithChartModel:_aaChartModel];
}

/**
 *   图表 Y 轴标示线的设置
 *   标示线设置作为图表一项基础功能,用于对图表的基本数据水平均线进行标注
 *   虽然不太常被使用,但我们仍然提供了此功能的完整接口,以便于有特殊需求的用户使用
 *   解除👆上面的设置 Y 轴标注线的已被注释代码,,运行程序,即可查看实际工程效果以酌情选择
 *
 **/
- (void)configureTheYAxisPlotLineForAAChartView {
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[NSNumber numberWithFloat:firstmoney]];
    [array addObject:[NSNumber numberWithFloat:secondmoney]];
    [array addObject:[NSNumber numberWithFloat:threemoney]];
    [array addObject:[NSNumber numberWithFloat:fourmoney]];
    [array addObject:[NSNumber numberWithFloat:fivetmoney]];
    [array addObject:[NSNumber numberWithFloat:sixtmoney]];
    
    for (int i = 1; i < array.count; i++) {
        for (int j = 0; j < array.count - i; j++) {
            if ([array[j] compare:array[j+1]] == NSOrderedDescending) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
            printf("排序中:");
        }
    }
    
    int biggestnum = [array[array.count-1]intValue];
    NSInteger newbiggsnum = 0;
    if (biggestnum<=100) {
        newbiggsnum = 100;
    }
    else if (biggestnum<=1000){
        newbiggsnum = 1000;
    }
    else if (biggestnum<=10000){
        newbiggsnum = 10000;
    }
    else {
        newbiggsnum = 100000;
    }
    
    
    NSInteger numvue = newbiggsnum/4;
    _aaChartModel.yAxisMaxSet(@(newbiggsnum))//Y轴最大值
    .yAxisMinSet(@(1))//Y轴最小值
    .yAxisAllowDecimalsSet(NO)//是否允许Y轴坐标值小数
    .yAxisTickPositionsSet(@[@(0),@(numvue*1),@(numvue*2),@(numvue*3),@(numvue*4)])//指定y轴坐标
    .yAxisPlotLinesSet(@[
                         AAObject(AAPlotLinesElement)
                         .colorSet(@"#F05353")//颜色值(16进制)
                         .dashStyleSet(AALineDashSyleTypeLongDashDot)//样式：Dash,Dot,Solid等,默认Solid
                         .widthSet(@(1)) //标示线粗细
                         .valueSet(@(20)) //所在位置
                         .zIndexSet(@(1)) //层叠,标示线在图表中显示的层叠级别，值越大，显示越向前
                         .labelSet(@{@"text":@"",@"x":@(0),@"style":@{@"color":@"#33bdfd"}})/*这里其实也可以像AAPlotLinesElement这样定义个对象来赋值（偷点懒直接用了字典，最会终转为js代码，可参考https://www.hcharts.cn/docs/basic-plotLines来写字典）*/
                         ,AAObject(AAPlotLinesElement)
                         .colorSet(@"#33BDFD")
                         .dashStyleSet(AALineDashSyleTypeLongDashDot)
                         .widthSet(@(1))
                         .valueSet(@(40))
                         .labelSet(@{@"text":@"",@"x":@(0),@"style":@{@"color":@"#33bdfd"}})
                         ,AAObject(AAPlotLinesElement)
                         .colorSet(@"#ADFF2F")
                         .dashStyleSet(AALineDashSyleTypeLongDashDot)
                         .widthSet(@(1))
                         .valueSet(@(60))
                         .labelSet(@{@"text":@"",@"x":@(0),@"style":@{@"color":@"#33bdfd"}})
                         ]
                       );
}

- (IBAction)timeBtn1Action:(id)sender {
    if (indexnum == 1) {
        return;
    }
        indexnum = 1;
        [self.tableview.mj_header beginRefreshing];
        [self setBtntitleColour:self.timeBtn1 OtheroneBtn:self.timeBtn2 OthertwoBtn:self.timeBtn3 OtherthreeBtn:self.timeBtn4 OtherfourBtn:self.timeBtn5 OthertfiveBtn:self.timeBtn6 FirstColour:[UIColor whiteColor] OtherColour:RGB(195, 224, 246)];
}

- (IBAction)timeBtn2Action:(id)sender {
    if (indexnum == 2) {
        return;
    }
        indexnum = 2;
        [self.tableview.mj_header beginRefreshing];
        [self setBtntitleColour:self.timeBtn2 OtheroneBtn:self.timeBtn1 OthertwoBtn:self.timeBtn3 OtherthreeBtn:self.timeBtn4 OtherfourBtn:self.timeBtn5 OthertfiveBtn:self.timeBtn6 FirstColour:[UIColor whiteColor] OtherColour:RGB(195, 224, 246)];
}



- (IBAction)timeBtn3Action:(id)sender {
    if (indexnum == 3) {
        return;
    }
    indexnum = 3;
    [self.tableview.mj_header beginRefreshing];
    [self setBtntitleColour:self.timeBtn3 OtheroneBtn:self.timeBtn1 OthertwoBtn:self.timeBtn2 OtherthreeBtn:self.timeBtn4 OtherfourBtn:self.timeBtn5 OthertfiveBtn:self.timeBtn6 FirstColour:[UIColor whiteColor] OtherColour:RGB(195, 224, 246)];
    
}

- (IBAction)timeBtn4Action:(id)sender {
    if (indexnum == 4) {
        return;
    }
    indexnum = 4;
    [self.tableview.mj_header beginRefreshing];
    [self setBtntitleColour:self.timeBtn4 OtheroneBtn:self.timeBtn1 OthertwoBtn:self.timeBtn2 OtherthreeBtn:self.timeBtn3 OtherfourBtn:self.timeBtn5 OthertfiveBtn:self.timeBtn6 FirstColour:[UIColor whiteColor] OtherColour:RGB(195, 224, 246)];
}

- (IBAction)timeBtn5Action:(id)sender {
    if (indexnum == 5) {
        return;
    }
    indexnum = 5;
    [self.tableview.mj_header beginRefreshing];
    [self setBtntitleColour:self.timeBtn5 OtheroneBtn:self.timeBtn1 OthertwoBtn:self.timeBtn2 OtherthreeBtn:self.timeBtn3 OtherfourBtn:self.timeBtn4 OthertfiveBtn:self.timeBtn6 FirstColour:[UIColor whiteColor] OtherColour:RGB(195, 224, 246)];
    
}

- (IBAction)timeBtn6Action:(id)sender {
    if (indexnum == 6) {
        return;
    }
    indexnum = 6;
    [self.tableview.mj_header beginRefreshing];
    [self setBtntitleColour:self.timeBtn6 OtheroneBtn:self.timeBtn1 OthertwoBtn:self.timeBtn2 OtherthreeBtn:self.timeBtn3 OtherfourBtn:self.timeBtn4 OthertfiveBtn:self.timeBtn5 FirstColour:[UIColor whiteColor] OtherColour:RGB(195, 224, 246)];
}


- (void)setBtntitleColour:(UIButton *)firstbtn OtheroneBtn:(UIButton *)otherone OthertwoBtn:(UIButton *)othertwo OtherthreeBtn:(UIButton *)otherthree OtherfourBtn:(UIButton *)otherfour OthertfiveBtn:(UIButton *)otherfive FirstColour:(UIColor *)firstcolour OtherColour:(UIColor *)othercolour {
    [firstbtn setTitleColor:firstcolour forState:UIControlStateNormal];
    [otherone setTitleColor:othercolour forState:UIControlStateNormal];
    [othertwo setTitleColor:othercolour forState:UIControlStateNormal];
    [otherthree setTitleColor:othercolour forState:UIControlStateNormal];
    [otherfour setTitleColor:othercolour forState:UIControlStateNormal];
    [otherfive setTitleColor:othercolour forState:UIControlStateNormal];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.listdataArr.count>0) {
      return 2;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TAbcell_H;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier1 = @"VersionCell";
    VersionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    YearlistBillFirstModel *model = self.listdataArr[indexnum];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.versioLab.text = [NSString stringWithFormat:@"%@收款金额",model.monthDate];
            cell.subLab.text = [NSString stringWithFormat:@"¥%.2f",model.totalAmount];
        }
        else{
            cell.versioLab.text = @"环比增长";
            if (indexPath.row == 0) {
                if (lastmoney <=0) {
                    cell.subLab.text = @"上月无数据";
                }
                else{
                    float pricenum = (model.totalAmount-lastmoney )/lastmoney ;
                    cell.subLab.text = [NSString stringWithFormat:@"%.2f%@",pricenum,@"%"];
                }
            }
            else{
                YearlistBillFirstModel *mode3 = self.listdataArr[indexnum-1];
                if (mode3.totalAmount <=0) {
                    cell.subLab.text = @"上月无数据";
                }
                else{
                    float pricenum = (model.totalAmount-mode3.totalAmount )/mode3.totalAmount ;
                    cell.subLab.text = [NSString stringWithFormat:@"%.2f%@",pricenum,@"%"];
                }
                
            }
        }
    }
    else{
        if (indexPath.row == 0) {
            cell.versioLab.text = [NSString stringWithFormat:@"%@收款笔数",model.monthDate];
            cell.subLab.text = [NSString stringWithFormat:@"%ld笔",(long)model.totalCount];
        }
        else{
            YearlistBillFirstModel *mode3 = self.listdataArr[indexnum-1];
            if (mode3.totalCount <=0) {
                cell.subLab.text = @"上月无数据";
            }
            else{
                float pricenum = (model.totalCount-mode3.totalCount )/mode3.totalCount ;
                cell.subLab.text = [NSString stringWithFormat:@"%.2f%@",pricenum,@"%"];
            }
        }
    }
    [cell.subLab setHidden:NO];
    cell.accessoryType = UITableViewCellAccessoryNone;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

#pragma mark - CYLTableViewPlaceHolderDelegate Method 没有数据界面显示

- (UIView *)makePlaceHolderView {
    
    
    UIView *weChatStyle = [self weChatStylePlaceHolder];
    weChatStyle.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return weChatStyle;
}

- (UIView *)weChatStylePlaceHolder {
    WeChatStylePlaceHolder *weChatStylePlaceHolder = [[WeChatStylePlaceHolder alloc] initWithFrame:self.tableview.frame];
    weChatStylePlaceHolder.delegate = self;
    
    weChatStylePlaceHolder.imageName = @"emty_icon";
    weChatStylePlaceHolder.title = @"这个月还没有账单哦";
    weChatStylePlaceHolder.content = @"看看别的吧!";
    
    return weChatStylePlaceHolder;
    
}

- (void)emptyOverlayClicked:(id)sender {
    
}

- (void)YearHistoryBillApi:(NSString *)uid {
    [self showLoding:@"请稍后"];
    YearHistoryBillApi *monbill = [[YearHistoryBillApi alloc]initWithUid:uid];
    [monbill startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            [self closeLoding];
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    NSDictionary *datadic = [dic objectForKey:@"data"];
                    
                    [self.listdataArr addObjectsFromArray:[YearlistBillFirstModel mj_objectArrayWithKeyValuesArray:datadic ]];
                    
                    
                    
                    YearlistBillFirstModel *model1 = self.listdataArr[0];
                    YearlistBillFirstModel *model2 = self.listdataArr[1];
                    YearlistBillFirstModel *model3 = self.listdataArr[2];
                    YearlistBillFirstModel *model4 = self.listdataArr[3];
                    YearlistBillFirstModel *model5 = self.listdataArr[4];
                    YearlistBillFirstModel *model6 = self.listdataArr[5];
                    YearlistBillFirstModel *model7 = self.listdataArr[6];
                    lastmonth = model1.monthDate;
                    lastmoney = model1.totalAmount;
                    lastpen  = model1.totalCount;
                    
                    firstmonth = model2.monthDate;
                    firstmoney = model2.totalAmount;
                    firstpen  = model2.totalCount;
                    [self.timeBtn1 setTitle:model2.monthDate forState:UIControlStateNormal];
                    
                    secondmonth = model3.monthDate;
                    secondmoney = model3.totalAmount;
                    secondpen  = model3.totalCount;
                    [self.timeBtn2 setTitle:model3.monthDate forState:UIControlStateNormal];
                    
                    threemonth = model4.monthDate;
                    threemoney = model4.totalAmount;
                    threepen  = model4.totalCount;
                    [self.timeBtn3 setTitle:model4.monthDate forState:UIControlStateNormal];
                    
                    fourmonth = model5.monthDate;
                    fourmoney = model5.totalAmount;
                    fourpen  = model5.totalCount;
                    [self.timeBtn4 setTitle:model5.monthDate forState:UIControlStateNormal];
                    
                    fivetmonth = model6.monthDate;
                    fivetmoney = model6.totalAmount;
                    fivetpen  = model6.totalCount;
                    [self.timeBtn5 setTitle:model6.monthDate forState:UIControlStateNormal];
                    
                    sixtmonth = model7.monthDate;
                    sixtmoney = model7.totalAmount;
                    sixtpen  = model7.totalCount;
                   [self.timeBtn6 setTitle:model7.monthDate forState:UIControlStateNormal];
                    
                     [self setUpTheAAChartViewWithChartType:AAChartTypeSpline];
                    [self.tableview.mj_header beginRefreshing];
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
