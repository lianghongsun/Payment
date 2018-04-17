//
//  AddCreditCardVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "AddCreditCardVC.h"
#import "ConfirmPaymentVC.h"

@interface AddCreditCardVC ()

@end

@implementation AddCreditCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加信用卡";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)saveAction:(id)sender {
    
    ConfirmPaymentVC *vc = [[ConfirmPaymentVC alloc]initWithNibName:@"ConfirmPaymentVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
