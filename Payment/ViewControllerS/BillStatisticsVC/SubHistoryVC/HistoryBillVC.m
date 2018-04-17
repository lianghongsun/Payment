//
//  TodayBillVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/4.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "HistoryBillVC.h"
#import "NewHistorybillVC.h"
#import "HistoryTimeVC.h"
@interface HistoryBillVC ()
{
    NSString *begintime;
}
@end

@implementation HistoryBillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史账单";
    begintime = [JCAUtility stringWithCurrentTime:@"yyyy年MM月"];
    self.PeriodtimeLab.text = begintime;
    self.backgrView.backgroundColor = ThemeColor;
   self.allgetLab.layer.borderWidth = 1;
   self.allgetLab.layer.cornerRadius = self.allgetLab.frame.size.height/2;
    self.allgetLab.layer.masksToBounds = YES;
    self.allgetLab.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    self.allgetnumLab.layer.borderWidth = 1;
    self.allgetnumLab.layer.cornerRadius = self.ailpaynumLab.frame.size.height/2;
    self.allgetnumLab.layer.masksToBounds = YES;
    self.allgetnumLab.layer.borderColor = [[UIColor whiteColor] CGColor];
    

    [self setUidata];
    
    
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
    
    NewHistorybillVC *vc = [[NewHistorybillVC alloc]initWithNibName:@"NewMonthbillVC" bundle:nil];
    vc.titleStr = @"支付宝历史账单详情";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)weixinAction:(id)sender {
    NewHistorybillVC *vc = [[NewHistorybillVC alloc]initWithNibName:@"NewHistorybillVC" bundle:nil];
    vc.titleStr = @"微信历史账单详情";
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)PeriodoftimeAction:(id)sender {
    HistoryTimeVC *vc = [[HistoryTimeVC alloc]initWithNibName:@"HistoryTimeVC" bundle:nil];
    vc.choosetime = begintime;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
