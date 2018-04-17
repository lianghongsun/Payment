//
//  MessageVC.m
//  Payment
//
//  Created by 噗噗 on 2018/3/31.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "MessageVC.h"
#import "MessSystemCell.h"

@interface MessageVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    
    [self setcollfirstLab:self.systemmes secLab:self.activitymes viewColour:ThemeColor Labcolur:[UIColor blackColor]];
    [self setBorderWithView:self.systemmes top:NO left:NO bottom:YES right:NO borderColor:ThemeColor borderWidth:2];
    [self setBorderWithView:self.activitymes top:NO left:NO bottom:YES right:NO borderColor:[UIColor whiteColor] borderWidth:2];
    
    
    [self.tableview registerNib:[UINib nibWithNibName:@"MessSystemCell" bundle:nil] forCellReuseIdentifier:@"MessSystemCell"];
    
    [self.newtableview registerNib:[UINib nibWithNibName:@"MessSystemCell" bundle:nil] forCellReuseIdentifier:@"MessSystemCell"];
    
    self.newtableview.delegate = self;
    self.newtableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.newtableview setHidden:YES];
    [self.tableview setHidden:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableview) {
        return 18;
    }
    else{
        return 5;
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


@end
