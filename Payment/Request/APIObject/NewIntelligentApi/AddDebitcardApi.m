//
//  CollectlistAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/10/12.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "AddDebitcardApi.h"

@implementation AddDebitcardApi
{
    NSString *_realname;
    NSString *_bankNo;
    NSString *_bankName;
    NSString *_cardType;
    NSString *_smscode;
}

- (id)initWithRealname:(NSString *)realname BankNo:(NSString *)bankNo BankName:(NSString *)bankName CardType:(NSString *)cardType Smscode:(NSString *)smscode{
    self = [super init];
    if (self) {
        _realname = realname?realname:@"";
        _bankNo = bankNo?bankNo:@"";
        _bankName = bankName?bankName:@"";
        _cardType = cardType?cardType:@"";
        _smscode = smscode?smscode:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/api/passport/debitcard/add";
}


- (id)requestArgument {
    
    return  @{
              @"realname":_realname,
              @"bankNo":_bankNo,
              @"bankName":_bankName,
              @"cardType":_cardType,
              @"smscode":_smscode,
              };
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPost;
}

@end
