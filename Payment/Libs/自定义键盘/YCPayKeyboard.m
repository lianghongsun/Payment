//
//  YCPayKeyboard.m
//  SWWH
//
//  Created by 尚往文化 on 17/1/16.
//  Copyright © 2017年 cy. All rights reserved.
//

#import "YCPayKeyboard.h"
#import "Define.h"
#import "UIView+Extension.h"

@implementation YCPayKeyboard

+ (instancetype)keyboard
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        for (int i=0; i<14; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            if (i<10) {
                [btn setTitle:[@(i) stringValue] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            } else {
                if (i == 10) {
                    [btn setTitle:@"." forState:UIControlStateNormal];
                    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                } else if (i==11) {
                    [btn setTitle:@"删除" forState:UIControlStateNormal];
                    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }
                else if (i == 12){
                    [btn setTitle:@"清空" forState:UIControlStateNormal];
                    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }
                else {
                    [btn setTitle:@"确定\n支付" forState:UIControlStateNormal];
                    btn.backgroundColor = ThemeColor;
                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

                }
            }
            btn.titleLabel.lineBreakMode = 0;
            btn.titleLabel.font = [UIFont systemFontOfSize:25];
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 10+i;
            [self addSubview:btn];
        }
        
        
        
    }
    return self;
}

- (void)click:(UIButton *)btn
{
    if (self.clickBlock) {
        self.clickBlock(btn.tag-10);
    }
}

- (void)drawRect:(CGRect)rect
{
    
    CGFloat w = self.width/4;
    CGFloat h = self.height/4;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    for (int i=0; i<5; i++) {
        [bezierPath moveToPoint: CGPointMake(0, h*i)];
        [bezierPath addLineToPoint: CGPointMake(self.width, h*i)];
    }
    for (int i=1; i<=3; i++) {
        [bezierPath moveToPoint: CGPointMake(w*i, 0)];
        [bezierPath addLineToPoint: CGPointMake(w*i, self.height-h*(i==1))];
    }
    [[UIColor lightGrayColor] setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
}

- (void)layoutSubviews
{
    CGFloat w = self.width/4;
    CGFloat h = self.height/4;
    for (int i=1; i<=9; i++) {
        UIView *view = [self viewWithTag:i+10];
        view.x = w*((i-1)%3);
        view.y = h*((i-1)/3);
        view.width = w;
        view.height = h;
    }
    [self viewWithTag:10].frame = CGRectMake(0, h*3, w*2, h);
    [self viewWithTag:20].frame = CGRectMake(w*2, h*3, w, h);
    [self viewWithTag:21].frame = CGRectMake(w*3, 0, w, h);
    [self viewWithTag:22].frame = CGRectMake(w*3, h, w, h);
    [self viewWithTag:23].frame = CGRectMake(w*3, h*2, w, h*2);
}

@end
