//
//  UserInfo.h
//  Qoros_v3
//
//  Created by Techistoner on 15/11/25.
//  Copyright © 2015年 unimker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject



+ (UserInfo *)shareObject;

@property (nonatomic,copy) NSString  *uid;//用户id
@property (nonatomic,copy) NSString  *userName;//用户名
@property (nonatomic, assign) NSInteger type;//用户类型 1-普通用户 2-特约用户 3-商户添加
@property (nonatomic,copy) NSString *datatoken;//身份TOKEN
@property (nonatomic, assign) NSInteger mobileAuthed;//手机是否绑定
@property (nonatomic,copy) NSString *mobile;//手机号
@property (nonatomic, assign) NSInteger identityAuthed;//是否实名
@property (nonatomic, assign) NSInteger merchantAuthed;//是否店铺认证
@property (nonatomic,strong) NSDictionary *accounts;//账户金额
@property (nonatomic,assign) BOOL isLogin;
@property (nonatomic,assign) BOOL issetpaypass;
@property (nonatomic,assign) BOOL issetgesturespass;

@property (nonatomic,copy) NSString *oldgestures;//测试  手势密码


@end
