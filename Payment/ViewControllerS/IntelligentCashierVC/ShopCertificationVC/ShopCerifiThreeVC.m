//
//  ShopCerifiThreeVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/11.
//  Copyright © 2018年 噗噗. All rights reserved.
//
#define Key_DistrictSelectProvince          @"DistrictSelectProvince"
#define Key_DistrictSelectProvinceCode      @"DistrictSelectProvinceCode"
#define Key_DistrictSelectProvinceSubCode   @"DistrictSelectProvinceSubCode"
#define Key_DistrictSelectProvinceSub       @"DistrictSelectProvinceSub"
#define Key_DistrictSelectCityCode          @"DistrictSelectCityCode"
#define Key_DistrictSelectCity              @"DistrictSelectCity"

#import "ShopCerifiThreeVC.h"
#import "ShopCerifFourVC.h"
#import "GPDateView.h"
#import "CZHAddressPickerView.h"
#import "AddressPickerHeader.h"
#import "IdentiyMerchantApi.h"
#import "ShopBindingYHKVC.h"

@interface ShopCerifiThreeVC ()<UITextFieldDelegate>
{
    NSString *province;
    NSString *provincecode;
    NSString *city;
    NSString *citycode;
    NSString *county;
    NSString *countycode;
    BOOL isagerr;
}
@end

@implementation ShopCerifiThreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺信息";
    
    self.nameTx.delegate = self;
    self.adreeTx.delegate = self;

    
    [self.agreeBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e615", 40, RGB(220, 220, 220))] forState:UIControlStateNormal];
    [self.agreeBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e614", 40, ThemeColor)] forState:UIControlStateSelected];
    [self.agreeBtn addTarget:self action:@selector(agreedAction:) forControlEvents:UIControlEventTouchUpInside];
    if ([self.storetype isEqualToString:@"1"]) {
        [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    }
    else if ([self.storetype isEqualToString:@"2"]){
        [self.nextBtn setTitle:@"提交" forState:UIControlStateNormal];
    }
    else{
        [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)agreedAction:(UIButton *)button {
    
    button.selected = !button.isSelected;
    isagerr = button.selected;
}

- (IBAction)nextAction:(id)sender {
    [self.nameTx resignFirstResponder];
    [self.adreeTx resignFirstResponder];
    
    if ([self.nameTx.text length]<=0) {
        [self showMessage:@"商户名称不能为空" viewHeight:0];
        return;
    }
    if ([self.cityBtn.titleLabel.text length]<=0) {
        [self showMessage:@"城市不能为空" viewHeight:0];
        return;
    }
    if ([self.adreeTx.text length]<=0) {
        [self showMessage:@"详细地址不能为空" viewHeight:0];
        return;
    }
    
    if ([self.categoryBtn.titleLabel.text length]<=0) {
        [self showMessage:@"商品类目不能为空" viewHeight:0];
        return;
    }
    if (!isagerr) {
        [self showMessage:@"请勾选确认真实信息" viewHeight:0];
        return;
    }
    
   
    
    
    
    if ([self.storetype isEqualToString:@"1"]) {
        ShopCerifFourVC *vc = [[ShopCerifFourVC alloc]initWithNibName:@"ShopCerifFourVC" bundle:nil];
        vc.type = self.storetype;
        vc.merName = self.nameTx.text;
        vc.provinceId = provincecode;
        vc.cityId = citycode;
        vc.district = countycode;
        vc.address = self.adreeTx.text;
        vc.merContent = self.categoryBtn.titleLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.storetype isEqualToString:@"2"]){
        [self IdentiyMerchantApi];
    }
    else{
        ShopCerifFourVC *vc = [[ShopCerifFourVC alloc]initWithNibName:@"ShopCerifFourVC" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameTx) {
        [self.nameTx resignFirstResponder];
    }
    else if (textField == self.adreeTx){
        [self.adreeTx resignFirstResponder];
    }
    
    return YES;
}

- (IBAction)cityAction:(id)sender {
    [self.nameTx resignFirstResponder];
    [self.adreeTx resignFirstResponder];
    
    GPDateView * dateView = [[GPDateView alloc] initWithFrame:CGRectMake(0, SCREEN_H-250, SCREEN_W, 250) Data:nil];
    
    [dateView showPickerView];
    
    dateView.ActionDistrictViewSelectBlock = ^(NSString *desStr,NSDictionary *selectDistrictDict){
        
        province = [selectDistrictDict objectForKey:Key_DistrictSelectProvince];
        city = [selectDistrictDict objectForKey:Key_DistrictSelectCity];
        county = [selectDistrictDict objectForKey:Key_DistrictSelectProvinceSub];
        provincecode = [selectDistrictDict objectForKey:Key_DistrictSelectProvinceCode];
        citycode = [selectDistrictDict objectForKey:Key_DistrictSelectCityCode];
        countycode = [selectDistrictDict objectForKey:Key_DistrictSelectProvinceSubCode];
        if ([city isEqualToString:@"县"]||[city isEqualToString:@"北京市"]||[city isEqualToString:@"天津市"]||[city isEqualToString:@"上海市"]||[city isEqualToString:@"重庆市"]) {
            city = @"";
        }
        [self.cityBtn setTitle:[NSString stringWithFormat:@"%@%@%@",province,city,county] forState:UIControlStateNormal];
        
    };
    
    
}
- (IBAction)categoryAction:(id)sender {
    [self.nameTx resignFirstResponder];
    [self.adreeTx resignFirstResponder];
    [CZHAddressPickerView cityPickerViewWithCityBlock:^(NSString *province, NSString *city) {
        [sender setTitle:[NSString stringWithFormat:@"%@-%@",province,city] forState:UIControlStateNormal];
    }];
    
}

- (void)IdentiyMerchantApi {
    [self showLoding:@"正在验证信息"];
    IdentiyMerchantApi *identuy = [[IdentiyMerchantApi alloc]initWithType:self.storetype MerName:self.nameTx.text ProvinceId:provincecode CityId:citycode District:countycode Address:self.adreeTx.text MerContent:self.categoryBtn.titleLabel.text BizCode:@"" BizCodeFile:[UIImage imageNamed:@"bill-msg1"] BizHeadFile:[UIImage imageNamed:@"bill-msg1"] BizInnerFile:[UIImage imageNamed:@"bill-msg1"]];
    [identuy startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [self closeLoding];
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    ShopBindingYHKVC *vc = [[ShopBindingYHKVC alloc]initWithNibName:@"ShopBindingYHKVC" bundle:nil];
                    [self.navigationController pushViewController:vc animated:YES];
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
