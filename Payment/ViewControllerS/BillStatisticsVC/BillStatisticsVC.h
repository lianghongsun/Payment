//
//  BillStatisticsVC.h
//  Payment
//
//  Created by 噗噗 on 2018/3/31.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillStatisticsVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIView *todaybackgrview;
@property (weak, nonatomic) IBOutlet UIView *tomobackgrview;
@property (weak, nonatomic) IBOutlet UILabel *todaypriceLab;
@property (weak, nonatomic) IBOutlet UILabel *todaynumLab;
@property (weak, nonatomic) IBOutlet UILabel *tomopriceLab;
@property (weak, nonatomic) IBOutlet UILabel *tomonumLab;

@end
