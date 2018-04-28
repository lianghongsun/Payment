//
//  WithdrawalSucc.m
//  Payment
//
//  Created by iMac_1 on 2018/4/10.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "WithdrawalSucc.h"
#import "WithSuccCell.h"
#import "WithDetermineBtnCell.h"
#import "WithSuccHeaderCell.h"
#import "NoimageSuccCell.h"

@interface WithdrawalSucc ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WithdrawalSucc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提款详情";
    
    self.tableview.separatorStyle = NO;
    [self.tableview registerNib:[UINib nibWithNibName:@"WithSuccCell" bundle:nil] forCellReuseIdentifier:@"WithSuccCell"];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"NoimageSuccCell" bundle:nil] forCellReuseIdentifier:@"NoimageSuccCell"];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"WithDetermineBtnCell" bundle:nil] forCellReuseIdentifier:@"WithDetermineBtnCell"];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"WithSuccHeaderCell" bundle:nil] forCellReuseIdentifier:@"WithSuccHeaderCell"];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 6;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.00001;
    }
    else if (section == 3){
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
        [cell.succBtn setTitle:@"提款成功" forState:UIControlStateNormal];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
        
    }
    else if (indexPath.section == 1){
        static NSString *identifier1 = @"WithSuccCell";
        WithSuccCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell.titleLab.text = @"提款金额";
        cell.subtitleLab.text = [NSString stringWithFormat:@"¥%@",@"888.00"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else if (indexPath.section == 2){
        static NSString *identifier1 = @"WithSuccCell";
        if (indexPath.row == 0) {
            WithSuccCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
            
            [cell.logimag setHidden:NO];
            cell.titleLab.text = @"提款账号";
            cell.subtitleLab.text = [NSString stringWithFormat:@"%@",@"************9398"];
            cell.logimag.image = [UIImage imageNamed:@"zhaohang"];
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
            
        }
        else  {
            NoimageSuccCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
            if (indexPath.row == 1) {
                cell.titleLab.text = @"提款时间";
                cell.subtitleLab.text = [NSString stringWithFormat:@"%@",@"2018年03月27日 09:18:34"];
            }
            else if (indexPath.row == 2){
                cell.titleLab.text = @"交易状态";
                cell.subtitleLab.text = [NSString stringWithFormat:@"%@",@"提款成功"];
            }
            else if (indexPath.row == 3){
                cell.titleLab.text = @"交易单号";
                cell.subtitleLab.text = [NSString stringWithFormat:@"%@",@"20180312837337747383"];
            }
            else if (indexPath.row == 4){
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
        
        
        
    }
    else{
        LRWeakSelf(self)
        static NSString *identifier1 = @"WithDetermineBtnCell";
        WithDetermineBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell.determineBlockoBlock = ^(WithDetermineBtnCell *cell) {
            if (self.ispopRoot) {
             [weakself.navigationController popToRootViewControllerAnimated:YES];
                return ;
            }
            else{
                [weakself.navigationController popViewControllerAnimated:YES];
                return ;
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
