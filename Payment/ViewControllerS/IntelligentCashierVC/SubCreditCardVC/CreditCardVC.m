//
//  BindingYHKVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/2.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "CreditCardVC.h"
#import "AddYHKCell.h"
#import "AddCreditCardVC.h"
#import "ConfirmPaymentVC.h"
#import "CraditRecordVC.h"

@interface CreditCardVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CreditCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信用卡还款";
    self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;

    [self.tableview registerNib:[UINib nibWithNibName:@"AddYHKCell" bundle:nil] forCellReuseIdentifier:@"AddYHKCell"];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self setrightNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setrightNav {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, 0, 0);
    rightButton.imageEdgeInsets = inset;
    [rightButton setTitle:@"还款记录" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -18)];
    rightButton.frame = CGRectMake(0, 0, 80, 35);
    [rightButton addTarget:self action:@selector(rightbuttonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc ] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;
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

    if (section == 0) {
        return 10;
    }
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        return 140;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        static NSString *identifier1 = @"AddYHKCell";
        AddYHKCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell.logimg.image = [UIImage imageNamed:@"zhaohang"];
        cell.nameLab.text = @"张无忌";
        cell.numLab.text = @"828283783738*********9989";
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ConfirmPaymentVC *vc = [[ConfirmPaymentVC alloc]initWithNibName:@"ConfirmPaymentVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (IBAction)addYHKAction:(id)sender {
    
    AddCreditCardVC *VC = [[AddCreditCardVC alloc]initWithNibName:@"AddCreditCardVC" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)rightbuttonAction {
    CraditRecordVC *vc = [[CraditRecordVC alloc]initWithNibName:@"CraditRecordVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)setdefaultAction:(id)sender {
}

- (IBAction)bindingAction:(id)sender {
}

@end
