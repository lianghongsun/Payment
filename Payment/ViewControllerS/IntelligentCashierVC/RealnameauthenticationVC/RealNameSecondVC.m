//
//  RealNameSecondVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/11.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "RealNameSecondVC.h"
#import "RealNameCationCell.h"
#import "ZZYPhotoHelper.h"

@interface RealNameSecondVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation RealNameSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @" 实名认证";
    [self.tableview registerNib:[UINib nibWithNibName:@"RealNameCationCell" bundle:nil] forCellReuseIdentifier:@"RealNameCationCell"];
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
    return 520;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier1 = @"RealNameCationCell";
    RealNameCationCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    cell.positivetoBlock = ^(RealNameCationCell *cell) {
        
        [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
            [cell.Photofirst setHidden:YES];
            cell.positiveimg.image =  (UIImage *)data;
        }];
        
        
    };
    
    cell.reversetoBlock = ^(RealNameCationCell *cell) {
        [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
            [cell.Photosecond setHidden:YES];
            cell.reverseimg.image =  (UIImage *)data;
        }];
    };
    
    cell.myimgtoBlock = ^(RealNameCationCell *cell) {
        [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
             [cell.Photothree setHidden:YES];
            cell.myimg.image =  (UIImage *)data;
        }];
    };
    
    cell.submittoBlock = ^(RealNameCationCell *cell) {
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
