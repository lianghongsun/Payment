//
//  HomeDataStatisticsCell.m
//  Payment
//
//  Created by 噗噗 on 2018/4/5.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "HomeDataStatisticsCell.h"

@implementation HomeDataStatisticsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.combinedBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e66c", 20, RGB(241, 157, 56))] forState:UIControlStateNormal];
    
    [self.ailpayBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e608", 20, ThemeColor)] forState:UIControlStateNormal];
    
    [self.weixinBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6ed", 20, RGB(106, 163, 85))] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
