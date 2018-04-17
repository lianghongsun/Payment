//
//  UsernameCell.m
//  Payment
//
//  Created by 噗噗 on 2018/4/1.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "UsernameCell.h"

@implementation UsernameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userImg.layer.cornerRadius = self.userImg.frame.size.height/2;
    self.userImg.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
