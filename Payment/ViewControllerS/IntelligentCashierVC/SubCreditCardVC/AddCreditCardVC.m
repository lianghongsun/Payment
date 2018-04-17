//
//  AddCreditCardVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "AddCreditCardVC.h"
#import "ConfirmPaymentVC.h"

@interface AddCreditCardVC ()<UITextFieldDelegate>

@end

@implementation AddCreditCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加信用卡";
    
    self.cardText.delegate = self;
    self.againcardText.delegate = self;
    self.cardnameText.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)saveAction:(id)sender {
    
    ConfirmPaymentVC *vc = [[ConfirmPaymentVC alloc]initWithNibName:@"ConfirmPaymentVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.cardText) {
        [self.cardText resignFirstResponder];
        [self.againcardText becomeFirstResponder];
    }else if(textField == self.againcardText){
        [self.againcardText resignFirstResponder];
        [self.cardnameText becomeFirstResponder];
    }
    else{
        [self.cardnameText resignFirstResponder];
    }
    return YES;
}



@end
