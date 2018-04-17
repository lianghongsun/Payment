//
//  Modify_pwdAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "Modify_pwdAPI.h"

@implementation Modify_pwdAPI

{
    NSString *_newPwd;
    NSString *_uid;
    NSString *_token;
    
}

- (id)initWithNewPwd:(NSString *)newPwd Uid:(NSString *)uid{
    self = [super init];
    if (self) {
        _newPwd = newPwd?newPwd:@"";
        uid = uid?uid:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/auth/modify_pwd";
}

- (NSDictionary *)requestHeaderFieldValueDictionary{
    
    UserInfo *user = [UserInfo shareObject];
    NSString *tonkenStr = [NSString stringWithFormat:@"bearer %@",user.datatoken];
    return @{
             @"Authorization":_token?:tonkenStr
             };
    
}

- (id)requestArgument {
    
    return  @{
              @"newPwd":_newPwd,
              @"uid":_newPwd,
              };
}


@end
