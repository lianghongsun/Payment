//
//  LoginOutCell.m
//  Payment
//
//  Created by 噗噗 on 2018/4/1.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "LoginOutCell.h"

@implementation LoginOutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.loginoutLab.textColor = ThemeColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
