//
//  LoginVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "RegisteredVC.h"
#import "SendsmsAPI.h"
#import "RegisterPI.h"

@interface RegisteredVC ()<UITextFieldDelegate>
{
    int timeCounts;
    BOOL isagerr;
}
@end

@implementation RegisteredVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.usernameText.delegate = self;
    self.passwordText.delegate = self;
    self.againpasswordText.delegate = self;
    self.verificationText.delegate = self;
    
    [self.passwordText setSecureTextEntry:YES];
    [self.againpasswordText setSecureTextEntry:YES];
    
    self.nameimg.image =  [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e65a", 40, RGB(153, 153, 153))];
    self.passimg.image =  [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62a", 40, RGB(153, 153, 153))];
    self.againpassimg.image =  [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62a", 40, RGB(153, 153, 153))];
    self.viccodeimg.image =  [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6a0", 40, RGB(153, 153, 153))];
    
    
    [self.agreeBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e615", 40, RGB(220, 220, 220))] forState:UIControlStateNormal];
    [self.agreeBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e614", 40, ThemeColor)] forState:UIControlStateSelected];
    [self.agreeBtn addTarget:self action:@selector(agreedAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [timer invalidate]; // 移除定时器
    timer  = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (IBAction)loginAction:(id)sender {
}

- (IBAction)verificationAction:(id)sender {
    
        if (![self phoneisMatchWith:self.usernameText.text]) {
            return;
        }
    
         [self SendsmsAPI];
}

- (void)agreedAction:(UIButton *)button {
    
    button.selected = !button.isSelected;
    isagerr = button.selected;
}



- (IBAction)agreementAction:(id)sender {
}

- (IBAction)registeredAction:(id)sender {
    if (![self phoneisMatchWith:self.usernameText.text]) {
        return;
    }
    if ([self.passwordText.text length]<6) {
        [self showMessage:@"密码为6位数以上数字或字母" viewHeight:0];
        return;
    }
    if ([self.againpasswordText.text length]<6) {
        [self showMessage:@"密码为6位数以上数字或字母" viewHeight:0];
        return;
    }
    if (![self.againpasswordText.text isEqualToString:self.passwordText.text]) {
        [self showMessage:@"两次输入的密码不一致" viewHeight:0];
        return;
    }
    if (self.verificationText.text.length < 1) {
        [self showMessage:@"请输入验证码" viewHeight:0];
        return;
    }
    if (!isagerr) {
        [self showMessage:@"请勾选同意用户协议" viewHeight:0];
    }
    
    [self RegisterPI];
}

- (IBAction)backLoginAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) SendsmsAPI {
    [self showLoding:@"正在发送"];
//    self.verificationBtn.userInteractionEnabled=NO;
//    timeCounts = 60;
//    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self  selector:@selector(showTimeLabels) userInfo:nil repeats:YES];
    
    SendsmsAPI *sms = [[SendsmsAPI alloc]initWithMobileNo:self.usernameText.text BzType:@"REG_VALIDCODE"];
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

- (void) RegisterPI {
    [self showLoding:@"正在注册"];
    RegisterPI *regis = [[RegisterPI alloc]initWithUsername:self.usernameText.text Passwd:[JUtility md5:self.passwordText.text] BzType:@"REG_VALIDCODE" Smscode:self.verificationText.text NeedLogin:@"1"];
    [regis startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [self closeLoding];
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    [self showMessage:@"注册成功" viewHeight:0];
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


-(void)showTimeLabels
{
    
    [self.verificationBtn setTitle:[NSString stringWithFormat:@"发送中%i秒",timeCounts] forState:UIControlStateNormal];
    timeCounts -= 1;
    
    if (timeCounts <= 0) {
        [timer invalidate];
        self.verificationBtn.userInteractionEnabled=YES;
        
        [self.verificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameText) {
        [self.usernameText resignFirstResponder];
        [self.passwordText becomeFirstResponder];
    }else if(textField == self.passwordText){
        [self.passwordText resignFirstResponder];
        [self.againpasswordText becomeFirstResponder];
    }else if (textField == self.againpasswordText){
        [self.againpasswordText resignFirstResponder];
        [self.verificationText becomeFirstResponder];
    }
    else{
        [self.verificationText resignFirstResponder];
    }
    return YES;
}


@end
