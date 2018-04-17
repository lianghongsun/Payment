//
//  DeviceInfo.m
//  SpendTime
//
//  Created by mini1 on 2016/9/30.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "DeviceInfo.h"

@implementation DeviceInfo

static DeviceInfo *sharedAccountManagerInstance = nil;

+ (DeviceInfo *)shareObject
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

@end
