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
#import "MonthBillApi.h"
#import "YHKModel.h"

@interface MonthBillVC ()
{
    NSString *mybegintime;
    NSString *myenttime;
    UserInfo *user;
}
@end

@implementation MonthBillVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    user = [UserInfo shareObject];
    [self MonthBillApi:user.uid];

}
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
    
//    ChooseTimeVC *vc = [[ChooseTimeVC alloc]initWithNibName:@"ChooseTimeVC" bundle:nil];
//    vc.begintime = mybegintime;
//    vc.enttime = myenttime;
//    vc.ismonth = YES;
//    vc.choosetimeBlock = ^(NSString *begintime, NSString *enttime) {
//        self.PeriodtimeLab.text = [NSString stringWithFormat:@"%@-%@",begintime,enttime];
//        mybegintime = begintime;
//        myenttime = enttime;
//
//    };
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)MonthBillApi:(NSString *)uid {
    [self showLoding:@"请稍后"];
    MonthBillApi *monbill = [[MonthBillApi alloc]initWithUid:uid];
    [monbill startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            [self closeLoding];
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    NSDictionary *datadic = [dic objectForKey:@"data"];
                    NSMutableArray*listarr = [NSMutableArray array];
                    [listarr addObjectsFromArray:[TodayBillFirstModel mj_objectArrayWithKeyValuesArray:[datadic objectForKey:@"list"]]];
                    
                    TodayBillFirstModel *model1 = listarr[0];
                    TodayBillFirstModel *model2 = listarr[1];
                    
                    self.allgetpriceLab.text = [NSString stringWithFormat:@"¥%.2f",[[datadic objectForKey:@"totalAmount"]floatValue]];
                    self.billnumLab.text = [NSString stringWithFormat:@"%@笔",[datadic objectForKey:@"totalRow"]];
                    
                   
                    
                if ([model1.platformId isEqualToString:@"100"]) {
                    self.weixinpriceLab.text = [NSString stringWithFormat:@"%.2f元",[model1.totalAmount floatValue]];
                    self.weixinnumLab.text = [NSString stringWithFormat:@"%@笔",model1.totalRow];
                        }
                else{
                    self.ailPaypriceLab.text = [NSString stringWithFormat:@"%.2f元",[model1.totalAmount floatValue]];
                    self.ailpaynumLab.text = [NSString stringWithFormat:@"%@笔",model1.totalRow];
                        }
                        
                        
                 if ([model2.platformId isEqualToString:@"100"]) {
                    self.weixinpriceLab.text = [NSString stringWithFormat:@"%.2f元",[model2.totalAmount floatValue]];
                    self.weixinnumLab.text = [NSString stringWithFormat:@"%@笔",model2.totalRow];
                        }
                        else{
                    self.ailPaypriceLab.text = [NSString stringWithFormat:@"%.2f元",[model2.totalAmount floatValue]];
                    self.ailpaynumLab.text = [NSString stringWithFormat:@"%@笔",model2.totalRow];
                        }
                }
                    break;
                default:
                {
                    NSString *mesgStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"msg"]];
                    [self showMessage:mesgStr viewHeight:0];
                }
                    break;
            }
        }
    } failure:^(YTKBaseRequest *request) {
        [self closeLoding];
        
        
    }];
}
@end
