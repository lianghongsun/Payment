//
//  PublishActiviteApi.m
//  SpendTime
//
//  Created by mini14 on 2016/10/11.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "PublishActiviteApi.h"

@implementation PublishActiviteApi{
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
    return @"/activemanager/addactive";
}

- (id)requestArgument {
    return  _paramDic;
}

@end
