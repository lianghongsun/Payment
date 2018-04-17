//
//  AroundActivitiesApi.m
//  SpendTime
//
//  Created by mini14 on 2016/10/13.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "AroundActivitiesApi.h"

@implementation AroundActivitiesApi{
    NSDictionary *_paramDic;
}
- (id)initWithParamDic:(NSDictionary *)paramDic{
    self = [super init];
    if (self) {
        _paramDic = paramDic;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (NSString *)requestUrl {
    return @"/active/getactive";
}

- (id)requestArgument {
    return  _paramDic;
}

@end
