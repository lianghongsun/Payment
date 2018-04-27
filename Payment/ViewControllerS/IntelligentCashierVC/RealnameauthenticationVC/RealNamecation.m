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
#import "RealNameFailureVC.h"

@interface RealNamecation ()<UITableViewDataSource,UITableViewDelegate>
{
    UserInfo *user;
}
@end

@implementation RealNamecation

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    user = [UserInfo shareObject];
    [self.tableview reloadData];
}
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
    if (user.identityAuthed == 0) {
        cell.subLab.text = @"未认证";
    }
    else if (user.identityAuthed == 1){
        cell.subLab.text = @"已认证";
    }
    else if (user.identityAuthed == 2){
        cell.subLab.text = @"审核中";
    }
    else if(user.identityAuthed == 3){
        cell.subLab.text = @"审核失败";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (user.identityAuthed) {
        case 0:
        {
            RealNameSecondVC *vc = [[RealNameSecondVC alloc]initWithNibName:@"RealNameSecondVC" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            RealNameFailureVC *vc = [[RealNameFailureVC alloc]initWithNibName:@"RealNameFailureVC" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
