//
//  MyactivedetailAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "MonthHistoryBillApi.h"

@implementation MonthHistoryBillApi
{
    NSString *_uid;
    NSString *_monthDate;
}

- (id)initWithUid:(NSString *)uid MonthDate:(NSString *)monthDate{
    self = [super init];
    if (self) {
        _uid = uid?uid:@"";
        _monthDate = monthDate?monthDate:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/api/pay/log/bill/history/month";
}


- (id)requestArgument {
    
    return  @{
              @"uid":_uid,
              @"monthDate":_monthDate,
              };
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPost;
}
@end
