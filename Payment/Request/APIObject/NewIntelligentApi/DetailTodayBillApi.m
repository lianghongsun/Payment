//
//  GetusermoneyAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/10/12.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "DetailTodayBillApi.h"

@implementation DetailTodayBillApi
{
    NSString *_uid;
    NSInteger _pageNum;
    NSInteger _pageSize;
    NSString *_startDate;
    NSString *_platformId;
}

- (id)initWithUid:(NSString *)uid PageNum:(NSInteger)pageNum PageSize:(NSInteger)pageSize StartDate:(NSString *)startDate PlatformId:(NSString *)platformId {
    self = [super init];
    if (self) {
        _uid = uid?uid:@"";
        _pageNum = pageNum;
        _pageSize = pageSize;
        _startDate = startDate?startDate:@"";
        _platformId = platformId?platformId:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/api/pay/log/bill/today/detail";
}


- (id)requestArgument {
    
    return  @{
              @"uid":_uid,
              @"pageNum":[NSNumber numberWithInteger:_pageNum],
              @"pageSize":[NSNumber numberWithInteger:_pageSize],
              @"startDate":_startDate,
              @"platformId":_platformId,
              };
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPost;
}

@end
