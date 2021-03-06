//
//  BindingYHKSecondVC.h
//  Payment
//
//  Created by iMac_1 on 2018/4/11.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSXPopMenu.h"

@interface ShopBindingYHKVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTx;
@property (weak, nonatomic) IBOutlet UITextField *yhknumTx;
@property (weak, nonatomic) IBOutlet UIView *typeview;

@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
- (IBAction)typeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *openaccountTc;
@property (weak, nonatomic) IBOutlet UITextField *iponeTx;
@property (weak, nonatomic) IBOutlet UITextField *codeTx;
- (IBAction)getcodeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *getcodeBtn;

- (IBAction)submitAction:(id)sender;

@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *merName;
@property (nonatomic,copy)NSString *provinceId;
@property (nonatomic,copy)NSString *cityId;
@property (nonatomic,copy)NSString *district;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *merContent;
@property (nonatomic,copy)NSString *bizCode;
@property (nonatomic,strong) UIImage *bizCodeimg;
@property (nonatomic,strong)UIImage *bizHeadimg;
@property (nonatomic,strong)UIImage *bizInnerimg;

@end
