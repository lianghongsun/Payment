//
//  CraditRecordCell.h
//  Payment
//
//  Created by iMac_1 on 2018/4/11.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CraditRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logimage;
@property (weak, nonatomic) IBOutlet UILabel *yhknum;
@property (weak, nonatomic) IBOutlet UILabel *yhkname;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
