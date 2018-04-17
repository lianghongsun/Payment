//
//  HomeCertificationCell.m
//  Payment
//
//  Created by 噗噗 on 2018/4/5.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "HomeCertificationCell.h"

@implementation HomeCertificationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.reimburBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6a7", 150, RGB(77, 152, 56))] forState:UIControlStateNormal];
    [self.relanBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e784", 150, RGB(167, 179, 248))] forState:UIControlStateNormal];
    [self.storeBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6cd", 150, ThemeColor)] forState:UIControlStateNormal];
    
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)reimbursementAction:(id)sender {
    if (self.reimbursementoBlock) {
        self.reimbursementoBlock(self);
    }
}

- (IBAction)realnameAction:(id)sender {
    
    if (self.realnametoBlock) {
        self.realnametoBlock(self);
    }
}

- (IBAction)storeAction:(id)sender {
    
    if (self.storetolock) {
        self.storetolock(self);
    }
    
}

- (IBAction)todayAction:(id)sender {
    if (self.todaytoBlock) {
        self.todaytoBlock(self);
    }
    
}
@end
