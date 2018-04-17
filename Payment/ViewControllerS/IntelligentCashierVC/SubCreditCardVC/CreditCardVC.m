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

@interface CreditCardVC ()<UITableViewDelegate,UITableViewDataSource,WeChatStylePlaceHolderDelegate>
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation CreditCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信用卡还款";
    self.dataArr = [NSMutableArray array];
    [self.dataArr addObject:@"123"];
    [self.dataArr addObject:@"1321"];
    
    self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;

    [self.tableview registerNib:[UINib nibWithNibName:@"AddYHKCell" bundle:nil] forCellReuseIdentifier:@"AddYHKCell"];
    
    [self setrightNav];
    [self setrefreshHeaderOrFooter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -- sterefresh

- (void)setrefreshHeaderOrFooter {
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

- (void)loadNewData {
    [self.dataArr removeAllObjects];
    
    [self.tableview cyl_reloadData];
    self.tableview.mj_footer.state = MJRefreshStateIdle;
    [self.tableview.mj_header endRefreshing];
}

- (void)loadMore {
    [self.tableview.mj_footer endRefreshing];
    self.tableview.mj_footer.state = MJRefreshStateNoMoreData;
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
  
    return self.dataArr.count;
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

#pragma mark - CYLTableViewPlaceHolderDelegate Method 没有数据界面显示

- (UIView *)makePlaceHolderView {
    
    
    UIView *weChatStyle = [self weChatStylePlaceHolder];
    weChatStyle.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return weChatStyle;
}

- (UIView *)weChatStylePlaceHolder {
    WeChatStylePlaceHolder *weChatStylePlaceHolder = [[WeChatStylePlaceHolder alloc] initWithFrame:self.tableview.frame];
    weChatStylePlaceHolder.delegate = self;

    weChatStylePlaceHolder.imageName = @"emty_icon";
    weChatStylePlaceHolder.title = @"您还没有添加信用卡哦";
    weChatStylePlaceHolder.content = @"快去添加吧!";
    return weChatStylePlaceHolder;
    
}

- (void)emptyOverlayClicked:(id)sender {
   
}



@end
