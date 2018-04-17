//
//  ToolDefine.h
//  RuiTuEBusiness
//
//  Created by Naive on 2016/11/21.
//  Copyright © 2016年 Naive. All rights reserved.
//

//在release版本禁止输出NSLog内容
//发布版本时注释 #define IOS_DEBUG
//#define IOS_DEBUG
#ifdef IOS_DEBUG
//#define NSLog(...) NSLog(__VA_ARGS__)
#else
//#define NSLog(...){}
#endif

//检查登录
#define Check_Login \
if ([UserInfo isLogin])\
{\
}\
else\
{\
[self presentLoginVCAction];\
return ;\
}\


#define Check_Login_Objc \
if ([UserInfo isLogin])\
{\
}\
else\
{\
[[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:[LoginVC navigationControllerContainSelf] animated:YES completion:nil];\
return ;\
}\

#define NOTIFICATION_REFRAME                          @"NOTIFICATION_REFRAME"     //重绘界面用

#define NOTIFICATION_ALIPAY                          @"NOTIFICATION_ALIPAY"     //支付宝支付完成回调

/**
 *  检查数据有效性
 */
#define CHECK_VALUE(value) NSStringExchangeTheReturnValueToString(value)

#define ChangeNSIntegerToStr(value) [CommonMethod changeNsinterToStr:value]

#define GET_IMAGEURL_URL(value) [NSURL URLWithString:[[Singer share] getImageUrlWithStr:value]]

#define TOKEN @"TOKEN"
#define USWEID @"USWEID"
#define LOGINTIME @"LOGINTIME"
#define USERIMG @"USERIMG"
#define ISLOGIN @"ISLOGIN"

#define USERPHONE @"USERPHONE"






