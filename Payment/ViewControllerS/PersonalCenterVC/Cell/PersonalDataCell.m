//
//  PersonalDataCell.m
//  CatchDoll
//
//  Created by mini1 on 2017/7/7.
//  Copyright © 2017年 umk. All rights reserved.
//

#import "PersonalDataCell.h"

@implementation PersonalDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.head_Image.layer.cornerRadius = 40;
    self.head_Image.layer.masksToBounds =YES;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
//    //    [self layoutIfNeeded];
//    //    usleep(100);
//    self.head_Image.layer.cornerRadius =self.head_Image.frame.size.width/2;
//    self.head_Image.layer.masksToBounds =YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
