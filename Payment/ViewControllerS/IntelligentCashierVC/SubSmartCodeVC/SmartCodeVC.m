//
//  SmartCodeVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/5.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "SmartCodeVC.h"
#import "MMScanViewController.h"

@interface SmartCodeVC ()
{
    NSString *QrUrlStr;
}
@end

@implementation SmartCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收款码收款";
    
    
    [self setimage];
    [self setrigBtn];
    QrUrlStr = @"http://www.baidu.com";
    
    UIImage *image = [MMScanViewController createQRImageWithString:QrUrlStr QRSize:CGSizeMake(300, 300) QRColor:[UIColor blackColor] bkColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:1.00]];
    //如果不需要设置背景色以及前景色，则使用下面代码  默认白色底黑色码
    //UIImage *image = [ScanViewController createQRImageWithString:_linkTfd.text QRSize:CGSizeMake(250, 250)];
    [self.QrcodeImg setImage: image];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setrigBtn {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 30, 30);
    [rightButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e696", 30, RGB(255, 255, 255))] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc ] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;
    
}

- (void)rightAction {
    
    
}

-(void)setimage {
    self.topailimage.image =  [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e608", 100, ThemeColor)];
    self.topweixinimage.image =  [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6ed",100, RGB(106, 163, 85))];
    self.saoyisaoImage.image =  [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e63a", 80, RGB(255, 255, 255))];
    self.moneyImage.image =  [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6e7", 80, RGB(255, 255, 255))];
    self.succImage.image =  [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e634", 80, RGB(255, 255, 255))];
    self.saoyisaoright.image =  [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e604", 25, RGB(255, 255, 255))];
    self.moneyright.image =  [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e604", 25, RGB(255, 255, 255))];
    
}

@end
