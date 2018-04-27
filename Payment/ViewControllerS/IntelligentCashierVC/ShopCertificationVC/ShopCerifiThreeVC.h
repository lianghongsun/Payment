//
//  ShopCerifiThreeVC.h
//  Payment
//
//  Created by iMac_1 on 2018/4/11.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCerifiThreeVC : BaseViewController

@property (nonatomic,copy)NSString *storetype;
@property (weak, nonatomic) IBOutlet UITextField *nameTx;
@property (weak, nonatomic) IBOutlet UITextField *adreeTx;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
- (IBAction)nextAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
- (IBAction)cityAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *categoryBtn;
- (IBAction)categoryAction:(id)sender;

@end
