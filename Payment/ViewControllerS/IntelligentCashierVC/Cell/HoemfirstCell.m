//
//  HoemfirstCell.m
//  Payment
//
//  Created by 噗噗 on 2018/4/5.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "HoemfirstCell.h"

@implementation HoemfirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.scanBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e63a", 150, ThemeColor)] forState:UIControlStateNormal];
    [self.smartBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e655", 150, ThemeColor)] forState:UIControlStateNormal];
    [self.paymentBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e612", 150, ThemeColor)] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)scanAction:(id)sender {
    if (self.scantoBlock) {
        self.scantoBlock(self);
    }
}

- (IBAction)smartCodeAction:(id)sender {
    
    if (self.smarttoBlock) {
        self.smarttoBlock(self);
    }
    
}

- (IBAction)paymentCodeAction:(id)sender {
    
    if (self.paymenttoBlock) {
        self.paymenttoBlock(self);
    }
    
}
@end
