//
//  SettingMessVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/3.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "SettingMessVC.h"
#import "GesturesCell.h"

@interface SettingMessVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SettingMessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableview registerNib:[UINib nibWithNibName:@"GesturesCell" bundle:nil] forCellReuseIdentifier:@"GesturesCell"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.00001;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TAbcell_H;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        static NSString *identifier1 = @"GesturesCell";
        GesturesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    
    if (indexPath.section == 0) {
         cell.gestureLab.text = @"新消息通知";
    }
    else if (indexPath.section == 1){
        cell.gestureLab.text = @"消息声音";
    }
    else{
        cell.gestureLab.text = @"震动";
    }
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
    }
    else{
        
        
    }
    
    
}


@end
