//
//  ForgetPasswordVC.h
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPasswordVC : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *iponeText;
@property (weak, nonatomic) IBOutlet UITextField *codeText;
@property (weak, nonatomic) IBOutlet UIButton *getcodeBtn;

@property (weak, nonatomic) IBOutlet UIImageView *iponeImg;
@property (weak, nonatomic) IBOutlet UIImageView *codeImg;


- (IBAction)getcodeAction:(id)sender;
- (IBAction)nextAction:(id)sender;
@end
