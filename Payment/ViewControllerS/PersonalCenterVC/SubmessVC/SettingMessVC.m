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
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"allMessnoti"];
    NSString *voice = [userDefault objectForKey:@"voiceMessnoti"];
    NSString *vibration = [userDefault objectForKey:@"vibrationMess"];
    
    if ([name isEqualToString:@"开启"]) {
        [self.noticeswitch setOn:YES];
        self.voiceswitch.userInteractionEnabled = YES;
        self.vibrationswitch.userInteractionEnabled = YES;
    }
    else{
        [self.noticeswitch setOn:NO];
        self.voiceswitch.userInteractionEnabled = NO;
        self.vibrationswitch.userInteractionEnabled = NO;
    }
    
    if ([voice isEqualToString:@"开启"]) {
        [self.voiceswitch setOn:YES];
    }
    else{
        [self.voiceswitch setOn:NO];
    }
    
    if ([vibration isEqualToString:@"开启"]) {
        [self.vibrationswitch setOn:YES];
    }
    else{
        [self.vibrationswitch setOn:NO];
    }
    self.noticeswitch.onTintColor = ThemeColor;
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
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    
    if (isButtonOn) {
        self.voiceswitch.userInteractionEnabled = YES;
        self.vibrationswitch.userInteractionEnabled = YES;
        [userDef setObject:@"开启" forKey:@"allMessnoti"];
    }else {
        [userDef setObject:@"关闭" forKey:@"allMessnoti"];
        self.voiceswitch.userInteractionEnabled = NO;
        self.vibrationswitch.userInteractionEnabled = NO;
    }
    [userDef synchronize];
}

-(void)voicesAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    if (isButtonOn) {
        [userDef setObject:@"开启" forKey:@"voiceMessnoti"];
    }else {
        [userDef setObject:@"关闭" forKey:@"voiceMessnoti"];
    }
    [userDef synchronize];

}


-(void)vibrationAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    if (isButtonOn) {
        LxPrintf(@"震动打开了");
        [userDef setObject:@"开启" forKey:@"vibrationMess"];
    }else {
        LxPrintf(@"震动关闭了");
        [userDef setObject:@"关闭" forKey:@"vibrationMess"];
    }
}




@end
