//
//  RefreshAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "ResetPayPassAPI.h"

@implementation ResetPayPassAPI

{
    NSString *_uid;
    NSString *_realName;
    NSString *_identityNo;
    NSString *_smscode;
}

- (id)initWithUid:(NSString *)uid RealName:(NSString *)realName IdentityNo:(NSString *)identityNo Smscode:(NSString *)smscode{
    self = [super init];
    if (self) {
        _uid = uid?uid:@"";
        _realName = realName?realName:@"";
        _identityNo = identityNo?identityNo:@"";
        _smscode = smscode?smscode:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/api/pay/password/reset";
}


- (id)requestArgument {
    
    return  @{
              @"uid":_uid,
              @"realName":_realName,
              @"identityNo":_identityNo,
              @"smscode":_smscode
              };
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPost;
}



@end
