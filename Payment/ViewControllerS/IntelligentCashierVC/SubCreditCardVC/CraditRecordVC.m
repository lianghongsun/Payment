//
//  CraditRecordVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/11.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "CraditRecordVC.h"
#import "CraditRecordCell.h"
#import "CreditSucc.h"

@interface CraditRecordVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CraditRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"还款记录";
    [self.tableview registerNib:[UINib nibWithNibName:@"CraditRecordCell" bundle:nil] forCellReuseIdentifier:@"CraditRecordCell"];
    
    [self setrefreshHeaderOrFooter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -- sterefresh

- (void)setrefreshHeaderOrFooter {
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

- (void)loadNewData {
    [self.tableview reloadData];
    self.tableview.mj_footer.state = MJRefreshStateIdle;
    [self.tableview.mj_header endRefreshing];
}

- (void)loadMore {
    [self.tableview.mj_footer endRefreshing];
    self.tableview.mj_footer.state = MJRefreshStateNoMoreData;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
     return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *identifier1 = @"CraditRecordCell";
    CraditRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    cell.logimage.image = [UIImage imageNamed:@"zhaohang"];
    cell.yhknum.text = @"82828378373****9989";
    cell.yhkname.text = @"张无忌";
    cell.money.text = [NSString stringWithFormat:@"%@元",@"333.00"];
    cell.status.text = @"还款成功";
    cell.time.text = @"2018/03/23 15:03:00";
    cell.accessoryType = UITableViewCellAccessoryNone;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CreditSucc *vc = [[CreditSucc alloc]initWithNibName:@"CreditSucc" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

@end
