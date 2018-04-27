//
//  PayStatusApi.m
//  SpendTime
//
//  Created by mini14 on 2016/10/20.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "PercentBillApi.h"

@implementation PercentBillApi{
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
    return @"/api/pay/log/bill/percent";
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
