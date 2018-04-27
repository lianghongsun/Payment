//
//  RealNameSecondVC.h
//  Payment
//
//  Created by iMac_1 on 2018/4/11.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCerifFourVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *merName;
@property (nonatomic,copy)NSString *provinceId;
@property (nonatomic,copy)NSString *cityId;
@property (nonatomic,copy)NSString *district;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *merContent;

@end
