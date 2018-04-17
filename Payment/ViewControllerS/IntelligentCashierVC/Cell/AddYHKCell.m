//
//  AddYHKCell.m
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "AddYHKCell.h"

@implementation AddYHKCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.backgrview.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.backgrview.layer.shadowOpacity = 0.5f;
    self.backgrview.layer.shadowRadius = 4.f;
    self.backgrview.layer.shadowOffset = CGSizeMake(0,0);

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
