//
//  AilpaybillVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/4.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "NewHistorybillVC.h"
#import "NewMonthBillCell.h"
#import "TodayBillSuccVC.h"
#import "DetailHistoryBillApi.h"
#import "YHKModel.h"

@interface NewHistorybillVC ()<UITableViewDelegate,UITableViewDataSource,WeChatStylePlaceHolderDelegate>
{
    UserInfo *user;
    NSString *platformId;
}
@property (nonatomic,strong) NSMutableArray *listdataArr;
@property (nonatomic,assign) NSInteger pageNum;

@end



@implementation NewHistorybillVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavigationBarBottomLine:YES];
    user = [UserInfo shareObject];
    if ([self.titleStr isEqualToString:@"支付宝历史账单详情"]) {
        platformId = @"101";
    }
    else{
        platformId = @"100";
    }
    
    [self.tableview.mj_header beginRefreshing];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self hideNavigationBarBottomLine:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    self.listdataArr = [NSMutableArray array];
 
    
    self.backgrView.backgroundColor = ThemeColor;
    self.todayLab.backgroundColor = ThemeColor;
    [self setUidata];
    [self.tableview registerNib:[UINib nibWithNibName:@"NewMonthBillCell" bundle:nil] forCellReuseIdentifier:@"NewMonthBillCell"];
    
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
    self.pageNum = 1;
    self.tableview.mj_footer.state = MJRefreshStateIdle;
    [self DetailHistoryBillApi:user.uid PageNum:self.pageNum PageSize:10  PlatformId:platformId MonthDate:self.monthStr];
}

- (void)loadMore {
    self.pageNum ++;
    [self DetailHistoryBillApi:user.uid PageNum:self.pageNum PageSize:10  PlatformId:platformId MonthDate:self.monthStr];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.listdataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0&&indexPath.row==self.listdataArr.count-1) {
        
        return 120;
    }
    
    else  if (indexPath.row == 0&&indexPath.row<self.listdataArr.count-1) {
        TodayBilldetailModel *model1 = self.listdataArr[indexPath.row];
        NSString * model1str = [model1.create substringToIndex:10];
        TodayBilldetailModel *model2 = self.listdataArr[indexPath.row+1];
        NSString * model2str = [model2.create substringToIndex:10];
        if ([model1str isEqualToString:model2str]) {
            return 120;
        }
        else{
            return 140;
        }
    }
    else  if (indexPath.row > 0&&indexPath.row<self.listdataArr.count-1) {
        TodayBilldetailModel *model0 = self.listdataArr[indexPath.row-1];
        NSString * model0str = [model0.create substringToIndex:10];
        TodayBilldetailModel *model1 = self.listdataArr[indexPath.row];
        NSString * model1str = [model1.create substringToIndex:10];
        TodayBilldetailModel *model2 = self.listdataArr[indexPath.row+1];
        NSString * model2str = [model2.create substringToIndex:10];
        if ([model1str isEqualToString:model0str]&&[model1str isEqualToString:model2str]) {
            return 80;
        }
        else if ([model1str isEqualToString:model0str]&&![model1str isEqualToString:model2str]){
            return 100;
        }
        else if (![model1str isEqualToString:model0str]&&[model1str isEqualToString:model2str]){
            return 120;
        }
        else if (![model1str isEqualToString:model0str]&&![model1str isEqualToString:model2str]){
            return 140;
        }
    }
    
    else if (indexPath.row == self.listdataArr.count-1){
        TodayBilldetailModel *model1 = self.listdataArr[indexPath.row];
        NSString * model1str = [model1.create substringToIndex:10];
        TodayBilldetailModel *model2 = self.listdataArr[indexPath.row-1];
        NSString * model2str = [model2.create substringToIndex:10];
        if ([model1str isEqualToString:model2str]) {
            return 80;
        }
        else{
            return 120;
        }
    }
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier1 = @"NewMonthBillCell";
    NewMonthBillCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    
    TodayBilldetailModel *newmodel1 = self.listdataArr[indexPath.row];
    if (indexPath.row == 0&&indexPath.row==self.listdataArr.count-1) {
        cell.topheight.constant = 40;
        cell.footheight.constant = 0;
    }
    
    else  if (indexPath.row == 0&&indexPath.row<self.listdataArr.count-1) {
        TodayBilldetailModel *model1 = self.listdataArr[indexPath.row];
        NSString * model1str = [model1.create substringToIndex:10];
        TodayBilldetailModel *model2 = self.listdataArr[indexPath.row+1];
        NSString * model2str = [model2.create substringToIndex:10];
        if ([model1str isEqualToString:model2str]) {
            cell.topheight.constant = 40;
            cell.footheight.constant = 0;
        }
        else{
            cell.topheight.constant = 40;
            cell.footheight.constant = 20;
        }
    }
    else  if (indexPath.row > 0&&indexPath.row<self.listdataArr.count-1) {
        TodayBilldetailModel *model0 = self.listdataArr[indexPath.row-1];
        NSString * model0str = [model0.create substringToIndex:10];
        TodayBilldetailModel *model1 = self.listdataArr[indexPath.row];
        NSString * model1str = [model1.create substringToIndex:10];
        TodayBilldetailModel *model2 = self.listdataArr[indexPath.row+1];
        NSString * model2str = [model2.create substringToIndex:10];
        if ([model1str isEqualToString:model0str]&&[model1str isEqualToString:model2str]) {
            cell.topheight.constant = 0;
            cell.footheight.constant = 0;
        }
        else if ([model1str isEqualToString:model0str]&&![model1str isEqualToString:model2str]){
            cell.topheight.constant = 0;
            cell.footheight.constant = 20;
        }
        else if (![model1str isEqualToString:model0str]&&[model1str isEqualToString:model2str]){
            cell.topheight.constant = 40;
            cell.footheight.constant = 0;
        }
        else if (![model1str isEqualToString:model0str]&&![model1str isEqualToString:model2str]){
            cell.topheight.constant = 40;
            cell.footheight.constant = 20;
        }
    }
    else if (indexPath.row == self.listdataArr.count-1){
        TodayBilldetailModel *model1 = self.listdataArr[indexPath.row];
        NSString * model1str = [model1.create substringToIndex:10];
        TodayBilldetailModel *model2 = self.listdataArr[indexPath.row-1];
        NSString * model2str = [model2.create substringToIndex:10];
        if ([model1str isEqualToString:model2str]) {
            cell.topheight.constant = 0;
            cell.footheight.constant = 0;
        }
        else{
            cell.topheight.constant = 40;
            cell.footheight.constant = 0;
        }
    }
    
    if ([self.titleStr isEqualToString:@"支付宝账单详情"]) {
        cell.headimge.image = cell.headimge.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e608", 40, ThemeColor)];
    }
    else{
        cell.headimge.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6ed", 40, RGB(106, 163, 85))];
    }
    cell.toptitle.text = [newmodel1.create substringToIndex:10];
    cell.topsubtitle.text = [NSString stringWithFormat:@"%.2f",[newmodel1.dateSum floatValue]];
    cell.nameLab.text = newmodel1.cashierName;
    cell.timeLab.text = newmodel1.create;
    cell.priceLab.text = newmodel1.arrivalAmount;
    cell.statusLab.text = newmodel1.logType;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserInfo *user = [UserInfo shareObject];
    if (!user.isLogin) {
        [self gobacklogin];
        return;
    }
    
    TodayBilldetailModel *model = self.listdataArr[indexPath.row];
    
    TodayBillSuccVC *vc = [[TodayBillSuccVC alloc]initWithNibName:@"TodayBillSuccVC" bundle:nil];
    vc.ispopRoot = NO;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)setUidata{
    
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
    weChatStylePlaceHolder.title = @"您还没有历史账单信息哦";
    weChatStylePlaceHolder.content = @"快去使用吧!";
    
    return weChatStylePlaceHolder;
    
}

- (void)emptyOverlayClicked:(id)sender {
    
}

- (void)DetailHistoryBillApi:(NSString *)uid PageNum:(NSInteger)pageNum PageSize:(NSInteger)pageSize PlatformId:(NSString *)platformId MonthDate:(NSString *)monthDate {
    DetailHistoryBillApi *minbill = [[DetailHistoryBillApi alloc]initWithUid:uid PageNum:pageNum PageSize:pageSize  PlatformId:platformId MonthDate:monthDate];
    [minbill startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            [self closeLoding];
            NSDictionary *dic = (NSDictionary *)request.responseJSONObject;
            NSInteger responseCode = [[dic objectForKey:@"retcode"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    NSDictionary *datadic = [dic objectForKey:@"data"];
                    NSInteger Code = [[datadic objectForKey:@"code"] integerValue];
                    
                    switch (Code) {
                        case SubRequestStatusSuccess:
                        {
                            NSDictionary *listdic = [datadic objectForKey:@"data"];
                            self.allgetpriceLab.text = [NSString stringWithFormat:@"¥%.2f",[[listdic objectForKey:@"totalAmount"]floatValue]];
                            self.billnumLab.text = [NSString stringWithFormat:@"%@笔",[listdic objectForKey:@"totalCount"]];
                            if (pageNum == 1) {
                                [self.listdataArr removeAllObjects];
                                [self.tableview.mj_header endRefreshing];
                            }
                            else{
                                [self.tableview.mj_footer endRefreshing];
                                
                            }
                            NSArray *arr = [listdic objectForKey:@"list"];
                            if (arr.count<10) {
                                self.tableview.mj_footer.state = MJRefreshStateNoMoreData;
                            }
                            
                            [self.listdataArr addObjectsFromArray:[TodayBilldetailModel mj_objectArrayWithKeyValuesArray:[listdic objectForKey:@"list"]]];
                            [self.tableview cyl_reloadData];
                        }
                            break;
                            
                        default:
                        {
                            [self.tableview.mj_header endRefreshing];
                            [self.tableview.mj_footer endRefreshing];
                            NSString *mesgStr = [NSString stringWithFormat:@"%@",[datadic objectForKey:@"msg"]];
                            [self showMessage:mesgStr viewHeight:0];
                        }
                            break;
                    }
                }
                    break;
                default:
                {
                    [self.tableview.mj_header endRefreshing];
                    [self.tableview.mj_footer endRefreshing];
                    NSString *mesgStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"msg"]];
                    [self showMessage:mesgStr viewHeight:0];
                }
                    break;
            }
        }
    } failure:^(YTKBaseRequest *request) {
        [self closeLoding];
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
    }];
    
}


@end
