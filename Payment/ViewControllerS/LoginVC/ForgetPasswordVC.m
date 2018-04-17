//
//  ForgetPasswordVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "ForgetPasswordVC.h"
#import "ForgetPassSecondVC.h"
#import "SendsmsAPI.h"

@interface ForgetPasswordVC ()<UITextFieldDelegate>

@end

@implementation ForgetPasswordVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    
    self.iponeText.delegate = self;
    self.codeText.delegate = self;
    
    self.iponeImg.image =  [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6a1", 40, RGB(153, 153, 153))];
    
      self.codeImg.image =  [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6a0", 40, RGB(153, 153, 153))];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (IBAction)getcodeAction:(id)sender {
    
    if (![self phoneisMatchWith:self.iponeText.text]) {
        return;
    }
    
    [self SendsmsAPI];
    
}

- (IBAction)nextAction:(id)sender {
    
    if (![self phoneisMatchWith:self.iponeText.text]) {
        return;
    }
    
    if (self.codeText.text.length < 1) {
        [self showMessage:@"请输入验证码" viewHeight:100];
        return;
    }
    ForgetPassSecondVC *vc = [[ForgetPassSecondVC alloc]initWithNibName:@"ForgetPassSecondVC" bundle:nil];
    vc.code = self.codeText.text;
    vc.username = self.iponeText.text;
    [self.navigationController pushViewController:vc animated:YES];
}



- (void) SendsmsAPI {
    [self showLoding:@"正在发送"];
    //    self.verificationBtn.userInteractionEnabled=NO;
    //    timeCounts = 60;
    //    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self  selector:@selector(showTimeLabels) userInfo:nil repeats:YES];
    
    SendsmsAPI *sms = [[SendsmsAPI alloc]initWithMobileNo:self.iponeText.text BzType:@"EDITPASSWD_VALIDCODE"];
    [sms startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [self closeLoding];
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    [self showMessage:@"验证码发送成功，请查看短信" viewHeight:100];
                }
                    break;
                default:
                {
                    NSString *mesgStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"msg"]];
                    [self showMessage:mesgStr viewHeight:100];
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
    if (textField == self.iponeText) {
        [self.iponeText resignFirstResponder];
        [self.codeText becomeFirstResponder];
    }else{
        [self.codeText resignFirstResponder];
    }
    return YES;
}


@end
