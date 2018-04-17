//
//  HomeBalanceCell.m
//  Payment
//
//  Created by 噗噗 on 2018/4/5.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "HomeBalanceCell.h"

@implementation HomeBalanceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)withdrawalsAction:(id)sender {
    if (self.withdrawalstoBlock) {
        self.withdrawalstoBlock(self);
    }
    
}
@end
