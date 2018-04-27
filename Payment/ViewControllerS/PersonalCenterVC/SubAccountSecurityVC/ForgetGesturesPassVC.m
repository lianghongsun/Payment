//
//  ForgetGesturesPassVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/16.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "ForgetGesturesPassVC.h"

@interface ForgetGesturesPassVC ()

@end

@implementation ForgetGesturesPassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重置手势密码";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)determineAction:(id)sender {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *password = [userDefault objectForKey:@"password"];
    if ([self.loginpassTx.text length]==0) {
        [self showMessage:@"请输入登录密码" viewHeight:0];
        return;
    }
    
    if (![self.loginpassTx.text isEqualToString:password]) {
        [self showMessage:@"密码输入错误,请重新输入" viewHeight:0];
        return;
    }
    
    [userDefault removeObjectForKey:@"LockPath"];
    [userDefault removeObjectForKey:@"isLockPath"];
    [userDefault synchronize];
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
