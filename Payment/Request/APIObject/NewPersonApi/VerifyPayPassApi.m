//
//  CollectActivityApi.m
//  SpendTime
//
//  Created by mini14 on 2016/10/13.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "VerifyPayPassApi.h"

@implementation VerifyPayPassApi{
    NSString *_uid;
    NSString *_payPasswd;
}
- (id)initWithUid:(NSString *)uid PayPasswd:(NSString *)payPasswd{
    self = [super init];
    if (self) {
        _uid = uid?uid:@"";
        _payPasswd = payPasswd?payPasswd:@"";
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (NSString *)requestUrl {
    return @"/api/pay/password/verify";
}

- (id)requestArgument {
    
    return  @{
              @"uid":_uid,
              @"payPasswd":_payPasswd
              };
}


@end
