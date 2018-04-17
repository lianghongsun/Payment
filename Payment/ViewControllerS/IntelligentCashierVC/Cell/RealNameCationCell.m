//
//  RealNameCationCell.m
//  Payment
//
//  Created by iMac_1 on 2018/4/11.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "RealNameCationCell.h"

@implementation RealNameCationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.positiveimg.layer.borderWidth = 1;
    self.positiveimg.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.positiveimg.layer.masksToBounds = YES;
    
    self.reverseimg.layer.borderWidth = 1;
    self.reverseimg.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.reverseimg.layer.masksToBounds = YES;
    
    self.myimg.layer.borderWidth = 1;
    self.myimg.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.myimg.layer.masksToBounds = YES;
    
    self.Photofirst.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e628", 40, ThemeColor)];
    self.Photosecond.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e628", 40, ThemeColor)];
    self.Photothree.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e628", 40, ThemeColor)];
    
    //添加手势
    UITapGestureRecognizer * tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(positive:)];
    [tapGesture1 setNumberOfTapsRequired:1];
    self.positiveimg.userInteractionEnabled = YES;
    [self.positiveimg addGestureRecognizer:tapGesture1];
    
    UITapGestureRecognizer * tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reverse:)];
    [tapGesture2 setNumberOfTapsRequired:1];
    self.reverseimg.userInteractionEnabled = YES;
    [self.reverseimg addGestureRecognizer:tapGesture2];
    
    UITapGestureRecognizer * tapGesture3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myimg:)];
    [tapGesture3 setNumberOfTapsRequired:1];
    self.myimg.userInteractionEnabled = YES;
    [self.myimg addGestureRecognizer:tapGesture3];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)positive:(UITapGestureRecognizer *)gesture {
    if (self.positivetoBlock) {
        self.positivetoBlock(self);
    }
}

- (void)reverse:(UITapGestureRecognizer *)gesture {
    if (self.reversetoBlock) {
        self.reversetoBlock(self);
    }
}

- (void)myimg:(UITapGestureRecognizer *)gesture {
    if (self.myimgtoBlock) {
        self.myimgtoBlock(self);
    }
}

- (IBAction)submitAction:(id)sender {
    
    if (self.submittoBlock) {
        self.submittoBlock(self);
    }
}
@end
