//
//  AilpaybillVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/4.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "NewMonthbillVC.h"
#import "collectionCell.h"
#import "GYZCityHeaderView.h"

@interface NewMonthbillVC ()<UITableViewDelegate,UITableViewDataSource,WeChatStylePlaceHolderDelegate>
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

NSString *const newHeaderView = @"newHeaderView";

@implementation NewMonthbillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    
    self.backgrView.backgroundColor = ThemeColor;
    self.todayLab.backgroundColor = ThemeColor;
    [self setUidata];
    self.dataArr = [NSMutableArray array];
    [self.dataArr addObject:@"123"];
    [self.dataArr addObject:@"1321"];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"collectionCell" bundle:nil] forCellReuseIdentifier:@"collectionCell"];
    
    [self.tableview registerClass:[GYZCityHeaderView class] forHeaderFooterViewReuseIdentifier:newHeaderView];
    
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    GYZCityHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:newHeaderView];
    headerView.contentView.backgroundColor = [UIColor whiteColor];
    NSString *title = @"2018年03月27日";
    NSString *subtitle = @"¥ 8888.00";
    headerView.titleLabel.text = title;
    headerView.subtitleLabel.text = subtitle;
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier1 = @"collectionCell";
    collectionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    if ([self.titleStr isEqualToString:@"支付宝账单详情"]) {
     cell.headimge.image = cell.headimge.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e608", 40, ThemeColor)];
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
    weChatStylePlaceHolder.title = @"您还没有当月账单信息哦";
    weChatStylePlaceHolder.content = @"快去使用吧!";
    
    return weChatStylePlaceHolder;
    
}

- (void)emptyOverlayClicked:(id)sender {
    
}



@end
