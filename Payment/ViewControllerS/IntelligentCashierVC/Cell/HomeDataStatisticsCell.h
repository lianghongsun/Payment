//
//  HomeDataStatisticsCell.h
//  Payment
//
//  Created by 噗噗 on 2018/4/5.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeDataStatisticsCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *alltodaypriceLab;

@property (weak, nonatomic) IBOutlet UILabel *alltomopriceLab;
@property (weak, nonatomic) IBOutlet UILabel *alipaytodaypriceLab;

@property (weak, nonatomic) IBOutlet UILabel *ailpaytomopriceLab;
@property (weak, nonatomic) IBOutlet UILabel *weixintodaypeiceLab;
@property (weak, nonatomic) IBOutlet UILabel *weixintomopriceLab;
@property (weak, nonatomic) IBOutlet UIButton *combinedBtn;
@property (weak, nonatomic) IBOutlet UIButton *ailpayBtn;
@property (weak, nonatomic) IBOutlet UIButton *weixinBtn;
@end
