//
//  AddactiveAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "TodayBillApi.h"

@implementation TodayBillApi

{
    NSString *_uid;
    NSString *_startDate;
}

- (id)initWithUid:(NSString *)uid StartDate:(NSString *)startDate{
    self = [super init];
    if (self) {
        _uid = uid?uid:@"";
        _startDate = startDate?startDate:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/api/pay/log/bill/today";
}


- (id)requestArgument {
    
    return  @{
              @"uid":_uid,
              @"startDate":_startDate,
              };
}


@end
