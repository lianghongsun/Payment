//
//  ChooesePayment.m
//  Payment
//
//  Created by 噗噗 on 2018/4/5.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "ChooeseThree.h"
#import "CollectionVC.h"
#import "LSXPopMenu.h"

@interface ChooeseThree ()<LSXPopMenuDelegate>
{
    NSArray *titlearr;
    NSString *platformId;
    NSString *platformname;
}
@end

@implementation ChooeseThree

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付方式";
    self.chooseImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60e", 40, ThemeColor)];
    self.subbackgView.layer.borderWidth = 1;
    //边框颜色
    self.subbackgView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    titlearr = @[@"超市电器类",@"服装百货类",@"酒店餐饮类",@"珠宝娱乐类",@"汽车消费类"];
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
    UserInfo *user = [UserInfo shareObject];
    if (!user.isLogin) {
        [self gobacklogin];
        return;
    }
    platformId = @"100";
    platformname = @"微信";
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
    UserInfo *user = [UserInfo shareObject];
    if (!user.isLogin) {
        [self gobacklogin];
        return;
    }
    platformId = @"101";
    platformname = @"支付宝";
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

- (IBAction)chooseindustryAction:(id)sender {
    [LSXPopMenu showRelyOnView:sender titles:titlearr  icons:@[@"",@"",@"",@"",@""] menuWidth:120 isShowTriangle:YES delegate:self];
}

#pragma mark --  LSXPopupMenDelegate
-(void)LSXPopupMenuDidSelectedAtIndex:(NSInteger)index LSXPopupMenu:(LSXPopMenu *)LSXPopupMenu{
    [self.industryBtn setTitle:[NSString stringWithFormat:@"%@",titlearr[index]] forState:UIControlStateNormal];
    NSLog(@"------点击---%ld",(long)index);
}

@end
