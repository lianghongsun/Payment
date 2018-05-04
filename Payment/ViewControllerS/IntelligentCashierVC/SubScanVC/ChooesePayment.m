//
//  ChooesePayment.m
//  Payment
//
//  Created by 噗噗 on 2018/4/5.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "ChooesePayment.h"
#import "MMScanViewController.h"
#import "CollectionSuccVC.h"
#import "CreateOrderApi.h"
#import "QueryOrderApi.h"
#import "LSXPopMenu.h"
#import "OrderModel.h"

@interface ChooesePayment ()<LSXPopMenuDelegate>
{
    NSArray *titlearr;
    NSString *platformId;
    NSString *platformname;
    BOOL _shouldStop;
    NSInteger  shounum;
    BOOL ispush;
    UserInfo *user;
}
@end

@implementation ChooesePayment

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ispush = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付方式";
    user = [UserInfo shareObject];
    shounum = 0;
    self.chooseImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60e", 40, ThemeColor)];
    self.subbackgView.layer.borderWidth = 1;
    //边框颜色
    self.subbackgView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    titlearr = @[@"超市电器类",@"服装百货类",@"酒店餐饮类",@"珠宝娱乐类",@"汽车消费类"];
    [self setborderlin:self.ailbackgrview Colour:[UIColor lightGrayColor]];
    [self setborderlin:self.weixinbackgrview Colour:[UIColor lightGrayColor]];
    [self.aillogBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e608", 100, ThemeColor)] forState:UIControlStateNormal];

    [self.weixinlogBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6ed", 100, RGB(106, 163, 85))] forState:UIControlStateNormal];
   
    self.ailtapimage.image =  [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e614", 40, ThemeColor)];
    self.weixintapimage.image =  [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e614", 40, ThemeColor)];
    
    [self.ailtapimage setHidden:YES];
    [self.weixintapimage setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (IBAction)weixinAction:(id)sender {
    if (!user.isLogin) {
        [self gobacklogin];
        return;
    }
    platformId = @"100";
    platformname = @"微信";
    [self.ailtapimage setHidden:YES];
    [self.weixintapimage setHidden:NO];
    [self setborderlin:self.ailbackgrview Colour:[UIColor lightGrayColor]];
    [self setborderlin:self.weixinbackgrview Colour:ThemeColor];
    
    MMScanViewController *scanVc = [[MMScanViewController alloc] initWithQrType:MMScanTypeQrCode priceStr:self.pricenum onFinish:^(NSString *result, NSError *error) {
        if (error) {
            LxPrintf(@"error: %@",error);
        } else {
            [self CreateOrderApi:result];
            LxPrintf(@"扫描结果：%@",result);
            
        }
    }];
    [self.navigationController pushViewController:scanVc animated:YES];
    
}

- (IBAction)ailpayAction:(id)sender {
    if (!user.isLogin) {
        [self gobacklogin];
        return;
    }
    platformId = @"101";
    platformname = @"支付宝";
    [self.ailtapimage setHidden:NO];
    [self.weixintapimage setHidden:YES];
    [self setborderlin:self.weixinbackgrview Colour:[UIColor lightGrayColor]];
    [self setborderlin:self.ailbackgrview Colour:ThemeColor];
    
   MMScanViewController *scanVc = [[MMScanViewController alloc] initWithQrType:MMScanTypeQrCode priceStr:self.pricenum onFinish:^(NSString *result, NSError *error) {
        if (error) {
            LxPrintf(@"error: %@",error);
        } else {
            [self CreateOrderApi:result];
            LxPrintf(@"扫描结果：%@",result);
            
        }
    }];
    [self.navigationController pushViewController:scanVc animated:YES];
    
}


- (void)setborderlin:(UIView *)view Colour:(UIColor *)colour {
    view.layer.borderWidth = 1;
    view.layer.borderColor = [colour CGColor];
}

- (void)CreateOrderApi:(NSString *)authcode {
    [self showLoding:@"正在支付请稍后"];
    _shouldStop = NO;
    shounum = 0;
    CreateOrderApi *create = [[CreateOrderApi alloc]initWithPlatformId:platformId ProductName:self.industryBtn.titleLabel.text Money:self.pricenum Authcode:authcode];
    [create startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)request.responseJSONObject;
            NSInteger responseCode = [[dic objectForKey:@"retcode"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    NSDictionary *datadic = [dic objectForKey:@"data"];
                     NSInteger Code = [[datadic objectForKey:@"code"] integerValue];
                    
                    switch (Code) {
                        case SubRequestStatusSuccess:
                        {
                            NSDictionary *payorder = [datadic objectForKey:@"payOrder"];
                            NSInteger orderState = [[payorder objectForKey:@"orderState"] integerValue];
                            NSString *orderNo = [payorder objectForKey:@"orderNo"];
                            switch (orderState) {
                                case 0:
                                {
                                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                                        
                                        while (YES)
                                        {
                                            if (_shouldStop)
                                            {
                                                goto CancelBlock;
                                            }
                                            [NSThread sleepForTimeInterval:2.0];
                                            [self QueryOrderApi:orderNo];
                                            //例如：下面是你block中实际任务中的一步
                                            LxPrintf(@"***每5秒输出一次这段文字***") ;
                                            shounum++;
                                            if (shounum>=15) {
                                                _shouldStop = YES;
                                            }
                                        }
                                        
                                    CancelBlock:
                                        //Do some clean up operations here
                                        NSLog(@"Block is cancelled");
                                        return;
                                    });
                                }
                                    break;
                                case 1:
                                {
                                    [self closeLoding];
                                    _shouldStop = YES;
                                    [self syntheticVoice:[NSString stringWithFormat:@"%@收款%@元",platformname,self.pricenum]];
                                    CollectionSuccVC *vc = [[CollectionSuccVC alloc]initWithNibName:@"CollectionSuccVC" bundle:nil];
                                    OrderModel *moders = [[OrderModel alloc]init];
                                    [moders mj_setKeyValues:payorder];
                                    vc.model = moders;
                                    vc.ispopRoot = YES;
                                    [self.navigationController pushViewController:vc animated:YES];
                                    return ;
                                }
                                    break;
                                case 2:
                                {
                                    [self closeLoding];
                                    [self showMessage:@"收款异常" viewHeight:0];
                                }
                                    break;
                                default:
                                {
                                    [self closeLoding];
                                }
                                    break;
                            }
                        }
                            break;
                            
                        default:
                        {
                            [self closeLoding];
                            NSString *mesgStr = [NSString stringWithFormat:@"%@",[datadic objectForKey:@"msg"]];
                            [self showMessage:mesgStr viewHeight:0];
                        }
                            break;
                    }
                    
                    
                    
                }
                    break;
                default:
                {
                    [self closeLoding];
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

- (void)QueryOrderApi:(NSString *)orderNo{
    QueryOrderApi *create = [[QueryOrderApi alloc]initWithOrderNo:orderNo];
    [create startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)request.responseJSONObject;
            NSInteger responseCode = [[dic objectForKey:@"retcode"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    NSDictionary *datadic = [dic objectForKey:@"data"];
                    NSInteger Code = [[datadic objectForKey:@"code"] integerValue];
                    switch (Code) {
                        case SubRequestStatusSuccess:
                        {
                            NSDictionary *payorder = [dic objectForKey:@"payOrder"];
                            NSInteger orderState = [[payorder objectForKey:@"orderState"] integerValue];
                            switch (orderState) {
                                case 0:
                                {
                                    if (_shouldStop) {
                                        [self closeLoding];
                                    }
                                }
                                    break;
                                case 1:
                                {
                                    if (ispush) {
                                        return ;
                                    }
                                    _shouldStop = YES;
                                    [self closeLoding];
                                    [self syntheticVoice:[NSString stringWithFormat:@"%@收款%@元",platformname,self.pricenum]];
                                    CollectionSuccVC *vc = [[CollectionSuccVC alloc]initWithNibName:@"CollectionSuccVC" bundle:nil];
                                    OrderModel *moders = [[OrderModel alloc]init];
                                    [moders mj_setKeyValues:payorder];
                                    vc.model = moders;
                                    vc.ispopRoot = YES;
                                    [self.navigationController pushViewController:vc animated:YES];
                                    ispush = YES;
                                }
                                    break;
                                case 2:
                                {
                                    [self showMessage:@"收款异常" viewHeight:0];
                                    _shouldStop = YES;
                                    [self closeLoding];
                                }
                                    break;
                                default:
                                    break;
                            }
                            
                        }
                            break;
                            
                        default:
                        {
                            [self closeLoding];
                            NSString *mesgStr = [NSString stringWithFormat:@"%@",[datadic objectForKey:@"msg"]];
                            [self showMessage:mesgStr viewHeight:0];
                        }
                            break;
                    }
                }
                    break;
                default:
                {
                    [self closeLoding];
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
- (IBAction)chooseindustryAction:(id)sender {
    
    [LSXPopMenu showRelyOnView:sender titles:titlearr  icons:@[@"",@"",@"",@"",@""] menuWidth:120 isShowTriangle:YES delegate:self];
    
}

#pragma mark --  LSXPopupMenDelegate
-(void)LSXPopupMenuDidSelectedAtIndex:(NSInteger)index LSXPopupMenu:(LSXPopMenu *)LSXPopupMenu{
    [self.industryBtn setTitle:[NSString stringWithFormat:@"%@",titlearr[index]] forState:UIControlStateNormal];
    NSLog(@"------点击---%ld",(long)index);
}

@end
