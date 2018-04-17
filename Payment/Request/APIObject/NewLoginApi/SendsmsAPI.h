//
//  SendsmsAPI.h
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//
//发送短信
#import "BaseAPIRequest.h"

@interface SendsmsAPI : BaseAPIRequest

- (id)initWithMobileNo:(NSString *)mobileNo  BzType:(NSString *)bzType;

@end
