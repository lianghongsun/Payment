//
//  SettingMessVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/3.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "SettingMessVC.h"


@interface SettingMessVC ()

@end

@implementation SettingMessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息通知设置";
    self.noticeswitch.onTintColor = ThemeColor;
    [self.noticeswitch setOn:NO];
    self.voiceswitch.onTintColor = ThemeColor;
    self.vibrationswitch.onTintColor = ThemeColor;
     [self.noticeswitch addTarget:self action:@selector(noticeAction:) forControlEvents:UIControlEventValueChanged];
    [self.voiceswitch addTarget:self action:@selector(voicesAction:) forControlEvents:UIControlEventValueChanged];
    [self.vibrationswitch addTarget:self action:@selector(vibrationAction:) forControlEvents:UIControlEventValueChanged];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)noticeAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        LxPrintf(@"通知打开了");
    }else {
        LxPrintf(@"通知关闭了");
    }
}

-(void)voicesAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        LxPrintf(@"消息打开了");
    }else {
        LxPrintf(@"消息关闭了");
    }
}


-(void)vibrationAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        LxPrintf(@"震动打开了");
    }else {
        LxPrintf(@"震动关闭了");
    }
}




@end
