//
//  DeviceInfo.h
//  SpendTime
//
//  Created by mini1 on 2016/9/30.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceInfo : NSObject

+ (DeviceInfo *)shareObject;

@property (nonatomic, copy  ) NSString  *systemStr;// 设备操作系统
@property (nonatomic, copy  ) NSString  *operatorsStr;// 获取运营商
@property (nonatomic, copy  ) NSString  *platformStr; // 设备型号

@end
