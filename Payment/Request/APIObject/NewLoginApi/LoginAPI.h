//
//  LoginAPI.h
//  Qoros_v3
//
//  Created by Techistoner on 15/12/1.
//  Copyright © 2015年 unimker. All rights reserved.
//
//登录
#import "BaseAPIRequest.h"

@interface LoginAPI : BaseAPIRequest
- (id)initWithUsername:(NSString *)username password:(NSString *)password;

@end
