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

@interface SetPaypassFirstVC ()
{
    NSString *passStr;
}
@end

@implementation SetPaypassFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
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
    if ([passStr length]==6) {
        SetPaypasSsecondVC *vc = [[SetPaypasSsecondVC alloc]initWithNibName:@"SetPaypasSsecondVC" bundle:nil];
        vc.passStr = passStr;
        vc.titleStr = self.titleStr;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        [self showMessage:@"请输入6位支付密码" viewHeight:100];
    }
    
}
@end
