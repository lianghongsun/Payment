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
@property (nonatomic,copy) NSString  *username;//用户名
@property (nonatomic, assign) NSInteger type;//用户类型 1-普通用户 2-特约用户 3-商户添加
@property (nonatomic,copy) NSString *datatoken;//身份TOKEN
@property (nonatomic, assign) NSInteger mobileAuthed;//手机是否绑定
@property (nonatomic,copy) NSString *mobile;//手机号
@property (nonatomic,copy) NSString *create;//创建时间
@property (nonatomic, assign) NSInteger identityAuthed;//是否实名
@property (nonatomic, assign) NSInteger paypasswdAuthed;//是否设置了支付密码
@property (nonatomic, assign) NSInteger merchantAuthed;//是否店铺认证
@property (nonatomic,strong) NSDictionary *accounts;//账户金额
@property (nonatomic,strong) NSDictionary *detail;//个人信息
@property (nonatomic,assign) BOOL isLogin;

@end
