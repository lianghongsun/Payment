//
//  CollectionSuccVC.h
//  Payment
//
//  Created by iMac_1 on 2018/4/10.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHKModel.h"

@interface TodayBillSuccVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,assign)BOOL ispopRoot;
@property (nonatomic,strong)TodayBilldetailModel *model;
@end
