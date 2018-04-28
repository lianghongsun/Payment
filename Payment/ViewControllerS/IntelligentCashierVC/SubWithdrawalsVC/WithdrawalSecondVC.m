//
//  WithdrawalSecondVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "WithdrawalSecondVC.h"
#import "WithdrpriceCell.h"
#import "AddYHKCell.h"
#import "WithDetermineBtnCell.h"
#import "WithdrawalSucc.h"
#import "WithdrawaPassVC.h"
#import "YHKModel.h"

@interface WithdrawalSecondVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong)UITextField *priceTx;
@property (nonatomic, assign)BOOL ifSelected;//是否选中
@property (nonatomic, strong)NSIndexPath * lastSelected;//上一次选中的索引

@end

@implementation WithdrawalSecondVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.priceLab.text = [NSString stringWithFormat:@"%@元",self.balancenum];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提款";
    [self setrigBtn];
    self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"WithdrpriceCell" bundle:nil] forCellReuseIdentifier:@"WithdrpriceCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"AddYHKCell" bundle:nil] forCellReuseIdentifier:@"AddYHKCell"];
      [self.tableview registerNib:[UINib nibWithNibName:@"WithDetermineBtnCell" bundle:nil] forCellReuseIdentifier:@"WithDetermineBtnCell"];
    [self.tableview registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setrigBtn {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 30, 30);
    [rightButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e696", 30, RGB(255, 255, 255))] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc ] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;
    
}

- (void)rightAction {
    
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return self.listDataarr.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.00001;
    }
    else if (section ==1){
      return 40;
    }
     return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 178;
    }
    else if (indexPath.section == 1){
      return 140;
    }
    return 160;
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
    if (section == 1) {
        headerView.textLabel.text = @"请选择提款账户";
    }else{
        
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        static NSString *identifier1 = @"WithdrpriceCell";
        WithdrpriceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell.tomotoBlock = ^(WithdrpriceCell *cell) {
            [cell.tomoBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
            
            [cell.todayBtn setImage:[UIImage imageNamed:@"noselected"] forState:UIControlStateNormal];
        };
        
        cell.todaytoBlock = ^(WithdrpriceCell *cell) {
            [cell.tomoBtn setImage:[UIImage imageNamed:@"noselected"] forState:UIControlStateNormal];
            
            [cell.todayBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        };
        cell.priceTx.delegate = self;
        self.priceTx = cell.priceTx;
        [self.priceTx addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [cell.allBtn addTarget:self action:@selector(allbtnAction) forControlEvents:UIControlEventTouchDown];
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
        
    }
    else if(indexPath.section == 1){
        static NSString *identifier1 = @"AddYHKCell";
        AddYHKCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
//        cell.backgroundColor = [UIColor whiteColor];
        YHKModel *model = self.listDataarr[indexPath.row];
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
    else{
        static NSString *identifier1 = @"WithDetermineBtnCell";
        WithDetermineBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell.determineBlockoBlock = ^(WithDetermineBtnCell *cell) {
            
            if (!self.lastSelected) {
                return;
            }
            YHKModel *model = self.listDataarr[self.lastSelected.row];
            
            LxPrintf(@"选中的卡号%@",model.bankNo);
            
//            WithdrawaPassVC *vc = [[WithdrawaPassVC alloc]initWithNibName:@"WithdrawaPassVC" bundle:nil];
//            [self.navigationController pushViewController:vc animated:YES];
            

        };
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        self.ifSelected = YES;
        self.lastSelected = indexPath;//选中的修改为当前行
        [tableView reloadData];
        
    }
    
}

- (void)allbtnAction {
    self.priceTx.text = self.balancenum;
}

-(void)textFieldDidChange :(UITextField *)theTextField{
    theTextField.text = [self okPriceDecimal:theTextField.text ];
    if ([theTextField.text floatValue]>[self.priceLab.text floatValue]) {
        self.priceTx.text = self.balancenum;
    }
}

-(NSString *)okPriceDecimal:(NSString *)priceStr
{
    
    NSRange startRange = [priceStr rangeOfString:@"."];
    //是否有小数点
    if (startRange.location != NSNotFound) {
        //若小数点直接在¥后面第一位，则补充0
        if (startRange.location == 0) {
            priceStr = [NSMutableString stringWithFormat:@"0%@",[priceStr substringFromIndex:0]];
            startRange = [priceStr rangeOfString:@"."];
        }
        //控制小数点后只能输入两位
        
        
        NSString *str = [priceStr substringFromIndex:startRange.location];
        if ([str length]==3) {
            NSString *str2 = [str substringWithRange:NSMakeRange(2,1)];
            if ([str2 isEqualToString:@"0"]) {
                return [priceStr substringToIndex:priceStr.length-1];
            }
        }
        if (str.length > 3) {
            return [priceStr substringToIndex:priceStr.length-1];
        }
    }else
    {
        if (priceStr.length < 3) return priceStr;
        //¥右侧第一个数字
        NSString *numStr = [priceStr substringWithRange:NSMakeRange(1, 1)];
        //若¥右侧第一个数字是0，则删除第一个0
        if ([numStr integerValue] == 0) {
            return [NSString stringWithFormat:@"%@",[priceStr substringFromIndex:2]];
        }
    }
    return priceStr;
}


@end
