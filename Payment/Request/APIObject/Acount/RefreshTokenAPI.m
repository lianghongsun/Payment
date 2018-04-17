 //
//  RefreshTokenAPI.m
//  Qoros_v3
//
//  Created by 亮哥 on 15/12/10.
//  Copyright © 2015年 unimker. All rights reserved.
//

#import "RefreshTokenAPI.h"

@implementation RefreshTokenAPI {
    NSInteger _userID;
    NSString *_accessToken;
}

- (id)initWithUserId:(NSInteger )userID AccessToken:(NSString *)accessToken {
    self = [super init];
    if (self) {
        _userID = userID;
        _accessToken = accessToken;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/Account/RefreshToken.ashx";
}

- (id)requestArgument {
    return @{
             @"UserId":[NSNumber numberWithInteger:_userID],
             @"AccessToken":_accessToken
             };
    
}


@end
