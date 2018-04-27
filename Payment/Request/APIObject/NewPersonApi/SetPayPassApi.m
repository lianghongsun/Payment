//
//  ActivityDetailApi.m
//  SpendTime
//
//  Created by mini14 on 2016/10/14.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "SetPayPassApi.h"

@implementation SetPayPassApi{
    NSString *_uid;
    NSString *_payPasswd;
    NSString *_newSecondPassword;
}
- (id)initWithUid:(NSString *)uid PayPasswd:(NSString *)payPasswd NewSecondPassword:(NSString *)newSecondPassword{
    self = [super init];
    if (self) {
        _uid = uid?uid:@"";
        _payPasswd = payPasswd?payPasswd:@"";
        _newSecondPassword = newSecondPassword?newSecondPassword:@"";
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/api/pay/password/set";
}


- (id)requestArgument {
    
    return  @{
              @"uid":_uid,
              @"payPasswd":_payPasswd,
              @"newSecondPassword":_newSecondPassword
              };
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPost;
}


@end
