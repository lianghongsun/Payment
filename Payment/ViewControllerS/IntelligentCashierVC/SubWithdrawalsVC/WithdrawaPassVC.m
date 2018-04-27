//
//  SetPaypassFirstVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/16.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "WithdrawaPassVC.h"
#import "CodeView.h"

@interface WithdrawaPassVC ()
{
    NSString *Passstr;
}
@end

@implementation WithdrawaPassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付密码";
    self.tipLabel.text = @"请输入支付密码";
    [self.nextBtn setTitle:@"确定" forState:UIControlStateNormal];
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
        Passstr = str;
    };
    [self.view addSubview:v];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)nextAction:(id)sender {
   
    
}
@end
