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
#import "MonthHistoryBillApi.h"
#import "YHKModel.h"

@interface HistoryBillVC ()
{
    NSString *mybegintime;
    NSString *mymonthtime;
    UserInfo *user;
}
@end

@implementation HistoryBillVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavigationBarBottomLine:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self hideNavigationBarBottomLine:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史账单";
    user = [UserInfo shareObject];
    mybegintime = [JCAUtility stringWithCurrentTime:@"yyyy年MM月"];
    mymonthtime = [JCAUtility stringWithCurrentTime:@"yyyy-MM"];
    self.PeriodtimeLab.text = [NSString stringWithFormat:@"%@账单",mybegintime];
    self.backgrView.backgroundColor = ThemeColor;
    [self setUidata];
    [self MonthHistoryBillApi:user.uid Monthdata:[JCAUtility stringWithCurrentTime:@"yyyy-MM"]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (void)setUidata{
    
}

- (IBAction)alipayAction:(id)sender {
    UserInfo *user = [UserInfo shareObject];
    if (!user.isLogin) {
        [self gobacklogin];
        return;
    }
    NewHistorybillVC *vc = [[NewHistorybillVC alloc]initWithNibName:@"NewMonthbillVC" bundle:nil];
    vc.titleStr = @"支付宝历史账单详情";
    vc.monthStr = mymonthtime;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)weixinAction:(id)sender {
    UserInfo *user = [UserInfo shareObject];
    if (!user.isLogin) {
        [self gobacklogin];
        return;
    }
    NewHistorybillVC *vc = [[NewHistorybillVC alloc]initWithNibName:@"NewHistorybillVC" bundle:nil];
    vc.titleStr = @"微信历史账单详情";
    vc.monthStr = mymonthtime;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)PeriodoftimeAction:(id)sender {
    UserInfo *user = [UserInfo shareObject];
    if (!user.isLogin) {
        [self gobacklogin];
        return;
    }
    HistoryTimeVC *vc = [[HistoryTimeVC alloc]initWithNibName:@"HistoryTimeVC" bundle:nil];
    vc.choosetime = mybegintime;
    vc.startDate = [JCAUtility DataWithTimestr:mybegintime formatStr:@"yyyy年MM月"];
    vc.choosetimeBlock = ^(NSString *begintime,NSDate *choosedata) {
        mybegintime = begintime;
        self.PeriodtimeLab.text = [NSString stringWithFormat:@"%@账单",begintime];
        mybegintime = [JCAUtility stringWithData:choosedata formatStr:@"yyyy年MM月"];
        mymonthtime = [JCAUtility stringWithData:choosedata formatStr:@"yyyy-MM"];
        [self MonthHistoryBillApi:user.uid Monthdata:[JCAUtility stringWithData:choosedata formatStr:@"yyyy-MM"]];
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)MonthHistoryBillApi:(NSString *)uid Monthdata:(NSString *)monthdata{
    [self showLoding:@"请稍后"];
    MonthHistoryBillApi *monbill = [[MonthHistoryBillApi alloc]initWithUid:uid MonthDate:monthdata];
    [monbill startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            [self closeLoding];
            NSDictionary *dic = (NSDictionary *)request.responseJSONObject ;
            NSInteger responseCode = [[dic objectForKey:@"retcode"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    NSDictionary *datadic = [dic objectForKey:@"data"];
                    NSInteger Code = [[datadic objectForKey:@"code"] integerValue];
                    switch (Code) {
                        case SubRequestStatusSuccess:
                        {
                            NSDictionary *listdic = [datadic objectForKey:@"data"];
                            NSMutableArray*listarr = [NSMutableArray array];
                            [listarr addObjectsFromArray:[TodayBillFirstModel mj_objectArrayWithKeyValuesArray:[listdic objectForKey:@"list"]]];
                            TodayBillFirstModel *model1 = listarr[0];
                            TodayBillFirstModel *model2 = listarr[1];
                            
                            self.allgetpriceLab.text = [NSString stringWithFormat:@"¥%.2f",[[listdic objectForKey:@"totalAmount"]floatValue]];
                            self.billnumLab.text = [NSString stringWithFormat:@"%@笔",[listdic objectForKey:@"totalRow"]];
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
                            NSString *mesgStr = [NSString stringWithFormat:@"%@",[datadic objectForKey:@"msg"]];
                            [self showMessage:mesgStr viewHeight:0];
                        }
                            break;
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
