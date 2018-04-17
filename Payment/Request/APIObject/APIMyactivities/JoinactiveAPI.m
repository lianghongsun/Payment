//
//  JoinactiveAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "JoinactiveAPI.h"

@implementation JoinactiveAPI

{
    NSString *_uid;
    NSString *_active_id;
    NSString *_pay_status;
}

- (id)initWithUid:(NSString *)uid Active_id:(NSString *)active_id Pay_status:(NSString *)pay_status{
    self = [super init];
    if (self) {
        _uid = uid?uid:@"";
        _active_id = active_id?active_id:@"";
        _pay_status = pay_status?pay_status:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/auth/joinactive";
}


- (id)requestArgument {
    
    return  @{
              @"uid":_uid,
              @"active_id":_active_id,
              @"pay_status":_pay_status
              };
}


@end
