//
//  ShopCerifiThreeVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/11.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "ShopCerifiThreeVC.h"
#import "ShopCerifFourVC.h"

@interface ShopCerifiThreeVC ()<UITextFieldDelegate>

@end

@implementation ShopCerifiThreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺信息";
    
    self.nameTx.delegate = self;
    self.provinceTx.delegate = self;
    self.cityTx.delegate = self;
    self.countyTx.delegate = self;
    self.adreeTx.delegate = self;
    self.categoryTx.delegate = self;
    
    [self.agreeBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e615", 40, RGB(220, 220, 220))] forState:UIControlStateNormal];
    [self.agreeBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e614", 40, ThemeColor)] forState:UIControlStateSelected];
    [self.agreeBtn addTarget:self action:@selector(agreedAction:) forControlEvents:UIControlEventTouchUpInside];
    if ([self.storestr isEqualToString:@"有证个体户"]) {
        [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    }
    else if ([self.storestr isEqualToString:@"无证个体户"]){
        [self.nextBtn setTitle:@"提交" forState:UIControlStateNormal];
    }
    else{
        [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)agreedAction:(UIButton *)button {
    
    button.selected = !button.isSelected;
}

- (IBAction)nextAction:(id)sender {
    
    if ([self.storestr isEqualToString:@"有证个体户"]) {
        ShopCerifFourVC *vc = [[ShopCerifFourVC alloc]initWithNibName:@"ShopCerifFourVC" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.storestr isEqualToString:@"无证个体户"]){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else{
        ShopCerifFourVC *vc = [[ShopCerifFourVC alloc]initWithNibName:@"ShopCerifFourVC" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameTx) {
        [self.nameTx resignFirstResponder];
        [self.provinceTx becomeFirstResponder];
    }else if(textField == self.provinceTx){
        [self.provinceTx resignFirstResponder];
        [self.cityTx becomeFirstResponder];
    }
    else if (textField == self.cityTx){
        [self.cityTx resignFirstResponder];
        [self.countyTx becomeFirstResponder];
    }
    else if (textField == self.countyTx){
        [self.countyTx resignFirstResponder];
        [self.adreeTx becomeFirstResponder];
    }
    else if (textField == self.adreeTx){
        [self.adreeTx resignFirstResponder];
        [self.categoryTx becomeFirstResponder];
    }
    else{
        [self.categoryTx resignFirstResponder];
    }
    return YES;
}

@end
