////
////  UploadImageTool.m
////  SportJX
////
////  Created by Chendy on 15/12/22.
////  Copyright © 2015年 Chendy. All rights reserved.
////
//
//#import "UploadImageTool.h"
//#import "AFNetworking.h"
////#import "AFNetworkActivityIndicatorManager.h"
//#import "QiniuUploadHelper.h"
//#import "SBJsonParser.h"
//
//
//@implementation UploadImageTool
//
//
//#pragma mark - Helpers
//
//
//
//
////上传单张图片
//+ (void)uploadImage:(UIImage *)image type:(NSString*)type progress:(QNUpProgressHandler)progress success:(void (^)(NSString *url))success failure:(void (^)(void))failure {
//
//    [UploadImageTool getQiniuUploadToken:type success:^(NSString *token) {
//
//        NSData *data = UIImageJPEGRepresentation(image, 0.00001);
//
//        if (!data) {
//
//            if (failure) {
//
//                failure();
//            }
//            return;
//        }
//
////        NSString *key = [NSString stringWithFormat:@"%@_%@.jpg",type,[NSString stringWithFormat:@"%0.f",(double)[[NSDate date] timeIntervalSince1970]*1000]];
//
//        NSString * key = [token componentsSeparatedByString:@"|"][1];
//        NSString * token_key = [token componentsSeparatedByString:@"|"][0];
//
////        QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:nil
////                                                   progressHandler:progress
////                                                            params:nil
////                                                          checkCrc:NO
////                                                cancellationSignal:nil];
//         QNUploadManager *upManager = [[QNUploadManager alloc] init];
//
//         [upManager putData:data
//                           key:key
//                         token:token_key
//                      complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//
//                          if (info.statusCode == 200 && resp) {
//                              NSString *url= [NSString stringWithFormat:@"%@%@", QI_NIU_HOST, resp[@"key"]];
//                              if (success) {
//
//                                  success(url);
//                              }
//                          }
//                          else {
//                              if (failure) {
//
//                                  failure();
//                              }
//                          }
//
//
//
//         } option:nil];
//
//    } failure:^{
//
//    }];
//
//}
//
////上传多张图片
//+ (void)uploadImages:(NSArray *)imageArray type:(NSString*)type progress:(void (^)(CGFloat))progress success:(void (^)(NSArray *))success failure:(void (^)(void))failure {
//
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//
//    __block CGFloat totalProgress = 0.0f;
//    __block CGFloat partProgress = 1.0f / [imageArray count];
//    __block NSUInteger currentIndex = 0;
//
//    QiniuUploadHelper *uploadHelper = [QiniuUploadHelper sharedUploadHelper];
//    __weak typeof(uploadHelper) weakHelper = uploadHelper;
//
//    uploadHelper.singleFailureBlock = ^() {
//        failure();
//        return;
//    };
//    uploadHelper.singleSuccessBlock  = ^(NSString *url) {
//        [array addObject:url];
//        totalProgress += partProgress;
//        progress(totalProgress);
//        currentIndex++;
//        if ([array count] == [imageArray count]) {
//            success([array copy]);
//            return;
//        }
//        else {
//            NSLog(@"---%ld",(unsigned long)currentIndex);
//
//            if (currentIndex<imageArray.count) {
//
//                 [UploadImageTool uploadImage:imageArray[currentIndex] type:type  progress:nil success:weakHelper.singleSuccessBlock failure:weakHelper.singleFailureBlock];
//            }
//
//        }
//    };
//
//    [UploadImageTool uploadImage:imageArray[0] type:type progress:nil success:weakHelper.singleSuccessBlock failure:weakHelper.singleFailureBlock];
//}
//
//
//////#error mark -- 必须设置获取七牛token服务器地址,然后获取token返回 --(确认设置后,删除此行)
//////获取七牛的token
////+ (void)getQiniuUploadToken:(NSString*)type success:(void (^)(NSString *))success failure:(void (^)())failure {
////
////    //网络请求七牛token
////
////     //服务器地址
////
////
////     //获取七牛token
////
////    NSString *aPath =[NSString stringWithFormat:@"%@",Qiniu_Token_Get];
////    NSString *key = [NSString stringWithFormat:@"%@_%@.jpg",type,[NSString stringWithFormat:@"%0.f",(double)[[NSDate date] timeIntervalSince1970]*1000]];
////
////    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
////    manager.requestSerializer = [AFJSONRequestSerializer serializer];
////    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
////    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
////    [dic setObject:key forKey:@"key"];
////    [manager POST:aPath parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
////
////    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
////        NSLog(@"JSON: %@", responseObject);
////        if ([responseObject isKindOfClass:[NSString class]]) {
////            SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
////            responseObject = [jsonParser objectWithString:responseObject];
////            jsonParser = nil;
////        }
////
////        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:responseObject];
////
////        if ([[dic[@"errCode"]stringValue] isEqualToString:FindSuccessStatus])
////        {
////             NSString *token = dic[@"result"][@"token"];
////            NSString * str = [NSString stringWithFormat:@"%@|%@",token,key];
////            if (success) {
////
////                success(str);
////            }
////        }
////        else
////        {
////            if (failure) {
////
////                failure();
////            }
////        }
////
////        
////
////    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
////        if (failure) {
////
////            failure();
////        }
////    }];
////
////}
//
//
//@end

