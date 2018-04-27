//
//  Modify_pwdAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "ModifyPayPassAPI.h"

@implementation ModifyPayPassAPI

{
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
    return @"/api/pay/password/modify";
}


- (id)requestArgument {
    
    return  @{
              @"uid":_uid,
              @"payPasswd":_payPasswd,
              @"newPayPassword":_newSecondPassword
              };
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPost;
}


@end
