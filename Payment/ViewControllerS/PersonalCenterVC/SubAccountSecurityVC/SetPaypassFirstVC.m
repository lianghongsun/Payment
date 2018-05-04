//
//  SetPaypassFirstVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/16.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "SetPaypassFirstVC.h"
#import "CodeView.h"
#import "SetPaypasSsecondVC.h"
#import "VerifyPayPassApi.h"

@interface SetPaypassFirstVC ()
{
    NSString *passStr;
    UserInfo *user;
}
@end

@implementation SetPaypassFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    user = [UserInfo shareObject];
    if ([self.titleStr isEqualToString:@"设置支付密码"]) {
        self.tipLabel.text = @"请输入6位新支付密码";
    }
    else{
        self.tipLabel.text = @"请输入原支付密码";
    }
    
    [self.subview setHidden:YES];
    CodeView *v = [[CodeView alloc] initWithFrame:CGRectMake(20, 90, SCREEN_W-40, 50)
                                              num:6
                                        lineColor:ThemeColor
                                         textFont:30];
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:v.bounds];
    v.layer.masksToBounds = NO;
    v.layer.shadowColor = ThemeColor.CGColor;
    v.layer.shadowOffset = CGSizeMake(0.5f, 0.0f);
    v.layer.shadowOpacity = 0.5f;
    v.layer.shadowPath = shadowPath.CGPath;
    
    v.hasUnderLine = NO;
    //分割线
    v.hasSpaceLine = YES;
    
    //输入风格
    v.codeType = CodeViewTypeSecret;
    v.EndEditBlcok = ^(NSString *str) {
        NSLog(@"%@",str);
        passStr = str;
    };
    [self.view addSubview:v];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (IBAction)nextAction:(id)sender {
    if ([self.titleStr isEqualToString:@"设置支付密码"]) {
        if ([passStr length]>6||[passStr length]<6) {
            [self showMessage:@"请输入6位支付密码" viewHeight:0];
            return;
        }
    }
    else{
        if ([passStr length]>6||[passStr length]<6) {
            [self showMessage:@"请输入原支付密码" viewHeight:0];
            return;
        }
    }
    if ([self.titleStr isEqualToString:@"设置支付密码"]) {
        SetPaypasSsecondVC *vc = [[SetPaypasSsecondVC alloc]initWithNibName:@"SetPaypasSsecondVC" bundle:nil];
        vc.passStr = passStr;
        vc.titleStr = self.titleStr;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        [self VerifyPayPassApi];
    }
}

- (void)VerifyPayPassApi {
    [self showLoding:@"请稍后"];
    VerifyPayPassApi *paypass = [[VerifyPayPassApi alloc]initWithUid:user.uid PayPasswd:[JUtility md5:passStr]];
    [paypass startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
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
                            SetPaypasSsecondVC *vc = [[SetPaypasSsecondVC alloc]initWithNibName:@"SetPaypasSsecondVC" bundle:nil];
                            vc.passStr = passStr;
                            vc.titleStr = self.titleStr;
                            [self.navigationController pushViewController:vc animated:YES];
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
@end
