//
//  ChangeLoginPassVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/1.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "ResetPayPassVC.h"

@interface ResetPayPassVC ()

@end

@implementation ResetPayPassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重置支付密码";
    
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
}

- (IBAction)confirmAction:(id)sender {
}
@end
