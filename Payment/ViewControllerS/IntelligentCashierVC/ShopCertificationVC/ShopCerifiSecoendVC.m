//
//  ShopCerifiSecoendVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/11.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "ShopCerifiSecoendVC.h"
#import "ShopCerifiThreeVC.h"

@interface ShopCerifiSecoendVC ()
{
    NSString *storetype;
}
@end

@implementation ShopCerifiSecoendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺类型";
    [self setbackgrBtn:self.havecardBtn backgColour:[UIColor whiteColor] titlecolour:[UIColor blackColor] lincolour:[UIColor lightGrayColor] Boll:YES ];
    [self setbackgrBtn:self.nocardBtn backgColour:[UIColor whiteColor] titlecolour:[UIColor blackColor] lincolour:[UIColor lightGrayColor] Boll:YES];
    [self setbackgrBtn:self.enterpriseBtn backgColour:[UIColor whiteColor] titlecolour:[UIColor blackColor] lincolour:[UIColor lightGrayColor] Boll:YES];
    [self setbackgrBtn:self.nextBtn backgColour:[UIColor lightGrayColor] titlecolour:[UIColor whiteColor] lincolour:[UIColor clearColor] Boll:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)havecarAction:(id)sender {
    UserInfo *user = [UserInfo shareObject];
    if (!user.isLogin) {
        [self gobacklogin];
        return;
    }
    
    storetype = @"1";
    [self setbackgrBtn:self.havecardBtn backgColour:ThemeColor titlecolour:[UIColor whiteColor] lincolour:[UIColor clearColor] Boll:YES ];
    [self setbackgrBtn:self.nocardBtn backgColour:[UIColor whiteColor] titlecolour:[UIColor blackColor] lincolour:[UIColor lightGrayColor] Boll:YES];
    [self setbackgrBtn:self.enterpriseBtn backgColour:[UIColor whiteColor] titlecolour:[UIColor blackColor] lincolour:[UIColor lightGrayColor] Boll:YES];
    [self setbackgrBtn:self.nextBtn backgColour:ThemeColor titlecolour:[UIColor whiteColor] lincolour:[UIColor clearColor] Boll:YES];
    
    
}

- (IBAction)nocarAction:(id)sender {
    UserInfo *user = [UserInfo shareObject];
    if (!user.isLogin) {
        [self gobacklogin];
        return;
    }
    
    storetype = @"2";
    [self setbackgrBtn:self.havecardBtn backgColour:[UIColor whiteColor] titlecolour:[UIColor blackColor] lincolour:[UIColor lightGrayColor] Boll:YES];
    [self setbackgrBtn:self.nocardBtn backgColour:ThemeColor titlecolour:[UIColor whiteColor] lincolour:[UIColor clearColor] Boll:YES ];
    [self setbackgrBtn:self.enterpriseBtn backgColour:[UIColor whiteColor] titlecolour:[UIColor blackColor] lincolour:[UIColor lightGrayColor] Boll:YES];
    [self setbackgrBtn:self.nextBtn backgColour:ThemeColor titlecolour:[UIColor whiteColor] lincolour:[UIColor clearColor] Boll:YES];
    
}

- (IBAction)enterpriseAction:(id)sender {
    UserInfo *user = [UserInfo shareObject];
    if (!user.isLogin) {
        [self gobacklogin];
        return;
    }
    
    storetype = @"3";
    [self setbackgrBtn:self.havecardBtn backgColour:[UIColor whiteColor] titlecolour:[UIColor blackColor] lincolour:[UIColor lightGrayColor] Boll:YES];
    [self setbackgrBtn:self.nocardBtn backgColour:[UIColor whiteColor] titlecolour:[UIColor blackColor] lincolour:[UIColor lightGrayColor] Boll:YES];
    [self setbackgrBtn:self.enterpriseBtn backgColour:ThemeColor titlecolour:[UIColor whiteColor] lincolour:[UIColor clearColor] Boll:YES ];
    [self setbackgrBtn:self.nextBtn backgColour:ThemeColor titlecolour:[UIColor whiteColor] lincolour:[UIColor clearColor] Boll:YES];
    
}

- (IBAction)nextAction:(id)sender {
    UserInfo *user = [UserInfo shareObject];
    if (!user.isLogin) {
        [self gobacklogin];
        return;
    }
    
    ShopCerifiThreeVC *vc = [[ShopCerifiThreeVC alloc]initWithNibName:@"ShopCerifiThreeVC" bundle:nil];
    vc.storetype = storetype;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setbackgrBtn:(UIButton *)button backgColour:(UIColor *)colour titlecolour:(UIColor *)titlecolours lincolour:(UIColor *)lincolours Boll:(BOOL)isuse  {
    [button setBackgroundColor:colour];
    [button setTitleColor:titlecolours forState:UIControlStateNormal];
    button.layer.borderWidth = 1;
    button.layer.borderColor = [lincolours CGColor];
    button.userInteractionEnabled = isuse;
}


@end
