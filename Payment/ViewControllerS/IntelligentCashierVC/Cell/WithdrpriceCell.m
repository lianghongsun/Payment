//
//  WithdrpriceCell.m
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "WithdrpriceCell.h"

@implementation WithdrpriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.priceTx.keyboardType = UIKeyboardTypeDecimalPad;
    self.backgroview.layer.borderWidth = 1;
    self.backgroview.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.allBtn.layer.cornerRadius = 5;
    self.allBtn.layer.masksToBounds = YES;
    
    self.priceLab.text = @"0元";
    self.poundageLab.text = @"(手续费0元)";
    [self.tomoBtn setImage:[UIImage imageNamed:@"noselected"] forState:UIControlStateNormal];
    
    [self.todayBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)tomoAction:(id)sender {
    if (self.tomotoBlock) {
        self.tomotoBlock(self);
    }
}

- (IBAction)todayAction:(id)sender {
    if (self.todaytoBlock) {
        self.todaytoBlock(self);
    }
}
@end
