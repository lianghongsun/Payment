//
//  ConfirmPaymentVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "ConfirmPaymentVC.h"
#import "CreditSucc.h"

@interface ConfirmPaymentVC ()

@end

@implementation ConfirmPaymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信用卡还款";
    [self setrigBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setrigBtn {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 30, 30);
    [rightButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e696", 30, RGB(255, 255, 255))] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc ] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;
    
}

- (void)rightAction {
    
    
}
- (IBAction)reimbursementAction:(id)sender {
    CreditSucc *vc = [[CreditSucc alloc]initWithNibName:@"CreditSucc" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
