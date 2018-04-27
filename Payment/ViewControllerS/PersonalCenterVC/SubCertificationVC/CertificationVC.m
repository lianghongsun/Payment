//
//  CertificationVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/2.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "CertificationVC.h"
#import "RealNameSecondVC.h"
#import "ShopCerifiSecoendVC.h"
#import "MerchantFailureVC.h"
#import "RealNameFailureVC.h"

@interface CertificationVC ()
{
    UserInfo *user;
}
@end

@implementation CertificationVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    user = [UserInfo shareObject];
    switch (user.identityAuthed) {
        case 0:
        {
            self.real_nameLab.text = @"未认证";
        }
            break;
        case 1:
        {
            self.real_nameLab.text = @"已认证";
        }
            break;
        case 2:
        {
            self.real_nameLab.text = @"审核中";
        }break;
        case 3:
        {
            self.real_nameLab.text = @"审核失败";
        }
            break;
        default:
            break;
    }
    
    switch (user.merchantAuthed) {
        case 0:
        {
            self.shopLab.text = @"未认证";
        }
            break;
        case 1:
        {
            self.shopLab.text = @"已认证";
        }
            break;
        case 2:
        {
            self.shopLab.text = @"审核中";
        }break;
        case 3:
        {
            self.shopLab.text = @"审核失败";
        }
            break;
        default:
            break;
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息认证";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 实名
- (IBAction)realnameAction:(id)sender {
    if ([self.real_nameLab.text isEqualToString:@"未认证"]) {
        RealNameSecondVC *vc = [[RealNameSecondVC alloc]initWithNibName:@"RealNameSecondVC" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.real_nameLab.text isEqualToString:@"审核失败"]){
        RealNameFailureVC *vc = [[RealNameFailureVC alloc]initWithNibName:@"RealNameFailureVC" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        
    }
    
}
//店铺信息
- (IBAction)shopAction:(id)sender {
    if ([self.shopLab.text isEqualToString:@"未审核"]) {
        ShopCerifiSecoendVC *vc = [[ShopCerifiSecoendVC alloc]initWithNibName:@"ShopCerifiSecoendVC" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.shopLab.text isEqualToString:@"审核失败"]){
        MerchantFailureVC *vc = [[MerchantFailureVC alloc]initWithNibName:@"MerchantFailureVC" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        
    }
}

@end
