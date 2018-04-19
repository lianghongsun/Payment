//
//  IntelligentCashierVC.m
//  Payment
//
//  Created by 噗噗 on 2018/3/31.
//  Copyright © 2018年 噗噗. All rights reserved.
//
#define HomeToolBarH    (110)
#define HomeGridViewH   (250)

#import "IntelligentCashierVC.h"
#import "HoemfirstCell.h"
#import "HomeBalanceCell.h"
#import "HomeCertificationCell.h"
#import "HomeDataStatisticsCell.h"
#import "ScanVC.h"
#import "SmartCodeVC.h"
#import "PaymentCodeVC.h"
#import "WithdrawalsVC.h"
#import "CreditCardVC.h"
#import "TodayBillVC.h"
#import "LoginVC.h"
#import <AudioToolbox/AudioToolbox.h>
#import "RealNamecation.h"
#import "ShopCertifiVC.h"

@interface IntelligentCashierVC ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
{
    UserInfo *user;
}

@end

@implementation IntelligentCashierVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     user = [UserInfo shareObject];
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
    [self.tableview.mj_header beginRefreshing];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {

        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    [self.tableview registerNib:[UINib nibWithNibName:@"HoemfirstCell" bundle:nil] forCellReuseIdentifier:@"HoemfirstCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"HomeBalanceCell" bundle:nil] forCellReuseIdentifier:@"HomeBalanceCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"HomeCertificationCell" bundle:nil] forCellReuseIdentifier:@"HomeCertificationCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"HomeDataStatisticsCell" bundle:nil] forCellReuseIdentifier:@"HomeDataStatisticsCell"];
    
    self.tableview.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)loadNewData {
    [self.tableview reloadData];
   [self.tableview.mj_header endRefreshing];
}
#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    if (user.type == 1||user.type == 2) {
        return 4;
    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (user.type == 1||user.type ==2) {
        if (indexPath.section == 0) {
            return 200;
        }
        else if (indexPath.section == 1){
            return 50;
        }
        else if (indexPath.section == 2){
            return 200;
        }
        return 135;
    }
    else{
        if (indexPath.section == 0) {
            return 200;
        }
        else if (indexPath.section == 1){
            return 200;
        }
        return 135;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LRWeakSelf(self);
    if (indexPath.section == 0) {
        static NSString *identifier1 = @"HoemfirstCell";
        HoemfirstCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell.navititleLab.text = @"智能收银";
        cell.scantoBlock  = ^(HoemfirstCell *cell) {
            if (user.isLogin) {
//                if (user.identityAuthed==0) {
//                    [self showMessage:@"请先进行实名认证" viewHeight:100];
//                    return;
//                }
//                if (user.merchantAuthed==0) {
//                    [self showMessage:@"请先进行店铺认证" viewHeight:100];
//                    return;
//                }
                ScanVC *vc = [[ScanVC alloc]initWithNibName:@"ScanVC" bundle:nil];
                vc.hidesBottomBarWhenPushed = YES;  // 设置B
                [weakself.navigationController pushViewController:vc animated:YES];
                
            }
            else{
                [self gologin];
            }
        };
        
        cell.smarttoBlock = ^(HoemfirstCell *cell){
            if (user.isLogin) {
//                if (user.identityAuthed==0) {
//                    [self showMessage:@"请先进行实名认证" viewHeight:100];
//                    return;
//                }
//                if (user.merchantAuthed==0) {
//                    [self showMessage:@"请先进行店铺认证" viewHeight:100];
//                    return;
//                }
                SmartCodeVC *vc = [[SmartCodeVC alloc]initWithNibName:@"SmartCodeVC" bundle:nil];
                vc.hidesBottomBarWhenPushed = YES;  // 设置B
                [weakself.navigationController pushViewController:vc animated:YES];
            }
            else{
                [self gologin];
            }
        };
        
        cell.paymenttoBlock  = ^(HoemfirstCell *cell){
            if (user.isLogin) {
//                if (user.identityAuthed==0) {
//                    [self showMessage:@"请先进行实名认证" viewHeight:100];
//                    return;
//                }
//                if (user.merchantAuthed==0) {
//                    [self showMessage:@"请先进行店铺认证" viewHeight:100];
//                    return;
//                }
                PaymentCodeVC *vc = [[PaymentCodeVC alloc]initWithNibName:@"PaymentCodeVC" bundle:nil];
                vc.hidesBottomBarWhenPushed = YES;  // 设置B
                [weakself.navigationController pushViewController:vc animated:YES];
            }
            else{
                [self gologin];
            }
        };
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    if (user.type == 1||user.type == 2) {
         if (indexPath.section == 1){
            static NSString *identifier1 = @"HomeBalanceCell";
            HomeBalanceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
            cell.balanceLab.text = [NSString stringWithFormat:@"%0.2f元",[[user.accounts objectForKey:@"R"]floatValue]] ;
            cell.withdrawalstoBlock = ^(HomeBalanceCell *cell) {
                
                if (user.isLogin) {
//                    if (user.identityAuthed==0) {
//                        [self showMessage:@"请先进行实名认证" viewHeight:100];
//                        return;
//                    }
//                    if (user.merchantAuthed==0) {
//                        [self showMessage:@"请先进行店铺认证" viewHeight:100];
//                        return;
//                    }
                    WithdrawalsVC *vc = [[WithdrawalsVC alloc]initWithNibName:@"WithdrawalsVC" bundle:nil];
                    vc.hidesBottomBarWhenPushed = YES;  // 设置B
                    [weakself.navigationController pushViewController:vc animated:YES];
                }
                else{
                    [self gologin];
                }
            };
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
        else  if(indexPath.section == 2){
            static NSString *identifier1 = @"HomeCertificationCell";
            HomeCertificationCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
            cell.reimbursementoBlock  = ^(HomeCertificationCell *cell) {
                if (user.isLogin) {
//                    if (user.identityAuthed==0) {
//                        [self showMessage:@"请先进行实名认证" viewHeight:100];
//                        return;
//                    }
//                    if (user.merchantAuthed==0) {
//                        [self showMessage:@"请先进行店铺认证" viewHeight:100];
//                        return;
//                    }
                    CreditCardVC *vc = [[CreditCardVC alloc]initWithNibName:@"CreditCardVC" bundle:nil];
                    vc.hidesBottomBarWhenPushed = YES;  // 设置B
                    [weakself.navigationController pushViewController:vc animated:YES];
                }
                else{
                    [self gologin];
                }
            };
            cell.realnametoBlock = ^(HomeCertificationCell *cell){
                if (user.isLogin) {
                    RealNamecation *vc = [[RealNamecation alloc]initWithNibName:@"RealNamecation" bundle:nil];
                    vc.hidesBottomBarWhenPushed = YES;  // 设置B
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else{
                    [self gologin];
                }
            };
            
            cell.storetolock  = ^(HomeCertificationCell *cell){
                
                if (user.isLogin) {
                    ShopCertifiVC *vc = [[ShopCertifiVC alloc]initWithNibName:@"ShopCertifiVC" bundle:nil];
                    vc.hidesBottomBarWhenPushed = YES;  // 设置B
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else{
                    [self gologin];
                }
            };
            
            cell.todaytoBlock  = ^(HomeCertificationCell *cell){
                if (user.isLogin) {
//                    if (user.identityAuthed==0) {
//                        [self showMessage:@"请先进行实名认证" viewHeight:100];
//                        return;
//                    }
//                    if (user.merchantAuthed==0) {
//                        [self showMessage:@"请先进行店铺认证" viewHeight:100];
//                        return;
//                    }
                    TodayBillVC *vc = [[TodayBillVC alloc]initWithNibName:@"TodayBillVC" bundle:nil];
                    vc.hidesBottomBarWhenPushed = YES;  // 设置B
                    [weakself.navigationController pushViewController:vc animated:YES];
                }
                else{
                    [self gologin];
                }
            };
            
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
        else{
            static NSString *identifier1 = @"HomeDataStatisticsCell";
            HomeDataStatisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
        
        
    }
    else{
          if(indexPath.section == 1){
            static NSString *identifier1 = @"HomeCertificationCell";
            HomeCertificationCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
            cell.reimbursementoBlock  = ^(HomeCertificationCell *cell) {
                CreditCardVC *vc = [[CreditCardVC alloc]initWithNibName:@"CreditCardVC" bundle:nil];
                vc.hidesBottomBarWhenPushed = YES;  // 设置B
                [weakself.navigationController pushViewController:vc animated:YES];
            };
            cell.realnametoBlock = ^(HomeCertificationCell *cell){
                RealNamecation *vc = [[RealNamecation alloc]initWithNibName:@"RealNamecation" bundle:nil];
                vc.hidesBottomBarWhenPushed = YES;  // 设置B
                [self.navigationController pushViewController:vc animated:YES];
            };
            
            cell.storetolock  = ^(HomeCertificationCell *cell){
                ShopCertifiVC *vc = [[ShopCertifiVC alloc]initWithNibName:@"ShopCertifiVC" bundle:nil];
                vc.hidesBottomBarWhenPushed = YES;  // 设置B
                [self.navigationController pushViewController:vc animated:YES];
                
            };
            
            cell.todaytoBlock  = ^(HomeCertificationCell *cell){
                TodayBillVC *vc = [[TodayBillVC alloc]initWithNibName:@"TodayBillVC" bundle:nil];
                vc.hidesBottomBarWhenPushed = YES;  // 设置B
                [weakself.navigationController pushViewController:vc animated:YES];
            };
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
        else{
            static NSString *identifier1 = @"HomeDataStatisticsCell";
            HomeDataStatisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
    }
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)gologin {
    LoginVC *vc = [[LoginVC alloc]initWithNibName:@"LoginVC" bundle:nil];
    vc.loginBlock = ^(LoginVC *vc) {
        
    };
    UINavigationController *naiv = [[UINavigationController alloc]initWithRootViewController:vc];
    
    [self presentViewController:naiv animated:YES completion:nil];
}

@end
