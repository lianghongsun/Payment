//
//  SendsmsAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "SendsmsAPI.h"

@implementation SendsmsAPI

{
    NSString *_mobileNo;
    NSString *_bzType;
}

- (id)initWithMobileNo:(NSString *)mobileNo BzType:(NSString *)bzType{
    self = [super init];
    if (self) {
        _mobileNo = mobileNo?mobileNo:@"";
        _bzType = bzType?bzType:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/api/sms/send";
}


- (id)requestArgument {
    
    return  @{
              @"mobileNo":_mobileNo,
              @"bzType":_bzType
              };
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPost;
}


@end
