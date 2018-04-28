//
//  WithdrawalSecondVC.h
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdrawalSecondVC : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic,copy)NSString *balancenum;
@property (nonatomic,strong)NSMutableArray *listDataarr;

@end
