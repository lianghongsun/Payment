//
//  ForgetPassSecondVC.h
//  Payment
//
//  Created by 噗噗 on 2018/4/7.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPassSecondVC : BaseViewController

@property (nonatomic,copy)NSString *username;
@property (nonatomic,copy)NSString *code;

@property (weak, nonatomic) IBOutlet UIImageView *passImg;
@property (weak, nonatomic) IBOutlet UIImageView *againpassImg;

@property (weak, nonatomic) IBOutlet UITextField *newpasswordText;
@property (weak, nonatomic) IBOutlet UITextField *againnewpassText;
- (IBAction)determineAction:(id)sender;

@end
