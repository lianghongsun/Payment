//
//  ScanVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/5.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "PaymentCodeVC.h"
#import "ChooeseThree.h"
#import "YCPayKeyboard.h"
#import "UIView+Extension.h"
#import "Define.h"

@interface PaymentCodeVC ()<UITextFieldDelegate>

@end

@implementation PaymentCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收款金额";
    [self setrigBtn];

     
    YCPayKeyboard *keyboard = [YCPayKeyboard keyboard];
    keyboard.height = 250;
    LRWeakSelf(self);
    [keyboard setClickBlock:^(NSInteger index) {
        
        
        
        NSString *currentMoneyStr = weakself.moneyTF.text;
        NSRange range = [currentMoneyStr rangeOfString:@"¥"];
        if (range.location == NSNotFound) {
            currentMoneyStr = [NSString stringWithFormat:@"¥%@",currentMoneyStr];
        }
        
        NSMutableString *mStr = [currentMoneyStr mutableCopy];
        switch (index) {
            case 0:
            {
                if (currentMoneyStr.floatValue==0 && [currentMoneyStr containsString:@"0"] && ![currentMoneyStr containsString:@"."]) {
                    break;
                } else {
                    [mStr appendString:@"0"];
                }
                break;
            }
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:
            {
                if ([currentMoneyStr isEqualToString:@"0"]) {
                    [mStr deleteCharactersInRange:NSMakeRange(0, 1)];
                }
                [mStr appendString:[@(index) stringValue]];
                break;
            }
            case 10:
                if (currentMoneyStr.length==0 || [currentMoneyStr containsString:@"."]) {
                    break;
                } else {
                    [mStr appendString:@"."];
                }
                break;
            case 11:
                if (currentMoneyStr.length) {
                    [mStr deleteCharactersInRange:NSMakeRange(currentMoneyStr.length-1, 1)];
                }
                break;
            case 12:
            {
                mStr  = nil;
            }
                break;
            case 13:
            {
                ChooeseThree *vc = [[ChooeseThree alloc]initWithNibName:@"ChooesePayment" bundle:nil];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
        
      NSString *newstr =  [self okPriceDecimal:mStr];
        
        
        weakself.moneyTF.text = newstr;
    }];
    self.moneyTF.inputView = keyboard;
    
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
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



-(NSString *)okPriceDecimal:(NSMutableString *)priceStr
{
    
    NSRange startRange = [priceStr rangeOfString:@"."];
    //是否有小数点
    if (startRange.location != NSNotFound) {
        //若小数点直接在¥后面第一位，则补充0
        if (startRange.location == 1) {
            priceStr = [NSMutableString stringWithFormat:@"¥0%@",[priceStr substringFromIndex:1]];
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
            return [NSString stringWithFormat:@"¥%@",[priceStr substringFromIndex:2]];
        }
    }
    return priceStr;
}


@end
