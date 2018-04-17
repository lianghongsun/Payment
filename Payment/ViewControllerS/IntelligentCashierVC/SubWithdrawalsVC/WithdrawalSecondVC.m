//
//  WithdrawalSecondVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "WithdrawalSecondVC.h"
#import "WithdrpriceCell.h"
#import "AddYHKCell.h"
#import "WithDetermineBtnCell.h"
#import "WithdrawalSucc.h"

@interface WithdrawalSecondVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WithdrawalSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提款";
    [self setrigBtn];
    self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"WithdrpriceCell" bundle:nil] forCellReuseIdentifier:@"WithdrpriceCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"AddYHKCell" bundle:nil] forCellReuseIdentifier:@"AddYHKCell"];
      [self.tableview registerNib:[UINib nibWithNibName:@"WithDetermineBtnCell" bundle:nil] forCellReuseIdentifier:@"WithDetermineBtnCell"];
    [self.tableview registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setrigBtn {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 30, 30);
    [rightButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e696", 30, RGB(255, 255, 255))] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc ] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;
    
}

- (void)rightAction {
    
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.00001;
    }
    else if (section ==1){
      return 40;
    }
     return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 60;
    }
    else if (indexPath.section == 1){
      return 140;
    }
    return 160;
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
    if (section == 1) {
        headerView.textLabel.text = @"请选择提款账户";
    }else{
        
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        static NSString *identifier1 = @"WithdrpriceCell";
        WithdrpriceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
        
    }
    else if(indexPath.section == 1){
        static NSString *identifier1 = @"AddYHKCell";
        AddYHKCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell.logimg.image = [UIImage imageNamed:@"zhaohang"];
        cell.nameLab.text = @"张无忌";
        cell.numLab.text = @"828283783738*********9989";
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else{
        static NSString *identifier1 = @"WithDetermineBtnCell";
        WithDetermineBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell.determineBlockoBlock = ^(WithDetermineBtnCell *cell) {
            WithdrawalSucc *vc = [[WithdrawalSucc alloc]initWithNibName:@"WithdrawalSucc" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    
    
}



@end
