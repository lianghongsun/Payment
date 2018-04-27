//
//  ActivitesSearchApi.m
//  SpendTime
//
//  Created by mini14 on 2016/10/13.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "DetailMinthBillApi.h"

@implementation DetailMinthBillApi{
    NSString *_uid;
    NSInteger _pageNum;
    NSInteger _pageSize;
    NSString *_platformId;
}

- (id)initWithUid:(NSString *)uid PageNum:(NSInteger)pageNum PageSize:(NSInteger)pageSize  PlatformId:(NSString *)platformId {
    self = [super init];
    if (self) {
        _uid = uid?uid:@"";
        _pageNum = pageNum;
        _pageSize = pageSize;
        _platformId = platformId?platformId:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/api/pay/log/bill/month/detail";
}


- (id)requestArgument {
    
    return  @{
              @"uid":_uid,
              @"pageNum":[NSNumber numberWithInteger:_pageNum],
              @"pageSize":[NSNumber numberWithInteger:_pageSize],
              @"platformId":_platformId,
              };
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPost;
}

@end
