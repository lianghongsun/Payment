//
//  JoinactiveAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "SetDefaultBankcardApi.h"

@implementation SetDefaultBankcardApi

{
    NSString *_bankId;
}

- (id)initWithBankId:(NSString *)bankId{
    self = [super init];
    if (self) {
        _bankId = bankId?bankId:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/api/passport/bankcard/default/set";
}


- (id)requestArgument {
    
    return  @{
              @"bankId":_bankId
              };
}


@end
