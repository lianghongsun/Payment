//
//  AilpaybillVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/4.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "AilpaybillVC.h"
#import "collectionCell.h"
#import "TodayBillSuccVC.h"
#import "DetailTodayBillApi.h"
#import "YHKModel.h"

@interface AilpaybillVC ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,WeChatStylePlaceHolderDelegate>
{
    UserInfo *user;
    NSString *platformId;
}
@property (nonatomic,strong) NSMutableArray *listdataArr;
@property (nonatomic,assign) NSInteger pageNum;

@end

@implementation AilpaybillVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
    user = [UserInfo shareObject];
    if ([self.titleStr isEqualToString:@"支付宝账单详情"]) {
        platformId = @"101";
    }
    else{
        platformId = @"100";
    }
    
    [self.tableview.mj_header beginRefreshing];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navititle.text = self.titleStr;

    self.listdataArr = [NSMutableArray array];
    
    
    if (@available(iOS 11.0, *)) {
        
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.backBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e7c2", 30, RGB(255, 255, 255))] forState:UIControlStateNormal];
    
    [self setUidata];
    [self.tableview registerNib:[UINib nibWithNibName:@"collectionCell" bundle:nil] forCellReuseIdentifier:@"collectionCell"];
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
    [self DetailTodayBillApi:user.uid PageNum:self.pageNum PageSize:10 StartDate:[JCAUtility stringWithCurrentTime:@"yyyy-MM-dd"] PlatformId:platformId];
}

- (void)loadMore {
    self.pageNum ++;
    [self DetailTodayBillApi:user.uid PageNum:self.pageNum PageSize:10 StartDate:[JCAUtility stringWithCurrentTime:@"yyyy-MM-dd"] PlatformId:platformId];
    
//    [self.tableview.mj_footer endRefreshing];
//    self.tableview.mj_footer.state = MJRefreshStateNoMoreData;
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
    
    return self.listdataArr.count;
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
    TodayBilldetailModel *model = self.listdataArr[indexPath.row];
    
    if ([self.titleStr isEqualToString:@"支付宝账单详情"]) {
     cell.headimge.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e608", 40, ThemeColor)];
    }
    else{
     cell.headimge.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6ed", 40, RGB(106, 163, 85))];
    }
    cell.nameLab.text = model.cashierName;
    cell.timeLab.text = model.create;
    cell.priceLab.text = model.arrivalAmount;
    cell.statusLab.text = model.logType;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TodayBilldetailModel *model = self.listdataArr[indexPath.row];
    
    TodayBillSuccVC *vc = [[TodayBillSuccVC alloc]initWithNibName:@"TodayBillSuccVC" bundle:nil];
    vc.ispopRoot = NO;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)setUidata{
    
}


- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
    weChatStylePlaceHolder.title = @"您还没有今日账单哦";
    weChatStylePlaceHolder.content = @"快去使用吧!";
    
    return weChatStylePlaceHolder;
    
}

- (void)emptyOverlayClicked:(id)sender {
    
}

- (void)DetailTodayBillApi:(NSString *)mid PageNum:(NSInteger)pageNum PageSize:(NSInteger)pageSize StartDate:(NSString *)startDate PlatformId:(NSString *)platformId {
    DetailTodayBillApi *todaybill = [[DetailTodayBillApi alloc]initWithUid:mid PageNum:pageNum PageSize:pageSize StartDate:startDate PlatformId:platformId];
    [todaybill startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            [self closeLoding];
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    NSDictionary *datadic = [dic objectForKey:@"data"];
                    self.allgetpriceLab.text = [NSString stringWithFormat:@"¥%.2f",[[datadic objectForKey:@"totalAmount"]floatValue]];
                    self.billnumLab.text = [NSString stringWithFormat:@"%@笔",[datadic objectForKey:@"totalCount"]];
                    if (pageNum == 1) {
                        [self.listdataArr removeAllObjects];
                        [self.tableview.mj_header endRefreshing];
                    }
                    else{
                        [self.tableview.mj_footer endRefreshing];
                        
                    }
                    NSArray *arr = [datadic objectForKey:@"list"];
                    if (arr.count<10) {
                        self.tableview.mj_footer.state = MJRefreshStateNoMoreData;
                    }
                    
                    [self.listdataArr addObjectsFromArray:[TodayBilldetailModel mj_objectArrayWithKeyValuesArray:[datadic objectForKey:@"list"]]];
                    [self.tableview cyl_reloadData];
                    

                    
                
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
