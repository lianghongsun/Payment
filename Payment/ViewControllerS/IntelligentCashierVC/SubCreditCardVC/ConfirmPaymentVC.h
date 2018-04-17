//
//  ConfirmPaymentVC.h
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmPaymentVC : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *cardnumLab;

@property (weak, nonatomic) IBOutlet UILabel *cardnameLab;
@property (weak, nonatomic) IBOutlet UIImageView *cardlogImg;
@property (weak, nonatomic) IBOutlet UITextField *priceText;

- (IBAction)reimbursementAction:(id)sender;
@end
