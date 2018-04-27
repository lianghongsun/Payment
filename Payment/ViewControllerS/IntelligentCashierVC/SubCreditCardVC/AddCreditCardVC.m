//
//  AddCreditCardVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "AddCreditCardVC.h"
#import "ConfirmPaymentVC.h"
#import "AddCreditCardApi.h"

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
    if ([self.cardText.text length]<=0) {
        [self showMessage:@"发卡行不能为空" viewHeight:0];
        return;
    }
    if ([self.againcardText.text length]<=0) {
        [self showMessage:@"信用卡不能为空" viewHeight:0];
        return;
    }
    if ([self.cardnameText.text length]<=0) {
        [self showMessage:@"持卡人姓名不能为空" viewHeight:0];
        return;
    }
    
    [self AddCreditCardApi];
   
    
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

- (void)AddCreditCardApi {
    [self showLoding:@"请稍后"];
    AddCreditCardApi *addcred = [[AddCreditCardApi alloc]initWithRealname:self.cardnameText.text BankNo:self.againcardText.text BankName:self.cardText.text];
    [addcred startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [self closeLoding];
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                     ConfirmPaymentVC *vc = [[ConfirmPaymentVC alloc]initWithNibName:@"ConfirmPaymentVC" bundle:nil];
                    vc.realname =self.cardnameText.text;
                    vc.bankNo = self.againcardText.text;
                    vc.bankName = self.cardText.text;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                default:
                {
                    NSString *mesgStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"msg"]];
                    [self showMessage:mesgStr viewHeight:0];
                }
                    break;
            }
        }
    } failure:^(YTKBaseRequest *request) {
        [self closeLoding];
        
        
    }];
}

@end
