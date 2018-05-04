//
//  BindingYHKSecondVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/11.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "BindingYHKSecondVC.h"
#import "UIView+Extension.h"
#import "AddDebitcardApi.h"
#import "SendsmsAPI.h"

@interface BindingYHKSecondVC ()<LSXPopMenuDelegate,UITextFieldDelegate>
{
    NSArray *titlearr;
    UserInfo *user;
}
@end

@implementation BindingYHKSecondVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    user = [UserInfo shareObject];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    titlearr = @[@"个人账户",@"对公账户"];
    self.title = @"增加收款银行卡";
    
    self.nameTx.delegate = self;
    self.yhknumTx.delegate = self;
    self.openaccountTc.delegate = self;
    self.iponeTx.delegate = self;
    self.codeTx.delegate = self;
    
    self.typeLab.text = [NSString stringWithFormat:@"%@",titlearr[0]];
    
    self.typeview.layer.borderWidth = 1;
    self.typeview.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.typeBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60e", 40, ThemeColor)] forState:UIControlStateNormal];
    
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

#pragma mark --  LSXPopupMenDelegate
-(void)LSXPopupMenuDidSelectedAtIndex:(NSInteger)index LSXPopupMenu:(LSXPopMenu *)LSXPopupMenu{
    self.typeLab.text = [NSString stringWithFormat:@"%@",titlearr[index]];
    NSLog(@"------点击---%ld",(long)index);
}

- (IBAction)typeAction:(id)sender {
    [self Packupthekeyboard];
    
    [LSXPopMenu showRelyOnView:sender titles:titlearr  icons:@[@"",@""] menuWidth:120 isShowTriangle:YES delegate:self];
    
}
- (IBAction)getcodeAction:(id)sender {
    UserInfo *user = [UserInfo shareObject];
    if (!user.isLogin) {
        [self gobacklogin];
        return;
    }
    [self SendsmsAPI];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameTx) {
        [self.nameTx resignFirstResponder];
        [self.yhknumTx becomeFirstResponder];
    }else if(textField == self.yhknumTx){
        [self.yhknumTx resignFirstResponder];
    }
    else if (textField == self.openaccountTc){
        [self.openaccountTc resignFirstResponder];
        [self.codeTx becomeFirstResponder];
    }
    else
    {
        [self.codeTx resignFirstResponder];
    }
    return YES;
}

- (void)AddDebitcardApi {
    [self showLoding:@"请稍后"];
    NSString *typestr;
    if ([self.typeLab.text isEqualToString:@"个人账户"]) {
        typestr = @"1";
    }
    else{
        typestr = @"2";
    }
    AddDebitcardApi *adddebit = [[AddDebitcardApi alloc]initWithRealname:self.nameTx.text BankNo:self.yhknumTx.text BankName:self.openaccountTc.text CardType:typestr Smscode:self.codeTx.text];
    [adddebit startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
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
                            [self.navigationController popViewControllerAnimated:YES];
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


- (void) SendsmsAPI {
    [self showLoding:@"正在发送"];
    SendsmsAPI *sms = [[SendsmsAPI alloc]initWithMobileNo:user.mobile BzType:@"ADDDEBITCARD_VALIDCODE"];
    [sms startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
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
                          [self showMessage:@"验证码发送成功，请查看短信" viewHeight:0];
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


- (IBAction)submitAction:(id)sender {
    UserInfo *user = [UserInfo shareObject];
    if (!user.isLogin) {
        [self gobacklogin];
        return;
    }
    if ([self.nameTx.text length]<=0) {
        [self showMessage:@"持卡人姓名不能为空" viewHeight:0];
        return;
    }
    if ([self.yhknumTx.text length]<=0) {
        [self showMessage:@"银行卡卡号不能为空" viewHeight:0];
        return;
    }
    if ([self.openaccountTc.text length]<=0) {
        [self showMessage:@"开户银行不能为空" viewHeight:0];
        return;
    }
    if ([self.codeTx.text length]<=0) {
        [self showMessage:@"验证码不能为空" viewHeight:0];
        return;
    }
    [self AddDebitcardApi];
}

- (void)Packupthekeyboard{
    [self.nameTx resignFirstResponder];
    [self.yhknumTx resignFirstResponder];
    [self.openaccountTc resignFirstResponder];
    [self.codeTx resignFirstResponder];
}
@end
