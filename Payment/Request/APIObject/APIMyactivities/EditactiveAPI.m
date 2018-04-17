//
//  EditactiveAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/10/18.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "EditactiveAPI.h"

@implementation EditactiveAPI {
     NSDictionary *_paramDic;
}
- (id)initWithParamDic:(NSDictionary *)paramDic{
    self = [super init];
    if (self) {
        _paramDic = paramDic;
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/activemanager/editactive";
}

- (id)requestArgument {
    return  _paramDic;
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPut;
}
@end
