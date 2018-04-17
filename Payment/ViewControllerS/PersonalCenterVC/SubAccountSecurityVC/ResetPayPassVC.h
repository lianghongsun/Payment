//
//  ChangeLoginPassVC.h
//  Payment
//
//  Created by 噗噗 on 2018/4/1.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetPayPassVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *passText;
@property (weak, nonatomic) IBOutlet UITextField *againpassText;
@property (weak, nonatomic) IBOutlet UITextField *smsText;

- (IBAction)smsAction:(id)sender;

- (IBAction)confirmAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *getcodeBtn;

@end
