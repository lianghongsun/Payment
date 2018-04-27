//
//  NetworkDefine.h
//  QOROS2_0
//
//  Created by lu yang on 14-8-13.
//  Copyright (c) 2014年 Fugumobile. All rights reserved.
//
/**
 *  网络定义
 */


//定义网络请求返回值
typedef NS_ENUM(NSInteger, RequestStatus) {
    RequestStatusSuccess = 1,
    
//    RequestStatusForbidQuery = 100,
//    RequestStatusUnofficialOwners = 130,
//    RequestStatusPasswordError = 150,
//    RequestStatusPasswordIrregularities = 151,
//    
//
//    //用户信息错误定义
//    RequestStatusUserInfoNotFind = 201,
//    RequestStatusUserInforInvalid = 210,
//    RequestStatusUserInfoRegister = 211,
//    RequestStatusUserMobilenum = 203,
//    RequestStatusUserMobileCAPTCHA = 204,
//    RequestStatusUserMobilefinf = 205,
//    RequestStatusUserMobilethirty = 230,
//    RequestStatusUserMobilehentriaconta = 231,
//    
//    
//    
//    
//    
//    //车辆信息错误定义
//    RequestStatusCarLocationInfoNotFind = 300,
//    
//    //行程信息错误定义
//    RequestStatusUnacceptedPinType = 401,
//    RequestStatusIllegalOperationType = 402,
//    RequestStatusImageSaveFail = 403,
//    RequestStatusImageFileAnomalous = 404,
//    RequestStatusPOINotFind = 405,
//    RequestStatusPointsLengthCannotMorethanFivePois = 406,
//    RequestStatusPoiIdNotFindInfo = 407,
//    RequestStatusPoiHaveSaved = 408,
//    RequestStatusPoiNotExist = 409,
//    RequestStatusPoiIdUserNotExist = 410,
//    RequestStatusPoiNameIsEmpty = 411,
//    RequestStatusTripNotSupportSort = 412,
//    RequestStatusTripNotSupportQuery = 413,
//    RequestStatusPoiPinNotSupportQuery = 414,
//    
//    //PickUp错误定义
//    RequestStatusPickupInofNotFind = 500,
//    RequestStatusIllegalPickupId = 501,
//    RequestStatusPickupIdUserNotExist = 502,
//    RequestStatusSaveStateIsNotTaccepted = 503,
//    RequestStatusCancelStateIsNotInitTacceptedtcancel = 504,
//    RequestStatusExpireStateIsNotInit = 505,
//    //Maintenance错误定义
//    RequestStatusIllegalIllegal = 600,
//    RequestStatusCancelOrderNotexist = 601,
//    RequestStatusCancelOrderStatusNotSubmitOrVerify = 602,
//    RequestStatusAppointmentOrderNotFind = 603,
//    RequestStatusNoDealerInfo = 603,
//
//    
//    RequestStatusAccessTokenSuccess = 900,
    RequestStatusUsernameOrPasswdError = 901
//    RequestStatusIllegalKey = 902,
//    RequestStatusServerError = 903,
//    RequestStatusIllegalAccessToken = 904,
//    RequestStatusAccessTokenExpire = 905,
//    RequestStatusReverseLocationIllegal = 906,
//    RequestStatusNoShortCut = 907,
//    RequestStatusShortCutUpdateFail = 908,
//    RequestStatusVerificationCodeFail = 910,
//    RequestStatusVerificationCodeLock = 911,
//    RequestStatusloginCodeLock = 912,

};

#define REFRESH_TOKEN_FIELD @"/Account/RefreshToken.ashx"  //刷新token的 url 参数
#define ACCESSTOKEN_HEAD_FIELD @"" //token 对应的头字段key
#define TOKEN_EXPIRE_CODE 905//token 过期的状态码
#define TOKEN_ILLEGAL 904//token 非法的状态码
#define SERVER_ERROR 903//服务器错误


#pragma mark - URL

//#define PRODUCT_SITUATION   //打开：生产环境 ，注释掉是预生产环境

#ifdef           PRODUCT_SITUATION

#define HTTPHEAD  @"http://payapi.tj.com"//
//七牛
#define QI_NIU_HOST    @""

//获取七牛的token
#define     Qiniu_Token_Get     @""


#else
#define HTTPHEAD  @"http://payapi.tj.com"//
//七牛
#define QI_NIU_HOST             @""

//获取七牛的token
#define     Qiniu_Token_Get     @""

#endif





