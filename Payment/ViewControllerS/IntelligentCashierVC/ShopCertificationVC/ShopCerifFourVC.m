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
#import "ShopBindingYHKVC.h"

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
        UserInfo *user = [UserInfo shareObject];
        if (!user.isLogin) {
            [self gobacklogin];
            return;
        }
        
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
        
        ShopBindingYHKVC *vc = [[ShopBindingYHKVC alloc]initWithNibName:@"ShopBindingYHKVC" bundle:nil];
        vc.type = self.type;
        vc.merName = self.merName;
        vc.provinceId = self.provinceId;
        vc.cityId = self.cityId;
        vc.district = self.district;
        vc.address = self.address;
        vc.merContent = self.merContent;
        vc.bizCode = mynameTx.text;
        vc.bizCodeimg = bizCodeimg;
        vc.bizHeadimg = bizHeadimg;
        vc.bizInnerimg = bizInnerimg;
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == mynameTx) {
        [mynameTx resignFirstResponder];
    }
    return YES;
}

@end
