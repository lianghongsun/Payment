//
//  LoginVC.h
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisteredVC : BaseViewController
{
    NSTimer * timer;
}
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *againpasswordText;
@property (weak, nonatomic) IBOutlet UITextField *verificationText;

@property (weak, nonatomic) IBOutlet UIButton *verificationBtn;

- (IBAction)verificationAction:(id)sender;

- (IBAction)agreementAction:(id)sender;


- (IBAction)registeredAction:(id)sender;

- (IBAction)backLoginAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *nameimg;
@property (weak, nonatomic) IBOutlet UIImageView *passimg;

@property (weak, nonatomic) IBOutlet UIImageView *againpassimg;
@property (weak, nonatomic) IBOutlet UIImageView *viccodeimg;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;



@end
