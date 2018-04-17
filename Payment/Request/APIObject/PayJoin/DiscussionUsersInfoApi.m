//
//  DiscussionUsersInfoApi.m
//  SpendTime
//
//  Created by mini14 on 2016/10/20.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "DiscussionUsersInfoApi.h"

@implementation DiscussionUsersInfoApi{
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
    return @"/activemanager/groupusers";
}

//- (BOOL)statusCodeValidator {
//    if ([[(NSDictionary *)[super responseJSONObject] objectForKey:@"status"] integerValue]==1) {
//        return YES;
//    }
//    return NO;
//}

- (id)requestArgument {
    return  _paramDic;
}

@end
