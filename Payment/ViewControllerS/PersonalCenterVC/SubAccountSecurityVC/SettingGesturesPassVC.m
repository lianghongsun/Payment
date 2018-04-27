//
//  SettingGesturesPassVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/1.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "SettingGesturesPassVC.h"
#import "GesturesCell.h"
#import "VersionCell.h"
#import "SetGestureLockViewController.h"
#import "ChangeGestureLockViewController.h"
#import "ForgetGesturesPassVC.h"

@interface SettingGesturesPassVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UserInfo *user;
    NSArray *titleArr;
    NSString *isLockPath;
}
@end

@implementation SettingGesturesPassVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *LockPath = [userDefault objectForKey:@"LockPath"];
    isLockPath = [userDefault objectForKey:@"isLockPath"];
    if ([LockPath length]>0) {
        titleArr = @[@"修改手势密码",@"忘记手势密码"];
    }else{
        titleArr = @[@"设置手势密码"];
    }
    [self.tableview reloadData];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手势密码";
   
    [self.tableview registerNib:[UINib nibWithNibName:@"GesturesCell" bundle:nil] forCellReuseIdentifier:@"GesturesCell"];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 1;
    }
    return titleArr.count;
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
    
    if (indexPath.section == 0) {
        static NSString *identifier1 = @"GesturesCell";
        GesturesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell.gestureLab.text = @"手势密码";
        cell.gestureSwitch.onTintColor = ThemeColor;
        if ([isLockPath isEqualToString:@"开启"]) {
            [cell.gestureSwitch setOn:YES];
        }
        else{
            [cell.gestureSwitch setOn:NO];
        }
        [cell.gestureSwitch addTarget:self action:@selector(noticeAction:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else{
        static NSString *identifier1 = @"VersionCell";
        VersionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell.versioLab.text = titleArr[indexPath.row];
        [cell.subLab setHidden:YES];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
        
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
    }
    else{
        if (titleArr.count == 1) {
            SetGestureLockViewController *setLockVc = [[SetGestureLockViewController alloc] init];
            setLockVc.serpassBlock = ^(SetGestureLockViewController *setLockVc) {
//                if ([user.oldgestures length]>0) {
//                    titleArr = @[@"修改手势密码",@"忘记手势密码"];
//                }else{
//                    titleArr = @[@"设置手势密码"];
//                }
//
//                [self.tableview reloadData];
            };
            [self.navigationController pushViewController:setLockVc animated:YES];
        }
        else{
            switch (indexPath.row) {
                case 0:
                {
                    ChangeGestureLockViewController *vc = [[ChangeGestureLockViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 1:
                {
                    ForgetGesturesPassVC *vc = [[ForgetGesturesPassVC alloc]initWithNibName:@"ForgetGesturesPassVC" bundle:nil];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
    }
    
    
}

-(void)noticeAction:(id)sender
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        [userDef setObject:@"开启" forKey:@"isLockPath"];
    }else {
        [userDef setObject:@"关闭" forKey:@"isLockPath"];
    }
    [userDef synchronize];
    
}


@end
