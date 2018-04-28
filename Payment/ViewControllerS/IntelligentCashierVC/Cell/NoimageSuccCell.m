//
//  NoimageSuccCell.m
//  Payment
//
//  Created by iMac_1 on 2018/4/10.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "NoimageSuccCell.h"

@implementation NoimageSuccCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLab.adjustsFontSizeToFitWidth = YES;
    self.subtitleLab.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
