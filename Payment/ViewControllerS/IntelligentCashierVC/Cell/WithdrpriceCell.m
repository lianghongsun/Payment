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
    
    self.backgroview.layer.borderWidth = 1;
    self.backgroview.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.allBtn.layer.cornerRadius = 5;
    self.allBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)waitAllAction:(id)sender {
}
@end
