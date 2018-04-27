//
//  ChangeLoginPassVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/1.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "ResetPayPassVC.h"
#import "SendsmsAPI.h"
#import "ResetPayPassAPI.h"


@interface ResetPayPassVC ()<UITextFieldDelegate>
{
    UserInfo *user;
}
@end

@implementation ResetPayPassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重置支付密码";
    
    self.passText.delegate = self;
    self.againpassText.delegate = self;
    self.smsText.delegate = self;
    
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

}


- (IBAction)smsAction:(id)sender {
    
    [self SendsmsAPI];
}

- (IBAction)confirmAction:(id)sender {
    if ([self.passText.text length]<1) {
        [self showMessage:@"请输入真实姓名" viewHeight:0];
        return;
    }
    if ([self.againpassText.text length]<1) {
        [self showMessage:@"请输入身份证号" viewHeight:0];
        return;
    }
    
    if (![self checkUserID:self.againpassText.text]) {
        [self showMessage:@"身份证号不合法，请重新输入" viewHeight:0];
        return;
    }
    if ([self.smsText.text length]<=0) {
        [self showMessage:@"请输入验证码" viewHeight:0];
        return;
    }
    [self ResetPayPassAPI];
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

- (void)ResetPayPassAPI {
    [self showLoding:@"请稍后"];
    ResetPayPassAPI *paypass = [[ResetPayPassAPI alloc]initWithUid:user.uid RealName:self.passText.text IdentityNo:self.againpassText.text Smscode:self.smsText.text];
    [paypass startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [self closeLoding];
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    [self showMessage:@"支付密码重置成功" viewHeight:0];
                    user.paypasswdAuthed = 0;
                    [self.navigationController popViewControllerAnimated:YES];
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
