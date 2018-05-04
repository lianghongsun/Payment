//
//  RealNameFailureVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/24.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "RealNameFailureVC.h"
#import "RealNameSecondVC.h"
#import "QueryApplyAPI.h"

@interface RealNameFailureVC ()

@end

@implementation RealNameFailureVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self QueryApplyAPI];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息认证";
    self.uploadBtn.backgroundColor = ThemeColor;
    [self.topBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6bd", 30,[UIColor redColor])] forState:UIControlStateNormal];
    [self.topBtn setTitle:@"实名认证审核未通过" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)uploadAgainAction:(id)sender {
    UserInfo *user = [UserInfo shareObject];
    if (!user.isLogin) {
        [self gobacklogin];
        return;
    }
    
    RealNameSecondVC *vc = [[RealNameSecondVC alloc]initWithNibName:@"RealNameSecondVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)QueryApplyAPI {
    [self showLoding:@"正在查询"];
    QueryApplyAPI *query = [[QueryApplyAPI alloc]initWith];
    [query startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [self closeLoding];
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
                            self.titleLab.text = [datadic objectForKey:@"reason"];
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
