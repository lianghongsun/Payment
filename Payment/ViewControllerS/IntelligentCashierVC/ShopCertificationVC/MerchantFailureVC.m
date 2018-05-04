//
//  RealNameFailureVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/24.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "MerchantFailureVC.h"
#import "ShopCerifiSecoendVC.h"

@interface MerchantFailureVC ()

@end

@implementation MerchantFailureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息认证";
    self.uploadBtn.backgroundColor = ThemeColor;
    [self.topBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6bd", 30,[UIColor redColor])] forState:UIControlStateNormal];
    [self.topBtn setTitle:@"店铺认证审核未通过" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (IBAction)uploadAgainAction:(id)sender {
    UserInfo *user = [UserInfo shareObject];
    if (!user.isLogin) {
        [self gobacklogin];
        return;
    }
    
    ShopCerifiSecoendVC *vc = [[ShopCerifiSecoendVC alloc]initWithNibName:@"ShopCerifiSecoendVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
