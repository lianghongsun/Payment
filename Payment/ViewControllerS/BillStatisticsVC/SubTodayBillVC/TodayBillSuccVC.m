//
//  TodayBillSuccVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/10.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "TodayBillSuccVC.h"
#import "NoimageSuccCell.h"
#import "WithDetermineBtnCell.h"
#import "WithSuccHeaderCell.h"

@interface TodayBillSuccVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TodayBillSuccVC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账单详情";
    self.tableview.separatorStyle = NO;
    [self.tableview registerNib:[UINib nibWithNibName:@"NoimageSuccCell" bundle:nil] forCellReuseIdentifier:@"NoimageSuccCell"];
    
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
        static NSString *identifier1 = @"NoimageSuccCell";
        NoimageSuccCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (indexPath.row == 0) {
            cell.titleLab.text = @"订单金额";
            cell.subtitleLab.text = [NSString stringWithFormat:@"¥%@",self.model.totalAmount];
        }
        else if (indexPath.row == 1){
            cell.titleLab.text = @"实收金额";
            cell.subtitleLab.text = [NSString stringWithFormat:@"¥%@",self.model.arrivalAmount];
        }
        else{
            cell.titleLab.text = @"付款账号";
            cell.subtitleLab.text = [NSString stringWithFormat:@"%@",@""];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else if (indexPath.section == 2){
        static NSString *identifier1 = @"NoimageSuccCell";
        NoimageSuccCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        
        if (indexPath.row == 0){
            cell.titleLab.text = @"交易时间";
            cell.subtitleLab.text = [NSString stringWithFormat:@"%@",self.model.create];
        }
        else if (indexPath.row == 1){
            
            cell.titleLab.text = @"交易状态";
            cell.subtitleLab.text = [NSString stringWithFormat:@"%@",self.model.logType];
        }
        else if (indexPath.row == 2){
            cell.titleLab.text = @"交易单号";
            cell.subtitleLab.text = [NSString stringWithFormat:@"%@",self.model.platOrderNo];
        }
        else if (indexPath.row == 3){
            cell.titleLab.text = @"订单编号";
            cell.subtitleLab.text = [NSString stringWithFormat:@"%@",self.model.orderNo];
        }else{
            cell.titleLab.text = @"备注";
            cell.subtitleLab.text = self.model.remark;
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
        
    }
    else if (indexPath.section == 3){
        static NSString *identifier1 = @"NoimageSuccCell";
        NoimageSuccCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell.titleLab.text = @"收银员";
        cell.subtitleLab.text = self.model.cashierName;
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else{
        LRWeakSelf(self)
        static NSString *identifier1 = @"WithDetermineBtnCell";
        WithDetermineBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell.determineBlockoBlock = ^(WithDetermineBtnCell *cell) {
            if (self.ispopRoot) {
            [weakself.navigationController popToRootViewControllerAnimated:YES];
                return;
            }
            else{
                [weakself.navigationController popViewControllerAnimated:YES];
                return;
            }
            
        };
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

@end
