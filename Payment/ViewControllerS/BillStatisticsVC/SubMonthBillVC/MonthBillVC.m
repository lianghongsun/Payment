//
//  TodayBillVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/4.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "MonthBillVC.h"
#import "NewMonthbillVC.h"
#import "ChooseTimeVC.h"
@interface MonthBillVC ()
{
    NSString *mybegintime;
    NSString *myenttime;
}
@end

@implementation MonthBillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"本月账单";
    self.backgrView.backgroundColor = ThemeColor;
   
    [self setUidata];
    myenttime = [JCAUtility stringLastWithCurrentTime:@"yyyy年MM月dd日"];
    mybegintime = [JCAUtility getMonthBeginAndEndWith:myenttime];
    self.PeriodtimeLab.text = [NSString stringWithFormat:@"%@-%@",mybegintime,myenttime];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (void)setUidata{
    self.allgetpriceLab.text = [NSString stringWithFormat:@"¥%@",@"8888.00"];
    self.billnumLab.text = [NSString stringWithFormat:@"%@笔",@"6"];
    self.ailPaypriceLab.text = [NSString stringWithFormat:@"%@",@"888.00"];
    self.weixinpriceLab.text = [NSString stringWithFormat:@"%@",@"888.00"];
    self.ailpaynumLab.text = [NSString stringWithFormat:@"%@笔",@"3"];
    self.weixinnumLab.text = [NSString stringWithFormat:@"%@笔",@"3"];
    
}

- (IBAction)alipayAction:(id)sender {
    
    NewMonthbillVC *vc = [[NewMonthbillVC alloc]initWithNibName:@"NewMonthbillVC" bundle:nil];
    vc.titleStr = @"支付宝账单详情";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)weixinAction:(id)sender {
    NewMonthbillVC *vc = [[NewMonthbillVC alloc]initWithNibName:@"NewMonthbillVC" bundle:nil];
    vc.titleStr = @"微信账单详情";
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)PeriodoftimeAction:(id)sender {
    ChooseTimeVC *vc = [[ChooseTimeVC alloc]initWithNibName:@"ChooseTimeVC" bundle:nil];
    vc.begintime = mybegintime;
    vc.enttime = myenttime;
    vc.ismonth = YES;
    vc.choosetimeBlock = ^(NSString *begintime, NSString *enttime) {
        self.PeriodtimeLab.text = [NSString stringWithFormat:@"%@-%@",begintime,enttime];
        mybegintime = begintime;
        myenttime = enttime;
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}
@end
