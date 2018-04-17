//
//  RegisterAPI.h
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//
//验证码修改密码
#import "BaseAPIRequest.h"

@interface PassportAPI : BaseAPIRequest

- (id)initWithUsername:(NSString *)username NewPasswd:(NSString *)newPasswd Smscode:(NSString *)smscode;

@end
