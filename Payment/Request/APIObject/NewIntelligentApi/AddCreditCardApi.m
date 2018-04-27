//
//  ActivedetailAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "AddCreditCardApi.h"

@implementation AddCreditCardApi
{
    NSString *_realname;
    NSString *_bankNo;
    NSString *_bankName;
}

- (id)initWithRealname:(NSString *)realname BankNo:(NSString *)bankNo BankName:(NSString *)bankName {
    self = [super init];
    if (self) {
        _realname = realname?realname:@"";
        _bankNo = bankNo?bankNo:@"";
        _bankName = bankName?bankName:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/api/passport/creditcard/add";
}


- (id)requestArgument {
    
    return  @{
              @"realname":_realname,
              @"bankNo":_bankNo,
              @"bankName":_bankName,
              };
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPost;
}

@end
