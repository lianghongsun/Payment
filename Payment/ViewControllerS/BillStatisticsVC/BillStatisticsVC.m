//
//  BillStatisticsVC.m
//  Payment
//
//  Created by 噗噗 on 2018/3/31.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "BillStatisticsVC.h"
#import "FXCyclePagerViewCell.h"
#import "FXCyclePagerView.h"
#import "FXPageControl.h"
#import "MyCell.h"
#import "TodayBillVC.h"
#import "MonthBillVC.h"
#import "HistoryBillVC.h"
#import "ConstituteVC.h"
#import "ThendVC.h"
#import "TodayBillApi.h"
#import "EverydayBillApi.h"

@interface BillStatisticsVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UserInfo *user;
    NSString *todayAllbill;
    NSString *todayailbill;
    NSString *todayweixinbill;
    NSString *tomoAllBill;
    NSString *tomoailBill;
    NSString *tomoweixinBill;
    
    NSString *myenttime;
}
@property (nonatomic, strong) NSArray *datas;

@end

@implementation BillStatisticsVC

static NSString * const identifier = @"FXCyclePagerViewCell";

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    user = [UserInfo shareObject];
    
    myenttime = [JCAUtility stringWithCurrentTime:@"yyyy-MM-dd"];
    
    [self TodayBillApi:user.uid StartDate:[JCAUtility stringWithCurrentTime:@"yyyy-MM-dd"] ];
    [self EverydayBillApi:user.uid StartDate:[JCAUtility stringLastWithCurrentTime:@"yyyy-MM-dd"] EndDate:[JCAUtility stringLastWithCurrentTime:@"yyyy-MM-dd"]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账单统计";
    self.todaybackgrview.layer.masksToBounds = YES;
    self.tomobackgrview.layer.masksToBounds = YES;
    [self.tableview registerNib:[UINib nibWithNibName:@"MyCell" bundle:nil] forCellReuseIdentifier:@"MyCell"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self  setassignment];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
}

- (void)setassignment {
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    return 2;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 10;
    }
    return  0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TAbcell_H;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        static NSString *identifier1 = @"MyCell";
        MyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.myTitle.text = @"今日账单";
            cell.myImg.image = [UIImage imageNamed:@"ic-todaybill"];
        }
        else if (indexPath.row == 1){
            cell.myTitle.text = @"本月账单";
            cell.myImg.image = [UIImage imageNamed:@"ic-monthbill"];
        }
        else{
            cell.myTitle.text = @"历史账单";
            cell.myImg.image = [UIImage imageNamed:@"ic-historybill"];
        }
    }
    else{
        if (indexPath.row == 0) {
            cell.myTitle.text = @"收款趋势";
            cell.myImg.image = [UIImage imageNamed:@"ic-gatheringtrend"];
        }
        else{
            cell.myTitle.text = @"收款构成";
            cell.myImg.image = [UIImage imageNamed:@"ic-paymentform"];
        }
    }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                TodayBillVC *vc = [[TodayBillVC alloc]initWithNibName:@"TodayBillVC" bundle:nil];
                vc.hidesBottomBarWhenPushed = YES;  // 设置B
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                MonthBillVC *vc = [[MonthBillVC alloc]initWithNibName:@"MonthBillVC" bundle:nil];
                vc.hidesBottomBarWhenPushed = YES;  // 设置B
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                HistoryBillVC *vc = [[HistoryBillVC alloc]initWithNibName:@"HistoryBillVC" bundle:nil];
                vc.hidesBottomBarWhenPushed = YES;  // 设置B
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
        
    }
    else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
            {
                ThendVC *vc = [[ThendVC alloc]initWithNibName:@"ThendVC" bundle:nil];
                vc.hidesBottomBarWhenPushed = YES;  // 设置B
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                ConstituteVC *vc = [[ConstituteVC alloc]initWithNibName:@"ConstituteVC" bundle:nil];
                vc.hidesBottomBarWhenPushed = YES;  // 设置B
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
}

- (void)TodayBillApi:(NSString *)mid StartDate:(NSString *)startDate{
    [self showLoding:@"请稍后"];
    TodayBillApi *todaybill = [[TodayBillApi alloc]initWithUid:mid StartDate:startDate];
    [todaybill startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            [self closeLoding];
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {   
                    NSDictionary *datadic = [dic objectForKey:@"data"];
                    
                        self.todaypriceLab.text = [NSString stringWithFormat:@"¥%.2f",[[datadic objectForKey:@"totalAmount"]floatValue]];
                        self.todaynumLab.text = [NSString stringWithFormat:@"合计%@笔",[datadic objectForKey:@"totalRow"]];
                    
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

- (void)EverydayBillApi:(NSString *)mid StartDate:(NSString *)startDate EndDate:(NSString *)endDate{
    [self showLoding:@"请稍后"];
    EverydayBillApi *todaybill = [[EverydayBillApi alloc]initWithUid:mid StartDate:startDate EndDate:endDate];
    [todaybill startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            [self closeLoding];
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    NSDictionary *datadic = [dic objectForKey:@"data"];
                        self.tomopriceLab.text = [NSString stringWithFormat:@"¥%.2f",[[datadic objectForKey:@"totalAmount"]floatValue]];
                        self.tomonumLab.text = [NSString stringWithFormat:@"合计%@笔",[datadic objectForKey:@"totalRow"]];
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
