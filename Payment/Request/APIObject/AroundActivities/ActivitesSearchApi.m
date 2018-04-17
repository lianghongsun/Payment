//
//  ActivitesSearchApi.m
//  SpendTime
//
//  Created by mini14 on 2016/10/13.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "ActivitesSearchApi.h"

@implementation ActivitesSearchApi{
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
    return YTKRequestMethodPost;
}

- (NSString *)requestUrl {
    return @"/active/search";
}

- (id)requestArgument {
    return  _paramDic;
}


@end
