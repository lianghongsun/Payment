//
//  MessageVC.m
//  Payment
//
//  Created by 噗噗 on 2018/3/31.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "MessageVC.h"
#import "MessSystemCell.h"

@interface MessageVC ()<UITableViewDelegate,UITableViewDataSource,WeChatStylePlaceHolderDelegate>
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSMutableArray *newdataArr;

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    self.dataArr = [NSMutableArray array];
    [self.dataArr addObject:@"123"];
    [self.dataArr addObject:@"1321"];
    self.newdataArr = [NSMutableArray array];
    [self.newdataArr addObject:@"123"];
    [self.newdataArr addObject:@"1321"];
    
    [self setcollfirstLab:self.systemmes secLab:self.activitymes viewColour:ThemeColor Labcolur:[UIColor blackColor]];
    [self setBorderWithView:self.systemmes top:NO left:NO bottom:YES right:NO borderColor:ThemeColor borderWidth:2];
    [self setBorderWithView:self.activitymes top:NO left:NO bottom:YES right:NO borderColor:[UIColor whiteColor] borderWidth:2];
    
    
    [self.tableview registerNib:[UINib nibWithNibName:@"MessSystemCell" bundle:nil] forCellReuseIdentifier:@"MessSystemCell"];
    
    [self.newtableview registerNib:[UINib nibWithNibName:@"MessSystemCell" bundle:nil] forCellReuseIdentifier:@"MessSystemCell"];
    
    [self setrefreshHeaderOrFooter];
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
    [self.dataArr removeAllObjects];
    [self.tableview cyl_reloadData];
    self.tableview.mj_footer.state = MJRefreshStateIdle;
    [self.tableview.mj_header endRefreshing];
}

- (void)loadMore {
    [self.tableview.mj_footer endRefreshing];
    self.tableview.mj_footer.state = MJRefreshStateNoMoreData;
}

- (void)newloadNewData {
    [self.newdataArr removeAllObjects];
    [self.newtableview cyl_reloadData];
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
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableview) {
        return self.dataArr.count;
    }
    else{
        return self.newdataArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableview) {
        static NSString *identifier1 = @"MessSystemCell";
        MessSystemCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell.sourceLab.text = @"支付宝收款";
        cell.timeLab.text = @"2018/03/23 11:00:00";
        cell.priceLab.text = @"+888.00";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else{
        static NSString *identifier1 = @"MessSystemCell";
        MessSystemCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell.sourceLab.text = @"微信提款了";
        cell.timeLab.text = @"2018/03/23 11:00:00";
        cell.priceLab.text = @"+888.00";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (IBAction)systemAction:(id)sender {
    [self.newtableview setHidden:YES];
    [self.tableview setHidden:NO];
    
    [self setcollfirstLab:self.systemmes secLab:self.activitymes viewColour:ThemeColor Labcolur:[UIColor blackColor]];
    [self setBorderWithView:self.systemmes top:NO left:NO bottom:YES right:NO borderColor:ThemeColor borderWidth:2];
    [self setBorderWithView:self.activitymes top:NO left:NO bottom:YES right:NO borderColor:[UIColor whiteColor] borderWidth:2];
    
}

- (IBAction)activityAction:(id)sender {
    [self.tableview setHidden:YES];
    [self.newtableview setHidden:NO];
    
    
    [self setcollfirstLab:self.activitymes secLab:self.systemmes viewColour:ThemeColor Labcolur:[UIColor blackColor]];
    [self setBorderWithView:self.activitymes top:NO left:NO bottom:YES right:NO borderColor:ThemeColor borderWidth:2];
    [self setBorderWithView:self.systemmes top:NO left:NO bottom:YES right:NO borderColor:[UIColor whiteColor] borderWidth:2];
    
}


- (void)setcollfirstLab:(UILabel *)label secLab:(UILabel *)seclab viewColour:(UIColor *)viewcolour Labcolur:(UIColor *)labcolour{
    
    label.textColor = viewcolour;
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
    weChatStylePlaceHolder.title = @"您还没有消息哦";
    weChatStylePlaceHolder.content = @"快去看看别的吧!";
    
    return weChatStylePlaceHolder;
    
}

- (void)emptyOverlayClicked:(id)sender {
    
}




@end
