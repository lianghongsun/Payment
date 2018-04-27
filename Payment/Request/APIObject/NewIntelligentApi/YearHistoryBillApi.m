//
//  DelOrderApi.m
//  SpendTime
//
//  Created by mini14 on 2016/10/20.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "YearHistoryBillApi.h"

@implementation YearHistoryBillApi{
    NSString *_uid;
}

- (id)initWithUid:(NSString *)uid{
    self = [super init];
    if (self) {
        _uid = uid?uid:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/api/pay/log/bill/history/year";
}


- (id)requestArgument {
    
    return  @{
              @"uid":_uid,
              };
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPost;
}
@end
