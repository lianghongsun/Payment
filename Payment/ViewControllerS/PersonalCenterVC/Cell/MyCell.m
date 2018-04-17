//
//  MyCell.m
//  RuiTuEBusiness
//
//  Created by Naive on 2016/12/6.
//  Copyright © 2016年 Naive. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.myContent setHidden:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
