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
#import "QueryBankcardApi.h"
#import "YHKModel.h"
#import "DelBankcardApi.h"
#import "SetDefaultBankcardApi.h"

@interface BindingYHKVC ()<UITableViewDelegate,UITableViewDataSource,WeChatStylePlaceHolderDelegate>

@property (nonatomic,strong) NSMutableArray *listdataArr;
@property (nonatomic, assign)BOOL ifSelected;//是否选中
@property (nonatomic, strong)NSIndexPath * lastSelected;//上一次选中的索引

@end

@implementation BindingYHKVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableview.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定收款银行卡";
    self.listdataArr = [NSMutableArray array];
    
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
    
//    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

- (void)loadNewData {
    
    [self QueryBankcardApi];
}

//- (void)loadMore {
//    [self.tableview.mj_footer endRefreshing];
//    self.tableview.mj_footer.state = MJRefreshStateNoMoreData;
//}

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
    YHKModel *model = self.listdataArr[indexPath.row];
    cell.backgrview.layer.shadowColor = ThemeColor.CGColor;
    cell.backgrview.layer.shadowOpacity = 0.5f;
    cell.backgrview.layer.shadowRadius = 4.f;
    cell.backgrview.layer.shadowOffset = CGSizeMake(0,0);
    if ([model.isDefault isEqualToString:@"1"]&&self.ifSelected == NO) {
        cell.backgrview.backgroundColor = ThemeColor;
        cell.nameLab.textColor = [UIColor whiteColor];
        cell.numLab.textColor = [UIColor whiteColor];
        [cell.defaultimg setHidden:NO];
    }
    else if ([model.isDefault isEqualToString:@"1"]&&self.ifSelected == YES){
        if (self.lastSelected == indexPath) {
            cell.backgrview.backgroundColor = ThemeColor;
            cell.nameLab.textColor = [UIColor whiteColor];
            cell.numLab.textColor = [UIColor whiteColor];
        }else{
            cell.backgrview.backgroundColor = [UIColor whiteColor];
            cell.nameLab.textColor = [UIColor blackColor];
            cell.numLab.textColor = [UIColor blackColor];
        }
        [cell.defaultimg setHidden:NO];
    }
    else{
        [cell.defaultimg setHidden:YES];
        if (self.lastSelected == indexPath) {
            cell.backgrview.backgroundColor = ThemeColor;
            cell.nameLab.textColor = [UIColor whiteColor];
            cell.numLab.textColor = [UIColor whiteColor];
        }else{
            cell.backgrview.backgroundColor = [UIColor whiteColor];
            cell.nameLab.textColor = [UIColor blackColor];
            cell.numLab.textColor = [UIColor blackColor];
        }
    }
    
    cell.logimg.image = [UIImage imageNamed:@"zhaohang"];
    cell.nameLab.text = model.realname;
    cell.numLab.text = [NSString stringWithFormat:@"****  ****  ****  %@",[model.bankNo substringFromIndex:model.bankNo.length-4]] ;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSIndexPath * temp = self.lastSelected;//暂存上一次选中的行
//    if (temp && temp != indexPath)//如果上一次的选中的行存在,并且不是当前选中的这一行,则让上一行不选中
//    {
//        self.ifSelected = NO;//修改之前选中的cell的数据为不选中
//        [tableView reloadRowsAtIndexPaths:@[temp] withRowAnimation:UITableViewRowAnimationAutomatic];//刷新该行
//    }
    self.ifSelected = YES;
    self.lastSelected = indexPath;//选中的修改为当前行
    [tableView reloadData];
//    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];//重新刷新
    
}

- (IBAction)addYHKAction:(id)sender {
    BindingYHKSecondVC *vc = [[BindingYHKSecondVC alloc]initWithNibName:@"BindingYHKSecondVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)setdefaultAction:(id)sender {
    if (!self.lastSelected) {
        return;
    }
    YHKModel *model = self.listdataArr[self.lastSelected.row];
    
    [self SetDefaultBankcardApi:model.bankId];
}

- (IBAction)bindingAction:(id)sender {
    if (!self.lastSelected) {
        return;
    }
    YHKModel *model = self.listdataArr[self.lastSelected.row];
    
    [self DelBankcardApi:model.bankId];
    
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

- (void)QueryBankcardApi {
    
    QueryBankcardApi *query = [[QueryBankcardApi alloc]initWithCategory:@"1"];
    [query startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            [self.tableview.mj_header endRefreshing];
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    self.lastSelected = nil;
                    self.ifSelected = NO;
                    [self.listdataArr removeAllObjects];
                    [self.listdataArr addObjectsFromArray:[YHKModel mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"list"]]];
                    [self.tableview cyl_reloadData];
                }
                    break;
                default:
                {
                    NSString *mesgStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"msg"]];
                    [self showMessage:mesgStr viewHeight:0];
                }
                    break;
            }
        }
    } failure:^(YTKBaseRequest *request) {
        [self.tableview.mj_header endRefreshing];
    }];
}

- (void)DelBankcardApi:(NSString *)bankid{
    DelBankcardApi *delbank = [[DelBankcardApi alloc]initWithBankId:bankid];
    [delbank startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
    
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    [self.tableview.mj_header beginRefreshing];
                }
                    break;
                default:
                {
                    NSString *mesgStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"msg"]];
                    [self showMessage:mesgStr viewHeight:0];
                }
                    break;
            }
        }
    } failure:^(YTKBaseRequest *request) {
        
    }];
}


- (void)SetDefaultBankcardApi:(NSString *)bankid{
    
    SetDefaultBankcardApi *setdefaulbank = [[SetDefaultBankcardApi alloc]initWithBankId:bankid];
    [setdefaulbank startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    [self.tableview.mj_header beginRefreshing];
                }
                    break;
                default:
                {
                    NSString *mesgStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"msg"]];
                    [self showMessage:mesgStr viewHeight:0];
                }
                    break;
            }
        }
    } failure:^(YTKBaseRequest *request) {
    
    }];
}
@end
