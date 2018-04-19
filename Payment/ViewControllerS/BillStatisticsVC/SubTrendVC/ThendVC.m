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

@interface ThendVC ()<UITableViewDataSource,UITableViewDelegate,WeChatStylePlaceHolderDelegate>
{
    NSInteger indexnum;
}
@property (nonatomic, strong) AAChartModel *aaChartModel;
@property (nonatomic, strong) AAChartView  *aaChartView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation ThendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收款趋势";
    self.dataArr = [NSMutableArray array];
    [self.dataArr addObject:@"123"];
    [self.dataArr addObject:@"1321"];
    
    [self setUpTheAAChartViewWithChartType:AAChartTypeSpline];
    
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

- (void)setUpTheAAChartViewWithChartType:(AAChartType)chartType {
    
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
    .categoriesSet(@[@"2018.01",@"2018.02",@"2018.03",@"2018.04", @"2018.05",@"2018.06"])//图表横轴的内容
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
                 .dataSet(@[@1000, @3000, @10000, @4000, @180, @2000]),
                 AAObject(AASeriesElement)
                 .nameSet(@"金额")
                 .dataSet(@[]),
                 AAObject(AASeriesElement)
                 .nameSet(@"金额")
                 .dataSet(@[]),
                 AAObject(AASeriesElement)
                 .nameSet(@"笔数")
                 .dataSet(@[@3900, @5000, @6200, @8000, @9000, @4000])
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
    
    NSInteger numvue = 10000/4;
    _aaChartModel.yAxisMaxSet(@(10000))//Y轴最大值
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
    return self.dataArr.count;
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
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.versioLab.text = @"2018-02收款金额";
            cell.subLab.text = @"¥1888.00";
        }
        else{
            cell.versioLab.text = @"环比增长";
            cell.subLab.text = @"20%";
        }
    }
    else{
        if (indexPath.row == 0) {
            cell.versioLab.text = @"2018-02收款笔数";
            cell.subLab.text = @"20笔";
        }
        else{
            cell.versioLab.text = @"¥1888.00";
            cell.subLab.text = @"30%";
        }
    }
    [cell.subLab setHidden:NO];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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



@end
