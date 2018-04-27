//
//  DelactiveAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/10/11.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "DelBankcardApi.h"

@implementation DelBankcardApi
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
    return @"/api/passport/bankcard/del";
}


- (id)requestArgument {
    
    return  @{
              @"bankId":_bankId
              };
}

@end
