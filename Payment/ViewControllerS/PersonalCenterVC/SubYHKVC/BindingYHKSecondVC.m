//
//  BindingYHKSecondVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/11.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "BindingYHKSecondVC.h"
#import "UIView+Extension.h"

@interface BindingYHKSecondVC ()<LSXPopMenuDelegate>
{
    NSArray *titlearr;
}
@end

@implementation BindingYHKSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    titlearr = @[@"个人账户",@"对公账户"];
    self.title = @"增加收款银行卡";
    self.typeview.layer.borderWidth = 1;
    self.typeview.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.typeBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60e", 40, ThemeColor)] forState:UIControlStateNormal];
    
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"获取验证码"];
    [tncString addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleSingle)
                      range:(NSRange){0,[tncString length]}];
    
    [tncString addAttribute:NSForegroundColorAttributeName value:ThemeColor  range:NSMakeRange(0,[tncString length])];
    
     [tncString addAttribute:NSUnderlineColorAttributeName value:ThemeColor range:(NSRange){0,[tncString length]}];
    [self.getcodeBtn setAttributedTitle:tncString forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark --  LSXPopupMenDelegate
-(void)LSXPopupMenuDidSelectedAtIndex:(NSInteger)index LSXPopupMenu:(LSXPopMenu *)LSXPopupMenu{
    
    self.typeLab.text = [NSString stringWithFormat:@"%@",titlearr[index]];
    NSLog(@"------点击---%ld",(long)index);
}

- (IBAction)typeAction:(id)sender {
    
    [LSXPopMenu showRelyOnView:sender titles:titlearr  icons:@[@"",@""] menuWidth:120 isShowTriangle:YES delegate:self];
    
}
- (IBAction)getcodeAction:(id)sender {
}
@end
