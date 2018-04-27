//
//  ChooesePayment.h
//  Payment
//
//  Created by 噗噗 on 2018/4/5.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooesePayment : BaseViewController
- (IBAction)weixinAction:(id)sender;

- (IBAction)ailpayAction:(id)sender;
@property (nonatomic,copy)NSString *pricenum;

@property (weak, nonatomic) IBOutlet UIImageView *ailtapimage;
@property (weak, nonatomic) IBOutlet UIImageView *weixintapimage;
@property (weak, nonatomic) IBOutlet UIButton *aillogBtn;
@property (weak, nonatomic) IBOutlet UIButton *weixinlogBtn;

@property (weak, nonatomic) IBOutlet UIView *ailbackgrview;
@property (weak, nonatomic) IBOutlet UIView *weixinbackgrview;
- (IBAction)chooseindustryAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *industryBtn;
@property (weak, nonatomic) IBOutlet UIImageView *chooseImg;
@property (weak, nonatomic) IBOutlet UIView *subbackgView;

@end
