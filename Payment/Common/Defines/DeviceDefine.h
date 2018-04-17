//
//  DeviceDefine.h
//  RuiTuEBusiness
//
//  Created by Naive on 2016/11/21.
//  Copyright © 2016年 Naive. All rights reserved.
//

//获取当前APP版本
#define CLIENT_VERSION [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"]

//设备UUID
#define uuid [[NSUUID UUID] UUIDString]

//判断ios7
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//判断ios8
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
