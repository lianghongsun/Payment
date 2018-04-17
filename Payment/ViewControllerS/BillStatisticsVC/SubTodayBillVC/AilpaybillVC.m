//
//  AilpaybillVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/4.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "AilpaybillVC.h"
#import "collectionCell.h"

@interface AilpaybillVC ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@end

@implementation AilpaybillVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navititle.text = self.titleStr;

    if (@available(iOS 11.0, *)) {
        
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.backBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e7c2", 30, RGB(255, 255, 255))] forState:UIControlStateNormal];
    
    [self setUidata];
    [self.tableview registerNib:[UINib nibWithNibName:@"collectionCell" bundle:nil] forCellReuseIdentifier:@"collectionCell"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier1 = @"collectionCell";
    collectionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    if ([self.titleStr isEqualToString:@"支付宝账单详情"]) {
     cell.headimge.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e608", 40, ThemeColor)];
    }
    else{
     cell.headimge.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6ed", 40, RGB(106, 163, 85))];
    }
    cell.nameLab.text = @"张无忌";
    cell.timeLab.text = @"2018/03/26 15:00:00";
    cell.priceLab.text = @"2222.00";
    cell.statusLab.text = @"收款成功";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


- (void)setUidata{
    self.allgetpriceLab.text = [NSString stringWithFormat:@"¥%@",@"8888.00"];
    self.billnumLab.text = [NSString stringWithFormat:@"%@笔",@"3"];
}


- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
