//
//  WithdrawalsVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "WithdrawalsVC.h"
#import "WithdrawalsFirstCell.h"
#import "WithButtonCell.h"
#import "WithdrawalSecondVC.h"
#import "WithdrawalSucc.h"

@interface WithdrawalsVC ()<UITableViewDelegate,UITableViewDataSource,WeChatStylePlaceHolderDelegate>
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation WithdrawalsVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.balanceLab.text = [NSString stringWithFormat:@"%@元",self.balancenum];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提款";
    self.dataArr = [NSMutableArray array];
    [self.dataArr addObject:@"123"];
    [self.dataArr addObject:@"1321"];
    [self.tableview registerNib:[UINib nibWithNibName:@"WithdrawalsFirstCell" bundle:nil] forCellReuseIdentifier:@"WithdrawalsFirstCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"WithButtonCell" bundle:nil] forCellReuseIdentifier:@"WithButtonCell"];
    [self.tableview registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
    
    
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
    [self.tableview cyl_reloadData];
    self.tableview.mj_footer.state = MJRefreshStateIdle;
    [self.tableview.mj_header endRefreshing];
}

- (void)loadMore {
    [self.tableview.mj_footer endRefreshing];
    self.tableview.mj_footer.state = MJRefreshStateNoMoreData;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    }
    return  0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 50;
    }
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)view;
    headerView.textLabel.font = [UIFont systemFontOfSize:14];
    headerView.textLabel.textColor = [UIColor blackColor];
    
    headerView.detailTextLabel.font = [UIFont systemFontOfSize:14];
    headerView.detailTextLabel.textColor = [UIColor blackColor];
    if (section == 0) {
        headerView.textLabel.text = @"提款订单";
    }else{
        
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        static NSString *identifier1 = @"WithdrawalsFirstCell";
        WithdrawalsFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        
        cell.priceLab.text = @"8888.00元";
        cell.statusLab.text = @"提款成功";
        cell.timeLab.text = @"2018/09/29 16:00:00";
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
        
    }
    else{
        LRWeakSelf(self);
        static NSString *identifier1 = @"WithButtonCell";
        WithButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        [cell.withdarBtn setTitle:@"我要提款" forState:UIControlStateNormal];
        cell.withdrawalstoBlock = ^(WithButtonCell *cell){
            WithdrawalSecondVC *vc = [[WithdrawalSecondVC alloc]initWithNibName:@"WithdrawalSecondVC" bundle:nil];
            vc.balancenum = self.balancenum;
            [weakself.navigationController pushViewController:vc animated:YES];
        };
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        WithdrawalSucc *vc = [[WithdrawalSucc alloc]initWithNibName:@"WithdrawalSucc" bundle:nil];
        vc.ispopRoot = NO;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
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
    weChatStylePlaceHolder.title = @"您还没有提款哦";
    weChatStylePlaceHolder.content = @"快去提款吧!";
    
    return weChatStylePlaceHolder;
    
}

- (void)emptyOverlayClicked:(id)sender {
    
}



@end
