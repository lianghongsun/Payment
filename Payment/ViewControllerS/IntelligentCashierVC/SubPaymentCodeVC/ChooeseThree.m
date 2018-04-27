//
//  ChooesePayment.m
//  Payment
//
//  Created by 噗噗 on 2018/4/5.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "ChooeseThree.h"
#import "CollectionVC.h"

@interface ChooeseThree ()

@end

@implementation ChooeseThree

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付方式";
    [self setborderlin:self.ailbackgrview Colour:[UIColor lightGrayColor]];
    [self setborderlin:self.weixinbackgrview Colour:[UIColor lightGrayColor]];
    [self.aillogBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e608", 100, ThemeColor)] forState:UIControlStateNormal];

    [self.weixinlogBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6ed", 100, RGB(106, 163, 85))] forState:UIControlStateNormal];
   
    self.ailtapimage.image =  [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e614", 40, ThemeColor)];
    self.weixintapimage.image =  [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e614", 40, ThemeColor)];
    
    [self.ailtapimage setHidden:YES];
    [self.weixintapimage setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (IBAction)weixinAction:(id)sender {
    [self.ailtapimage setHidden:YES];
    [self.weixintapimage setHidden:NO];
    [self setborderlin:self.ailbackgrview Colour:[UIColor lightGrayColor]];
    [self setborderlin:self.weixinbackgrview Colour:ThemeColor];
    
    CollectionVC *vc = [[CollectionVC alloc]initWithNibName:@"CollectionVC" bundle:nil];
    vc.methods = @"微信收款";
    vc.price = self.pricenum;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)ailpayAction:(id)sender {
    [self.ailtapimage setHidden:NO];
    [self.weixintapimage setHidden:YES];
    [self setborderlin:self.weixinbackgrview Colour:[UIColor lightGrayColor]];
    [self setborderlin:self.ailbackgrview Colour:ThemeColor];
    
    CollectionVC *vc = [[CollectionVC alloc]initWithNibName:@"CollectionVC" bundle:nil];
    vc.methods = @"支付宝收款";
    vc.price = self.pricenum;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)setborderlin:(UIView *)view Colour:(UIColor *)colour {
    view.layer.borderWidth = 1;
    view.layer.borderColor = [colour CGColor];
}

@end
