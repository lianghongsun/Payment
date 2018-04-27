//
//  PayApi.m
//  SpendTime
//
//  Created by mini14 on 2016/10/19.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "EverydayBillApi.h"

@implementation EverydayBillApi{
    NSString *_uid;
    NSString *_startDate;
    NSString *_endDate;
}

- (id)initWithUid:(NSString *)uid StartDate:(NSString *)startDate EndDate:(NSString *)endDate{
    self = [super init];
    if (self) {
        _uid = uid?uid:@"";
        _startDate = startDate?startDate:@"";
        _endDate = endDate?endDate:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/api/pay/log/bill/everyday";
}


- (id)requestArgument {
    
    return  @{
              @"uid":_uid,
              @"startDate":_startDate,
              @"endDate":_endDate,
              };
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPost;
}

@end
