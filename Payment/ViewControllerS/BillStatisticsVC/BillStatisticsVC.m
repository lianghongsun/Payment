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

@interface BillStatisticsVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *datas;

@end

@implementation BillStatisticsVC

static NSString * const identifier = @"FXCyclePagerViewCell";

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
    self.todaypriceLab.text = [NSString stringWithFormat:@"¥%@",@"99999.00"];
    self.todaynumLab.text = [NSString stringWithFormat:@"合计%@笔",@"6"];
    self.tomopriceLab.text = [NSString stringWithFormat:@"¥%@",@"8888.00"];
    self.tomonumLab.text = [NSString stringWithFormat:@"合计%@笔",@"9"];
    
    
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
@end
