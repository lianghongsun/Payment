//
//  RealNameSecondVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/11.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "ShopCerifFourVC.h"
#import "ShopCationCell.h"
#import "UIViewController+XHPhoto.h"
#import "IdentiyMerchantApi.h"

@interface ShopCerifFourVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UIImage *bizCodeimg;
    UIImage *bizHeadimg;
    UIImage *bizInnerimg;
    UITextField *mynameTx;
}
@end

@implementation ShopCerifFourVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"营业执照认证";
    [self.tableview registerNib:[UINib nibWithNibName:@"ShopCationCell" bundle:nil] forCellReuseIdentifier:@"ShopCationCell"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 480;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier1 = @"ShopCationCell";
    ShopCationCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    cell.nameTx.delegate = self;
    mynameTx = cell.nameTx;
    cell.positivetoBlock = ^(ShopCationCell *cell) {
        
        [self showCanEdit:YES photo:^(UIImage *photo) {
            [cell.Photofirst setHidden:YES];
            [cell.photofirstLab setHidden:YES];
            cell.positiveimg.image = photo;
            bizCodeimg = photo;
        }];
    };
    
    cell.reversetoBlock = ^(ShopCationCell *cell) {
        
        [self showCanEdit:YES photo:^(UIImage *photo) {
            [cell.Photosecond setHidden:YES];
            [cell.photosecondLab setHidden:YES];
            cell.reverseimg.image =  photo;
            bizHeadimg = photo;
        }];
    };
    
    cell.myimgtoBlock = ^(ShopCationCell *cell) {
        
        [self showCanEdit:YES photo:^(UIImage *photo) {
            [cell.Photothree setHidden:YES];
            [cell.photothreeLab setHidden:YES];
            cell.myimg.image =  photo;
            bizInnerimg = photo;
        }];
    };
    
    cell.submittoBlock = ^(ShopCationCell *cell) {
        if ([mynameTx.text length]<=0) {
            [self showMessage:@"营业执照号不能为空" viewHeight:0];
            return ;
        }
        
        if (!bizCodeimg) {
            [self showMessage:@"营业执照照片不能为空" viewHeight:0];
            return ;
        }
        if (!bizHeadimg) {
            [self showMessage:@"门头照不能为空" viewHeight:0];
            return ;
        }
        if (!bizInnerimg) {
            [self showMessage:@"营业场所照片不能为空" viewHeight:0];
            return ;
        }
        [self IdentiyMerchantApi];
    };
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)IdentiyMerchantApi {
    [self showLoding:@"请稍后"];
    IdentiyMerchantApi *identuy = [[IdentiyMerchantApi alloc]initWithType:self.type MerName:self.merName ProvinceId:self.provinceId CityId:self.cityId District:self.district Address:self.address MerContent:self.merContent BizCode:mynameTx.text BizCodeFile:bizCodeimg BizHeadFile:bizHeadimg BizInnerFile:bizInnerimg];
    [identuy startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [self closeLoding];
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    [self.navigationController popToRootViewControllerAnimated:YES];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == mynameTx) {
        [mynameTx resignFirstResponder];
    }
    return YES;
}

@end
