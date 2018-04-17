//
//  AddCreditCardVC.h
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCreditCardVC : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *cardText;
@property (weak, nonatomic) IBOutlet UITextField *againcardText;
@property (weak, nonatomic) IBOutlet UITextField *cardnameText;

- (IBAction)saveAction:(id)sender;

@end
