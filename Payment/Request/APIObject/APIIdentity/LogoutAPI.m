//
//  LogoutAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "LogoutAPI.h"

@implementation LogoutAPI

{
    NSString *_authorization;
    
}

- (id)initWithAuthorization:(NSString *)authorization{
    self = [super init];
    if (self) {
        _authorization = authorization?authorization:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/auth/logout";
}


- (id)requestArgument {
    
    return  @{
              @"Authorization":_authorization
              };
}

@end
