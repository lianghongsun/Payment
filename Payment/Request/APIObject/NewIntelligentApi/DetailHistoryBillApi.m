//
//  AroundActivitiesApi.m
//  SpendTime
//
//  Created by mini14 on 2016/10/13.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "DetailHistoryBillApi.h"

@implementation DetailHistoryBillApi{
    NSString *_uid;
    NSInteger _pageNum;
    NSInteger _pageSize;
    NSString *_platformId;
    NSString *_monthDate;
}

- (id)initWithUid:(NSString *)uid PageNum:(NSInteger)pageNum PageSize:(NSInteger)pageSize  PlatformId:(NSString *)platformId MonthDate:(NSString *)monthDate {
    self = [super init];
    if (self) {
        _uid = uid?uid:@"";
        _pageNum = pageNum;
        _pageSize = pageSize;
        _platformId = platformId?platformId:@"";
        _monthDate = monthDate?monthDate:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/api/pay/log/bill/history/detail";
}


- (id)requestArgument {
    
    return  @{
              @"uid":_uid,
              @"pageNum":[NSNumber numberWithInteger:_pageNum],
              @"pageSize":[NSNumber numberWithInteger:_pageSize],
              @"platformId":_platformId,
              @"monthDate":_monthDate,
              };
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPost;
}


@end
