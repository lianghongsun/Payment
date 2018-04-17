//
//  BillStatisticsVC.m
//  Payment
//
//  Created by 噗噗 on 2018/3/31.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "MyBillVC.h"
#import "collectionCell.h"
#import "ChooseTimeVC.h"
#import "GYZCityHeaderView.h"

@interface MyBillVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *begintime;
    NSString *enttime;
}
@end

NSString *const cityHeaderView = @"CityHeaderView";

@implementation MyBillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的账单";
    
    enttime = [JCAUtility stringWithCurrentTime:@"yyyy年MM月dd日"];
    begintime = [JCAUtility getMonthBeginAndEndWith:enttime];
    self.PeriodtimeLab.text = [NSString stringWithFormat:@"%@-%@",begintime,enttime];
  
    [self setcollviewbackg:self.collectpriceLab firstLab:self.collectnameLab secLab:self.collectpriceLab viewColour:ThemeColor Labcolur:ThemeColor];
    [self setcollviewbackg:self.spendingpriceLab firstLab:self.spendingnameLab secLab:self.spendingpriceLab viewColour:[UIColor whiteColor] Labcolur:[UIColor blackColor]];
    
    [self setBorderWithView:self.collectpriceLab top:NO left:NO bottom:YES right:NO borderColor:ThemeColor borderWidth:2];
    [self setBorderWithView:self.spendingpriceLab top:NO left:NO bottom:YES right:NO borderColor:[UIColor whiteColor] borderWidth:2];
    
    
    [self.tableview registerNib:[UINib nibWithNibName:@"collectionCell" bundle:nil] forCellReuseIdentifier:@"collectionCell"];
     [self.tableview registerClass:[GYZCityHeaderView class] forHeaderFooterViewReuseIdentifier:cityHeaderView];
    [self.newtableview registerNib:[UINib nibWithNibName:@"collectionCell" bundle:nil] forCellReuseIdentifier:@"collectionCell"];
    [self.newtableview registerClass:[GYZCityHeaderView class] forHeaderFooterViewReuseIdentifier:cityHeaderView];
    
  
    [self.newtableview setHidden:YES];
    [self.tableview setHidden:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -- sterefresh

- (void)setrefreshHeaderOrFooter {
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.newtableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(newloadNewData)];
    
    
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.newtableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(newloadMore)];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.newtableview.delegate = self;
    self.newtableview.dataSource = self;
}

- (void)loadNewData {
    [self.tableview reloadData];
    self.tableview.mj_footer.state = MJRefreshStateIdle;
    [self.tableview.mj_header endRefreshing];
}

- (void)loadMore {
    [self.tableview.mj_footer endRefreshing];
    self.tableview.mj_footer.state = MJRefreshStateNoMoreData;
}

- (void)newloadNewData {
    [self.newtableview reloadData];
    self.newtableview.mj_footer.state = MJRefreshStateIdle;
    [self.newtableview.mj_header endRefreshing];
}

- (void)newloadMore {
    [self.newtableview.mj_footer endRefreshing];
    self.newtableview.mj_footer.state = MJRefreshStateNoMoreData;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableview) {
     return 2;
    }
    else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableview) {
        return 3;
    }
    else{
     return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    GYZCityHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cityHeaderView];
    headerView.contentView.backgroundColor = [UIColor whiteColor];
    NSString *title;
    NSString *subtitle;
    if (tableView == self.tableview) {
        title = @"2018年03月27日";
        subtitle = @"¥ 8888.00";
    }
    else{
        title = @"2019年12月09日";
        subtitle = @"¥ 6666.00";
    }
    headerView.titleLabel.text = title;
    headerView.subtitleLabel.text = subtitle;
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableview) {
        static NSString *identifier1 = @"collectionCell";
        collectionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell.headimge.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e608", 100, ThemeColor)];
        cell.nameLab.text = @"张无忌";
        cell.timeLab.text = @"2018/03/26 15:00:00";
        cell.priceLab.text = @"2222.00";
        cell.statusLab.text = @"收款成功";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else{
        static NSString *identifier1 = @"collectionCell";
        collectionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell.headimge.image = [UIImage imageNamed:@"zhaohang"];
        cell.nameLab.text = @"大魔头";
        cell.timeLab.text = @"6888*******9999";
        cell.priceLab.text = @"还信用卡";
        cell.statusLab.text = @"2019/03/26";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


- (IBAction)collectionAction:(id)sender {
    
    [self.newtableview setHidden:YES];
    [self.tableview setHidden:NO];
    
    [self setBorderWithView:self.collectpriceLab top:NO left:NO bottom:YES right:NO borderColor:ThemeColor borderWidth:2];
    [self setBorderWithView:self.spendingpriceLab top:NO left:NO bottom:YES right:NO borderColor:[UIColor whiteColor] borderWidth:2];
    
    [self setcollviewbackg:self.collectpriceLab firstLab:self.collectnameLab secLab:self.collectpriceLab viewColour:ThemeColor Labcolur:ThemeColor];
    
    [self setcollviewbackg:self.spendingpriceLab firstLab:self.spendingnameLab secLab:self.spendingpriceLab viewColour:[UIColor whiteColor] Labcolur:[UIColor blackColor]];
    
    
}
- (IBAction)spendingAction:(id)sender {
     [self.tableview setHidden:YES];
    [self.newtableview setHidden:NO];
   
    
    [self setBorderWithView:self.spendingpriceLab top:NO left:NO bottom:YES right:NO borderColor:ThemeColor borderWidth:2];
    [self setBorderWithView:self.collectpriceLab top:NO left:NO bottom:YES right:NO borderColor:[UIColor whiteColor] borderWidth:2];
    
    
    [self setcollviewbackg:self.spendingpriceLab firstLab:self.spendingnameLab secLab:self.spendingpriceLab viewColour:ThemeColor Labcolur:ThemeColor];
    
    [self setcollviewbackg:self.collectpriceLab firstLab:self.collectnameLab secLab:self.collectpriceLab viewColour:[UIColor whiteColor] Labcolur:[UIColor blackColor]];
    
}

- (IBAction)PeriodoftimeAction:(id)sender {
    ChooseTimeVC *vc = [[ChooseTimeVC alloc]initWithNibName:@"ChooseTimeVC" bundle:nil];
    vc.begintime = begintime;
    vc.enttime = enttime;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)setcollviewbackg:(UIView *)view firstLab:(UILabel *)label secLab:(UILabel *)seclab viewColour:(UIColor *)viewcolour Labcolur:(UIColor *)labcolour{
    
    label.textColor = labcolour;
    seclab.textColor = labcolour;
    
    
}


- (void)setBorderWithView:(UILabel *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width
{
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, view.frame.size.height - width, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(view.frame.size.width - width, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
}


@end
