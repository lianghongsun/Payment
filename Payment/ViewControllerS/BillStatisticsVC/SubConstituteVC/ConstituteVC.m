//
//  ConstituteVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/8.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "ConstituteVC.h"
#import "AXDrawView.h"

@interface ConstituteVC ()
{
    AXDrawView      *_drawView;
    NSMutableArray  *_array;
}

@end

@implementation ConstituteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收款构成";
    _array = [NSMutableArray array];
    [_array addObject:@"90"];
    [_array addObject:@"10"];
    
    _drawView = [[AXDrawView alloc]initWithFrame:CGRectMake(0, 0, 250, 250) type:PieChart_Type];
    _drawView.arrayPoint = _array;
    //设置每个扇形的颜色，不设置颜色随机显示
    _drawView.colorItems = @[ThemeColor, RGB(121, 172, 59), ];
    [self.backgrView addSubview:_drawView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_drawView) {
        [_drawView removeFromSuperview];
        _drawView = nil;
    }
}


- (IBAction)choosetimeAction:(id)sender {
}
@end
