//
//  AilpaybillVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/4.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "NewHistorybillVC.h"
#import "collectionCell.h"
#import "GYZCityHeaderView.h"

@interface NewHistorybillVC ()<UITableViewDelegate,UITableViewDataSource>

@end

NSString *const hisnewHeaderView = @"hisnewHeaderView";

@implementation NewHistorybillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    
    self.backgrView.backgroundColor = ThemeColor;
    self.todayLab.backgroundColor = ThemeColor;
    [self setUidata];
    [self.tableview registerNib:[UINib nibWithNibName:@"collectionCell" bundle:nil] forCellReuseIdentifier:@"collectionCell"];
    
    [self.tableview registerClass:[GYZCityHeaderView class] forHeaderFooterViewReuseIdentifier:hisnewHeaderView];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    GYZCityHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:hisnewHeaderView];
    headerView.contentView.backgroundColor = [UIColor whiteColor];
    NSString *title = @"2018年03月27日";
    NSString *subtitle = @"¥ 8888.00";
    headerView.titleLabel.text = title;
    headerView.subtitleLabel.text = subtitle;
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier1 = @"collectionCell";
    collectionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    if ([self.titleStr isEqualToString:@"支付宝历史账单详情"]) {
     cell.headimge.image = cell.headimge.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e608", 40, ThemeColor)];
    }
    else{
     cell.headimge.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6ed", 40, RGB(106, 163, 85))];
    }
    cell.nameLab.text = @"张无忌";
    cell.timeLab.text = @"2018/03/26 15:00:00";
    cell.priceLab.text = @"2222.00";
    cell.statusLab.text = @"收款成功";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


- (void)setUidata{
    self.allgetpriceLab.text = [NSString stringWithFormat:@"¥%@",@"8888.00"];
    self.billnumLab.text = [NSString stringWithFormat:@"%@笔",@"3"];
}


@end
