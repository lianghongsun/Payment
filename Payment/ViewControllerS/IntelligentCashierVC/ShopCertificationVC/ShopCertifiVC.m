//
//  ShopCertifiVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/11.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "ShopCertifiVC.h"
#import "ShopCerifiSecoendVC.h"

@interface ShopCertifiVC ()

@end

@implementation ShopCertifiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息认证";
    self.status.text = @"未审核";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (IBAction)nextAction:(id)sender {
    ShopCerifiSecoendVC *vc = [[ShopCerifiSecoendVC alloc]initWithNibName:@"ShopCerifiSecoendVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
