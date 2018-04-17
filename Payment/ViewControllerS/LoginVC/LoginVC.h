//
//  LoginVC.h
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginVC;
typedef void (^LoginBlock) (LoginVC *);

@interface LoginVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
- (IBAction)loginAction:(id)sender;
- (IBAction)registeredAction:(id)sender;
- (IBAction)forgetpassAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIImageView *usernameImg;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImg;

@property(nonatomic, copy) LoginBlock loginBlock;

@end
