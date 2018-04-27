//
//  UserupdateAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/10/12.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "MonthBillApi.h"

@implementation MonthBillApi
{
    NSString *_uid;
}

- (id)initWithUid:(NSString *)uid{
    self = [super init];
    if (self) {
        _uid = uid?uid:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/api/pay/log/bill/month";
}


- (id)requestArgument {
    
    return  @{
              @"uid":_uid,
              };
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPost;
}

@end
