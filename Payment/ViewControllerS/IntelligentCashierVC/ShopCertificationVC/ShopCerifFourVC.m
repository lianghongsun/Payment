//
//  RealNameSecondVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/11.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "ShopCerifFourVC.h"
#import "ShopCationCell.h"
#import "ZZYPhotoHelper.h"

@interface ShopCerifFourVC ()<UITableViewDataSource,UITableViewDelegate>

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
    cell.positivetoBlock = ^(ShopCationCell *cell) {
        
        [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
            [cell.Photofirst setHidden:YES];
            [cell.photofirstLab setHidden:YES];
            cell.positiveimg.image =  (UIImage *)data;
        }];
        
        
    };
    
    cell.reversetoBlock = ^(ShopCationCell *cell) {
        [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
            [cell.Photosecond setHidden:YES];
             [cell.photosecondLab setHidden:YES];
            cell.reverseimg.image =  (UIImage *)data;
        }];
    };
    
    cell.myimgtoBlock = ^(ShopCationCell *cell) {
        [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
             [cell.Photothree setHidden:YES];
            [cell.photothreeLab setHidden:YES];
            cell.myimg.image =  (UIImage *)data;
        }];
    };
    
    cell.submittoBlock = ^(ShopCationCell *cell) {
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
