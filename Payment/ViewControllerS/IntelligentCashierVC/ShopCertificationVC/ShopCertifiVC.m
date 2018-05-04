//
//  ShopCertifiVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/11.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "ShopCertifiVC.h"
#import "ShopCerifiSecoendVC.h"
#import "MerchantFailureVC.h"

@interface ShopCertifiVC ()
{
    UserInfo *user;
}
@end

@implementation ShopCertifiVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    user = [UserInfo shareObject];
    switch (user.merchantAuthed) {
        case 0:
        {
            self.status.text = @"未认证";
        }
            break;
        case 1:
        {
            self.status.text = @"已认证";
        }
            break;
        case 2:
        {
            self.status.text = @"审核中";
        }break;
        case 3:
        {
            self.status.text = @"审核失败";
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



- (IBAction)nextAction:(id)sender {
    UserInfo *user = [UserInfo shareObject];
    if (!user.isLogin) {
        [self gobacklogin];
        return;
    }
    
    if ([self.status.text isEqualToString:@"未认证"]) {
        ShopCerifiSecoendVC *vc = [[ShopCerifiSecoendVC alloc]initWithNibName:@"ShopCerifiSecoendVC" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.status.text isEqualToString:@"审核失败"]){
        MerchantFailureVC *vc = [[MerchantFailureVC alloc]initWithNibName:@"MerchantFailureVC" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        
    }
    
}
@end
