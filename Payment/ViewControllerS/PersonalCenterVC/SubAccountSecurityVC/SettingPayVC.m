//
//  SettingPayVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/1.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "SettingPayVC.h"
#import "VersionCell.h"
#import "SetPaypassFirstVC.h"
#import "ResetPayPassVC.h"
@interface SettingPayVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *titleArr;
    UserInfo *user;
}

@end

@implementation SettingPayVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    user = [UserInfo shareObject];
    
    if (user.paypasswdAuthed == 1) {
        self.title = @"修改支付密码";
        titleArr = @[@"修改支付密码",@"重置支付密码"];
    }else{
        self.title = @"设置支付密码";
        titleArr = @[@"设置支付密码"];
    }
    [self.tableview reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    return titleArr.count;
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
    cell.versioLab.text = titleArr[indexPath.row];
    [cell.subLab setHidden:YES];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (user.paypasswdAuthed == 1) {
        switch (indexPath.row) {
            case 0:
            {
                SetPaypassFirstVC *vc = [[SetPaypassFirstVC alloc]initWithNibName:@"SetPaypassFirstVC" bundle:nil];
                vc.titleStr = @"修改支付密码";
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
            {
                ResetPayPassVC *vc = [[ResetPayPassVC alloc]initWithNibName:@"ResetPayPassVC" bundle:nil];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
        }
        
    }
    else{
        SetPaypassFirstVC *vc = [[SetPaypassFirstVC alloc]initWithNibName:@"SetPaypassFirstVC" bundle:nil];
        vc.titleStr = @"设置支付密码";
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end
