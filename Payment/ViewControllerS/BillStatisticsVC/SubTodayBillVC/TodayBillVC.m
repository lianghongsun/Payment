//
//  TodayBillVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/4.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "TodayBillVC.h"
#import "AilpaybillVC.h"
@interface TodayBillVC ()<UINavigationControllerDelegate>

@end

@implementation TodayBillVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
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
    self.allgetpriceLab.text = [NSString stringWithFormat:@"¥%@",@"8888.00"];
    self.billnumLab.text = [NSString stringWithFormat:@"%@笔",@"6"];
    self.ailPaypriceLab.text = [NSString stringWithFormat:@"%@",@"888.00"];
    self.weixinpriceLab.text = [NSString stringWithFormat:@"%@",@"888.00"];
    self.ailpaynumLab.text = [NSString stringWithFormat:@"%@笔",@"3"];
    self.weixinnumLab.text = [NSString stringWithFormat:@"%@笔",@"3"];
    
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
@end
