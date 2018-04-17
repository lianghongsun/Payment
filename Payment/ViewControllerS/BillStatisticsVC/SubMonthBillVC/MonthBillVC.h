//
//  TodayBillVC.h
//  Payment
//
//  Created by iMac_1 on 2018/4/4.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonthBillVC : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *allgetLab;
@property (weak, nonatomic) IBOutlet UILabel *allgetnumLab;
@property (weak, nonatomic) IBOutlet UIView *backgrView;
@property (weak, nonatomic) IBOutlet UILabel *allgetpriceLab;
@property (weak, nonatomic) IBOutlet UILabel *billnumLab;
@property (weak, nonatomic) IBOutlet UILabel *ailPaypriceLab;
@property (weak, nonatomic) IBOutlet UILabel *weixinpriceLab;
@property (weak, nonatomic) IBOutlet UILabel *ailpaynumLab;
@property (weak, nonatomic) IBOutlet UILabel *weixinnumLab;
- (IBAction)alipayAction:(id)sender;
- (IBAction)weixinAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *PeriodtimeLab;
- (IBAction)PeriodoftimeAction:(id)sender;

@end
