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
#import "BaseinfoAPI.h"
#import "TodayBillApi.h"
#import "YHKModel.h"
#import "EverydayBillApi.h"

@interface IntelligentCashierVC ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
{
    UserInfo *user;
    NSString *todayAllbill;
    NSString *todayailbill;
    NSString *todayweixinbill;
    NSString *tomoAllBill;
    NSString *tomoailBill;
    NSString *tomoweixinBill;
    
    NSString *myenttime;
}

@end

@implementation IntelligentCashierVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     user = [UserInfo shareObject];
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
    [self BaseinfoAPI];
    myenttime = [JCAUtility stringWithCurrentTime:@"yyyy-MM-dd"];
    
    [self TodayBillApi:user.uid StartDate:[JCAUtility stringWithCurrentTime:@"yyyy-MM-dd"]];
    [self EverydayBillApi:user.uid StartDate:[JCAUtility stringLastWithCurrentTime:@"yyyy-MM-dd"] EndDate:[JCAUtility stringLastWithCurrentTime:@"yyyy-MM-dd"]];
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
    
    if (user.type == 2) {
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
    NSInteger  topheigthnum;
    NSInteger  footheigthnum;
    if (iPhone6Plus_6sPlus) {
        topheigthnum = 200;
        footheigthnum = 185;
    }
    else{
        topheigthnum = 175;
        footheigthnum = 160;
    }
    
    if (user.type ==2) {
        if (indexPath.section == 0) {
            return topheigthnum;
        }
        else if (indexPath.section == 1){
            return 50;
        }
        else if (indexPath.section == 2){
            return footheigthnum;
        }
        return 120;
    }
    else{
        if (indexPath.section == 0) {
            return topheigthnum;
        }
        else if (indexPath.section == 1){
            return footheigthnum;
        }
        return 120;
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
                switch (user.type) {
                    case 1:
                    {
                        [self checkgoscanVc:YES Checkmerchan:YES];
                    }
                        break;
                    case 2:
                    {
                        [self checkgoscanVc:YES Checkmerchan:NO];
                    }break;
                    case 3:
                    {
                        ScanVC *vc = [[ScanVC alloc]initWithNibName:@"ScanVC" bundle:nil];
                        vc.hidesBottomBarWhenPushed = YES;  // 设置B
                        [self.navigationController pushViewController:vc animated:YES];
                    }break;
                    default:
                        break;
                }
            }
            else{
                [self gologin];
            }
        };
        
        cell.smarttoBlock = ^(HoemfirstCell *cell){
            if (user.isLogin) {
                switch (user.type) {
                    case 1:
                    {
                        [self checkgosmartVc:YES Checkmerchan:YES];
                    }
                        break;
                    case 2:
                    {
                        [self checkgosmartVc:YES Checkmerchan:NO];
                    }break;
                    case 3:
                    {
                        SmartCodeVC *vc = [[SmartCodeVC alloc]initWithNibName:@"SmartCodeVC" bundle:nil];
                        vc.hidesBottomBarWhenPushed = YES;  // 设置B
                        [self.navigationController pushViewController:vc animated:YES];
                    }break;
                        
                    default:
                        break;
                }
            }
            else{
                [self gologin];
            }
        };
        
        cell.paymenttoBlock  = ^(HoemfirstCell *cell){
            if (user.isLogin) {
                switch (user.type) {
                    case 1:
                    {
                        [self checkpaymentVc:YES Checkmerchan:YES];
                    }
                        break;
                    case 2:
                    {
                        [self checkpaymentVc:YES Checkmerchan:NO];
                    }break;
                    case 3:
                    {
                        PaymentCodeVC *vc = [[PaymentCodeVC alloc]initWithNibName:@"PaymentCodeVC" bundle:nil];
                        vc.hidesBottomBarWhenPushed = YES;  // 设置B
                        [self.navigationController pushViewController:vc animated:YES];
                    }break;
                    default:
                        break;
                }
            }
            else{
                [self gologin];
            }
        };
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    if (user.type == 2) {
         if (indexPath.section == 1){
            static NSString *identifier1 = @"HomeBalanceCell";
            HomeBalanceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
            cell.balanceLab.text = [NSString stringWithFormat:@"%0.2f元",[[user.accounts objectForKey:@"R"]floatValue]] ;
            cell.withdrawalstoBlock = ^(HomeBalanceCell *cell) {
                
                if (user.isLogin) {
                    [self  checkgoWithdrawalsVC:YES Checkmerchan:NO];
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
                    [self checkgoCreditCardVC:YES Checkmerchan:NO];
                }
                else{
                    [self gologin];
                }
            };
            cell.realnametoBlock = ^(HomeCertificationCell *cell){
                if (user.isLogin) {
                    [self checkgoRealNamecation];
                }
                else{
                    [self gologin];
                }
            };
            
            cell.storetolock  = ^(HomeCertificationCell *cell){
                
                if (user.isLogin) {
                    [self checkgoShopCertifiVC];
                }
                else{
                    [self gologin];
                }
            };
            
            cell.todaytoBlock  = ^(HomeCertificationCell *cell){
                if (user.isLogin) {
                    [self checkgoTodayBillVC:YES Checkmerchan:NO];
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
            cell.alltodaypriceLab.text = todayAllbill;
            cell.alltomopriceLab.text = tomoAllBill;
            cell.alipaytodaypriceLab.text = todayailbill;
            cell.ailpaytomopriceLab.text = tomoailBill;
            cell.weixintodaypeiceLab.text = todayweixinbill;
            cell.weixintomopriceLab.text = tomoweixinBill;
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
                [self showMessage:@"您还没有权限使用此功能" viewHeight:0];
                
            };
            cell.realnametoBlock = ^(HomeCertificationCell *cell){
                [self checkgoRealNamecation];
            };
            
            cell.storetolock  = ^(HomeCertificationCell *cell){
                [self checkgoShopCertifiVC];
                
            };
            
            cell.todaytoBlock  = ^(HomeCertificationCell *cell){
                switch (user.type) {
                    case 1:
                    {
                        [self checkgoTodayBillVC:YES Checkmerchan:YES];
                    }
                        break;
                    case 3:
                    {
                        TodayBillVC *vc = [[TodayBillVC alloc]initWithNibName:@"TodayBillVC" bundle:nil];
                        vc.hidesBottomBarWhenPushed = YES;  // 设置B
                        [weakself.navigationController pushViewController:vc animated:YES];
                    }break;
                    default:
                        break;
                }
            };
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
        else{
            static NSString *identifier1 = @"HomeDataStatisticsCell";
            HomeDataStatisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
            cell.alltodaypriceLab.text = todayAllbill;
            cell.alltomopriceLab.text = tomoAllBill;
            cell.alipaytodaypriceLab.text = todayailbill;
            cell.ailpaytomopriceLab.text = tomoailBill;
            cell.weixintodaypeiceLab.text = todayweixinbill;
            cell.weixintomopriceLab.text = tomoweixinBill;
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)gologin {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)BaseinfoAPI {
    BaseinfoAPI *basein = [[BaseinfoAPI alloc]initWith];
    [basein startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    UserInfo *user = [UserInfo shareObject];
                    [user mj_setKeyValues:dic];
                    user.isLogin = YES;
                     [self.tableview.mj_header beginRefreshing];
                    
                    
                }
                    break;
                default:
                {
                    NSString *mesgStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"msg"]];
                    [self showMessage:mesgStr viewHeight:0];
                }
                    break;
            }
        }
    } failure:^(YTKBaseRequest *request) {
        
        
    }];
}

#pragma mark -- 扫一扫
- (void)checkgoscanVc:(BOOL)checkident Checkmerchan:(BOOL)checkmerchan{
    if (checkident) {
        if (!(user.identityAuthed==1)) {
            [self showMessage:@"请先进行实名认证" viewHeight:0];
            return;
        }
    }
    
    if (checkmerchan) {
        if (!(user.merchantAuthed==1)) {
            [self showMessage:@"请先进行店铺认证" viewHeight:0];
            return;
        }
    }
    
    ScanVC *vc = [[ScanVC alloc]initWithNibName:@"ScanVC" bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;  // 设置B
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- 智能码
- (void)checkgosmartVc:(BOOL)checkident Checkmerchan:(BOOL)checkmerchan {
    if (checkident) {
        if (!(user.identityAuthed==1)) {
            [self showMessage:@"请先进行实名认证" viewHeight:0];
            return;
        }
    }
    
    if (checkmerchan) {
        if (!(user.merchantAuthed==1)) {
            [self showMessage:@"请先进行店铺认证" viewHeight:0];
            return;
        }
    }
    
    SmartCodeVC *vc = [[SmartCodeVC alloc]initWithNibName:@"SmartCodeVC" bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;  // 设置B
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)checkpaymentVc:(BOOL)checkident Checkmerchan:(BOOL)checkmerchan {
    if (checkident) {
        if (!(user.identityAuthed==1)) {
            [self showMessage:@"请先进行实名认证" viewHeight:0];
            return;
        }
    }
    
    if (checkmerchan) {
        if (!(user.merchantAuthed==1)) {
            [self showMessage:@"请先进行店铺认证" viewHeight:0];
            return;
        }
    }
    
    PaymentCodeVC *vc = [[PaymentCodeVC alloc]initWithNibName:@"PaymentCodeVC" bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;  // 设置B
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- 收款码
- (void)checkgoWithdrawalsVC:(BOOL)checkident Checkmerchan:(BOOL)checkmerchan {
    if (checkident) {
        if (!(user.identityAuthed==1)) {
            [self showMessage:@"请先进行实名认证" viewHeight:0];
            return;
        }
    }
    
    if (checkmerchan) {
        if (!(user.merchantAuthed==1)) {
            [self showMessage:@"请先进行店铺认证" viewHeight:0];
            return;
        }
    }
    
    WithdrawalsVC *vc = [[WithdrawalsVC alloc]initWithNibName:@"WithdrawalsVC" bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;  // 设置B
    vc.balancenum = [NSString stringWithFormat:@"%0.2f",[[user.accounts objectForKey:@"R"]floatValue]];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- 信用卡
- (void)checkgoCreditCardVC:(BOOL)checkident Checkmerchan:(BOOL)checkmerchan {
    
    if (checkident) {
        if (!(user.identityAuthed==1)) {
            [self showMessage:@"请先进行实名认证" viewHeight:0];
            return;
        }
    }
    
    if (checkmerchan) {
        if (!(user.merchantAuthed==1)) {
            [self showMessage:@"请先进行店铺认证" viewHeight:0];
            return;
        }
    }
    
    CreditCardVC *vc = [[CreditCardVC alloc]initWithNibName:@"CreditCardVC" bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;  // 设置B
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --实名认证
- (void)checkgoRealNamecation{
    if (user.type==3) {
        [self showMessage:@"您不要进行此步骤" viewHeight:0];
        return;
    }
    RealNamecation *vc = [[RealNamecation alloc]initWithNibName:@"RealNamecation" bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;  // 设置B
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- 店铺认证
- (void)checkgoShopCertifiVC {
    if (user.type==3) {
        [self showMessage:@"您不要进行此步骤" viewHeight:0];
        return;
    }
    ShopCertifiVC *vc = [[ShopCertifiVC alloc]initWithNibName:@"ShopCertifiVC" bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;  // 设置B
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --今日数据
- (void)checkgoTodayBillVC:(BOOL)checkident Checkmerchan:(BOOL)checkmerchan {
    if (checkident) {
        if (!(user.identityAuthed==1)) {
            [self showMessage:@"请先进行实名认证" viewHeight:0];
            return;
        }
    }
    
    if (checkmerchan) {
        if (!(user.merchantAuthed==1)) {
            [self showMessage:@"请先进行店铺认证" viewHeight:0];
            return;
        }
    }
    
    TodayBillVC *vc = [[TodayBillVC alloc]initWithNibName:@"TodayBillVC" bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;  // 设置B
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)TodayBillApi:(NSString *)mid StartDate:(NSString *)startDate{
    [self showLoding:@"请稍后"];
    TodayBillApi *todaybill = [[TodayBillApi alloc]initWithUid:mid StartDate:startDate];
    [todaybill startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            [self closeLoding];
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    NSDictionary *datadic = [dic objectForKey:@"data"];
                    NSMutableArray*listarr = [NSMutableArray array];
                    [listarr addObjectsFromArray:[TodayBillFirstModel mj_objectArrayWithKeyValuesArray:[datadic objectForKey:@"list"]]];
                    
                    TodayBillFirstModel *model1 = listarr[0];
                    TodayBillFirstModel *model2 = listarr[1];
                    
                    
                        todayAllbill = [NSString stringWithFormat:@"今日 %.2f",[[datadic objectForKey:@"totalAmount"]floatValue]];
                        if ([model1.platformId isEqualToString:@"100"]) {
                            todayweixinbill = [NSString stringWithFormat:@"今日 %.2f",[model1.totalAmount floatValue]];
                        }
                        else{
                            todayweixinbill = [NSString stringWithFormat:@"今日 %.2f",[model1.totalAmount floatValue]];
                        }
                        
                        if ([model2.platformId isEqualToString:@"100"]) {
                            todayailbill = [NSString stringWithFormat:@"今日 %.2f",[model2.totalAmount floatValue]];
                        }
                        else{
                            todayailbill = [NSString stringWithFormat:@"今日 %.2f",[model2.totalAmount floatValue]];
                        }
                    
                    
                    [self.tableview reloadData];
                    
                }
                    break;
                default:
                {
                    NSString *mesgStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"msg"]];
                    [self showMessage:mesgStr viewHeight:0];
                }
                    break;
            }
        }
    } failure:^(YTKBaseRequest *request) {
        [self closeLoding];
        
        
    }];
}

- (void)EverydayBillApi:(NSString *)mid StartDate:(NSString *)startDate EndDate:(NSString *)endDate{
    [self showLoding:@"请稍后"];
    EverydayBillApi *todaybill = [[EverydayBillApi alloc]initWithUid:mid StartDate:startDate EndDate:endDate];
    [todaybill startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            [self closeLoding];
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    NSDictionary *datadic = [dic objectForKey:@"data"];
                    NSMutableArray*listarr = [NSMutableArray array];
                    [listarr addObjectsFromArray:[TodayBillFirstModel mj_objectArrayWithKeyValuesArray:[datadic objectForKey:@"list"]]];
                    
                    TodayBillFirstModel *model1 = listarr[0];
                    TodayBillFirstModel *model2 = listarr[1];
                    
                    
                        tomoAllBill = [NSString stringWithFormat:@"昨日 %.2f",[[datadic objectForKey:@"totalAmount"]floatValue]];
                        if ([model1.platformId isEqualToString:@"100"]) {
                            tomoweixinBill = [NSString stringWithFormat:@"昨日 %.2f",[model1.totalAmount floatValue]];
                        }
                        else{
                            tomoweixinBill = [NSString stringWithFormat:@"昨日 %.2f",[model1.totalAmount floatValue]];
                        }
                        
                        if ([model2.platformId isEqualToString:@"100"]) {
                            tomoailBill = [NSString stringWithFormat:@"昨日 %.2f",[model2.totalAmount floatValue]];
                        }
                        else{
                            tomoailBill = [NSString stringWithFormat:@"昨日 %.2f",[model2.totalAmount floatValue]];
                        }
        
                    [self.tableview reloadData];
                    
                }
                    break;
                default:
                {
                    NSString *mesgStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"msg"]];
                    [self showMessage:mesgStr viewHeight:0];
                }
                    break;
            }
        }
    } failure:^(YTKBaseRequest *request) {
        [self closeLoding];
        
        
    }];
}



@end
