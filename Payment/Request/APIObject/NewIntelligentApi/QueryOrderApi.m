//
//  MyactivecountAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/10/11.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "QueryOrderApi.h"

@implementation QueryOrderApi
{
    NSString *_orderNo;
}

- (id)initWithOrderNo:(NSString *)orderNo {
    self = [super init];
    if (self) {
        _orderNo = orderNo?orderNo:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/api/pay/order/query";
}


- (id)requestArgument {
    
    return  @{
              @"orderNo":_orderNo,
              };
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPost;
}

@end
