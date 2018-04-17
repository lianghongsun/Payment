//
//  CertificationVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/2.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "CertificationVC.h"
#import "RealNameCertificationVC.h"
#import "RealNameSecondVC.h"
#import "ShopCerifiSecoendVC.h"

@interface CertificationVC ()

@end

@implementation CertificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息认证";
    self.real_nameLab.text = @"审核中";
    self.shopLab.text = @"未完善";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 实名
- (IBAction)realnameAction:(id)sender {
    RealNameSecondVC *vc = [[RealNameSecondVC alloc]initWithNibName:@"RealNameSecondVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
//店铺信息
- (IBAction)shopAction:(id)sender {
    ShopCerifiSecoendVC *vc = [[ShopCerifiSecoendVC alloc]initWithNibName:@"ShopCerifiSecoendVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
