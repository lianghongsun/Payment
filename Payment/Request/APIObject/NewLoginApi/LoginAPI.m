//
//  LoginApi.m
//  YTKNetworkDemo
//
//  Created by Techistoner on 15/11/30.
//  Copyright © 2015年 yuantiku.com. All rights reserved.
//

#import "LoginAPI.h"

#import "DeviceInfo.h"
#import "CommonUse.h"
@implementation LoginAPI {
    NSString *_username;
    NSString *_password;
}

- (id)initWithUsername:(NSString *)username password:(NSString *)password {
    self = [super init];
    if (self) {
        _username = username?username:@"";
        _password = password?password:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/api/passport/login";
}


- (id)requestArgument {
    
    return  @{
                @"username":_username,
                @"passwd":_password,
            };
}






@end
