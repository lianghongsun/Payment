//
//  UploadImageTool.h
//  SportJX
//
//  Created by Chendy on 15/12/22.
//  Copyright © 2015年 Chendy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Qiniu/QiniuSDK.h>
#import <UIKit/UIKit.h>
@interface UploadImageTool : NSObject


// 获取七牛上传token
+ (void)getQiniuUploadToken:(NSString*)type success:(void (^)(NSString *))success failure:(void (^)())failure;
/**
 *  上传图片
 *
 *  @param image    需要上传的image
 *  @param progress 上传进度block
 *  @param success  成功block 返回url地址
 *  @param failure  失败block
 */
+ (void)uploadImage:(UIImage *)image type:(NSString*)type progress:(QNUpProgressHandler)progress success:(void (^)(NSString *url))success failure:(void (^)())failure ;

// 上传多张图片,按队列依次上传
+ (void)uploadImages:(NSArray *)imageArray type:(NSString*)type progress:(void (^)(CGFloat))progress success:(void (^)(NSArray *))success failure:(void (^)())failure;
@end
