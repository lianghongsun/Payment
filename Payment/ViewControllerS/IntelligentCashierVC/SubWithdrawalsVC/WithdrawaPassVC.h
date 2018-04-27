//
//  SetPaypassFirstVC.h
//  Payment
//
//  Created by iMac_1 on 2018/4/16.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdrawaPassVC : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@property (weak, nonatomic) IBOutlet UIView *subview;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

- (IBAction)nextAction:(id)sender;
@end
