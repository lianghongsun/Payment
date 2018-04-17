//
//  ChooesePayment.h
//  Payment
//
//  Created by 噗噗 on 2018/4/5.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooeseThree : BaseViewController
- (IBAction)weixinAction:(id)sender;

- (IBAction)ailpayAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *ailtapimage;
@property (weak, nonatomic) IBOutlet UIImageView *weixintapimage;
@property (weak, nonatomic) IBOutlet UIButton *aillogBtn;
@property (weak, nonatomic) IBOutlet UIButton *weixinlogBtn;

@property (weak, nonatomic) IBOutlet UIView *ailbackgrview;
@property (weak, nonatomic) IBOutlet UIView *weixinbackgrview;

@end
