//
//  AilpaybillVC.h
//  Payment
//
//  Created by iMac_1 on 2018/4/4.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewHistorybillVC : BaseViewController
@property (nonatomic,copy)NSString *titleStr;
@property (nonatomic,copy)NSString *monthStr;
@property (weak, nonatomic) IBOutlet UIView *backgrView;
@property (weak, nonatomic) IBOutlet UILabel *allgetLab;
@property (weak, nonatomic) IBOutlet UILabel *allgetnumLab;
@property (weak, nonatomic) IBOutlet UILabel *allgetpriceLab;
@property (weak, nonatomic) IBOutlet UILabel *billnumLab;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *todayLab;

@end
