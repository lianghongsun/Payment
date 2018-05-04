//
//  ForgetPassSecondVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/7.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "ForgetPassSecondVC.h"
#import "PassportAPI.h"

@interface ForgetPassSecondVC ()<UITextFieldDelegate>

@end

@implementation ForgetPassSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    self.newpasswordText.delegate = self;
    self.againnewpassText.delegate = self;
    [self.newpasswordText setSecureTextEntry:YES];
    [self.againnewpassText setSecureTextEntry:YES];
    
    self.newpasswordText.autocorrectionType = UITextAutocorrectionTypeNo;
    self.againnewpassText.autocorrectionType = UITextAutocorrectionTypeNo;
    
    
    self.passImg.image =  [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62a", 40, RGB(153, 153, 153))];
    self.againpassImg.image =  [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62a", 40, RGB(153, 153, 153))];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)determineAction:(id)sender {
    
    [self Packupthekeyboard];
    if ([self.newpasswordText.text length]<6) {
        [self showMessage:@"密码为6位数以上数字或字母" viewHeight:0];
        return;
    }
    if ([self.againnewpassText.text length]<6) {
        [self showMessage:@"密码为6位数以上数字或字母" viewHeight:0];
        return;
    }
    if (![self.againnewpassText.text isEqualToString:self.newpasswordText.text]) {
        [self showMessage:@"两次输入的密码不一致" viewHeight:0];
        return;
    }
    [self PassportAPI];
    
}


- (void) PassportAPI {
    [self showLoding:@"正在重置新密码"];
    PassportAPI *passport = [[PassportAPI alloc]initWithUsername:self.username NewPasswd:[JUtility md5:self.newpasswordText.text] Smscode:self.code];
    [passport startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [self closeLoding];
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)request.responseJSONObject;
            NSInteger responseCode = [[dic objectForKey:@"retcode"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    NSDictionary *datadic = [dic objectForKey:@"data"];
                    NSInteger Code = [[datadic objectForKey:@"code"] integerValue];
                    
                    switch (Code) {
                        case SubRequestStatusSuccess:
                        {
                            [self showMessage:@"密码重置成功" viewHeight:0];
                            [self.navigationController popToRootViewControllerAnimated:YES];
                        }
                            break;
                            
                        default:
                        {
                            NSString *mesgStr = [NSString stringWithFormat:@"%@",[datadic objectForKey:@"msg"]];
                            [self showMessage:mesgStr viewHeight:0];
                        }
                            break;
                    }
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.newpasswordText) {
        [self.newpasswordText resignFirstResponder];
        [self.againnewpassText becomeFirstResponder];
    }else{
        [self.againnewpassText resignFirstResponder];
    }
    return YES;
}

- (void)Packupthekeyboard{
    [self.newpasswordText resignFirstResponder];
    [self.againnewpassText resignFirstResponder];
}

@end
