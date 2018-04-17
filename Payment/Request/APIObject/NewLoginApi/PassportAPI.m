//
//  RegisterAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "PassportAPI.h"

@implementation PassportAPI
{
    NSString *_username;
    NSString *_newPasswd;
    NSString *_smscode;
}


- (id)initWithUsername:(NSString *)username NewPasswd:(NSString *)newPasswd Smscode:(NSString *)smscode {
    
    self = [super init];
    if (self) {
        _username = username?username:@"";
        _newPasswd = newPasswd?newPasswd:@"";
        _smscode = smscode?smscode:@"";
    }
    return self;
}

- (NSString *)requestUrl {
    
    return @"/api/passport/passwd/edit";
}


- (id)requestArgument {
    
    return  @{
              @"username":_username,
              @"newPasswd":_newPasswd,
              @"smscode":_smscode
              };
}

//-(YTKRequestMethod)requestMethod{
//    return YTKRequestMethodGet;
//}
@end
