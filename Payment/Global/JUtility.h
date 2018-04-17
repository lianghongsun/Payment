//
//  JUtility.h
//  JCFindHouse
//
//  Created by Jam on 13-8-19.
//  Copyright (c) 2013年 jiamiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JUtility : NSObject

//MD5加密
+ (NSString *)md5:(NSString *)str;

//是否允许访问相册
+ (BOOL)canOpenPicture;

//是否允许访问摄像机
+ (BOOL)canOpenCamera;

//是否允许访问话筒
+ (void)canOpenMicrophone:(void (^)(BOOL finished))allowBlock;

//获取文件MD5值
+(NSString*)getFileMD5WithPath:(NSString*)path;

//通知是否打开
+ (BOOL)isAllowedNotification;

//获取全局路径
+ (NSString *)getGlobalPath;

+ (NSString *)toJsonString:(id)data;

//判断文件是否存在
+ (BOOL)fileExistsAtPath:(NSString *)filePath;

@end
