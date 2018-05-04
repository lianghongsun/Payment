//
//  PersonalCenterVC.m
//  Payment
//
//  Created by 噗噗 on 2018/3/31.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "PersonalCenterVC.h"
#import "MyCell.h"
#import "UsernameCell.h"
#import "LoginOutCell.h"
#import "UserInfoVC.h"
#import "UserPasswordVC.h"
#import "CertificationVC.h"
#import "BindingYHKVC.h"
#import "MyBillVC.h"
#import "SettingMessVC.h"
#import "LoginVC.h"
#import "GestureLockLogin.h"
#import "UIImageView+WebCache.h"

@interface PersonalCenterVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *titleArr;
    NSArray *imageArr;
    UserInfo *user;
}
@end

@implementation PersonalCenterVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    user = [UserInfo shareObject];
    switch (user.type) {
        case 1:
        {
            titleArr = @[@"账户安全",@"信息认证"];
            imageArr = @[@"user-ic-security",@"user-ic-message"];
        }
            break;
        case 2:
        {
            titleArr = @[@"账户安全",@"信息认证",@"绑定银行卡",@"我的账单"];
            imageArr = @[@"user-ic-security",@"user-ic-message",@"user-ic-bankcard",@"user-ic-bill"];
        }break;
        case 3:
        {
            titleArr = @[];
            imageArr = @[];
        }break;
            
        default:
            break;
    }
    [self.tableview reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    
    [self.tableview registerNib:[UINib nibWithNibName:@"UsernameCell" bundle:nil] forCellReuseIdentifier:@"UsernameCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"MyCell" bundle:nil] forCellReuseIdentifier:@"MyCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"LoginOutCell" bundle:nil] forCellReuseIdentifier:@"LoginOutCell"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1){
        return titleArr.count;
    }
    else if (section == 2){
        return 2;
    }
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return  10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }
    return TAbcell_H;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        static NSString *identifier1 = @"UsernameCell";
        UsernameCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        [cell.userImg sd_setImageWithURL:[user.detail objectForKey:@"headPath"]  placeholderImage:[UIImage imageNamed:@"userporfile-pic"]];
        NSString *namestr;
        if ([self StringIsNullOrEmpty:[user.detail objectForKey:@"realName"]]) {
            namestr = user.username;
        }
        else{
            namestr = [user.detail objectForKey:@"realName"];
        }
        cell.usernameLab.text = namestr;
        cell.usernumLab.text = user.username;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else if (indexPath.section == 1){
        static NSString *identifier1 = @"MyCell";
        MyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell.myImg.image = [UIImage imageNamed:imageArr[indexPath.row]];
        cell.myTitle.text = titleArr[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else  if(indexPath.section == 2){
        static NSString *identifier1 = @"MyCell";
        MyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (indexPath.row == 0) {
            cell.myImg.image = [UIImage imageNamed:@"user-ic-set"];
            cell.myTitle.text = @"消息设置";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else{
            [cell.myContent setHidden:NO];
            cell.myImg.image = nil;
            cell.myTitle.text = @"当前版本号";
            cell.myContent.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else{
        static NSString *identifier1 = @"LoginOutCell";
        LoginOutCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell.loginoutLab.text = @"退出登录";
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserInfo *user = [UserInfo shareObject];
    if (!user.isLogin) {
        [self gobacklogin];
        return;
    }
    
    if (indexPath.section == 0) {
        UserInfoVC *vc = [[UserInfoVC alloc]initWithNibName:@"UserInfoVC" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
            {
                UserPasswordVC *vc = [[UserPasswordVC alloc]initWithNibName:@"UserPasswordVC" bundle:nil];
                vc.hidesBottomBarWhenPushed = YES;  // 设置B
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                CertificationVC *vc = [[CertificationVC alloc]initWithNibName:@"CertificationVC" bundle:nil];
                vc.hidesBottomBarWhenPushed = YES;  // 设置B
                [self.navigationController pushViewController:vc animated:YES];
                
            }break;
            case 2:
            {
                if (!(user.identityAuthed==1)) {
                    [self showMessage:@"请先进行实名认证" viewHeight:0];
                    return;
                }
                if (!(user.merchantAuthed==1)) {
                    [self showMessage:@"请先进行店铺认证" viewHeight:0];
                    return;
                }
                
                BindingYHKVC *vc = [[BindingYHKVC alloc]initWithNibName:@"BindingYHKVC" bundle:nil];
                vc.hidesBottomBarWhenPushed = YES;  // 设置B
                [self.navigationController pushViewController:vc animated:YES];
            }break;
            case 3:
            {
                if (user.type == 2) {
                    MyBillVC *vc = [[MyBillVC alloc]initWithNibName:@"MyBillVC" bundle:nil];
                    vc.hidesBottomBarWhenPushed = YES;  // 设置B
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else{
                    
                }
            }break;
 
            default:{
                
            }
                break;
        }
        
    }
    else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            SettingMessVC *vc = [[SettingMessVC alloc]initWithNibName:@"SettingMessVC" bundle:nil];
            vc.hidesBottomBarWhenPushed = YES;  // 设置B
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    else{
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        //移除UserDefaults中存储的用户信息
        [userDefaults removeObjectForKey:@"name"];
        [userDefaults removeObjectForKey:@"password"];
        [userDefaults synchronize];
        
        UserInfo *user = [UserInfo shareObject];
        user.isLogin = false;
        LoginVC *vc = [[LoginVC alloc]initWithNibName:@"LoginVC" bundle:nil];
        vc.isloginout = YES;
        UINavigationController *naiv = [[UINavigationController alloc]initWithRootViewController:vc];
        self.tabBarController.selectedIndex = 0;
        [self presentViewController:naiv animated:YES completion:nil];
        
    }
}


@end
