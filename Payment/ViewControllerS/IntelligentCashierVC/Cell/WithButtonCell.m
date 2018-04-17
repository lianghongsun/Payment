//
//  WithButtonCell.m
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "WithButtonCell.h"

@implementation WithButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)withdrawalAction:(id)sender {
    
    if (self.withdrawalstoBlock) {
        self.withdrawalstoBlock(self);
    }
    
}
@end
