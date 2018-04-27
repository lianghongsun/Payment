//
//  UserPasswordVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/1.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "UserPasswordVC.h"
#import "VersionCell.h"
#import "ChangeLoginPassVC.h"
#import "SettingPayVC.h"
#import "SettingGesturesPassVC.h"

@interface UserPasswordVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *titleArr;
    UserInfo *user;
}
@end

@implementation UserPasswordVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    user = [UserInfo shareObject];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账户安全";
    titleArr = @[@"登录密码",@"支付密码",@"手势密码"];
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
    switch (indexPath.row) {
        case 0:
        {
            ChangeLoginPassVC *vc = [[ChangeLoginPassVC alloc]initWithNibName:@"ChangeLoginPassVC" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            if (!(user.identityAuthed==1)) {
            [self showMessage:@"请先进行实名认证" viewHeight:0];
            return;
            }
            if (!(user.merchantAuthed==1)) {
            [self showMessage:@"请先进行店铺认证" viewHeight:0];
            return;
            }
            
            SettingPayVC *vc = [[SettingPayVC alloc]initWithNibName:@"SettingPayVC" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 2:
        {
            SettingGesturesPassVC *vc = [[SettingGesturesPassVC alloc]initWithNibName:@"SettingGesturesPassVC" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
