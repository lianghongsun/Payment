//
//  MyactiveAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "CreateOrderApi.h"

@implementation CreateOrderApi

{
    NSString *_platformId;
    NSString *_productName;
    NSString *_money;
    NSString *_authcode;
}

- (id)initWithPlatformId:(NSString *)platformId ProductName:(NSString *)productName Money:(NSString *)money Authcode:(NSString *)authcode{
    self = [super init];
    if (self) {
        _platformId = platformId?platformId:@"";
        _productName = productName?productName:@"";
        _money = money?money:@"";
        _authcode = authcode?authcode:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/api/pay/order/create";
}


- (id)requestArgument {
    
    return  @{
              @"platformId":_platformId,
              @"productName":_productName,
              @"money":_money,
              @"authcode":_authcode,
              };
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPost;
}

@end
