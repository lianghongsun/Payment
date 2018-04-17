//
//  FXCyclePagerViewCell.m
//  FXKitExampleDemo
//
//  Created by sunjinshuai on 2017/8/14.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "FXCyclePagerViewCell.h"

@interface FXCyclePagerViewCell ()

@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) UILabel *pricelabel;
@property (nonatomic, weak) UILabel *orderlabel;

@end
@implementation FXCyclePagerViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addLabel];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        [self addLabel];
    }
    return self;
}


- (void)addLabel {
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    [self addSubview:label];
    
    UILabel *pricelabel = [[UILabel alloc]init];
    pricelabel.textAlignment = NSTextAlignmentCenter;
    pricelabel.textColor = [UIColor whiteColor];
    pricelabel.font = [UIFont systemFontOfSize:22];
    [self addSubview:pricelabel];
    
    UILabel *orderlabel = [[UILabel alloc]init];
    orderlabel.textAlignment = NSTextAlignmentCenter;
    orderlabel.textColor = [UIColor whiteColor];
    orderlabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:orderlabel];
    
    
    _label = label;
    _pricelabel = pricelabel;
    _orderlabel = orderlabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _label.frame = CGRectMake(10, 10, 80, 20);
    _pricelabel.frame = CGRectMake(15, 35, self.frame.size.width-30, 20);
    _orderlabel.frame = CGRectMake(15, 55, self.frame.size.width-30, 20);
}

@end
