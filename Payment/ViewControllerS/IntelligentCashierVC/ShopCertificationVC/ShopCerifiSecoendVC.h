//
//  ShopCerifiSecoendVC.h
//  Payment
//
//  Created by iMac_1 on 2018/4/11.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCerifiSecoendVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *havecardBtn;
@property (weak, nonatomic) IBOutlet UIButton *nocardBtn;
@property (weak, nonatomic) IBOutlet UIButton *enterpriseBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

- (IBAction)havecarAction:(id)sender;
- (IBAction)nocarAction:(id)sender;
- (IBAction)enterpriseAction:(id)sender;
- (IBAction)nextAction:(id)sender;

@end
