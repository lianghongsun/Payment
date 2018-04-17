//
//  ResetpwdAPI.h
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//
// 注册
#import "BaseAPIRequest.h"

@interface RegisterPI : BaseAPIRequest

- (id)initWithUsername:(NSString *)username Passwd:(NSString *)passwd BzType:(NSString *)bzType Smscode:(NSString *)smscode NeedLogin:(NSString *)needLogin;

@end
