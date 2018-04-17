//
//  CollectionVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "CollectionVC.h"
#import "MMScanViewController.h"

@interface CollectionVC ()
{
    NSString *QrUrlStr;
}
@end

@implementation CollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收款码收款";
    self.paymethodLab.text = self.methods;
    self.paypriceLab.text = [NSString stringWithFormat:@"¥%@",self.price];
    
    QrUrlStr = @"http://www.baidu.com";
    
    UIImage *image = [MMScanViewController createQRImageWithString:QrUrlStr QRSize:CGSizeMake(300, 300) QRColor:[UIColor blackColor] bkColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:1.00]];
    //如果不需要设置背景色以及前景色，则使用下面代码  默认白色底黑色码
    //UIImage *image = [ScanViewController createQRImageWithString:_linkTfd.text QRSize:CGSizeMake(250, 250)];
    [self.QrImg setImage: image];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
