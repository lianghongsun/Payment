//
//  BindingYHKVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/2.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "BindingYHKVC.h"
#import "AddYHKCell.h"
#import "BindingYHKSecondVC.h"

@interface BindingYHKVC ()<UITableViewDelegate,UITableViewDataSource,WeChatStylePlaceHolderDelegate>

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation BindingYHKVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定收款银行卡";
    self.dataArr = [NSMutableArray array];
    [self.dataArr addObject:@"123"];
    [self.dataArr addObject:@"1321"];
    
    self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.tableview registerNib:[UINib nibWithNibName:@"AddYHKCell" bundle:nil] forCellReuseIdentifier:@"AddYHKCell"];
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
    cell.backgroundColor = [UIColor whiteColor];
    cell.backgrview.layer.shadowColor = ThemeColor.CGColor;
    cell.backgrview.layer.shadowOpacity = 0.5f;
    cell.backgrview.layer.shadowRadius = 4.f;
    cell.backgrview.layer.shadowOffset = CGSizeMake(0,0);
    cell.logimg.image = [UIImage imageNamed:@"zhaohang"];
    cell.nameLab.text = @"张无忌";
    cell.numLab.text = @"828283783738*********9989";
    cell.accessoryType = UITableViewCellAccessoryNone;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (IBAction)addYHKAction:(id)sender {
    BindingYHKSecondVC *vc = [[BindingYHKSecondVC alloc]initWithNibName:@"BindingYHKSecondVC" bundle:nil];
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
    weChatStylePlaceHolder.title = @"您还没有绑定银行卡哦";
    weChatStylePlaceHolder.content = @"快去绑定吧!";
    
    return weChatStylePlaceHolder;
    
}

- (void)emptyOverlayClicked:(id)sender {
    
}



@end
