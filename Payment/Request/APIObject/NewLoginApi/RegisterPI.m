//
//  ResetpwdAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "RegisterPI.h"

@implementation RegisterPI

{
    NSString *_username;
    NSString *_passwd;
    NSString *_bzType;
    NSString *_smscode;
    NSString *_needLogin;
    
}


- (id)initWithUsername:(NSString *)username Passwd:(NSString *)passwd BzType:(NSString *)bzType Smscode:(NSString *)smscode NeedLogin:(NSString *)needLogin{
    
    self = [super init];
    if (self) {
        _username = username?username:@"";
        _passwd = passwd?passwd:@"";
        _bzType = bzType?bzType:@"";
        _smscode = smscode?smscode:@"";
        _needLogin = needLogin?needLogin:@"";
        
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/api/register/mobile";
}

- (id)requestArgument {
    
    return  @{
              @"username":_username,
              @"passwd":_passwd,
              @"bzType":_bzType,
               @"smscode":_smscode,
               @"needLogin":_needLogin
              
              };
}

@end
