//
//  SetPaypassFirstVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/16.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "SetPaypasSsecondVC.h"
#import "CodeView.h"
#import "SetPayPassApi.h"
#import "ModifyPayPassAPI.h"

@interface SetPaypasSsecondVC ()
{
    NSString *againPassstr;
    UserInfo *user;
}
@end

@implementation SetPaypasSsecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;;
    user = [UserInfo shareObject];
    if ([self.titleStr isEqualToString:@"设置支付密码"]) {
        self.tipLabel.text = @"请再次输入6位新支付密码";
        [self.nextBtn setTitle:@"确定" forState:UIControlStateNormal];
    }
    else{
        self.tipLabel.text = @"请输入新支付密码";
        [self.nextBtn setTitle:@"确认修改" forState:UIControlStateNormal];
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
        againPassstr = str;
    };
    [self.view addSubview:v];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)nextAction:(id)sender {
    if ([againPassstr length]<6||[againPassstr length]>6) {
        [self showMessage:@"请输入6位支付密码" viewHeight:0];
        return;
    }
    if (user.paypasswdAuthed == 0) {
        if (![againPassstr isEqualToString:self.passStr]) {
            [self showMessage:@"两次输入的支付密码不一致" viewHeight:0];
            return;
        }
    }
    if (user.paypasswdAuthed == 1) {
        [self ModifyPayPassAPI];
    }
    else{
        [self SetPayPassApi];
    }
}

- (void) SetPayPassApi {
    [self showLoding:@"请稍后"];
    SetPayPassApi *paypass = [[SetPayPassApi alloc]initWithUid:user.uid PayPasswd:[JUtility md5:self.passStr] NewSecondPassword:[JUtility md5:againPassstr]];
    [paypass startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [self closeLoding];
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    [self showMessage:@"支付密码设置成功" viewHeight:0];
                    user.paypasswdAuthed = 1;
                    NSInteger index=[[self.navigationController viewControllers]indexOfObject:self];
                    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-2]animated:YES];
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

- (void)ModifyPayPassAPI {
    [self showLoding:@"请稍后"];
    ModifyPayPassAPI *paypass = [[ModifyPayPassAPI alloc]initWithUid:user.uid PayPasswd:[JUtility md5:self.passStr] NewSecondPassword:[JUtility md5:againPassstr]];
    [paypass startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [self closeLoding];
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    [self showMessage:@"支付密码修改成功" viewHeight:0];
                    user.paypasswdAuthed = 1;
                    NSInteger index=[[self.navigationController viewControllers]indexOfObject:self];
                    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-2]animated:YES];
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
