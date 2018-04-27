//
//  TodayBillVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/4.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "TodayBillVC.h"
#import "AilpaybillVC.h"
#import "TodayBillApi.h"
#import "YHKModel.h"

@interface TodayBillVC ()<UINavigationControllerDelegate>
{
    UserInfo *user;
}
@property (nonatomic,strong) NSMutableArray *listdataArr;

@end

@implementation TodayBillVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
    user = [UserInfo shareObject];
    [self TodayBillApi:user.uid StartDate:[JCAUtility stringWithCurrentTime:@"yyyy-MM-dd"]];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"今日账单";
    [self setUidata];
   
    [self.backBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e7c2", 30, RGB(255, 255, 255))] forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (void)setUidata{
    
    
}

- (IBAction)alipayAction:(id)sender {
    
    AilpaybillVC *vc = [[AilpaybillVC alloc]initWithNibName:@"AilpaybillVC" bundle:nil];
    vc.titleStr = @"支付宝账单详情";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)weixinAction:(id)sender {
    AilpaybillVC *vc = [[AilpaybillVC alloc]initWithNibName:@"AilpaybillVC" bundle:nil];
    vc.titleStr = @"微信账单详情";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
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
                    self.allgetpriceLab.text = [NSString stringWithFormat:@"¥%.2f",[[datadic objectForKey:@"totalAmount"]floatValue]];
                    self.billnumLab.text = [NSString stringWithFormat:@"%@笔",[datadic objectForKey:@"totalRow"]];
                   
                    self.listdataArr = [NSMutableArray array];
                    [self.listdataArr addObjectsFromArray:[TodayBillFirstModel mj_objectArrayWithKeyValuesArray:[datadic objectForKey:@"list"]]];
                    if (self.listdataArr.count==2) {
                        TodayBillFirstModel *model1 = self.listdataArr[0];
                        TodayBillFirstModel *model2 = self.listdataArr[1];
                        if ([model1.platformId isEqualToString:@"100"]) {
                            self.weixinpriceLab.text = [NSString stringWithFormat:@"%.2f元",[model1.totalAmount floatValue]];
                            self.weixinnumLab.text = [NSString stringWithFormat:@"%@笔",model1.totalRow];
                        }
                        else{
                            self.ailPaypriceLab.text = [NSString stringWithFormat:@"%.2f元",[model1.totalAmount floatValue]];
                            self.ailpaynumLab.text = [NSString stringWithFormat:@"%@笔",model1.totalRow];
                        }
                        
                        
                        if ([model2.platformId isEqualToString:@"100"]) {
                            self.weixinpriceLab.text = [NSString stringWithFormat:@"%.2f元",[model2.totalAmount floatValue]];
                            self.weixinnumLab.text = [NSString stringWithFormat:@"%@笔",model2.totalRow];
                        }
                        else{
                            self.ailPaypriceLab.text = [NSString stringWithFormat:@"%.2f元",[model2.totalAmount floatValue]];
                            self.ailpaynumLab.text = [NSString stringWithFormat:@"%@笔",model2.totalRow];
                        }
                    }
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
