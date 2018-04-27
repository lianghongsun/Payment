//
//  ChangeLoginPassVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/1.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "ChangeLoginPassVC.h"
#import "SendsmsAPI.h"
#import "PassportAPI.h"
#import "LoginVC.h"

@interface ChangeLoginPassVC ()<UITextFieldDelegate>
{
    UserInfo *user;
}
@end

@implementation ChangeLoginPassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改登录密码";
    self.passText.delegate = self;
    self.againpassText.delegate = self;
    self.smsText.delegate = self;
    
    [self.passText setSecureTextEntry:YES];
    [self.againpassText setSecureTextEntry:YES];
    user = [UserInfo shareObject];
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"获取验证码"];
    [tncString addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleSingle)
                      range:(NSRange){0,[tncString length]}];
    
    [tncString addAttribute:NSForegroundColorAttributeName value:ThemeColor  range:NSMakeRange(0,[tncString length])];
    
    [tncString addAttribute:NSUnderlineColorAttributeName value:ThemeColor range:(NSRange){0,[tncString length]}];
    [self.getcodeBtn setAttributedTitle:tncString forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- ButtonAction
- (IBAction)smsAction:(id)sender {
    
    [self SendsmsAPI];
}

- (IBAction)confirmAction:(id)sender {
    if ([self.passText.text length]<6) {
        [self showMessage:@"密码为6位数以上数字或字母" viewHeight:0];
        return;
    }
    if ([self.againpassText.text length]<6) {
        [self showMessage:@"密码为6位数以上数字或字母" viewHeight:0];
        return;
    }
    if (![self.againpassText.text isEqualToString:self.passText.text]) {
        [self showMessage:@"两次输入的密码不一致" viewHeight:0];
        return;
    }
    if (self.smsText.text.length < 1) {
        [self showMessage:@"请输入验证码" viewHeight:0];
        return;
    }
    [self PassportAPI];
    
}

- (void) SendsmsAPI {
    [self showLoding:@"正在发送"];
    SendsmsAPI *sms = [[SendsmsAPI alloc]initWithMobileNo:user.mobile BzType:@"EDITPASSWD_VALIDCODE"];
    [sms startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [self closeLoding];
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    [self showMessage:@"验证码发送成功，请查看短信" viewHeight:0];
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

- (void) PassportAPI {
    [self showLoding:@"正在重置新密码"];
    PassportAPI *passport = [[PassportAPI alloc]initWithUsername:user.mobile NewPasswd:[JUtility md5:self.passText.text] Smscode:self.smsText.text];
    [passport startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [self closeLoding];
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    LoginVC *vc = [[LoginVC alloc]initWithNibName:@"LoginVC" bundle:nil];
                    vc.isloginout = YES;
                    UINavigationController *naiv = [[UINavigationController alloc]initWithRootViewController:vc];
                    
                    [self showMessage:@"密码重置成功" viewHeight:0];
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    //移除UserDefaults中存储的用户信息
                    [userDefaults removeObjectForKey:@"password"];
                    [userDefaults synchronize];
                    UserInfo *user = [UserInfo shareObject];
                    user.isLogin = false;
                    self.tabBarController.selectedIndex = 0;
                    [self presentViewController:naiv animated:YES completion:nil];
                
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
    if (textField == self.passText) {
        [self.passText resignFirstResponder];
        [self.againpassText becomeFirstResponder];
    }else if(textField == self.againpassText){
        [self.againpassText resignFirstResponder];
        [self.smsText becomeFirstResponder];
    }
    else{
        [self.smsText resignFirstResponder];
    }
    return YES;
}



@end
