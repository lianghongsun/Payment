//
//  ConfirmPaymentVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "ConfirmPaymentVC.h"
#import "CreditSucc.h"
#import "WithdrawaPassVC.h"

@interface ConfirmPaymentVC ()

@end

@implementation ConfirmPaymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信用卡还款";
    [self setrigBtn];
    self.cardnumLab.text = self.bankNo;
    self.cardnameLab.text = self.realname;
    [self.priceText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.priceText.keyboardType = UIKeyboardTypeDecimalPad;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setrigBtn {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 30, 30);
    [rightButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e696", 30, RGB(255, 255, 255))] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc ] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;
    
}

- (void)rightAction {
    UserInfo *user = [UserInfo shareObject];
    if (!user.isLogin) {
        [self gobacklogin];
        return;
    }
    
}
- (IBAction)reimbursementAction:(id)sender {
    UserInfo *user = [UserInfo shareObject];
    if (!user.isLogin) {
        [self gobacklogin];
        return;
    }
    
    
    WithdrawaPassVC *vc = [[WithdrawaPassVC alloc]initWithNibName:@"WithdrawaPassVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
//    CreditSucc *vc = [[CreditSucc alloc]initWithNibName:@"CreditSucc" bundle:nil];
//    vc.ispopRoot = YES;
//    [self.navigationController pushViewController:vc animated:YES];
}

-(void)textFieldDidChange :(UITextField *)theTextField{
    theTextField.text = [self okPriceDecimal:theTextField.text ];
}

-(NSString *)okPriceDecimal:(NSString *)priceStr
{
    
    NSRange startRange = [priceStr rangeOfString:@"."];
    //是否有小数点
    if (startRange.location != NSNotFound) {
        //若小数点直接在¥后面第一位，则补充0
        if (startRange.location == 0) {
            priceStr = [NSMutableString stringWithFormat:@"0%@",[priceStr substringFromIndex:0]];
            startRange = [priceStr rangeOfString:@"."];
        }
        //控制小数点后只能输入两位
        
        
        NSString *str = [priceStr substringFromIndex:startRange.location];
        if ([str length]==3) {
            NSString *str2 = [str substringWithRange:NSMakeRange(2,1)];
            if ([str2 isEqualToString:@"0"]) {
                return [priceStr substringToIndex:priceStr.length-1];
            }
        }
        if (str.length > 3) {
            return [priceStr substringToIndex:priceStr.length-1];
        }
    }else
    {
        if (priceStr.length < 3) return priceStr;
        //¥右侧第一个数字
        NSString *numStr = [priceStr substringWithRange:NSMakeRange(1, 1)];
        //若¥右侧第一个数字是0，则删除第一个0
        if ([numStr integerValue] == 0) {
            return [NSString stringWithFormat:@"%@",[priceStr substringFromIndex:2]];
        }
    }
    return priceStr;
}


@end
