//
//  LoginVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "LoginVC.h"
#import "RegisteredVC.h"
#import "ForgetPasswordVC.h"
#import "LoginAPI.h"

#import "BaseinfoAPI.h"

@interface LoginVC ()<UITextFieldDelegate>
{
    
}
@end

@implementation LoginVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.usernameText.delegate = self;
    self.passwordText.delegate = self;
     self.usernameImg.image =  [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e65a", 40, RGB(153, 153, 153))];
     self.passwordImg.image =  [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62a", 40, RGB(153, 153, 153))];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)loginAction:(id)sender {
    

    if (![self phoneisMatchWith:self.usernameText.text]) {
        return;
    }
    if ([self.passwordText.text length] <6) {
        [self showMessage:@"密码为6位数以上数字或字母" viewHeight:100];
        return;
    }
    [self LoginAPI];

    
//     [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)registeredAction:(id)sender {
    RegisteredVC *vc = [[RegisteredVC alloc]initWithNibName:@"RegisteredVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)forgetpassAction:(id)sender {
    ForgetPasswordVC *vc = [[ForgetPasswordVC alloc]initWithNibName:@"ForgetPasswordVC" bundle:nil];
     [self.navigationController pushViewController:vc animated:YES];
    
}


- (void) LoginAPI {
 
    [self showLoding:@"正在登录"];
    LoginAPI *login = [[LoginAPI alloc]initWithUsername:self.usernameText.text password:[JUtility md5:self.passwordText.text]];
    [login startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [self closeLoding];
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    UserInfo *user = [UserInfo shareObject];
                    user.datatoken = [NSString stringWithFormat:@"%@",[dic objectForKey:@"token"]];
                    user.type = [[dic objectForKey:@"type"]integerValue];
                    [self BaseinfoAPI];
                    
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

- (void)BaseinfoAPI {
    BaseinfoAPI *basein = [[BaseinfoAPI alloc]initWith];
    [basein startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    UserInfo *user = [UserInfo shareObject];
                    [user mj_setKeyValues:dic];
                    user.isLogin = YES;
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    //登陆成功后把用户名和密码存储到UserDefault
                    [userDefaults setObject:self.usernameText.text forKey:@"name"];
                    [userDefaults setObject:self.passwordText.text forKey:@"password"];
                    if (self.loginBlock) {
                        self.loginBlock(self);
                    }
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
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
        
        
    }];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameText) {
        [self.usernameText resignFirstResponder];
        [self.passwordText becomeFirstResponder];
    }else{
        [self.passwordText resignFirstResponder];
    }
    return YES;
}


@end
