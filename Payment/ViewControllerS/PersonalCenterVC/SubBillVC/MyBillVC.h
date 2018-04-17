//
//  BillStatisticsVC.h
//  Payment
//
//  Created by 噗噗 on 2018/3/31.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBillVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;
- (IBAction)collectionAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *spendingBtn;
- (IBAction)spendingAction:(id)sender;
- (IBAction)PeriodoftimeAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *PeriodtimeLab;
@property (weak, nonatomic) IBOutlet UIView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *collectnameLab;
@property (weak, nonatomic) IBOutlet UILabel *collectpriceLab;
@property (weak, nonatomic) IBOutlet UIView *spendingView;
@property (weak, nonatomic) IBOutlet UILabel *spendingnameLab;
@property (weak, nonatomic) IBOutlet UILabel *spendingpriceLab;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UITableView *newtableview;

@end
