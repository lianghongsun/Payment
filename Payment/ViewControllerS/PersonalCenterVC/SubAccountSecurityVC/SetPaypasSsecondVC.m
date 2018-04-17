//
//  SetPaypassFirstVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/16.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "SetPaypasSsecondVC.h"
#import "CodeView.h"

@interface SetPaypasSsecondVC ()
{
    NSString *againPassstr;
}
@end

@implementation SetPaypasSsecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;;
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)nextAction:(id)sender {
    if ([againPassstr length] == 6) {
        if ([againPassstr isEqualToString:self.passStr]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else{
           [self showMessage:@"两次输入的支付密码不一致" viewHeight:100];
        }
    }
    else{
        [self showMessage:@"请输入6位支付密码" viewHeight:100];
    }
    
}
@end
