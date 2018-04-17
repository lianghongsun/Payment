//
//  CollectionSuccVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/10.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "CollectionSuccVC.h"
#import "WithSuccCell.h"
#import "WithDetermineBtnCell.h"
#import "WithSuccHeaderCell.h"

@interface CollectionSuccVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CollectionSuccVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账单详情";
    self.tableview.separatorStyle = NO;
    [self.tableview registerNib:[UINib nibWithNibName:@"WithSuccCell" bundle:nil] forCellReuseIdentifier:@"WithSuccCell"];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"WithDetermineBtnCell" bundle:nil] forCellReuseIdentifier:@"WithDetermineBtnCell"];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"WithSuccHeaderCell" bundle:nil] forCellReuseIdentifier:@"WithSuccHeaderCell"];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 3;
    }
    else if (section == 2){
        return 5;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0||section == 1) {
        return 0.00001;
    }
    else if (section == 4){
        return  30;
    }
    return  10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return TAbcell_H;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString *identifier1 = @"WithSuccHeaderCell";
        WithSuccHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        [cell.succBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e623", 30, ThemeColor)] forState:UIControlStateNormal];
        [cell.succBtn setTitle:@"收款成功" forState:UIControlStateNormal];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
        
    }
    else if (indexPath.section == 1){
        static NSString *identifier1 = @"WithSuccCell";
        WithSuccCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (indexPath.row == 0) {
            cell.titleLab.text = @"订单金额";
            cell.subtitleLab.text = [NSString stringWithFormat:@"¥%@",@"888.00"];
        }
        else if (indexPath.row == 1){
            cell.titleLab.text = @"实收金额";
            cell.subtitleLab.text = [NSString stringWithFormat:@"¥%@",@"888.00"];
        }
        else{
            cell.titleLab.text = @"付款账号";
            cell.subtitleLab.text = [NSString stringWithFormat:@"%@",@"15467677663"];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else if (indexPath.section == 2){
        static NSString *identifier1 = @"WithSuccCell";
        WithSuccCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        
        if (indexPath.row == 0){
            cell.titleLab.text = @"交易时间";
            cell.subtitleLab.text = [NSString stringWithFormat:@"%@",@"2018年03月27日 09:18:34"];
        }
        else if (indexPath.row == 1){
            cell.titleLab.text = @"交易状态";
            cell.subtitleLab.text = [NSString stringWithFormat:@"%@",@"收款成功"];
        }
        else if (indexPath.row == 2){
            cell.titleLab.text = @"交易单号";
            cell.subtitleLab.text = [NSString stringWithFormat:@"%@",@"20180312837337747383"];
        }
        else if (indexPath.row == 3){
            cell.titleLab.text = @"订单编号";
            cell.subtitleLab.text = [NSString stringWithFormat:@"%@",@"000123837473737737"];
        }else{
            cell.titleLab.text = @"备注";
            cell.subtitleLab.text = [NSString stringWithFormat:@"%@",@"我想花钱了"];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
        
    }
    else if (indexPath.section == 3){
        static NSString *identifier1 = @"WithSuccCell";
        WithSuccCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell.titleLab.text = @"收银员";
        cell.subtitleLab.text = [NSString stringWithFormat:@"%@",@"张无忌"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else{
        
        static NSString *identifier1 = @"WithDetermineBtnCell";
        WithDetermineBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell.determineBlockoBlock = ^(WithDetermineBtnCell *cell) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        };
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

@end
