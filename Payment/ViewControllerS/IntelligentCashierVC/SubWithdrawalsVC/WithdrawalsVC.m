//
//  WithdrawalsVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "WithdrawalsVC.h"
#import "WithdrawalsFirstCell.h"
#import "WithButtonCell.h"
#import "WithdrawalSecondVC.h"

@interface WithdrawalsVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WithdrawalsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提款";
//    self.tableview.separatorStyle = NO;
    [self.tableview registerNib:[UINib nibWithNibName:@"WithdrawalsFirstCell" bundle:nil] forCellReuseIdentifier:@"WithdrawalsFirstCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"WithButtonCell" bundle:nil] forCellReuseIdentifier:@"WithButtonCell"];
    [self.tableview registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
    
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
    if (section == 0) {
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    }
    return  0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 50;
    }
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)view;
    headerView.textLabel.font = [UIFont systemFontOfSize:14];
    headerView.textLabel.textColor = [UIColor blackColor];
    
    headerView.detailTextLabel.font = [UIFont systemFontOfSize:14];
    headerView.detailTextLabel.textColor = [UIColor blackColor];
    if (section == 0) {
        headerView.textLabel.text = @"提款订单";
    }else{
        
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        static NSString *identifier1 = @"WithdrawalsFirstCell";
        WithdrawalsFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        
        cell.priceLab.text = @"8888.00元";
        cell.statusLab.text = @"提款成功";
        cell.timeLab.text = @"2018/09/29 16:00:00";
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
        
    }
    else{
        LRWeakSelf(self);
        static NSString *identifier1 = @"WithButtonCell";
        WithButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        [cell.withdarBtn setTitle:@"我要提款" forState:UIControlStateNormal];
        cell.withdrawalstoBlock = ^(WithButtonCell *cell){
            WithdrawalSecondVC *vc = [[WithdrawalSecondVC alloc]initWithNibName:@"WithdrawalSecondVC" bundle:nil];
            [weakself.navigationController pushViewController:vc animated:YES];
        };
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}


@end
