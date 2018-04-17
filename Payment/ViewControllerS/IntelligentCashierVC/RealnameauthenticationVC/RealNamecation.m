//
//  RealNamecation.m
//  Payment
//
//  Created by iMac_1 on 2018/4/11.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "RealNamecation.h"
#import "VersionCell.h"
#import "RealNameSecondVC.h"

@interface RealNamecation ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation RealNamecation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @" 信息认证";
    self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"VersionCell" bundle:nil] forCellReuseIdentifier:@"VersionCell"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.00001;
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
    cell.versioLab.text = @"实名认证";
    cell.subLab.text = @"审核中";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RealNameSecondVC *vc = [[RealNameSecondVC alloc]initWithNibName:@"RealNameSecondVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
